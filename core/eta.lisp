;; July 10/19 
;; ===========================================================
;;
;; For inputs, we use the question it answers to create a list
;; of simple, explicit English clauses, especially the first of 
;; which is intended to capture the "gist" of what was said,
;; i.e., the content of an utterance most likely to be needed
;; to understand the next turn in the dialogue. The intent is that
;; logical interpretations will later play that role, and this
;; has been initiated by supplying a hash table of (some) Eta 
;; output interpretations,
;;     *output-semantics*
;; (which uses keys such as (*eta-schema* ?e3) along with the
;; hash table of gist clauses,
;;     *output-gist-clauses*
;; (indexed in the same way). These tables can be used to set up
;; the 'interpretation' and 'output-gist-clauses' properties of
;; action proposition names, generated in forming plans from 
;; schemas.
;;
;; One important goal in setting up these tables is to be able
;; later to match certain user inputs to Eta question gists/
;; interpretations, to see if the inputs already answer the
;; questions, making them redundant. 
;;
;; TODO: Regarding coreference and memory, it seems like there are
;; a couple separate things:
;; 1. Eta needs a way to parameterize say-to.v actions (and the corresponding
;; gist clauses) based on previous user answers. For example, if Eta asks "what
;; was your favorite class?" and the user replies "Macroeconomics", instead of the
;; next question being "did you find your favorite class hard", it should be
;; "did you find Macroeconomics hard?"
;; 2. Eta needs a way to "trigger" bringing up past information in response to
;; a user question, perhaps based on some similarity metric
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; -*- Common-Lisp -*-

; [This is partly derivative from "doolittle", an improvement of
; Weizenbaum's ELIZA that carries information forward from the
; previous question/answer pair, makes greater use of features,
; uses more flexible, hierarchical pattern matching, and initially
; classifies inputs by their general form (instead of by keyword).]
	
; To run the program, do the following (while in the present
; eta directory):
; lisp
; (load "start")


(setf *print-circle* t) ; needed to prevent recursive loop when printing plan-step

(defstruct ds
;```````````````````````````````
; contains the following fields:
; curr-plan        : points to the currently active dialogue plan
; task-queue       : a list of tasks (currently 'perform-next-step', 'perceive-world', 'interpret-perceptions',
;                    'infer-facts-top-down', and 'infer-facts-bottom-up') to repeatedly execute in cycles
; perception-queue : a queue of perceptions pending context-driven interpretation
; reference-list   : contains a list of discourse entities to be used in ULF coref
; equality-sets    : hash table containing a list of aliases, keyed by canonical name
; gist-kb-user     : hash table of all gist clauses + associated topic keys from user
; gist-kb-eta      : hash table of all gist clauses + associated topic keys from Eta
; conversation-log : three-tuple containing chronological records of all text, gist, and ulf in conversation
; context          : hash table of facts that are true at Now*, e.g., <wff3>
; memory           : hash table of atemporal/"long-term" facts, e.g., (<wff3> ** E3) and (Now* during E3)
; kb               : hash table of Eta's knowledge base, containing general facts
; tg               : timegraph of all episodes
; time             : the constant denoting the current time period. NOW0 is taken uniquely to refer
;                    to the beginning, with all moves/etc. occurring at subsequent times
; count            : number of Eta outputs generated so far (maintained for latency enforcement, i.e.,
;                    not repeating a previously used response too soon)
;
; TODO: currently reference-list and equality-sets are separate things, though they serve a similar
; purpose, namely keeping track of which entities co-refer (e.g. skolem variable and noun phrase).
; These should eventually become unified once we have a systemic way of doing coreference over all
; propositions, versus the current module built over the ULF interpretation.
;
  curr-plan
  task-queue
  perception-queue
  reference-list
  equality-sets
  gist-kb-user
  gist-kb-eta
  conversation-log
  context
  memory
  kb
  tg
  time
  count
) ; END defstruct ds





(defun init ()
;`````````````````````````````
; Initialize global parameters
;
; TODO:
; Other global parameters used here, but whose values are set elsewhere,
; are:  ***THIS NEEDS UPDATING
;      *output-semantics*
;      *output-gist-clauses*
;      *eta-schema* (top-level schema) & possibly many subschemas
;      *reactions-to-input* (top-level choice tree for selecting a
;         schema or subtree to react to a user turn (possibly multiple
;         extracted "gist clauses")
;      *reaction-to-assertion* for individual user assertions
;      *reaction-to-question* for individual user questions
;      *interpretation-of-input* (top-level interpretation tree),
;         and many other interpretation trees (built from packets).
;      *gist-clause-trees* (top-level gist clause extraction
;         tree) and many subsidiary gist-clause extraction trees
;         (formed from corresponding packets).
;
  ; Use response inhibition via latency numbers when *use-latency* = T
  (defvar *use-latency* t)

  ; Queue of tasks that Eta must perform
  (defvar *tasks-list* '(perform-next-step perceive-world interpret-perceptions infer-facts-top-down infer-facts-bottom-up))

  ; Global variable for dialogue record structure
  (defvar *ds* (make-ds))
  (init-ds)

  ; Global stack of discourse states at each turn
  (defparameter *ds-stack* nil)

  ; Load object schemas
  (load-obj-schemas)

  ; Load initial knowledge (if any)
  (when (boundp '*init-knowledge*)
    (mapcar #'store-in-kb *init-knowledge*))

  ; Initialize time
  (setf (ds-time *ds*) 'NOW0)
  (store-time)
  (update-time)

  ; Coreference mode
  ; 0 : simply reconstruct the original ulf
  ; 1 : mode 2 but excluding i.pro and you.pro from resolved references
  ; 2 : substitute most specific referents only for anaphora and indexical np's (e.g. that block)
  ; 3 : substitute most specific referents for all references
  (defparameter *coreference-mode* 1)

  ; Recency cutoff used when attempting coreference (i.e. the coreference
  ; module will only look this far back, in terms of turns, in the discourse
  ; history to find possible referents).
  (defparameter *recency-cutoff* 2)

  ; Certainty cutoff used to generate responses given a list of relations+certainties from the blocks world
  (defparameter *certainty-threshold* 0.7)

  ; Maximum delays used in processing speech acts
  (defparameter *delay-acknowledge.v* 10) ; certainty ~0.3
  (defparameter *delay-respond-to.v* 15) ; certainty ~0.4
  (defparameter *delay-say-to.v* 15) ; certainty ~0.4

  ; A list of supported speech acts
  (defparameter *speech-acts* '(say-to.v paraphrase-to.v reply-to.v react-to.v))

  ; Initialize count
  (setf (ds-count *ds*) 0)

  ; Used for keeping track of output number in output.txt.
  ; TODO: figure out what to do with this variable when saving/rewinding dialogue state
  (defparameter *output-count* 0)
  ; Used for detecting whether to print "dummy" line to output.txt to prompt system to listen.
  (defparameter *output-listen-prompt* 0)

  ; Used for maintaining a buffer of consecutive Eta outputs so that they can be combined and
  ; written as a single turn to turn-output.txt
  (defparameter *output-buffer* nil)

  ; Timer parameters. Each end up being set to current system time, meaning
  ; that time elapsed can be calculated by comparing the timer values to the
  ; system time at a future point.
  (defparameter *flush-context-timer* (get-universal-time))
  (defparameter *expected-step-failure-timer* (get-universal-time))

  ; The timer period (in seconds) that must be passed for Eta to flush context,
  ; removing "instantaneous" telic verbs from context.
  (defparameter *flush-context-period* 5)

  ; The certainty of an episode determines the timer period (in seconds) that must be
  ; passed for Eta to consider an expected episode failed and move on in the plan.
  ; This is a function on the certainty of the episode, with a certainty of 1 having
  ; an infinite period, and a certainty of 0 having a period of 0. This constant determines
  ; the coefficient on the certainty-to-period function.
  ; Currently, this coefficient makes a certainty of ~0.632 correspond to 30 seconds.
  (defparameter *expected-step-failure-period-coefficient* 30)

  ; If *read-log* is the name of some file (in logs/ directory), read and
  ; emulate that file, allowing for user corrections and saving them in a file
  ; of the same name in logs_out/ directory.
  (defparameter *read-log* nil)

  ; If *emotions* is T, Eta will allow use of emotion tags at beginning of outputs.
  (defparameter *emotions* nil)
  (defparameter *emotions-list* '([NEUTRAL] [SAD] [HAPPY] [WORRIED] [ANGRY]))

  ; Log contents and pointer corresponding to current position in log.
  (defparameter *log-contents* nil)
  (defparameter *log-answer* nil)
  (defparameter *log-ptr* 0)

  ; The dialogue instance is used to keep track of multiple dialogue trajectories within
  ; a single session (in the case where the dialogue is rewound to a previous state), and
  ; is incremented every time a rewind occurs.
  (defparameter *dialogue-instance* 0)

  ; A list of any registered perception subsystems that Eta needs to listen to.
  ; Currently only supports '|Blocks-World-System|, '|Terminal|, and '|Audio|.
  (defparameter *registered-systems-perception* nil)
  ; A list of any registered specialist subsystems that Eta can interact with.
  ; Currently only supports '|Spatial-Reasoning-System|.
  (defparameter *registered-systems-specialist* nil)

  ; Set indexical variables
  (defparameter *^me*
    (if (and (boundp '*avatar-name*) *avatar-name*) (intern *avatar-name*) 'Eta))
  (defparameter *^you*
    (if (and (boundp '*user-name*) *user-name*) (intern *user-name*) '|John Doe|))

  ; Keep list of block coordinates mimicking actual BW system (for debugging purposes
  ; while not connected to the BW system).
  (defparameter *block-coordinates* '(
    ((the.d (|Target| block.n))      at-loc.p ($ loc :x -3.289 :y -2.454 :z 0.488))
    ((the.d (|Starbucks| block.n))   at-loc.p ($ loc :x -2.262 :y -2.438 :z 0.493))
    ((the.d (|Twitter| block.n))     at-loc.p ($ loc :x -1.254 :y -2.43  :z 0.493))
    ((the.d (|Texaco| block.n))      at-loc.p ($ loc :x -0.27  :y -2.415 :z 0.493))
    ((the.d (|McDonald's| block.n))  at-loc.p ($ loc :x  0.713 :y -2.412 :z 0.493))
    ((the.d (|Mercedes| block.n))    at-loc.p ($ loc :x  1.696 :y -2.396 :z 0.493))
    ((the.d (|Toyota| block.n))      at-loc.p ($ loc :x  2.728 :y -2.346 :z 0.493))
    ((the.d (|Burger King| block.n)) at-loc.p ($ loc :x  3.753 :y -2.323 :z 0.493))
  ))

  ; Global variables used for IO
  (defparameter *input* nil)
  (defparameter *next-answer* nil)
  (defparameter *next-input* nil)
  (defparameter *next-perceptions* nil)
  (defparameter *next-ulf* nil)
  (defparameter *goal-rep* nil)
  (defparameter *obj-schemas* nil)
  (defparameter *chosen-obj-schema* nil)
  (defparameter *rewind-state* nil)

) ; END init





(defun init-ds ()
;``````````````````````
; Initializes a dialogue state record structure with any special
; properties of the dialogue state (e.g. hash tables, task queues, etc.)
;
  ; Initialize task queue
  (refill-task-queue)

  ; Initialize hash table for aliases/equality sets
  (setf (ds-equality-sets *ds*) (make-hash-table :test #'equal))

  ; Initialize hash tables for User and Eta topic keys/gist clauses
  (setf (ds-gist-kb-user *ds*) (make-hash-table :test #'equal))
  (setf (ds-gist-kb-eta *ds*) (make-hash-table :test #'equal))

  ; Initialize conversation log ((text gists ulfs inferences) tuple)
  (setf (ds-conversation-log *ds*) (list nil nil nil nil))

  ; Initialize fact hash tables
  (setf (ds-context *ds*) (make-hash-table :test #'equal))
  (setf (ds-memory *ds*) (make-hash-table :test #'equal))
  (setf (ds-kb *ds*) (make-hash-table :test #'equal))

  ; Initialize timegraph
  (construct-timegraph)
) ; END init-ds





(defun rewind-ds (offset)
;```````````````````````````
; Rewind the dialogue state to a previous state in the stack of recorded states
; (specified by a relative offset).
;
  (setq *ds* (nth offset *ds-stack*))
  (setq *ds-stack* (last *ds-stack* (- (length *ds-stack*) offset)))
  ; Restart conversation log
  (setq *dialogue-instance* (1+ *dialogue-instance*))
  (ensure-log-files-exist :instance *dialogue-instance*)
  (log-turn-write-all)
  (setq *rewind-state* nil)
) ; END rewind-ds





(defun eta (&key (subsystems-perception '(|Terminal| |Audio|)) (subsystems-specialist '())
                 (dependencies nil) (response-generator 'RULE) (emotions nil) (read-log nil))
;``````````````````````````````````````````````````````````````````````````````````````````````````````````
; Main program: Originally handled initial and final formalities,
; (now largely commented out) and controls the loop for producing,
; managing, and executing the dialog plan (mostly, reading & feature-
; annotating inputs & producing outputs, but with some subplan
; formation, gist clause formation, etc.).
;
  (setq *dependencies* dependencies)

  (init)
  (setq *read-log* read-log)
  (setq *registered-systems-perception* subsystems-perception)
  (setq *registered-systems-specialist* subsystems-specialist)
  (setq *emotions* emotions)
  (setf (ds-count *ds*) 0) ; Number of outputs so far

  ; Initialize gpt3-shell (if in GPT3 generation mode and valid API key exists)
  (setq *response-generator*
    (if (member response-generator '(GPT3 RULE)) response-generator 'RULE))
  (when (equal *response-generator* 'GPT3)
    (let ((api-key (get-api-key "openai")))
      (if api-key
        (gpt3-shell:init api-key)
        (setq *response-generator* 'RULE))))

  ; Initialize ulf2english if among dependencies (prevents delay on first invocation)
  (when (member "ulf2english" *dependencies*)
    (ulf2english:ulf2english '(this.pro ((pres be.v) (= (a.d (test.n |ULF|.n)))))))

  (when *read-log*
    (setq *log-contents* (read-log-contents *read-log*))
    (setq *log-answer* nil)
    (setq *log-ptr* -1))

  ; If '*eta-schema* is not bound, return an error
  (when (not (boundp '*eta-schema*))
    (format t "***  *eta-schema* is not bound. If using a multi-session avatar, make sure *session-number* is set.~%")
    (return-from eta nil))

  ; Initiate the dialogue plan. The schema named
  ; *eta-schema* is used to create the top-level plan
  (setf (ds-curr-plan *ds*) (init-plan-from-schema '*eta-schema* nil))

  ;; (print-current-plan-status (ds-curr-plan *ds*)) ; DEBUGGING

  ; The interaction continues so long as the dialogue plan has another step
  (loop while (has-next-step? (ds-curr-plan *ds*)) do
    (do-task (select-and-remove-task)))
  
) ; END eta





(defun refill-task-queue ()
;```````````````````````````````````
; Refills the task queue after it becomes empty.
  (setf (ds-task-queue *ds*) *tasks-list*)
) ; END refill-task-queue





(defun select-and-remove-task ()
;```````````````````````````````````
; Select the task at the front of the task queue. Return the
; task and update the queue, refilling the queue when empty.
;
  ; When the task queue is empty, refill
  (when (null (ds-task-queue *ds*))
    (refill-task-queue))

  ; Pop the current front of the task queue
  (let ((curr-task (car (ds-task-queue *ds*))))
    (setf (ds-task-queue *ds*) (cdr (ds-task-queue *ds*)))
    curr-task)
) ; END select-and-remove-task





(defun do-task (task)
;````````````````````````
; Given a symbol denoting a task, call the top-level function
; implementing that task.
; NOTE: this can be made a bit more space-efficient just by using
; (funcall task), but I didn't want to assume that all tasks will
; necessarily share the same format.
;
  ;; (format t "executing task: ~a~%" task) ; DEBUGGING
  (case task
    (perform-next-step (perform-next-step))
    (perceive-world (perceive-world))
    (interpret-perceptions (interpret-perceptions))
    (infer-facts-top-down (infer-facts-top-down))
    (infer-facts-bottom-up (infer-facts-bottom-up)))
) ; END do-task





(defun perform-next-step ()
;````````````````````````````````````
; Performs the next step of the current dialogue plan, and
; updates the plan state, removing any completed subplans.
;
  (let ((plan (ds-curr-plan *ds*)) subplan curr-step wff subj certainty plan-advanced?)

    ; If a signal to rewind the dialogue state is detected, rewind to that state (if possible)
    (when (check-for-rewind-signal)
      (rewind-ds *rewind-state*))

    ; Find the next action from the deepest active subplan
    (setq subplan (find-curr-subplan plan))

    ; Current step becomes whatever the current step of subplan is
    (setq curr-step (plan-curr-step subplan))

    ; Get wff of current step and the subject of the episode
    (setq wff (plan-step-wff curr-step))
    (setq subj (car wff))

    (cond
      ; If the subject of the expected plan step is the user, inquire about the truth of the episode.
      ((equal subj '^you)

        ; Output prompt for external system to listen for user audio (but only once)
        (setq *output-listen-prompt* (if (= *output-listen-prompt* 0) 1 2))

        ; If first time listening for user input for given episode, and in read-log mode,
        ; read next tuple in log as input.
        ; NOTE: the following code is only relevant if (*read-log-mode* t) is set in config.lisp.
        ; TODO: this still isn't working; need to look into this more.
        (when (and (= *output-listen-prompt* 1) *read-log*)
          (process-and-increment-log)
          (update-plan-state plan)
          (return-from perform-next-step nil))

        ; Write output buffer
        (when *output-buffer*
          (write-output-buffer))

        ; Check certainty of expected plan step
        (setq certainty (plan-step-certainty curr-step))

        (cond
          ; If timer exceeds period (a function of certainty of step), instantiate a 'failed' episode and continue plan.
          ((>=inf (- (get-universal-time) *expected-step-failure-timer*) (certainty-to-period certainty)) 
            (setq plan-advanced? (determine-next-episode-failed subplan)))

          ; Otherwise, inquire self about the truth of the immediately pending episode. Plan is advanced
          ; (and appropriate substitutions made) if the expected episode is determined to be true.
          (t
            (setq plan-advanced? (inquire-truth-of-next-episode subplan)))))

      ; Otherwise, process the plan step, resetting the timer for expected step failure.
      (t
        ; Disable prompt for external system to listen for user audio
        (setq *output-listen-prompt* 0)

        (process-next-episode subplan)
        (setq plan-advanced? t)))

    ;; (print-current-plan-status (ds-curr-plan *ds*)) ; DEBUGGING
    ;; (format t " here is after the print-current-plan-status -----------~%")

    ; Update plan state after processing the previous step
    (update-plan-state plan)

    ; If plan was advanced, reset the timer for checking whether to declare an expected step a failure.
    (if plan-advanced? (setq *expected-step-failure-timer* (get-universal-time)))

    ;; (format t " here is after the plan state has been updated -----------~%")
    ;; (print-current-plan-status (ds-curr-plan *ds*)) ; DEBUGGING

)) ; END perform-next-step





(defun perceive-world ()
;````````````````````````````````````
; Perceive the world by cycling through each of Eta's registered subsystems
; collecting facts from each one, and adding them to context as well as a
; perception queue for further interpretation. In the case where a fact
; is negated (i.e., (not ...)), the fact is instead removed from context.
;
; Periodically (with the parameter determining the period defined in the 'init'
; function), Eta should also flush context of facts with predicates that are
; known to be "instantaneous" telic predicates, e.g., saying, replying, moving, etc.
;
  (let (inputs)

  ; Flush context of "instantaneous" telic verbs once timer passes a certain period.
  (when (>= (- (get-universal-time) *flush-context-timer*) *flush-context-period*)
    ;; (format t "FLUSHING CONTEXT~%") ; DEBUGGING
    (flush-context)
    (setq *flush-context-timer* (get-universal-time)))

  ; Cycle through all registered perception sources;
  ; for each observation, instantiate an episode and
  ; any relevant temporal relations.
    (dolist (system *registered-systems-perception*)
      (setq inputs (read-from-system system))

      ;; (when inputs (format t "received inputs: ~a~%" inputs)) ; DEBUGGING

      ; Remove any facts observed to no longer be true, i.e. of the form (not (...)).
      ; Then remove these facts from the list.
      ; TODO: some facts imply the negation of other ones,
      ; e.g., (^you smiling.a) => (not (^you frowning.a)). Presumably
      ; this would be inferred, but I'm not sure how this inferred
      ; fact can be used to remove a previous (^you smiling.a) fact
      ; from context, unless we look for & remove contradictions from
      ; context each time this task executes. I suppose another option
      ; to inferring the negation would be using a lexical resource,
      ; such as WordNet, which has mutual exclusion relations.
      (mapcar (lambda (input)
        (when (equal 'not (car input)) (remove-old-contextual-fact (second input)))) inputs)
      (remove-if (lambda (input) (equal 'not (car input))) inputs)

      ; Add facts to context, and push them into a queue of new perceptions for further interpretation.
      (when inputs (setq ep-name-new (store-new-contextual-facts inputs)))
      (mapcar (lambda (input) (push (list ep-name-new input) (ds-perception-queue *ds*))) inputs))
)) ; END perceive-world





(defun interpret-perceptions ()
;```````````````````````````````
; Given a list of enqueued perceptions, go through each one and interpret it
; in the context of the current (sub)plan (emptying the queue in the process).
;
  (let (subplan)
    ; Find the next action from the deepest active subplan
    (setq subplan (find-curr-subplan (ds-curr-plan *ds*)))

    ; Go through queued perceptions and try to interpret each one in
    ; context of the current plan
    (dolist (fact (ds-perception-queue *ds*))
      (interpret-perception-in-context fact subplan))
    (setf (ds-perception-queue *ds*) nil)

)) ; END interpret-perceptions





(defun infer-facts-top-down ()
;```````````````````````````````
; TBC
;
  nil
) ; END infer-facts-top-down





(defun infer-facts-bottom-up ()
;````````````````````````````````````
; TBC
; 
  nil
) ; END infer-facts-bottom-up





(defun implement-next-plan-episode (subplan)
;``````````````````````````````````````````````
; Any "abstract" plan episodes concerned with control flow (e.g., conditional events,
; repeating an event, etc.), as opposed to actions starting with "^me" or "^you", are
; implemented here. Execution of such episodes by Eta involves modifying the plan structure
; in a way that corresponds to the episode in question.
;
  (let* ((curr-step (plan-curr-step subplan)) bindings expr new-subplan var-bindings
         (ep-name (plan-step-ep-name curr-step)) (wff (plan-step-wff curr-step))
         args-list)
  
    ;; (format t "~%WFF = ~a,~% in the ETA action ~a being processed~%" wff ep-name) ; DEBUGGING

    ; Big conditional statement to determine the type of the current
    ; action, and to form the subsequent action accordingly.
    (cond

      ;`````````````````````````````
      ; Plan: Conditional
      ;`````````````````````````````
      ; Simple "if cond, do this, else do this" conditional.
      ; binding yields ((_+ (cond1 name1 wff1 name2 wff2 ... :else name3 wff3 ...)))
      ((setq bindings (bindings-from-ttt-match '(:if _+) wff))
        (setq expr (get-multiple-bindings bindings))
        ; Generate and subplan (possibly nil)
        (setq new-subplan (plan-if-else expr)))

      ;``````````````````````````````````````````
      ; Plan: Sequence of conditionals
      ;``````````````````````````````````````````
      ; An arbitrary number of conditionals which are tried in sequence.
      ; bindings yields ((_+ ((:if cond1 name1.1 wff1.1 name1.2 wff1.2 ...)
      ;                       (:if cond2 name2.1 wff2.1 name2.2 wff2.2 ...) ...
      ;                       (:else name3.1 wff3.1 name3.2 wff3.2 ...))))
      ((setq bindings (bindings-from-ttt-match '(:try-in-sequence _+) wff))
        (setq expr (get-multiple-bindings bindings))
        ; Generate a subplan for the 1st action-wff with a true condition:
        (setq new-subplan (plan-try-in-sequence expr)))

      ;`````````````````````
      ; Plan: Looping
      ;`````````````````````
      ; repeat-until, potentially other forms of loops in the future.
      ; bindings yields ((_+ (ep-var cond name1 wff1 ...)))
      ; ep-var supplies a (quoted) episode variable, cond supplies the condition of the loop,
      ; and the rest of the list is a number of name, wff pairs.
      ((setq bindings (bindings-from-ttt-match '(:repeat-until _+) wff))
        (setq expr (get-multiple-bindings bindings))
        ; Generate a subplan for the 1st action-wff with a true condition:
        (setq new-subplan (plan-repeat-until subplan ep-name expr)))

      ;````````````````````````````````
      ; Plan: Subschema Instantiation
      ;````````````````````````````````
      ; instantiation of any subschema involving both participants.
      ((setq bindings (bindings-from-ttt-match '((! (set-of ^me ^you) (set-of ^you ^me))
                                                  schema-header? (? _*)) wff))
        (setq bindings (cdr bindings))
        (setq args-list (get-multiple-bindings bindings))
        ; If episode is an obviated action, skip, otherwise generate subplan from schema name
        (cond
          ((obviated-action ep-name)
            (setq new-subplan nil))
          (t (setq new-subplan (init-plan-from-schema (schema-name! (second wff)) args-list)))))
      
      ; Unrecognizable step
      (t (format t "~%*** UNRECOGNIZABLE STEP ~a " wff) (error))
    )

    ; Return new subplan (possibly nil) and any variable bindings
    (list var-bindings new-subplan)

)) ; END implement-next-plan-episode





(defun implement-next-eta-action (subplan)
;``````````````````````````````````````````````````
; Any actions by Eta are implemented here. We assume that this program
; is called only if the first action of the plan is already known to be of
; type (^me ...).
;
; If the currently due step of the plan is a primitive action (e.g., saying
; something), execute it. Otherwise, create a subplan for the action. 
; No part of the new subplan is immediately executed or further
; elaborated, so that the main Eta plan manager can in principle
; check and amend the overall rest of the plan if necessary (e.g.,
; add or modify temporal constraints to avoid inconsistencies; more 
; radical changes may be warranted for optimizing overall utility).
; Any subschemas used in the elaboration process typically supply 
; multiple (^me say-to.v ^you '(...)) actions), and choice packets used
; for step elaboration typically elaborate (^me react-to.v ...) actions
; into single or multiple (^me say-to.v ^you '(...)) subactions.
;
; The function returns a pair (var-bindings new-subplan), where either
; may be nil. var-bindings is a list of pairs of variables and symbols
; generated during execution of the action, to be bound to that variable
; in the remainder of the plan. new-subplan is the subplan created by the
; action (if any). If a new subplan is returned, it is attached to the
; current plan step by the calling function, otherwise the calling function
; advances the plan to the next step.
;
; TODO: IT SEEMS THAT THIS PROGRAM COULD ITSELF BE
;   REFORMULATED AS A KIND OF CHOICE TREE THAT SELECTS A SUBPLAN
;   TO EXPAND A NONPRIMITIVE ACTION THAT IT FINDS AT THE 'REST-
;   OF-PLAN' POINTER, OR, FOR PRIMITIVE ACTIONS (SAYING WORDS),
;   EXECUTES THEM. WE MIGHT ULTIMATELY DEVELOP PLANS NON-SEQUENT-
;   IALLY, SEPARATING SUCH DEVELOPMENT FROM EXECUTION OF (CURRENTLY
;   DUE) PRIMITIVE ACTIONS. SO THE ROLE OF THE PLANNING EXECUTIVE
;   WOULD BE MORE IN THE NATURE OF "PRIORITIZING" -- DECIDING WHETHER
;   TO EXECUTE THE NEXT STEP (IF PRIMITIVE), OR WHAT PLAN STEPS TO  
;   ELABORATE, MODIFY, OR SHIFT AROUND NEXT, WHILE USING CHOICE 
;   TREES FOR FINDING SUITABLE METHODS FOR ELABORATION (AND DOING 
;   FREQUENT OVERALL CONSISTENCY, PROBABILITY, AND UTILITY 
;   CALCULATIONS).
;
  (let* ((curr-step (plan-curr-step subplan)) bindings expr expr-new new-subplan var-bindings
         (ep-name (plan-step-ep-name curr-step)) (wff (plan-step-wff curr-step))
         superstep ep-name1 user-ep-name user-ulf n user-gist-clauses user-gist-passage
         prev-step prev-step-ep-name prev-step-wff utterance query eta-ulf
         proposal-gist main-clause info topic suggestion ans perceptions
         perceived-actions sk-var sk-name concept-name concept-schema goal-name goal-schema)

    ;; (format t "~%WFF = ~a,~% in the ETA action ~a being processed~%" wff ep-name) ; DEBUGGING

    ; Big conditional statement to determine the type of the current
    ; action, and to form the subsequent action accordingly.
    (cond

      ;`````````````````````
      ; Eta: Saying
      ;`````````````````````
      ; e.g. yields ((_+ '(I am a senior comp sci major\, how about you?)))
      ; or nil, for non-match
      ((setq bindings (bindings-from-ttt-match '(^me say-to.v ^you _+) wff))
        (setq expr (eval-functions (get-single-binding bindings)))
        (cond
          ; If the current "say" action is a question, then use 'topic-keys'
          ; and gist-kb-user to see if question has already been answered.
          ; If so, omit action.
          ; TODO: investigate why this required advancing the plan twice...
          ((not (null (obviated-question expr ep-name)))
            (advance-plan subplan)
            (setq new-subplan nil))
          ; Primitive say-to.v act: drop the quote, say it, increment the
          ; count variable, advance the 'rest-of-plan' pointer, and
          ; log the turn in the conversation history
          ((or (quoted-sentence? expr) (variable? expr))

            ; If argument is a variable, and in GPT3 generation mode, replace
            ; variable with a generated utterance in say-to.v act and throughout schema.
            (cond
              ((variable? expr)
                (setq expr-new (if (equal *response-generator* 'GPT3)
                  (form-surface-utterance-using-language-model)
                  nil))
                (nsubst-variable subplan `(quote ,expr-new) expr)
                (setq expr expr-new))
              (t (setq expr (flatten (second expr)))))
            
            (setf (ds-count *ds*) (1+ (ds-count *ds*)))
            (setq expr (tag-emotions expr))

            ; Inherit any gists/semantics from parent episode, if any
            (setq ep-name1 (get-parent-ep-name subplan))
            (when ep-name1
              (mapcar (lambda (gist) (store-gist-clause-characterizing-episode gist ep-name '^me '^you))
                (get-gist-clauses-characterizing-episode ep-name1))
              (mapcar (lambda (ulf) (store-semantic-interpretation-characterizing-episode ulf ep-name '^me '^you))
                (get-semantic-interpretations-characterizing-episode ep-name1)))

            ; Add discourse state to stack
            (push (deepcopy-ds *ds*) *ds-stack*)

            ; Check both episode and parent episode for gists/ulfs
            (log-turn (list expr
                (get-gist-clauses-characterizing-episode ep-name)
                (get-semantic-interpretations-characterizing-episode ep-name)
                nil)
              :agent (if (boundp '*agent-id*) *agent-id* 'eta))

            ; Output words
            (if (member '|Audio| *registered-systems-perception*)
              (say-words expr)
              (print-words expr)))

          ; Nonprimitive say-to.v act (e.g. (^me say-to.v ^you (that (?e be.v finished.a)))):
          ; Should probably be illegal action specification since we can use 'tell.v' for
          ; inform acts. For the moment however, handle equivalently to tell.v.
          (t (setq new-subplan (plan-tell expr)))))

      ; For now, saying something is the only primitive action, so everything
      ; beyond this point is non-primitive actions, to be expanded using choice packets.

      ;`````````````````````
      ; Eta: Paraphrasing
      ;`````````````````````
      ; Yields e.g. ((_+ '(I am a senior comp sci major \.))), or nil if unsuccessful.
      ; Used for elaborating a gist-clause by Eta into a surface-level utterance via choice
      ; packets which first branch on the gist-clause to select an appropriate subtree, and
      ; then generate an utterance based on the context of the previous speech act in the dialogue.
      ((setq bindings (bindings-from-ttt-match '(^me paraphrase-to.v ^you _+) wff))
        (setq expr (eval-functions (get-single-binding bindings)))
        (cond
          ; If the current "say" action is a question, then use 'topic-keys'
          ; and gist-kb-user to see if question has already been answered.
          ; If so, omit action.
          ((not (null (obviated-question expr ep-name)))
            (advance-plan subplan)
            (setq new-subplan nil))

          ; Get subtree, get surface response, attach say-to.v action
          ((eq (car expr) 'quote)
            (setq expr (flatten (second expr)))

            ; Store gist-clause that Eta is paraphrasing
            (store-gist expr (get ep-name 'topic-keys) (ds-gist-kb-eta *ds*))
            (store-gist-clause-characterizing-episode expr ep-name '^me '^you)

            ; Inherit any semantics from parent episode, if any
            (setq ep-name1 (get-parent-ep-name subplan))
            (when ep-name1
              (mapcar (lambda (ulf) (store-semantic-interpretation-characterizing-episode ulf ep-name '^me '^you))
                (get-semantic-interpretations-characterizing-episode ep-name1)))

            ; Use previous user reply as context for response generation
            (setq prev-step (find-prev-step-of-type subplan '^you '(say-to.v paraphrase-to.v reply-to.v react-to.v)))
            (when prev-step
              (setq prev-step-ep-name (plan-step-ep-name prev-step))
              (setq prev-step-wff (plan-step-wff prev-step)))

            ;; (format t "~%found previous speech act: ~a (~a)~%" prev-step-ep-name prev-step-wff) ; DEBUGGING

            ; Get gist-clauses corresponding to previous user speech act
            (setq user-gist-clauses (get-gist-clauses-characterizing-episode prev-step-ep-name))

            ;; (format t "associated gist clauses: ~a~%" user-gist-clauses) ; DEBUGGING

            (cond
              ; Use GPT3-based paraphrase model if available
              ((equal *response-generator* 'GPT3)
                (setq utterance (form-surface-utterance-using-language-model expr)))
              
              ; Otherwise, use rule-based methods to select surface utterance
              (t
                ; Get utterance from gist-clause and prior gist-clause
                ; TODO: for now this appends all user gist-clauses together, but there might be a better way to do it
                (setq utterance (form-surface-utterance-from-gist-clause expr (apply #'append user-gist-clauses)))))

            ; Attach say-to.v action as subplan to paraphrase-to.v action
            (setq new-subplan
              (init-plan-from-episode-list
                (list :episodes (episode-var) (create-say-to-wff utterance)))))

          ; Other argument types unexpected
          (t (setq new-subplan nil))))

      ;`````````````````````
      ; Eta: Reacting
      ;`````````````````````
      ; Yields e.g. ((_! EP34.)), or nil if unsuccessful.
      ((setq bindings (bindings-from-ttt-match '(^me react-to.v _!) wff))
        (setq expr (get-single-binding bindings))
        (cond
          ; If 'quoted' gist-clause, attribute gist-clause to user
          ((and (listp expr) (eq (car expr) 'quote))
            (setq expr (flatten (second expr)))
            (setq user-gist-clauses (list expr))
            (setq user-ulf nil))
          ; Otherwise, find gist-clauses associated with episode Eta is reacting to
          (t
            (setq user-ep-name (get-single-binding bindings))
            (setq user-gist-clauses (get-gist-clauses-characterizing-episode user-ep-name))
            (setq user-ulf (resolve-references (get-semantic-interpretations-characterizing-episode user-ep-name)))))

        ;; (format t "~% user gist clause (for ~a) is ~a" user-ep-name user-gist-clauses) ; DEBUGGING
        ;; (format t "~% user ulf (for ~a) is ~a ~%" user-ep-name user-ulf) ; DEBUGGING
        (setq new-subplan (plan-reaction-to user-gist-clauses user-ulf ep-name)))

      ; NOTE: Apart from saying and reacting, assume that Eta actions
      ; also allow telling, describing, suggesting, asking, saying 
      ; hello, and saying good-bye. 
      ;
      ; (Other speech acts may be added later, such as proposing,
      ; rejecting, praising, advising, reprimanding, acknowledging,
      ; apologizing, exclaiming, etc.)

      ;`````````````````````
      ; Eta: Telling
      ;`````````````````````
      ; e.g. telling one's name could be formulated as
      ; (^me tell.v ^you (ans-to (wh ?x (^me have-as.v name.n ?x))))
      ; and answer retrieval should bind ?x to a name. Or we could have
      ; explicit reified propositions such as (that (^me have-as.v name.n 'Eta))
      ; or (that (^me be.v ((attr autonomous.a) avatar.n))). The match variable
      ; _! will have as a binding the (wh ...) expression.
      ((setq bindings (bindings-from-ttt-match '(^me tell.v ^you _!) wff))
        (setq info (get-single-binding bindings))
        (setq new-subplan (plan-tell info)))

      ;`````````````````````
      ; Eta: Describing
      ;`````````````````````
      ; Describing, like telling, is an inform-act, but describing conveys a proposition
      ; at an abstract level (e.g. "who I am", describing one's capabilities or appearance, etc.).
      ; This involves access to knowledge in the appropriate categories, and this may then
      ; be further expanded via tell-acts.
      ;
      ; In general, describing is a severe challenge in NLG, but here it will be initially assumed
      ; that we have schemas for expanding any descriptive actions that a plan might call for.
      ; An even simpler way of packaging related sets of sentences for outputs is to just use a
      ; tell-act of type (^me tell.v ^you (meaning-of.f '(<sent1> <sent2> ...))), where the
      ; 'meaning-of.f' function applied to English sentences supplies their semantic interpretation,
      ; reified with the 'that' operator. Combining the two ideas, we can provide schemas for expanding
      ; a describe-act directly into a tell-act with a complex meaning-of.f argument.
      ((setq bindings (bindings-from-ttt-match '(^me describe-to.v ^you _!) wff))
        (setq topic (get-single-binding bindings))
        (setq new-subplan (plan-description topic)))

      ;`````````````````````
      ; Eta: Suggesting
      ;`````````````````````
      ; e.g. (that (^you provide-to.v ^me (K ((attr extended.a) (plur answer.n)))))
      ((setq bindings (bindings-from-ttt-match '(^me suggest-to.v ^you _!) wff))
        (setq suggestion (get-single-binding bindings))
        (setq new-subplan (plan-suggest suggestion)))

      ;`````````````````````
      ; Eta: Asking
      ;`````````````````````
      ; e.g. (ans-to (wh ?x (^you have-as.v major.n ?x)))
      ((setq bindings (bindings-from-ttt-match '(^me ask.v ^you _!) wff))
        (setq query (get-single-binding bindings))
        (setq new-subplan (plan-question query)))

      ;`````````````````````
      ; Eta: Saying hello
      ;`````````````````````
      ((equal wff '(^me say-hello-to.v ^you))
        (setq new-subplan (plan-saying-hello)))

      ;``````````````````````
      ; Eta: Saying good-bye
      ;``````````````````````
      ((equal wff '(^me say-bye-to.v ^you))
        (setq new-subplan (plan-saying-bye)))

      ;```````````````````````````
      ; Eta: Exiting conversation
      ;```````````````````````````
      ; NOTE: duplicated from the above (though different action arguments) -
      ; meant to reflect a more "absolute" say-bye.v action where Eta directly/abruptly
      ; exits the conversation, whereas say-bye-to.v might be used during the exchange of
      ; pleasantries and farewells at the end of a standard conversation.
      ((equal wff '(^me say-bye.v))
        (exit))

      ;`````````````````````````````````````
      ; Eta: Recalling answer from history
      ;`````````````````````````````````````
      ((setq bindings (bindings-from-ttt-match '(^me recall-answer.v _!1 _!2) wff))
        (setq user-ulf (get-single-binding bindings))
        (setq bindings (cdr bindings))
        (setq expr (get-single-binding bindings))

        ; If in *read-log* debug mode, update stored block coordinates according to current log entry and store in context.
        ; TODO: first might need to remove stored block coordinates from context.
        (when *read-log*
          (let ((perceptions (second (nth *log-ptr* *log-contents*))))
            (if (not (listp perceptions)) (setq perceptions nil))
            (remove-old-contextual-fact '(?x at-loc.p ?y))
            (store-new-contextual-facts (update-block-coordinates (remove-if-not #'verb-phrase? perceptions)))))

        ; Get object locations from context
        (setq object-locations (get-from-context '(?x at-loc.p ?y)))
        ;; (format t "found object locations from context: ~a~%" object-locations) ; DEBUGGING

        ; Determine answers by recalling from history
        (if (subsetp '("ulf-lib" "ulf2english" "ulf-pragmatics" "timegraph") *dependencies* :test #'equal)
          (setq ans `(quote ,(recall-answer object-locations (eval user-ulf))))
          (setq ans '()))
        (format t "recalled answer: ~a~%" ans) ; DEBUGGING

        ; Bind ans to variable given in plan (e.g. ?ans-relations)
        (setq var-bindings (cons (list expr ans) var-bindings)))

      ;````````````````````````````````````````
      ; Eta: Seek answer from external source
      ;````````````````````````````````````````
      ((setq bindings (bindings-from-ttt-match '(^me seek-answer-from.v _! _!1) wff))
        (setq system (get-single-binding bindings))
        (setq bindings (cdr bindings))
        (setq query (eval (get-single-binding bindings)))

        ; If in *read-log* debug mode, update stored block coordinates according to current log entry and store in context.
        (when *read-log*
          (let ((perceptions (second (nth *log-ptr* *log-contents*))))
            (if (not (listp perceptions)) (setq perceptions nil))
            (remove-old-contextual-fact '(?x at-loc.p ?y))
            (store-new-contextual-facts (update-block-coordinates (remove-if-not #'verb-phrase? perceptions)))))

        ; Send query to external source
        (if system (write-subsystem (list query) system)))

      ;``````````````````````````````````````````
      ; Eta: Recieve answer from external source
      ;``````````````````````````````````````````
      ((setq bindings (bindings-from-ttt-match '(^me receive-answer-from.v _! _!1) wff))
        (setq system (get-single-binding bindings))
        (setq bindings (cdr bindings))
        (setq expr (get-single-binding bindings))
        ; Get answer from subsystem
        (setq ans (read-subsystem system :block t))
        (if (or *read-log* (not (answer-list? ans))) (setq ans nil))
        (if ans (setq ans `(quote ,ans)))
        (format t "received answer: ~a~% (for variable ~a)~%" ans expr) ; DEBUGGING
        ; Bind ans to variable given in plan (e.g. ?ans-relations)
        (setq var-bindings (cons (list expr ans) var-bindings)))

      ;````````````````````````````
      ; Eta: Conditionally saying
      ;````````````````````````````
      ((setq bindings (bindings-from-ttt-match '(^me conditionally-say-to.v ^you _! _!1) wff))
        (setq user-ulf (get-single-binding bindings))
        (setq bindings (cdr bindings))
        (setq expr (get-single-binding bindings))
        ; Generate response based on list of relations
        (cond
          ((not (member '|Spatial-Reasoning-System| *registered-systems-specialist*))
            (setq ans '(Could not form final answer \: |Spatial-Reasoning-System| not registered \.)))
          (t (let ((tuple (generate-response (eval user-ulf) (eval expr))))
            (setq ans (first tuple))
            (setq eta-ulf (second tuple))
            (store-semantic-interpretation-characterizing-episode eta-ulf ep-name '^me '^you))))
        (format t "answer to output: ~a~%" ans) ; DEBUGGING
        ; If in read-log mode, append answer to list of new log answers
        (when *read-log*
          (setq *log-answer* ans))
        ; Create say-to.v subplan from answer
        (setq new-subplan
          (init-plan-from-episode-list
            (list :episodes (episode-var) (create-say-to-wff ans)))))

      ;````````````````````````````
      ; Eta: Conditionally paraphrasing
      ;````````````````````````````
      ; TODO: I'm not really fond of the way that this is handled currently. It seems like
      ; getting an answer binding from an external system, and communicating that answer,
      ; should be two separate steps in the schema.
      ((setq bindings (bindings-from-ttt-match '(^me conditionally-paraphrase-to.v ^you _! _!1) wff))
        (setq user-ulf (get-single-binding bindings))
        (setq bindings (cdr bindings))
        (setq expr (get-single-binding bindings))
        ; Generate response gist based on list of relations
        (cond
          ((not (member '|Spatial-Reasoning-System| *registered-systems-specialist*))
            (setq ans '(Could not form final answer \: |Spatial-Reasoning-System| not registered \.)))
          (t (let ((tuple (generate-response (eval user-ulf) (eval expr))))
            (setq ans (first tuple))
            (setq eta-ulf (second tuple))
            (store-semantic-interpretation-characterizing-episode eta-ulf ep-name '^me '^you))))
        (format t "gist answer to output: ~a~%" ans) ; DEBUGGING
        ; If in read-log mode, append answer gist to list of new log answers
        (when *read-log*
          (setq *log-answer* ans))
        ; Create paraphrase-to.v subplan from answer
        (setq new-subplan
          (init-plan-from-episode-list
            (list :episodes (episode-var) (create-paraphrase-to-wff ans)))))

      ;````````````````````````````
      ; Eta: Proposing
      ;````````````````````````````
      ((setq bindings (bindings-from-ttt-match '(^me propose1-to.v ^you _!) wff))
        (setq expr (get-single-binding bindings))
        (cond
          ((null (member '|Spatial-Reasoning-System| *registered-systems-specialist*))
            (setq proposal-gist '(Could not create proposal \: '|Spatial-Reasoning-System| not registered \.)))
          (t (setq proposal-gist (generate-proposal expr))))
        ;; (format t "proposal gist: ~a~%" proposal-gist) ; DEBUGGING
        (store-gist-clause-characterizing-episode proposal-gist ep-name '^me '^you)
        (setq new-subplan (plan-proposal proposal-gist)))

      ;````````````````````````````
      ; Eta: Issuing corrections
      ;````````````````````````````
      ; NOTE: currently equivalent to propose1-to.v, except proposals are processed differently
      ; so as to suppress corrections on 'undo' actions and add corrective phrasing.
      ((setq bindings (bindings-from-ttt-match '(^me issue-correction-to.v ^you _!) wff))
        (setq expr (get-single-binding bindings))
        (cond
          ((null (member '|Spatial-Reasoning-System| *registered-systems-specialist*))
            (setq proposal-gist '(Could not create proposal \: |Spatial-Reasoning-System| not registered \.)))
          (t (setq proposal-gist (generate-proposal expr))))
        ;; (format t "proposal gist: ~a~%" proposal-gist) ; DEBUGGING
        (store-gist-clause-characterizing-episode proposal-gist ep-name '^me '^you)
        (setq new-subplan (plan-correction proposal-gist)))

      ;`````````````````````````
      ; Eta: Committing to STM
      ;`````````````````````````
      ; Storing a given wff expression in short-term memory (context)
      ; TODO: currently this action takes a single (reified) fact, e.g.,
      ; (^me commit-to-STM.v (that ((the.d (|Twitter| block.n)) blue.a))).
      ; In the future, it seems like it should be able to support a conjunction
      ; of facts using 'and', rather than having to have many separate actions for each.
      ((setq bindings (bindings-from-ttt-match '(^me commit-to-STM.v (that _!)) wff))
        (setq expr (get-single-binding bindings))
        ; Store each formula in context
        (store-new-contextual-facts (list expr)))

      ;````````````````````````````
      ; Eta: Trying
      ;````````````````````````````
      ; Forms a subplan for whichever argument is given to the try1.v
      ; action. If the subplan is successful (i.e., returns t), store
      ; ((pair ^me ?ep-var) successful.a) in context.
      ; TODO: currently doesn't do anything in particular other than
      ; making a subplan - the context storage is hardcoded into the find4.v
      ; action, which needs to be changed once I hear back from Len.
      ((setq bindings (bindings-from-ttt-match '(^me try1.v (to _!)) wff))
        (setq expr (get-single-binding bindings))
        (setq new-subplan
          (init-plan-from-episode-list
            (list :episodes (episode-var) (cons '^me expr)))))

      ;````````````````````````````
      ; Eta: Finding
      ;````````````````````````````
      ; Finding some action (or other entity?), given an episode like
      ; ?e1 (find4.v (some.d ?ka1 (:l (?x) (?x step1-toward.p ?goal-rep))))
      ; TODO: currently assumes that the request must be sent to the
      ; Spatial-Reasoning-System, but in theory a 'finding' episode could involve
      ; any specialist server, or possibly even none (e.g., 'finding' in memory).
      ; The former can be solved somewhat unelegantly by adding the server as an
      ; argument to this action in the schema; the latter will be more difficult.
      ((setq bindings (bindings-from-ttt-match '(^me find4.v _!) wff))
        (setq expr (get-single-binding bindings))
        (setq sk-var (second expr))
        ; Get goal name from expr, and corresponding record structure
        (setq goal-name (get-single-binding
          (cdr (bindings-from-ttt-match-deep '(_!1 step1-toward.p _!2) expr))))
        (setq goal-schema (get-record-structure goal-name))
        ; Substitute record structure for goal name in expr
        (setq expr (subst goal-schema goal-name expr))
        ; Request step towards goal schema from BW system
        (setq query `((what.pro be.v (= ,expr)) ?))
        (write-subsystem (list query) '|Spatial-Reasoning-System|)

        ; Get answer from BW system
        ; This is either nil or a list (((ka ...) step1-toward.p ($ ...)))
        (setq ans (read-subsystem '|Spatial-Reasoning-System| :block t))
        ; Substitute goal name for record structure in ans
        (setq ans (subst goal-name goal-schema ans :test #'equal))
        ; Set sk-name to reified action
        (setq sk-name (get-single-binding
          (bindings-from-ttt-match-deep '(_!1 step1-toward.p _!2) ans)))
        ; Remove existing step1-toward.p propositions from context, and add new one(s)
        (remove-from-context `(?x step1-toward.p ,goal-name))
        (mapcar #'store-in-context ans)
        ; Substitute skolem name for skolem var in schema
        (format t "found ~a for variable ~a~%" sk-name sk-var)

        ; If a step was found for the current episode, store that
        ; the episode was successful in context
        ; TODO: needs to be changed; see comment on 'Eta: Trying' action.
        ;; (setq superstep (plan-subplan-of subplan))
        ;; (setq ep-name1 (plan-step-ep-name superstep))
        (setq ep-name1 ep-name)
        (if (and sk-name ep-name1)
          (store-in-context `((pair ^me ,ep-name1) successful.a)))

        ; Bind variable to skolem constant in plan
        (setq var-bindings (cons (list sk-var sk-name) var-bindings)))

      ;````````````````````````````
      ; Eta: Choosing
      ;````````````````````````````
      ; Choosing a reference for an indefinite quantifier, given an episode
      ; like ?e1 (^me choose.v (a.d ?c (random.a
      ;            (:l (?x) (and (?x member-of.p ?cc)
      ;                          (not (^you understand.v ?x)))))))
      ; The lambda abstract is used to select candidates (given the facts stored
      ; in context), which is optionally preceded by an additional modifier
      ; (e.g., random.a, (most.mod-a simple.a), etc.) which is used for final
      ; selection from the candidate list.
      ; The canonical name is substituted for the variable in the rest of the plan
      ; (a skolem constant is also generated and aliased to the canonical name, but
      ; is currently unused).
      ((setq bindings (bindings-from-ttt-match '(^me choose.v _!) wff))
        (setq expr (get-single-binding bindings))
        (setq sk-var (second expr))
        (setq sk-name (choose-variable-restrictions sk-var (third expr)))
        (format t "chose value ~a for variable ~a~%" sk-name sk-var) ; DEBUGGING

        ; Store fact that sk-name chosen in context (removing any existing choice)
        ; TODO: perhaps choose.v actions are 'instantaneous' and should therefore be
        ; removed periodically, along with say-to.v actions etc.
        (remove-from-context '(^me choose.v ?x))
        (store-in-context `(^me choose.v ,sk-name))

        ; Bind variable to skolem constant in plan
        (setq var-bindings (cons (list sk-var sk-name) var-bindings)))

      ;```````````````````````````````````````
      ; Eta: Forming a spatial representation
      ;```````````````````````````````````````
      ; Form some spatial representation of a concept (i.e., of an
      ; object schema). Given an episode like:
      ; ?e2 (^me form-spatial-representation.v (a.d ?goal-rep ((most.mod-a simple.a)
      ;        (:l (?x) (and (?x goal-schema1.n) (?x instance-of.p ?c))))))
      ; First, Eta queries the BW system for the spatial representation, using the indefinite
      ; quantifier. Then, Eta reads the goal representation from the BW system, generates a name for
      ; the goal representation, and substitutes it in the schema.
      ((setq bindings (bindings-from-ttt-match '(^me form-spatial-representation.v _!) wff))
        (setq expr (get-single-binding bindings))
        (setq sk-var (second expr))
        ; Get concept name from expr, and corresponding record structure
        (setq concept-name (get-single-binding
          (cdr (bindings-from-ttt-match-deep '(_!1 instance-of.p _!2) expr))))
        (setq concept-schema (get-record-structure concept-name))
        ; Substitute record structure for concept name in expr
        (setq expr (subst concept-schema concept-name expr))
        ; Request goal representation from BW system
        (setq query `((what.pro be.v (= ,expr)) ?))
        (write-subsystem (list query) '|Spatial-Reasoning-System|)

        ; Get answer from BW system
        ; This is a list of relations ((($ ...) goal-schema1.n) (($ ...) instance-of.p ($ ...)))
        (setq ans (read-subsystem '|Spatial-Reasoning-System| :block t))
        ; Create name for goal representation and add alias
        (setq sk-name (gensym "BW-goal-rep"))
        (setq goal-schema (get-single-binding
          (bindings-from-ttt-match-deep '(_! goal-schema1.n) ans)))
        (add-alias goal-schema sk-name)
        ; Substitute canonical names for record structures in relations
        (setq ans (subst concept-name concept-schema ans :test #'equal))
        (setq ans (subst sk-name goal-schema ans :test #'equal))
        ; Store answer in context
        (mapcar #'store-in-context ans)
        ; Substitute skolem name for skolem var in schema
        (format t "formed representation ~a for variable ~a~%" sk-name sk-var)
        
        ; Bind variable to skolem constant in plan
        (setq var-bindings (cons (list sk-var sk-name) var-bindings)))

      ;````````````````````````````
      ; Eta: Initiating Subschema
      ;````````````````````````````
      ((setq bindings (bindings-from-ttt-match '(^me schema-header? ^you (? _*)) wff))
        (setq args-list (get-multiple-bindings bindings))
        ; If episode is an obviated action, skip, otherwise generate subplan from schema name
        (cond
          ((obviated-action ep-name)
            (setq new-subplan nil))
          (t (setq new-subplan (init-plan-from-schema (schema-name! (second wff)) args-list)))))
      
      ; Unrecognizable step
      (t (format t "~%*** UNRECOGNIZABLE STEP ~a " wff) (error))
    )

    ; Return new subplan (possibly nil) and any variable bindings
    (list var-bindings new-subplan)

)) ; END implement-next-eta-action





(defun interpret-perception-in-context (fact plan)
;````````````````````````````````````````````````````````
; Interpret a 'primitive' perception in the context of the current plan status.
; In the case of a perceived "^you say-to.v ^me" action by the user, the relevant
; context is the previous speech act in the plan (typically by Eta), and the user's
; reply is 'automatically' interpreted as a response to that speech act.
;
; e.g., suppose the previous speech act by Eta in the plan is:
; E1 (^me say-to.v ^you '(What is your favorite type of food ?))
;
; And the following action by the user is perceived:
; E2 (^you say-to.v ^me '(Thai food \.))
;
; We want to try to interpret the utterance in E2 using the context of E1 (particularly, the gist-clause
; corresponding to Eta's utterance), extracting a gist-clause and semantic interpretation (when relevant)
; for the user, and possibly additional inferences. After doing so (and storing them in memory), we store
; the fact:
; ((^you reply-to.v E1) ** E2)
;
  (let* (ep-name wff expr bindings words prev-step prev-step-ep-name prev-step-wff prev-step-gist-clauses
         user-gist-clauses user-ulfs inferred-wffs goal-step ka try-success
         (curr-step (plan-curr-step plan)) (curr-step-wff (plan-step-wff curr-step)))

    (setq ep-name (first fact))
    (setq wff (second fact))

    ; Conditional statement matching different types of 'primitive' observed wffs
    (cond
      ;```````````````````````````
      ; User: Saying -> Replying
      ;```````````````````````````
      ((setq bindings (bindings-from-ttt-match '(^you say-to.v ^me _!) wff))
        (setq expr (get-single-binding bindings))

        ; If say-to.v act has a quoted word list argument, e.g., '(nice to meet you \.)',
        ; it should unquote and decompress the words.
        (cond
          ((quoted-sentence? expr)
            (setq words (decompress (second expr))))
          ; Anything else is unexpected
          (t
            (format t "~%*** SAY-ACTION ~a~%    BY THE USER SHOULD SPECIFY A QUOTED WORD LIST OR VARIABLE" expr)))

        ; Use previous speech act as context for interpretation
        (setq prev-step (find-prev-step-of-type plan '^me *speech-acts*))
        (when prev-step
          (setq prev-step-ep-name (plan-step-ep-name prev-step))
          (setq prev-step-wff (plan-step-wff prev-step)))

        ;; (format t "~%wff = ~a,~%     in the context of ~a ~a~%" wff prev-step-ep-name prev-step-wff) ; DEBUGGING

        ; Get gist-clauses corresponding to previous speech act
        (setq prev-step-gist-clauses (get-gist-clauses-characterizing-episode prev-step-ep-name))

        ; If current plan step is a relative speech act with a past episode as an argument
        ; (e.g., (^you reply-to.v E1)), use the gist-clauses of that episode for interpretation as well
        (when (and (relative-speech-act? curr-step-wff) (not (equal (third curr-step-wff) prev-step-ep-name)))
          (setq prev-step-gist-clauses (append prev-step-gist-clauses
            (get-gist-clauses-characterizing-episode (third curr-step-wff)))))

        ;; (format t "~%ETA gist clauses that the user is responding to (from episode ~a)~% = ~a " prev-step-ep-name prev-step-gist-clauses)
        ;; (format t "~%using gist clause: ~a~% " (car (last prev-step-gist-clauses))) ; DEBUGGING

        ; Compute the "interpretation" (gist clauses) of the user input,
        ; which will be done with a gist-clause packet selected using the
        ; main Eta action clause, and with the user input being the text
        ; to which the tests in the gist clause packet (tree) are applied.
        ;
        ; TODO: In the future, we might instead of or in addition use the semantic
        ; interpretation of Eta's previous speech act.
        (setq user-gist-clauses
          (form-gist-clauses-from-input words (car (last prev-step-gist-clauses))))

        ; Remove contradicting user gist-clauses (if any)
        (setq user-gist-clauses (remove-contradiction user-gist-clauses))
        ;; (format t "~%Obtained user gist clauses ~a for episode ~a" user-gist-clauses ep-name) ; DEBUGGING

        ; Store user gist-clauses in memory
        (dolist (user-gist-clause user-gist-clauses)
          (store-gist-clause-characterizing-episode user-gist-clause ep-name '^you '^me))

        ; Obtain semantic interpretation(s) of the user gist-clauses
        (setq user-ulfs (mapcar #'form-ulf-from-clause user-gist-clauses))
        ;; (format t "~%Obtained ulfs ~a for episode ~a" user-ulfs ep-name) ; DEBUGGING

        ; Store the semantic interpretations in memory
        (dolist (user-ulf user-ulfs)
          (store-semantic-interpretation-characterizing-episode user-ulf ep-name '^you '^me))

        ; Add the fact (^you reply-to.v <prev-step-ep-name>) to context (characterizing ep-name)
        (when prev-step-ep-name
          (store-contextual-fact-characterizing-episode `(^you reply-to.v ,prev-step-ep-name) ep-name))

        ; If current plan step is a relative speech act, add the fact (^you reply-to.v <rel-ep-name>) as well
        (when (and (relative-speech-act? curr-step-wff) (not (equal (third curr-step-wff) prev-step-ep-name)))
          (store-contextual-fact-characterizing-episode `(^you reply-to.v ,(third curr-step-wff)) ep-name))

        ; Infer any additional facts from user gist-clauses
        ; TODO: since this is now input-driven inference rather than (gist-clause/LF) interpretation,
        ; it should probably be moved to a different function, perhaps using another queue of 'new'
        ; gist-clauses or LF interpretations. Ultimately, it seems like this sort of inference should
        ; be done directly using the LF interpretations, rather than the gist-clause, but using 
        ; gist-clauses is more straightforward for now.
        ; TODO: currently this only supports one inferred wff per gist-clause, but it should allow multiple.
        ; NOTE: for now, we assume that each user utterance is described by only one action type,
        ; so the gist clauses are concatenated together first.
        (setq inferred-wffs (remove nil (mapcar #'form-inferences-from-gist-clause user-gist-clauses)))

        ;; (format t "~%Inferred wffs ~a for episode ~a~%" inferred-wffs ep-name) ; DEBUGGING

        ; Add each inferred wff to context (characterizing ep-name)
        (dolist (inferred-wff inferred-wffs)
          (store-contextual-fact-characterizing-episode inferred-wff ep-name))

        ; Add discourse state to stack
        (push (deepcopy-ds *ds*) *ds-stack*)

        ; Log the user's turn
        (log-turn (list words user-gist-clauses (resolve-references user-ulfs) inferred-wffs) :agent 'user)

      )
      ;````````````````````````````
      ; User: Moving -> Trying
      ;````````````````````````````
      ((setq bindings (bindings-from-ttt-match '(^you action-verb? _*) wff))
        (setq expr (get-multiple-bindings bindings))

        ;; (format t "~%Matched arguments = ~a" expr) ; DEBUGGING

        ; Check context for any current goal step; get reified action from goal step
        (setq goal-step (car (get-from-context '(?ka step1-toward.p ?goal))))
        (setq ka (first goal-step))
        
        (format t "~%Found ka = ~a" ka) ; DEBUGGING

        ; If the (ka ...) consists of an action verb, check arguments of action verb against arguments of
        ; the matched action to check if the action successfully instantiates (ka ...)
        (when (action-verb? (car (second ka)))
          (when (and (equal (length (cdr (second ka))) (length expr))
                     (every (lambda (x y) (equal x y)) (cdr (second ka)) expr))
            (setq try-success t)))

        ;; (format t "~%Match between ~a and ~a successful?: ~a~%" (cdr (second ka)) expr try-success) ; DEBUGGING

        ; If the action was successful, store the following facts in context
        (when try-success
          (store-in-context `((pair ^you ,ep-name) successful.a))
          (store-in-context `((pair ^you ,ep-name) instance-of.p ,ka)))
        
        ; Store (^you try1.v (ka ...)) as characterizing ep-name regardless
        (store-contextual-fact-characterizing-episode `(^you try1.v ,ka) ep-name)

      )
      ; Some other wff (currently nothing is done in this case)
      (t nil))

)) ; END interpret-perception-in-context





(defun plan-if-else (expr)
;``````````````````````````````````````````
; expr = (cond name1 wff1 name2 wff2 ... :else name3 wff3 name4 wff4 ...)
; Expr is a condition followed by consecutive name & wff pairs. Optionally,
; this is followed by an :else keyword and additional name & wff pairs.
;
  (let* ((cnd (car expr)) (rst (cdr expr))
         (else-episodes (car (get-keyword-contents rst '(:else))))
         (if-episodes (if (not else-episodes) rst
          (reverse (set-difference rst (member :else rst))))))
    (cond
      ; Try conditional
      ((eval-truth-value cnd)
        (init-plan-from-episode-list (cons :episodes if-episodes)))
      ; Otherwise try else, if it exists
      (else-episodes
        (init-plan-from-episode-list (cons :episodes else-episodes)))))
) ; END plan-if-else





(defun plan-try-in-sequence (expr)
;``````````````````````````````````````````````````
; expr = ((:if cond1 name1.1 wff1.1 name1.2 wff1.2 ...)
;         (:if cond2 name2.1 wff2.1 name2.2 wff2.2 ...) ...
;         (:else name3.1 wff3.1 name3.2 wff3.2 ...))
; Expr is a list of consecutive (:if cond e1 e2 ...) lists, potentially followed
; by a final (:else e1 e2 ...) list. These conditions should be tried in sequence,
; instantiating the first one which holds true.
;
  (let* ((lst1 (car expr)) (else1 (if (equal (first lst1) :else) t))
         (cond1 (if (not else1) (second lst1)))
         (episodes1 (if (not else1) (cddr lst1) (cdr lst1))))
    (cond
      ; None of the cases have been matched, so no subplan is generated
      ((null expr) nil)
      ; If the condition is satisfied, create a subplan from the episode list
      ((or else1 (eval-truth-value cond1))
        (init-plan-from-episode-list (cons :episodes episodes1)))
      ; Otherwise, try next condition & episodes
      (t (plan-try-in-sequence (cdr expr))))
)) ; END plan-try-in-sequence





(defun plan-repeat-until (subplan ep-name expr)
;`````````````````````````````````````````````````````````
; expr = (ep-var cond name1 wff1 name2 wff2 ...)
;
; 'ep-name' is the name of the reoccuring :repeat-until episode. It will
; be used again in the recursion at the end of the plan we are forming;
; 'expr' is of form
;    (ep-var cond name1 wff1 name2 wff2 ...), 
; where cond is the stop condition of the repeated event,
; 'name1' is the episode characterized by the first action- or event-wff
; 'wff1', 'name2' is the episode characterized by the 2nd action- or
; event-wff 'wff2', etc.
;
; The subplan (if wff0 is false) will consist of all the steps of the loop (with
; duplicate action names created, which inherit any attached gist clauses/ulf/etc.), 
; and ending with another repeat-until loop, identical to the original one.
;
; TODO: I THINK I'LL ALSO NEED 'plan-seq-acts', 'plan-consec-acts', ETC.
; THESE SHOULD BE PRETTY SIMPLE, JUST LISTING THE ACTIONS & PROVIDING
; seq-ep, consec-ep, ETC. RELATIONS IN THE SUBPLAN. 
;
  (let ((cond1 (first expr)) (expr-rest (cdr expr)) truth-val new-subplan)
    ; First check termination condition
    (setq truth-val (eval-truth-value cond1))
    ; Substitute expr-rest with duplicate variables
    (setq expr-rest (subst-duplicate-variables subplan expr-rest))
    (cond
      ; Termination has been reached - return nil so the calling program can delete loop
      (truth-val nil)
      ; Otherwise, create a subplan that has the steps of the loop & a recursive copy of the loop
      (t (setq new-subplan
          (init-plan-from-episode-list
            (cons :episodes (append expr-rest (list ep-name (cons :repeat-until expr))))))
        new-subplan))
)) ; END plan-repeat-until





(defun plan-reaction-to (user-gist-clauses user-ulf ep-name)
;````````````````````````````````````````````````````````````````
; Starting at a top-level choice tree root, choose an action or
; subschema suitable for reacting to 'user-gist-clauses' (which
; is one or more sentences, without tags (and with a final detached
; "\." or "?"), that try to capture the main content (gist) of
; a user input). Return the (new) name of a plan for realizing 
; that action or subschema.
;
; If the action arrived at is a particular verbal output (instantiated
; reassembly pattern, where the latter was signalled by directive :out, 
; & is indicated by ':out' in the car of the 'choose-result-for' result), 
; form a plan with one action, viz. the action of saying that verbal 
; output.
;
; If the action arrived at is another choice tree root (signalled by
; directive :subtree), this will be automatically pursued recursively
; in the search for a choice, ultimately delivering a verbal output
; or a schema name.
;
; If the action arrived at is a :schema+args "action" (a schema name
; along with an argument list), use this schema to form a subplan.
;
; ** Should the new subplan name also receive a 'semantics'
; property? ... We don't really expect a further user response to these
; reactive comments from Eta, which would then need to be understood
; in light of the meaning of these reactive comments...More thought
; required.
;
  (let (user-gist-words choice wff schema-name args eta-gist-clause keys)
    
    (if (null user-gist-clauses)
      (return-from plan-reaction-to nil))

    ; Currently we're only using a single ulf
    (if user-ulf (setq user-ulf (car user-ulf)))

    ; If the extracted ulf specifies an :out directive, we want to create a
    ; say-to.v subplan directly
    ; TODO: this is not very elegant - not sure it makes sense for the value
    ; of the user's ULF to be an out directive by Eta...
    (when (and user-ulf (eq (car user-ulf) :out))
      (return-from plan-reaction-to
        (init-plan-from-episode-list
          (list :episodes (episode-var) (create-say-to-wff (cdr user-ulf))))))

    ; Remove 'nil' gist clauses (unless the only gist clause is the 'nil' gist clause)
    (setq user-gist-clauses_p (purify-func user-gist-clauses))

    ; We use either choice tree '*reaction-to-input*' or
    ; '*reactions-to-input*' (note plural) depending on whether
    ; we have one or more gist clauses.
    (cond
      ; Single gist clause
      ((null (cdr user-gist-clauses_p))
        (setq choice (choose-result-for (car user-gist-clauses_p) '*reaction-to-input*))
        ;; (format t "~% (single clause) choice are ~a ~% " choice) ; DEBUGGING
      )

      ; Multiple gist clauses
      (t
        ;; (format t "~% user-gist-words are ~a ~% " user-gist-clauses_p) ; DEBUGGING
        (setq user-gist-words (apply 'append user-gist-clauses_p))
        ;; (format t "~% user-gist-words are ~a ~% " user-gist-words) ; DEBUGGING
        (setq choice (choose-result-for user-gist-words '*reactions-to-input*))
        ;; (format t "~% choice is ~a ~% " choice) ; DEBUGGING
    ))

    ; 'choice' may be an instantiated reassembly pattern corresponding to a
    ; gist-clause (directive :gist), to be contextually paraphrased by Eta
    ; as a subplan, or a direct output (directive :out) to be spoken to the
    ; user as a subplan. Otherwise it may be the name of a schema (to be initialized).
    ; In the first case we create a 1-step subplan whose action is of
    ; the type (^me paraphrase-to.v ^you '(...)) or (^me say-to.v ^you '(...)),
    ; respectively, where in the latter case the verbal output is adjusted by
    ; applying 'modify-response' to the reassembly patterns.
    ; In the case of a schema, we initiate a multistep plan.
    (cond
      ; null choice -- use GPT3 to generate a reaction (if in GPT3 response generation mode);
      ; otherwise generate an "empty" say-to.v action.
      ((null choice)
        (init-plan-from-episode-list
          (list :episodes (episode-var) (create-say-to-wff
            (if (equal *response-generator* 'GPT3)
              (form-surface-utterance-using-language-model)
              nil)))))

      ; :gist directive
      ((eq (car choice) :gist)
        (cond
          ((atom (first (cdr choice)))
            (setq eta-gist-clause (cdr choice)))
          (t
            (setq eta-gist-clause (first (cdr choice)))
            (setq keys (second (cdr choice)))))
        ;; (format t "~%chosen Eta gist clause = ~a~%" eta-gist-clause) ; DEBUGGING
        ; Store Eta's gist-clause under top-level episode
        (store-gist eta-gist-clause keys (ds-gist-kb-eta *ds*))
        (store-gist-clause-characterizing-episode eta-gist-clause ep-name '^me '^you)
        ; Add paraphrase-to.v subplan
        (init-plan-from-episode-list
          (list :episodes (episode-var) `(^me paraphrase-to.v ^you (quote ,eta-gist-clause)))))

      ; :out directive
      ((eq (car choice) :out)
        (if (null (cdr choice)) nil
          (init-plan-from-episode-list
            (list :episodes (episode-var) (create-say-to-wff (cdr choice))))))

      ; :schema directive
      ((eq (car choice) :schema)
        (setq schema-name (cdr choice))
        (init-plan-from-schema schema-name nil))

      ; :schema+args directive
      ((eq (car choice) :schema+args)
        ; We assume that the cdr of 'choice' must then be of form
        ; (<schema name> <argument list>)
        ; The idea is that the separate pieces of the word sequence
        ; supply separate gist clauses that Eta may react to in the
        ; steps of the schema. These are provided as sublists in 
        ; <argument list>.
        (setq schema-name (first (cdr choice)) args (second (cdr choice)))
        (init-plan-from-schema schema-name args))

      ; :schema+ulf directive
      ((eq (car choice) :schema+ulf)
        ; TODO: Just a temporary directive to test spatial-question schema. Needs changing.
        (setq schema-name (cdr choice) args (list `(quote ,(resolve-references user-ulf)) nil))
        (init-plan-from-schema schema-name args))
    )
)) ; END plan-reaction-to





(defun plan-proposal (proposal-gist)
;````````````````````````````````````````````````
; Given a proposal gist clause, convert it to an utterance using
; hierarchical transduction trees, starting at a top-level choice
; tree root.
; NOTE: currently only :out directives are expected, but this can
; be expanded if we find e.g. subschema instantiation is necessary
; (for example, if some particularly complex proposal that needs
; to be broken down into multiple actions).
;
  (let (choice)

    (if (null proposal-gist)
      (return-from plan-proposal nil))

    (setq choice (choose-result-for proposal-gist '*output-for-proposal-tree*))
    ;; (format t "~% proposal choice is ~a ~% " choice) ; DEBUGGING

    (when (or (null choice) (equal choice '(:out)))
      (return-from plan-proposal nil))

    (cond
      ; :out directive
      ((eq (car choice) :out)
        (init-plan-from-episode-list
          (list :episodes (episode-var) (create-say-to-wff (cdr choice))))))
)) ; END plan-proposal





(defun plan-correction (correction-gist)
;````````````````````````````````````````````````````
; Given a correction gist clause, convert it to an utterance using
; hierarchical transduction trees, starting at a top-level choice
; tree root.
; NOTE: the same as plan-proposal, but uses a different rule tree.
;
  (let (choice)

    (if (null correction-gist)
      (return-from plan-correction nil))

    (setq choice (choose-result-for correction-gist '*output-for-correction-tree*))
    ;; (format t "~% correction choice is ~a ~% " choice) ; DEBUGGING

    (when (or (null choice) (equal choice '(:out)))
      (return-from plan-correction nil))

    (cond
      ; :out directive
      ((eq (car choice) :out)
        (init-plan-from-episode-list
          (list :episodes (episode-var) (create-say-to-wff (cdr choice))))))
)) ; END plan-correction





(defun plan-tell (info) ; TBC
;`````````````````````````````
; Return the name of a plan for telling the user the 'info';
; 'info' is a reified proposition that may be in a form that makes
; verbalization trivial, e.g.,
;     (meaning-of.f '(I am Eta. I am an autonomous avatar.))
; where the 'meaning-of.f' function in principle provides EL
; propositions corresponding to English sentences -- i.e., semantic
; parser output, reified using 'that'; but of course, for verbal-
; ization we don't need to first convert to EL! Or else the info 
; is directly in EL form, e.g.,
;     (that (^me have-as.v name.n 'Eta)), or
;     (that (^me be.v ((attr autonomous.a) avatar.n))),
; which requires English generation for a fully expanded tell
; act.
;
  (if (null info) (return-from plan-tell nil))
  ; TBC
) ; END plan-tell





(defun plan-description (topic) ; TBC
;`````````````````````````````````````
  (if (null info) (return-from plan-description nil))
  ; TBC
) ; END plan-description





(defun plan-suggest (suggestion) ; TBC
;````````````````````````````````````````
  (if (null suggestion) (return-from plan-suggest nil))
  ; TBC
) ; END plan-suggest





(defun plan-question (query) ; TBC
;```````````````````````````````````
  (if (null query) (return-from plan-question nil))
  ; TBC
) ; END plan-question





(defun plan-saying-hello () ; TBC
;`````````````````````````````````
  ; TBC
) ; END plan-saying-hello





(defun plan-saying-bye () ; TBC
;```````````````````````````````
  ; TBC
) ; END plan-saying-bye





(defun observe-variable-type (sk-var type)
;```````````````````````````````````````````
; Through observation of the world, find an entity which can fill in
; variable of type (variable assumed to be neither in schema header or
; filled in at later point in schema).
;
  (let (sk-name sk-const)
    (setq sk-const (skolem (implode (cdr (explode sk-var)))))
    (setq sk-name
      (car (find-all-instances-context `(:l (?x) (?x ,type)))))
    (add-alias sk-const sk-name)
    sk-name)
) ; END observe-variable-type





;; (defun form-spatial-representation ()
;; ;``````````````````````````````````````
;; ; TODO: now deprecated; will delete in the future.
;; ; Forms a spatial representation from the currently chosen BW-concept.n
;; ; (assuming such a choice has actually been made at this point), through
;; ; sending the BW system the chosen concept schema and receiving a goal
;; ; schema.
;; ; TODO: I'm not sold on how this is done currently, but I'm stumped on
;; ; how to do it more sensibly. The issue is that, for the lambda expression
;; ; + find-all-instances to work, the facts about the goal schema need to be
;; ; stored ahead-of-time, so the communication of the goal schema needs to be
;; ; done before the 'choice' step of the indefinite quantifier. This requires
;; ; sending the BW system the chosen concept schema, but the concept schema
;; ; name is nested inside the lambda extract, and messing with that here would
;; ; be a pretty messy approach. Instead, I check context for some individual such
;; ; that it is a BW-concept.n and Eta has chosen it.
;; ; TODO: BW-concept.n in lambda descr should be valid, reachable through subsumption
;; ; relationship between BW-concept.n and BW-concept-structure.n/BW-concept-primitive.n
;; ; in noun hierarchy.
;; ;
;;   (let (concept-name goal-schema goal-name)
;;     (setq concept-name (car (find-all-instances-context
;;       '(:l (?x) (and (?x BW-concept-structure.n) (^me choose.v ?x))))))
;;     (request-goal-rep (cdr (get-record-structure concept-name)))
;;     ; NOTE: currently no special offline (terminal mode) procedure
;;     ; for getting goal schema.
;;     (setq goal-schema (get-goal-rep))
;;     (setq goal-name (gensym "BW-goal-rep"))
;;     (add-alias (cons '$ goal-schema) goal-name)
;;     (store-in-context (list goal-name 'goal-schema1.n))
;;     (store-in-context (list goal-name 'instance-of.p concept-name)))
;; ) ; END form-spatial-representation





;; (defun observe-step-towards-goal (goal-rep)
;; ;`````````````````````````````````````````````
;; ; TODO: now deprecated; will delete in the future.
;; ; Observes next step towards the currently active BW goal-schema,
;; ; through reading IO file. Store fact in context.
;; ; TODO: might need changing - see note on 'find4.v' implementation.
;; ; Currently, the (?x step1-toward.p ?goal-rep) step is hard-coded
;; ; (based on the value of ?goal-rep extracted from the lambda function
;; ; in the find4.v action), which it shouldn't be.
;; ;
;;   (let (step)
;;     (setq step (if (member '|Spatial-Reasoning-System| *registered-systems-specialist*)
;;                     (get-planner-input)
;;                     (get-planner-input-offline)))
;;     (remove-from-context `(?x step1-toward.p ,goal-rep))
;;     (if step
;;       (store-in-context `(,step step1-toward.p ,goal-rep))))
;; ) ; END observe-step-toward-goal





(defun choose-variable-restrictions (sk-var restrictions)
;``````````````````````````````````````````````````````````
; Handles any indefinite quantification of a variable filled
; through a choice  made by Eta, given a list of restrictions.
; 'sk-var' is the variable to be replaced, e.g., '?c'.
; 'restrictions' may be a lambda abstract, possibly preceded by
; some adjective modifier, e.g.,
; (random.a (:l (?x) (and (?x member-of.p ?cc)
;                         (not (^you understand.v ?x)))))
;
  (let (sk-name sk-const lambda-descr modifier candidates)
    (setq sk-const (skolem (implode (cdr (explode sk-var)))))
    ; Allow for initial modifier 
    (when (not (lambda-descr? restrictions))
      (setq modifier (car restrictions)) (setq restrictions (second restrictions)))
    (setq lambda-descr restrictions)
    (setq candidates (find-all-instances-context lambda-descr))
    (format t "given restriction ~a, found candidates ~a~%" lambda-descr candidates) ; DEBUGGING
    (format t "using modifier ~a to choose~%" modifier) ; DEBUGGING
    (setq sk-name (cond
      ((equal modifier 'random.a)
        (nth (random (length candidates)) candidates))
      (t (car candidates))))
    sk-name)
) ; END choose-variable-restrictions





(defun obviated-question (sentence eta-action-name)
;````````````````````````````````````````````````````
; Check whether this is a (quoted, bracketed) question.
; If so, check what facts, if any, are stored in gist-kb-user under 
; the 'topic-keys' obtained as the value of that property of
; 'eta-action-name'. If there are such facts, check if they
; seem to provide an answer to the gist-version of the question.
; NOTE: modified to check if gist clause contains question rather than surface
; sentence (B.K. 4/17/2020)
;
  (let (gist-clauses topic-keys facts)
    ;; (format t "~% ****** input sentence: ~a~%" sentence)
    (setq gist-clauses (get-gist-clauses-characterizing-episode eta-action-name))
    ;; (format t "~% ****** gist clauses are ~a **** ~%" gist-clauses)
    ;; (format t "~% ****** quoted question returns ~a **** ~%" (some #'question? gist-clauses)) ; DEBUGGING
    (if (not (some #'question? gist-clauses))
      (return-from obviated-question nil))
    (setq topic-keys (get eta-action-name 'topic-keys))
    ;; (format t "~% ****** topic key is ~a ****** ~%" topic-keys) ; DEBUGGING
    (if (null topic-keys) (return-from obviated-question nil))
    (setq facts (remove nil (mapcar (lambda (key) (gethash key (ds-gist-kb-user *ds*))) topic-keys)))
    ;; (format t "~% ****** gist-kb ~a ****** ~%" (ds-gist-kb-user *ds*))
    ;; (format t "~% ****** list facts about this topic = ~a ****** ~%" facts)
    ;; (format t "~% ****** There is no fact about this topic. ~a ****** ~%" (null facts)) ; DEBUGGING
    (if (null facts) (return-from obviated-question nil))
    ; We have an Eta question, corresponding to which we have stored facts
    ; (as user gist clauses) that seem topically relevant.
    ; NOTE: in this initial version, we don't try to verify that the facts
    ; actually obviate the question, but just assume that they do. 
  facts)
) ; END obviated-question





(defun obviated-action (eta-action-name)
;`````````````````````````````````````````
; Check whether this is an obviated action (such as a schema instantiation),
; i.e. if the action has a topic-key(s) associated, check if any facts are stored
; in gist-kb-user under the topic-key(s). If there are such facts, we assume that
; these facts obviate the action, so the action can be deleted from the plan.
;
  (let (topic-keys facts)
    (setq topic-keys (get eta-action-name 'topic-keys))
    ;; (format t "~% ****** topic key is ~a ****** ~%" topic-keys) ; DEBUGGING
    (if (null topic-keys) (return-from obviated-action nil))
    (setq facts (remove nil (mapcar (lambda (key) (gethash key (ds-gist-kb-user *ds*))) topic-keys)))
    ;; (format t "~% ****** gist-kb ~a ****** ~%" (ds-gist-kb-user *ds*))
    ;; (format t "~% ****** list facts about this topic = ~a ****** ~%" facts)
    ;; (format t "~% ****** There is no fact about this topic. ~a ****** ~%" (null facts)) ; DEBUGGING
    (if (null facts) (return-from obviated-action nil))
  facts)
) ; END obviated-action





(defun form-surface-utterance-using-language-model (&optional gist-clause)
;```````````````````````````````````````````````````````````````````````````````````````````
; Generate a surface utterance using a language model (currently, GPT-3).
;
; This will automatically generate a prompt using the system's current schema
; and some relevant pieces of knowledge.
;
; In the case where a particular Eta gist-clause is given as input, this will be
; treated as a paraphrasing task: the prompt will be followed by several examples
; of paraphrases (relevant examples are retrieved using pattern transduction based
; on the given gist-clause), and the model will be prompted to paraphrase the
; given gist-clause in the context of the previous user utterance.
;
; In the case where gist-clause is nil, this will be treated as unconstrained
; generation: the prompt will be followed by the full dialogue hisory, and the
; model will be prompted to generate the next response.
;
  (let ((curr-subplan (find-curr-subplan (ds-curr-plan *ds*))) utterance
        preconds goals relevant-knowledge facts history facts-str history-str
        choice examples examples-str emotion prev-utterance)

    ; Get preconditions and goals of schema
    ; TODO: add other relevant schema categories here in the future
    (setq preconds (mapcar #'second (reverse (plan-preconds curr-subplan))))
    (setq goals (mapcar #'second (reverse (plan-goals curr-subplan))))

    ; Get relevant knowledge
    ; TODO: replace the following once a more general retrieval method is used
    (setq relevant-knowledge (reverse (get-all-from-kb)))

    ; Combine facts and convert to strings
    (setq facts (append relevant-knowledge preconds goals))
    (setq facts-str (remove nil (mapcar (lambda (fact)
      (if (sentence? fact)
        (words-to-str fact)
        (ulf-to-str fact)))
      facts)))

    ; Get history strings (removing any emotion tags)
    (setq history (reverse (first (ds-conversation-log *ds*))))
    (setq history (mapcar (lambda (turn)
      (list (first turn) (untag-emotions (second turn)))) history))
    (setq history-str (mapcar (lambda (turn)
      (list (string (first turn)) (words-to-str (second turn)))) history))

    ; Generate response
    (cond
      ; Gist-clause given: Paraphrase task
      (gist-clause

        ; Get example strings
        (setq choice (choose-result-for gist-clause '*prompt-examples-tree*))
        (when (eq (car choice) :prompt-examples)
          (setq examples (cdr choice)))
        (setq examples-str
          (mapcar (lambda (example) (mapcar #'words-to-str example)) examples))

        ; Get previous user utterance
        (setq prev-utterance (second (car (last
          (remove-if (lambda (turn) (equal (first turn) (string *^me*))) history)))))
        
        ; If no previous user utterance, create a generic one
        (when (null prev-utterance)
          (setq prev-utterance '(Hello \.)))
        
        ; Get utterance
        (setq utterance (get-gpt3-paraphrase facts-str examples-str
          (words-to-str prev-utterance)
          (words-to-str gist-clause))))


      ; No gist clause: Unconstrained generation task
      (t

        ; Get utterance
        (setq utterance (get-gpt3-response facts-str history-str))))

    ; Generate emotion tag for utterance (if enabled)
    (when *emotions*
      (setq emotion (get-gpt3-emotion (words-to-str utterance) (last history-str 3)))
      (setq utterance (cons emotion utterance)))

    ;; (format t "~% utterance = ~a" utterance) ; DEBUGGING   

    utterance
)) ; END form-surface-utterance-using-language-model





(defun form-surface-utterance-from-gist-clause (gist-clause prior-gist-clause)
;``````````````````````````````````````````````````````````````````````````````
; Given a gist-clause by Eta, elaborate it into a surface utterance using the
; context provided by the prior gist-clause using choice trees.
;
; First this uses Eta's gist-clause to select a relevant subtree for response
; generation, then it uses the context of the previous gist-clause to select
; the surface utterance.
;
  (let (choice relevant-tree utterance)

    ; Get the relevant pattern transduction tree given Eta's gist clause
    ;````````````````````````````````````````````````````````````````````````````````````````````````
    ;; (format t "~% gist-clause = ~a" gist-clause) ; DEBUGGING
    (setq choice (choose-result-for gist-clause '*gist-clause-trees-for-response*))

    ; Get the surface utterance using context (if applicable)
    ;````````````````````````````````````````````````````````````````````````````````````````````````
    (cond
      ; :out directive; output utterance directly without using context
      ((eq (car choice) :out)
        (setq utterance (cdr choice)))

      ; :subtrees directive; use first subtree to select response based on context
      ((eq (car choice) :subtrees)
        (setq relevant-tree (cadr choice))
        ;; (format t "~% relevant tree = ~a" relevant-tree) ; DEBUGGING   
        ;; (format t "~% prior-gist-clause = ~a" prior-gist-clause) ; DEBUGGING
        (setq utterance (cdr
          (choose-result-for prior-gist-clause relevant-tree)))))

    ;; (format t "~% utterance = ~a" utterance) ; DEBUGGING   

    utterance
)) ; END form-surface-utterance-from-gist-clause





(defun form-gist-clauses-from-input (words prior-gist-clause)
;``````````````````````````````````````````````````````````````
; Find a list of gist-clauses corresponding to the user's 'words',
; interpreted in the context of 'prior-gist-clause' (usually a
; question output by the system). Use hierarchically related 
; choice trees for extracting gist clauses.
;
; The gist clause extraction patterns will be similar to the
; ones in the choice packets for reacting to inputs, used in
; the previous version; whereas the choice packets for reacting
; will become simpler, based on the gist clauses extracted from
; the input.
;
; - look for a final question -- either yes-no, starting
;   with auxiliary + "you{r}", or wh-question, starting with
;   a wh-word and with "you{r}" coming within a few words.
;   "What about you" isa fairly common pattern. (Sometimes the
;   wh-word is not detected but "you"/"your" is quite reliable.)
;   The question, by default, is reciprocal to Eta's question.
;
  (let ((n (length words)) relevant-trees sentences
        specific-tree thematic-tree facts gist-clauses)

    ; Get the relevant pattern transduction tree given the gist clause of Eta's previous utterance.
    ;````````````````````````````````````````````````````````````````````````````````````````````````
    ;; (format t "~% prior-gist-clause = ~a" prior-gist-clause) ; DEBUGGING
    (setq relevant-trees (cdr
      (choose-result-for prior-gist-clause '*gist-clause-trees-for-input*)))
    ;; (format t "~% this is a clue == ~a" (choose-result-for prior-gist-clause
    ;;   '*gist-clause-trees-for-input*))
    ;; (format t "~% relevant trees = ~a" relevant-trees) ; DEBUGGING   
    (setq specific-tree (first relevant-trees)) 
    (setq thematic-tree (second relevant-trees))  

    ;; ; Get the list of gist clauses from the user's utterance, using the contextually
    ;; ; relevant pattern transduction tree.
    ;; ;```````````````````````````````````````````````````````````````````````````````````````````````````````
    ;; (setq facts (cdr (choose-result-for words relevant-tree)))
    ;; (format t "~% gist clauses = ~a" facts) ; DEBUGGING

    ; Split user's reply into sentences for extracting specific gist clauses
    ;`````````````````````````````````````````````````````````````````````````
    (setq sentences (split-sentences words))
    (dolist (sentence sentences)
      (setq clause (cdr (choose-result-for sentence specific-tree)))
      (when (atom (car clause)) (setq clause (list clause))) ; in case no topic-key
      (when clause
        (setq keys (second clause))
        (store-gist (car clause) keys (ds-gist-kb-user *ds*))
        (push (car clause) facts)))

    ; Form thematic answer from input (if no specific facts are extracted)
    ;``````````````````````````````````````````````````````````````````````
    (when (and (> (length sentences) 2) (null facts))
      (setq clause (cdr (choose-result-for words thematic-tree)))
      (when (atom (car clause)) (setq clause (list clause))) ; in case no topic-key
      (when clause
        (setq keys (second clause))
        (store-gist (car clause) keys (ds-gist-kb-user *ds*))
        (push (car clause) facts)))

    ; 'facts' should be a concatenation of the above results in the order in
    ; which they occur in the user's input; in reacting, Eta will
    ; pay particular attention to the first clause, and any final question.
    (setq gist-clauses (reverse facts))

    ;; (format t "~% extracted gist clauses: ~a" gist-clauses) ; DEBUGGING
	
	  ; Allow arbitrary unexpected inputs to be processed
    ; replace nil with (null gist-clauses)
    (if nil (list words)
		  gist-clauses)
)) ; END form-gist-clauses-from-input





(defun form-ulf-from-clause (clause)
;`````````````````````````````````````
; Find the ULF corresponding to the user's 'clause' (a gist clause).
; **Right now, this uses *spatial-question-ulf-tree* directly, instead of
;   using, say *clause-ulf-tree*, as a general starting point for any
;   sentential input. When *clause-ulf-tree* has been designed 
;   (branching to subtrees for assertions, questions, requests, etc.)
;   it should replace *spatial-question-ulf-tree* below.
;
; **For initial experimentation, the "raw" question rather than any
;   gist clause derived from it is processed. The idea is that we
;   would transform inputs like "What's to the right of it?" or
;   "Add another one" into gist clauses, using the prior utterance
;   or action. This should be possible with the existing gist clause
;   mechanisms. For example, if the prior utterance was "Put a red
;   block on the NVidia block", then "Add another one" should be
;   interpretable as "Put another red block on the current structure",
;   or something like that. The present program would be applied 
;   to this. Cf., the use of the prior gist clause in
;   'form-gist-clauses-from-input'.
;
; Use hierarchical choice trees for extracting the ULF.
;
  (let (ulf)
    (setq ulf (choose-result-for clause '*clause-ulf-tree*))
  ulf)
) ; END form-ulf-from-clause





(defun form-inferences-from-gist-clause (clause)
;``````````````````````````````````````````````````
; Infer an additional wff from a user gist-clause using pattern transduction.
; TODO: currently, this only supports one inferred wff per gist-clause, but should
; be able to support multiple.
;
  (let (inferred-wff)
    (setq inferred-wff (choose-result-for clause '*clause-inference-tree*))
  inferred-wff)
) ; END form-inferences-from-gist-clause





;; (defun commit-perceptions-to-memory (perceptions user-ulf)
;; ;``````````````````````````````````````````````````````````
;; ; TODO: deprecated, remove
;; ; Given perceptions by the system (e.g., block moves) and/or a
;; ; query ULF, store these facts in short-term memory (context).
;; ; The facts are deindexed and stored in context as, e.g.,
;; ; ((you.pro ((past move.v) |B1|)) @ NOW1), though the indexical
;; ; formula is also stored hashed on the time NOW1.
;; ; TODO: as indicated, many aspects of this will need changing.
;; ; I'm also not sure that such historical temporal facts should
;; ; be stored in short-term memory/context at all, versus some
;; ; form of long-term memory.
;; ;
;;   ; Store move.v facts in context, deindexed at the current time
;;   ; TODO: COME BACK TO THIS
;;   ; It seems like this should be somehow an explicit store-in-context step in schema, but which facts are
;;   ; indexical? Should e.g. past moves in fact be stored in memory rather than context?
;;   (let ((action-perceptions (remove-if-not #'verb-phrase? perceptions)))
;;     (when action-perceptions
;;       (setq *time-prev* *time*)
;;       (mapcar (lambda (perception)
;;           (let ((perception1 (list perception '@ *time*)))
;;             (update-time)
;;             (store-in-context perception1)
;;           ))
;;         action-perceptions)))

;;   ; Store ULF of user utterance in context, deindexed at the current time
;;   ; TODO: COME BACK TO THIS
;;   ; This should probably be done elsewhere (e.g. at the time of Eta processing the say-to.v episode),
;;   ; but then the utterance would come temporally before any block moves, whereas it should be the other
;;   ; way around. The perceive-world.v action in general needs to be rethought (since really observing a
;;   ; user say-to.v action, much like a move.v action or any other action, IS a perceive world action).
;;   ; Update Eta's current time
;;   (when user-ulf
;;     (let ((utterance-prop `((^you ((past ask.v) ,user-ulf)) @ ,*time*)))
;;       (update-time)
;;       (store-in-context utterance-prop)
;;     ))
;; ) ; END commit-perceptions-to-memory





(defun eval-truth-value (wff)
;```````````````````````````````
; Evaluates the truth of a conditional schema action.
; This assumes a CWA, i.e., if something is not found in
; context, it is assumed to be false.
;
  (cond
    ; (wff1 = wff2)
    ((equal-prop? wff)
      (setq wff (eval-functions wff))
      (equal (first wff) (third wff)))
    ; (not wff1)
    ((not-prop? wff)
      (not (eval-truth-value (second wff))))
    ; (wff1 and wff2)
    ((and-prop? wff)
      (and (eval-truth-value (first wff))
           (eval-truth-value (third wff))))
    ; (wff1 or wff2)
    ((or-prop? wff)
      (or  (eval-truth-value (first wff))
           (eval-truth-value (third wff))))
    ; Otherwise, check to see if wff is true in context
    (t (get-from-context wff))
)) ; END eval-truth-value





(defun choose-result-for (clause rule-node)
;`````````````````````````````````````````````
; This is just the top-level call to 'choose-result-for', with
; no prior match providing a value of 'parts', i.e., 'parts' = nil;
; this is to enable tracing of just the top-level calls
  (choose-result-for1 clause nil rule-node nil)
) ; END choose-result-for





(defun choose-result-for1 (clause parts rule-node visited-subtrees)
;``````````````````````````````````````````````````````````````````````````
; This is a generic choice-tree search program, used both for
; (i) finding gist clauses in user inputs (starting with selection
; of appropriate subtrees as a function of Eta's preceding
; question, simplified to a gist clause), and (ii) in selecting
; outputs in response to (the gist clauses extracted from) user 
; inputs. Outputs in the latter case may be verbal responses
; obtained with reassembly rules, or names (possibly with
; arguments) of other choice trees for response selection, or
; the names (possibly with arguments) of schemas for planning 
; an output. The program works in essentially the same way for
; purposes (i) and (ii), but returns
;      (cons <directive keyword> result)
; where the directive keyword (:out, :subtree, :subtree+clause,
; :schema, ...) is the one associated with the rule node that
; provided the final result to the calling program. (The calling
; program is presumed to ensure that the appropriate choice tree
; is supplied  as 'rule-node' argument, and that the result is
; interpreted and used as intended for that choice tree.)
;
; So, given an input clause 'clause', a list 
; 'parts' of matched parts from application of the superordiate
; decomposition rule (initially, nil), and the choice tree node 
; 'rule-node' in a tree of decomposition/result rules, we generate
; a verbal result or other specified result starting at that rule,
; prefixed with the directive keyword.
;
; Decomposition rules (as opposed to result rules) have no
; 'directive' property (i.e., it is NIL). Note that in general
; a decomposition rule will fail if the pattern it supplies fails
; to match 'clause', while a result rule will fail if its
; latency requirements prevent its (re)use until more system
; outputs have been generated. (This avoids repetitive outputs.)
;
; Note also that result rules can have siblings, but not children,
; since the "downward" direction in a choice tree corresponds to
; successive refinements of choices. Further, note that if the
; given rule node provides a decomposition rule (as indicated by
; a NIL 'directive' property), then it doesn't make any direct
; use of the 'parts' list supplied to it -- it creates its own
; 'newparts' list via a new pattern match. However, if this
; match fails (or succeeds but the recursion using the children 
; returns NIL), then the given 'parts' list needs to be passed
; to the siblings of the rule node -- which after all may be 
; result rules, in particular reassembly rules.
;
; Method:
;````````
; If the rule has a NIL 'directive' property, then its 'pattern'
; property supplies a decomposition rule. We match this pattern,
; and if successful, recursively seek a result from the children
; of the rule node (which may be result rules or further decomp-
; osition rules), returning the result if it is non-nil; in case
; of failure, we recursively return a result from the siblings
; of the rule node (via the 'next' property); these siblings
; represent alternatives to the current rule node, and as such
; may be either alternative decomposition rules, or result rules 
; (with a non-nil 'directive' property) -- perhaps intended as
; a last resort if the decomposition rules at the current level
; fail.
;
; In all cases of non-nil directives, if the latency requirement
; is not met, i.e., the rule cannot be reused yet, the recursive
; search for a result continues with the siblings of the rule.
;
; If the rule node has directive property :out, then its 'pattern'
; property supplies a reassembly rule. If the latency requirement 
; of the rule is met, the result based on the reassembly rule and
; the 'parts' list is returned (after updating 'time-last-used'). 
; The latency criterion uses the 'latency' property of 'rule-node' 
; jointly with the 'time-last-used' property and the global result 
; count, (ds-count *ds*).
;
; If the rule node has directive property :subtree, then 'pattern'
; will just be the name of another choice tree. If the latency 
; requirement is met, a result is recursively computed using the
; named choice tree (with the same 'clause' as input).
; The latency will usually be 0 in this case, i.e., a particular
; choice subtree can usually be used again right away.
;
; If the rule node has directive property :subtree+clause, then
; 'pattern' supplies both the name of another choice tree and
; a reassembly pattern to be used to construct a clause serving
; as input in the continued search (whereas for :subtree the
; recursion continues with the original clause). Again the
; latency will usually be 0.
;
; (June 9/19) If the rule node has directive property :ulf-recur,
; then 'pattern' supplies two reassembly rules, the first of which,
; upon instantiation with 'parts', is a list such as
;  ((*be-ulf-tree* ((is be pres))) 
;   (*np-ulf-tree* (the det def) (Nvidia name corp-name) (block cube obj))
;   (*rel-ulf-tree* (to prep dir loc) (the det def) (left noun loc) (of prep))
;   (*np-ulf-tree* (a det indef) (red adj color) (block cube obj)) 
;   (*end-punc-ulf-tree* (? end-punc ques-punc))),
; ie., a list of sublists of words, with each sublist prefaced by
; the name of a rule tree to be used to produce a ulf for that sublist of
; words. The instantiated reassembly rule is then processed
; further, by successively trying to get a result for each of the rule
; trees named in the sublists; if all succeed, the individual results
; are assembled into an overall ULF, and this is the result returned
; (otherwise, the result is nil -- failure). The second reassembly rule
; provides the right bracketing structure for putting together the
; individual ULFs. Example: ((1 2 (3 4)) 5); result for the above:
;     (((pres be.v) (the.d (|NVidia| block.n)) 
;                   (to_the_left_of.p (a.d (red.a block.n)))) ?)
;
; Other directives (leading to direct return of a successful result
; rather than possible failure, leading to continuing search) are 
; - :subtrees (returning the names of multiple subtrees (e.g., 
;   for extracting different types of gist clauses from a 
;   potentially lengthy user input); 
; - :schema (returning the name of a schema to be instantiated, 
;   where this schema requires no arguments); 
; - :schemas (returning multiple schema names, perhaps as 
;   alternatives); 
; - :schema+args (a schema to be instantiated for the specified 
;   args derived from the given 'clause'); 
; - :gist (a gist clause extracted from the given 'clause,
;   plus possibly a list of topic keys for storage);
; - :ulf (June 9/19) (returning a ulf for a phrase simple enough
;   to be directly interpreted);
; - perhaps others will be added, such as :subtrees+clauses or
;   :schemas+args
;
; These cases are all treated uniformly -- a result is returned
; (with the directive) and it is the calling program's responsib-
; ility to use it appropriately. Specifically, if the latency
; requirement is met, the value supplied as 'pattern', instantiated
; with the supplied 'parts', is returned. (Thus integers appearing
; in the value pattern are interpreted as references to parts
; obtained from the prior match.) 
;
; The function maintains a list of visited subtrees
; (for a particular path) to avoid entering infinite recursion, as well
; as a list of matched nodes that are returned for debugging purposes.
; (NOTE: the latter is not yet implemented for ULF directives)
;

  ; First make sure we have the lexical code needed for ULF computation
  (if (not (fboundp 'eval-lexical-ulfs)) (load "eval-lexical-ulfs.lisp"))

  (let (directive pattern newparts newclause ulf ulfs result)
    ; Don't use empty choice trees
    (if (null rule-node) (return-from choose-result-for1 nil))

    ; Get directive and pattern from rule node
    (setq directive (get rule-node 'directive))
    (setq pattern (get rule-node 'pattern))

    ; If latency is being enforced, skip rule if it was used too recently
    (when (and directive *use-latency*
            (< (ds-count *ds*) (+ (get rule-node 'time-last-used)
                          (get rule-node 'latency))))
      (return-from choose-result-for1
        (choose-result-for1 clause parts (get rule-node 'next) visited-subtrees)))

    ;; (format t "~% ***1*** Clause = ~a ~%" clause) ; DEBUGGING
    ;; (format t "~% =====2==== Pattern/output to be matched in rule ~a = ~%  ~a and directive = ~a" rule-node pattern directive) ; DEBUGGING
  
    ; Big conditional statement for dealing with all possible directives.
    ; We first deal with cases requiring further tree-descent (with possible
    ; failure and thus recursive backtracking), no directive (i.e. decomposition
    ; rule), :subtree, :subtree+clause, and :ulf-recur
    (cond
      ;``````````````````
      ; No directive
      ;``````````````````
      ; Look depth-first for more specific match, otherwise try alternatives
      ((null directive)
        (setq newparts (match1 pattern clause))
        ;; (format t "~% ----3---- new part = ~a ~%" newparts) ; DEBUGGING

        ; Pattern does not match 'clause', search siblings recursively
        (if (null newparts)
          (return-from choose-result-for1
            (choose-result-for1 clause parts (get rule-node 'next) visited-subtrees)))

        ; Pattern matched, try to obtain recursive result from children
        (setq result
          (choose-result-for1 clause newparts (get rule-node 'children) visited-subtrees))

        (if result (return-from choose-result-for1 result)
                   (return-from choose-result-for1
                      (choose-result-for1 clause parts (get rule-node 'next) visited-subtrees))))

      ;`````````````````````
      ; :subtree directive
      ;`````````````````````
      ; Recursively obtain a result from the choice tree specified via its
      ; root name, given as 'pattern'
      ((eq directive :subtree)
        (setf (get rule-node 'time-last-used) (ds-count *ds*))
        (cond
          ; Pattern is wrong format
          ((not (atom pattern)) (return-from choose-result-for1 nil))
          ; If subtree was already visited, skip rule
          ((member pattern visited-subtrees)
            (return-from choose-result-for1
              (choose-result-for1 clause parts (get rule-node 'next) visited-subtrees)))
          ; Otherwise, go to subtree and add subtree to list of visited subtrees
          (t (return-from choose-result-for1
            (choose-result-for1 clause parts pattern (cons pattern visited-subtrees))))))

      ;````````````````````````````
      ; :subtree+clause directive
      ;````````````````````````````
      ; Similar to :subtree, except that 'pattern' is not simply the root
      ; name of a tree to be searched, but rather a pair of form
      ; (<root name of tree> <reassembly pattern>), indicating that the
      ; reassembly pattern should be used together with 'parts' to reassemble
      ; some portion of 'clause', whose results should then be used
      ; (after re-tagging) in the recursive search.
      ((eq directive :subtree+clause)
        (setf (get rule-node 'time-last-used) (ds-count *ds*))
        (setq newclause (fill-template (second pattern) parts))
        (return-from choose-result-for1
          (choose-result-for1 newclause nil (car pattern)
            (remove-duplicates (cons (car pattern) visited-subtrees)))))

      ;````````````````````````
      ; :ulf-recur directive
      ;````````````````````````
      ; Find the instance of the rule pattern determined by 'parts',
      ; which will be a shallow analysis of a text segment, of the
      ; form described in the initial commentary; try to find results
      ; (ULFs) for the component phrases, and if successful assemble
      ; these into a complete ULF for the input. NB: (first pattern)
      ; supplies the top-level phrasal segments to be further analyzed
      ; (using the ulf rule trees heading each phrasal segment), while
      ; (second pattern) supplies the bracketing structure for the
      ; phrasal ULFs.
      ((eq directive :ulf-recur)
        ; Instantiate shallow analysis
        (setq newclause (fill-template (first pattern) parts))
        ; Interpret recursive phrases; the car of each nonatomic phrase
        ; either gives the name of the relevant rule tree to use, or it
        ; is 'lex-ulf@'; in the former case we proceed recursively, in
        ; the latter we keep the phrase as-is
        (dolist (phrase newclause)
          (if (or (atom phrase) (eq (car phrase) 'lex-ulf@))
            (setq ulf phrase) ; e.g., ulf of (next to) = next_to.p
            (setq ulf
              (choose-result-for (cdr phrase) (car phrase))))
          ; If failure, exit loop
          (when (null ulf)
            (setq ulfs nil)
            (return-from choose-result-for1 nil))
          (push ulf ulfs))
        ; Assemble the (initially reversed) list of phrasal ULFs into a
        ; ULF for the entire input, using the second reassembly rule
        (when ulfs
          (setq n (length ulfs)) ; number of phrasal ULFs
          (setq result (second pattern)) ; bracket structure with indices
          (dolist (ulf ulfs)
            (setq ulf (eval-lexical-ulfs ulf))
            (setq result (subst ulf n result))
            (decf n)))
        (return-from choose-result-for1 result))

      ; Now we deal with cases expected to directly return a result,
      ; not requiring allowance for failure-driven backtracking

      ;`````````````````
      ; :ulf directive
      ;`````````````````
      ; In the case of ULF computation we don't prefix the result with
      ; the directive symbol; this is in contrast with  cases like :out,
      ; :gist, :schema, etc., where the schema executor needs to know
      ; what it's getting back as result for an input, and hence what
      ; to do with it
      ((eq directive :ulf)
        (setq result (fill-template pattern parts))
        (setq result (eval-lexical-ulfs result))
        (return-from choose-result-for1 result))

      ;```````````````````````
      ; :ulf-coref directive
      ;```````````````````````
      ; Obtains a ulf result using the subtree & input specified in the pattern, and
      ; then resolves the coreferences in the resulting ulf
      ((eq directive :ulf-coref)
        (setq newclause (fill-template (second pattern) parts))
        (setq result (choose-result-for1 newclause nil (car pattern) visited-subtrees))
        (if (and result (not (equal (car result) :out)))
          (setq result (coref-ulf result)))
        (return-from choose-result-for1 result))

      ;```````````````````````
      ; :gist-coref directive
      ;```````````````````````
      ; TODO: Implement coreference resolution (gist case)
      ((eq directive :gist-coref)
        (setq result (cons directive (fill-template pattern parts)))
        (setf (get rule-node 'time-last-used) (ds-count *ds*))
        (setq result (coref-gist result))
        (return-from choose-result-for1 result))

      ;```````````````````````````````
      ; Misc non-recursive directives
      ;```````````````````````````````
      ((member directive '(:out :subtrees :schema :schemas
                           :schema+args :gist :schema+ulf
                           :prompt-examples))
        (setq result (cons directive (fill-template pattern parts)))
        (setf (get rule-node 'time-last-used) (ds-count *ds*))
        (return-from choose-result-for1 result))

      ; A directive is not recognized
      (t
        (format t "~%*** UNRECOGNIZABLE DIRECTIVE ~s ENCOUNTERED FOR RULE ~s~%    FOR THE FOLLOWING PATTERN AND CLAUSE: ~%    ~s,  ~s" directive rule-node pattern clause))
    )
)) ; END choose-result-for1






