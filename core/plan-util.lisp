;; Feb 21/2023
;; ===========================================================
;;
;; Contains the schema-based planning module used by Eta, built around the 'plan-step' structure
;; defined below. Each plan-step is a node in a plan polytree containing an episode name and
;; corresponding WFF, as well as possibly other information (probabilistic certainty scores,
;; obligations associated with the episode, etc.). Each plan-step is also marked as an intention
;; or expectation, depending on whether the episode is an action with Eta as the agent, or some
;; other type of episode.
;;
;; Each plan-step contains a pointer to a list of abstract plan-steps that it instantiates (parents),
;; as well as a pointer to a list of more concrete substeps (children).
;;
;; Functions described in more detail in their headers.
;;

(setf *print-circle* t) ; needed to prevent recursive loop when printing plan-step

(defstruct plan-node
;```````````````````````````````
; contains the following fields:
; step : the plan step associated with the node
; prev : the previous step in the overall 'surface' plan
; next : the next step in the overall 'surface' plan
;
  step
  prev
  next
) ; END defstruct plan-node



(defun deepcopy-plan-node (old1) ; {@}
;`````````````````````````````````
; Deep copy a plan-node structure recursively (note that we need to maintain a
; hash table mapping visited plan-step IDs to the new plan-step structures, in
; order to prevent creation of duplicates).
;
  (let ((visited (make-hash-table)))
    (labels ((deepcopy-plan-node-recur (old prev next)
      (let ((new (make-plan-node)))
        (setf (plan-node-step new)
          (deepcopy-plan-step (plan-node-step old) :visited visited))
        (when (plan-node-prev old)
          (setf (plan-node-prev new)
            (if prev
              prev
              (deepcopy-plan-node-recur (plan-node-prev old) nil new))))
        (when (plan-node-next old)
          (setf (plan-node-next new)
            (if next
              next
              (deepcopy-plan-node-recur (plan-node-next old) new nil))))
        new)))
    (deepcopy-plan-node-recur old1 nil nil)
))) ; END deepcopy-plan-node



(defstruct plan-step
;```````````````````````````````
; contains the following fields:
; id         : a unique ID for this plan-step
; substeps   : a list of concrete substeps that are associated with this step
; supersteps : a list of abstract steps that this step instantiates
; ep-name    : episode name of step (gist-clauses, etc. are implicitly attached to ep-name)
; wff        : action formula corresponding to episode name
; certainty  : how certain the step is (if the step is an expected step). The patience of the
;             system in waiting to observe the step is proportional to this
; obligation : the obligation(s) associated with the step
; schema     : the instantiated schema that created this step (if any)
;
  (id (gentemp "STEP"))
  substeps
  supersteps
  ep-name
  wff
  (certainty 1.0) ; defaults to 1, i.e. a certain step
  obligation
  schema
) ; END defstruct plan-step



(defun deepcopy-plan-step (old &key substep visited) ; {@}
;```````````````````````````````````````````````````````
; Deep copy a plan-step structure recursively (note that we need to maintain a
; hash table mapping visited plan-step IDs to the new plan-step structures, in
; order to prevent creation of duplicates).
; Since we assume that plan-nodes are at the "surface" of the plan hierarchy,
; this function recurs "downwards" (i.e., towards supersteps).
;
  (let (new)
    (cond
      ; If step has already been visited, get new step structure from hash table
      ((and (hash-table-p visited) (gethash (plan-step-id old) visited))
        (setq new (gethash (plan-step-id old) visited))
        (when substep
          (push substep (plan-step-substeps new))))
          
      ; Otherwise, create new step structure and add to visited hash table
      (t
        (setq new (make-plan-step))
        (setf (plan-step-ep-name new) (copy-tree (plan-step-ep-name old)))
        (setf (plan-step-wff new) (copy-tree (plan-step-wff old)))
        (setf (plan-step-certainty new) (copy-tree (plan-step-certainty old)))
        (setf (plan-step-obligation new) (copy-tree (plan-step-obligation old)))
        ; TODO REFACTOR - the following needs to be modified so as to not create duplicate schema copies
        (setf (plan-step-schema new) (deepcopy-epi-schema (plan-step-schema old)))

        (when substep
          (push substep (plan-step-substeps new)))

        (when (plan-step-supersteps old)
          (setf (plan-step-supersteps new)
            (mapcar (lambda (superstep-old)
                (deepcopy-plan-step superstep-old :substep new :visited visited))
              (plan-step-supersteps old))))

        (setf (gethash (plan-step-id old) visited) new)))

    new
)) ; END deepcopy-plan-step



(defun init-plan-from-schema (schema args) 
;`````````````````````````````````````````````
; Given a schema structure, instantiate the schema that a plan is to
; be based on. For non-nil 'args', we replace successive variables
; occurring in the header (excluding the episode variable ?e itself)
; by successive elements of 'args'.
;
  (let (plan schema-instance sections ep-vars)
    ; Return error if schema has no episodes
    (when (null (epi-schema-episodes schema))
      (format t "*** Attempt to form plan from schema ~a with no episodes"
        (schema-predicate schema))
      (return-from init-plan-from-schema nil))

    ; Create copy of general schema to instantiate
    (setq schema-instance (instantiate-epi-schema schema args))

    ; Create a plan structure from the episodes of the schema (in
    ; addition to certainties and obligations)
    (setq plan (init-plan-from-episode-list
      (get-schema-section schema-instance :episodes)
      :certainties (get-schema-section schema-instance :certainties)
      :obligations (get-schema-section schema-instance :obligations)))

    (when plan
      (setf (plan-schema plan) schema-instance))

  ; If goals of plan are already satisfied, skip over plan by returning nil,
  ; otherwise return new plan
  ;; TODO REFACTOR : modify the below once goal queue is implemented
  ;; (if (and (plan-goals plan) (every #'check-goal-satisfied (plan-goals plan)))
  ;;   nil
  ;;   plan)
  plan
)) ; END init-plan-from-schema



(defun init-plan-from-episode-list (episodes &key certainties obligations) 
;````````````````````````````````````````````````````````````````````````````
; Given a list of episodes, create a plan corresponding to that
; sequence of episodes. May be called as a subroutine in instantiating
; a plan from an overall schema, or from procedurally creating a subplan
; for a particular action (e.g., a say-to action from a paraphrase-to action).
;
; The episodes are converted to a linked list representing the steps in a plan;
; the first plan step is returned. Optionally, certainties and obligations for
; episodes may be given, in which case these are attached to the corresponding
; plan steps.
;
  (let (plan steps first-step prev-step curr-step)

    ; Remove :episodes keyword (if given), and group episodes into steps
    (if (equal :episodes (car episodes)) (setq episodes (cdr episodes)))
    (setq steps (group-facts-in-schema-section episodes))

    ; Make plan structure plan-name
    (setq plan (make-plan))
    (setf (plan-plan-name plan) (gentemp "PLAN"))

    ; Give error if first element of first pair isn't episode variable starting with '?'
    (when (not (variable? (caar steps)))
      (format t "*** malformed step ~a while trying to form plan ~a (doesn't begin with episode variable)~%"
        (car steps) (plan-plan-name plan))
      (return-from init-plan-from-episode-list nil))

    ; Iterate over steps in episodes list
    (dolist (step steps)

      ; Make plan step structure and set data
      (setq curr-step (make-plan-step))
      (setf (plan-step-step-of curr-step) plan)
      (if (null first-step) (setq first-step curr-step))
      (setf (plan-step-ep-name curr-step) (first step))
      (setf (plan-step-wff curr-step) (second step))
      ; When episode name has certainty associated, add to step
      ; certainties are formulas like (!c1 (!e16 0.3))
      (dolist (certainty (group-facts-in-schema-section certainties))
        (when (equal (first step) (dual-var (first (second certainty))))
          (setf (plan-step-certainty curr-step) (second (second certainty)))))
      ; When episode name has obligation associated, add to step
      ; obligations are formulas like (!o1 (?e1 obligates <wff>))
      (dolist (obligation (group-facts-in-schema-section obligations))
        (when (equal (first step) (first (second obligation)))
          (setf (plan-step-obligation curr-step) (third (second obligation)))))
      ; When previous step exists, set bidirectional pointers
      (when prev-step
        (setf (plan-step-prev-step curr-step) prev-step)
        (setf (plan-step-next-step prev-step) curr-step))
      ; Previous step becomes current step
      (setq prev-step curr-step))
    
    ; Set curr-step pointer in plan to first step in plan
    (setf (plan-curr-step plan) first-step)

    ;; (format t "action list of argument-instantiated schema is:~%")
    ;; (print-current-plan-steps plan) ; DEBUGGING

  plan
)) ; END init-plan-from-episode-list



(defun init-plan-from-episode-list-repeating (plan ep-name episodes-embedded episodes-loop)
;`````````````````````````````````````````````````````````````````````````````````````````````
; Initializes a plan from an episode list for a :repeat-until loop. Before initializing
; the subplan, we need to create duplicate episode variables for all of the embedded episodes
; that get instantiated during this particular iteration (while keeping the original episode
; variables for the loop 'yet to be unrolled'). These duplicate variables need to inherit the
; certainties and obligations of the original episode variables in the plan schema (if any).
;
  (let (duplicates new-plan)
    (setq duplicates (subst-duplicate-variables
      episodes-embedded
      (get-schema-section (plan-schema plan) :certainties)
      (get-schema-section (plan-schema plan) :obligations)))
    (init-plan-from-episode-list
      (cons :episodes (append (first duplicates) (list ep-name (cons :repeat-until episodes-loop))))
      :certainties (second duplicates)
      :obligations (third duplicates))
)) ; END init-plan-from-episode-list-repeating



(defun certainty-to-period (certainty)
;``````````````````````````````````````````
; Maps a certainty from [0,1] to a period corresponding to the
; period (in seconds) that Eta must wait to consider an expected episode
; failed and move on in the plan.
; The proportion between the period (in task cycles) and the
; quantity -log(1 - certainty) is determined by the global
; constant *expected-step-failure-period-coefficient*.
;
  (if (or (>= certainty 1) (< certainty 0))
    'inf
    (* *expected-step-failure-period-coefficient*
      (* -1 (log (- 1 certainty)))))
) ; END certainty-to-period



(defun add-subplan-curr-step (plan subplan) 
;````````````````````````````````````````````
; Given a plan and a subplan, attaches the subplan to the
; currently active step of the plan using the add-subplan function.
; Unless the subplan already has an associated subschema, it inherits
; the schema used to create the subplan.
; 
  (add-subplan (plan-curr-step plan) subplan)
  (when (null (plan-schema subplan))
    (setf (plan-schema subplan) (plan-schema plan)))
) ; END add-subplan-curr-step



(defun add-subplan (plan-step subplan) 
;```````````````````````````````````````````
; Adds a subplan to a given plan-step using bidirectional links.
;
  (setf (plan-step-subplan plan-step) subplan)
  (setf (plan-subplan-of subplan) plan-step)
) ; END add-subplan



(defun advance-plan (plan) 
;```````````````````````````
; Advances the curr-step in plan to the next step.
;
  ; If no curr-step, return nil
  (if (null (plan-curr-step plan)) (return-from advance-plan nil))

  ;; (format t "current action being advanced in plan ~a: ~%  ~a ~a~%" (plan-plan-name plan)
  ;;   (plan-step-ep-name (plan-curr-step plan)) (plan-step-wff (plan-curr-step plan))) ; DEBUGGING

  ; Set curr-step to the next step in plan
  (setf (plan-curr-step plan)
    (plan-step-next-step (plan-curr-step plan)))

  ;; (format t "remaining steps in plan ~a after advancing: ~%" (plan-plan-name plan))
  ;; (print-current-plan-steps plan) ; DEBUGGING

) ; END advance-plan



(defun update-plan-state (plan) 
;`````````````````````````````````
; Updates the state of the plan by advancing any step whose
; subplan has been completed, i.e. has no more steps left.
; 
  (let ((curr-step (plan-curr-step plan)) subplan unsatisfied-goals replanned?)

    ; If no curr-step, return nil
    (if (null curr-step) (return-from update-plan-state nil))

    (setq subplan (plan-step-subplan curr-step))
    (cond
      ; If no subplan, do nothing
      ((null subplan) nil)
      ; If subplan forms an infinite loop, break loop and do nothing
      ((and (plan-curr-step subplan) (equal subplan (plan-step-subplan (plan-curr-step subplan))))
        (setf (plan-step-subplan curr-step) nil))
      ; Otherwise, recursively update each subplan
      (t (update-plan-state subplan)

        ; Advance plan once subplan is finished
        (when (null (plan-curr-step subplan))

          ; If goals of subplan (if any) still unsatisfied, try replanning based on the first unsatisfied goal
          ;; TODO REFACTOR : modify the below once goal queue is implemented
          ;; (when (plan-goals subplan)
          ;;   (setq unsatisfied-goals (remove-if #'check-goal-satisfied (plan-goals subplan)))
          ;;   (when unsatisfied-goals
          ;;     ;; (dolist (ug unsatisfied-goals) (format t "~%  unsatisfied goal: ~a" ug)) ; DEBUGGING
          ;;     (setq replanned? (replan-for-goal plan (car unsatisfied-goals)))
          ;;     (if replanned? (return-from update-plan-state nil))))

          ;; (format t "subplan ~a has no curr-step, so advancing plan ~a past step: ~%  ~a ~a ~%"
          ;;   (plan-plan-name subplan) (plan-plan-name plan) (plan-step-ep-name curr-step) (plan-step-wff curr-step)) ; DEBUGGING

          ; Advance plan if subplan is finished and goals (if any) satisfied
          (advance-plan plan)))))
) ; END update-plan-state



(defun instantiate-curr-step (plan) 
;`````````````````````````````````````
; Instantiates the first episode in the plan, destructively substituting
; the skolemized episode wherever it occurs in the plan, as well as binding
; that episode variable in the schema.
;
  (let ((curr-step (plan-curr-step plan)) ep-var ep-name)

    ; If no curr-step, return nil
    (if (null curr-step) (return-from instantiate-curr-step nil))
    
    ; Get episode-var (if already instantiated, return nil)
    (setq ep-var (plan-step-ep-name curr-step))
    (if (not (variable? ep-var)) (return-from instantiate-curr-step nil))

    ; Generate a constant for the episode and destructively substitute in plan
    (setq ep-name (episode-name))
    ; TODO: use episode-relations formulas to assert relations in timegraph
    (store-init-time-of-episode ep-name)
    (bind-variable-in-plan plan ep-name ep-var)

    ;; (format t "action list after substituting ~a for ~a:~%" ep-name ep-var)
    ;; (print-current-plan-steps plan) ; DEBUGGING

    ; TODO: should (wff ** ep-name) be stored in context at this point?
    ;       as well as instantiating the non-fluent variable, e.g. '!e1'?
    
)) ; END instantiate-curr-step



(defun find-curr-subplan (plan) 
;`````````````````````````````````
; Finds the deepest subplan of the given plan (starting with current step)
; with an immediately pending step.
;
  (let ((curr-step (plan-curr-step plan)) subplan)

    ; If no curr-step, return nil
    (if (null curr-step) (return-from find-curr-subplan nil))

    ;; (format t "current step of plan ~a is: ~%  ~a ~a~%" (plan-plan-name plan)
    ;;   (plan-step-ep-name curr-step) (plan-step-wff curr-step)) ; DEBUGGING

    (setq subplan (plan-step-subplan curr-step))
    (cond
      ; If no subplan, next action is top-level
      ((null subplan) plan)
      ; If subplan forms an infinite loop, break loop and return subplan
      ((and (plan-curr-step subplan) (equal subplan (plan-step-subplan (plan-curr-step subplan))))
        (format t "*** found infinite loop in subplan ~a; breaking loop ~%"
          (plan-plan-name subplan))
        (setf (plan-step-subplan curr-step) nil)
        subplan)
      ; If the subplan is fully executed, then remove subplan and return plan
      ((null (plan-curr-step subplan))
        (format t "*** find-curr-subplan arrived at a completed subplan ~a~%"
          (plan-plan-name subplan))
        (setf (plan-step-subplan curr-step) nil)
        plan)
      ; Otherwise, subplan is active, so find deepest subplan recursively
      (t (find-curr-subplan subplan))))
) ; END find-curr-subplan



(defun find-prev-step-of-type (plan subject action-type)
;``````````````````````````````````````````````````````````
; Finds the most recent previous step in a plan of a certain type
; (e.g. 'say-to.v') or within a list of types, and a particular subject
; (nil if subject doesn't matter).
; If no such step in the current plan, try recursively in the superplan
; of plan (returning nil if no superplan exists).
;
  (let ((prev-step (plan-step-prev-step (plan-curr-step plan))) wff action-type1)

    ; Iterate through each previous step, and return that step if the
    ; action type of the wff is the same as action-type
    (loop while (not (null prev-step)) do
      (setq wff (plan-step-wff prev-step))
      (setq action-type1 (if (listp wff) (second wff)))
      (setq subject1 (if (listp wff) (first wff)))
      (cond
        ((and (atom action-type) (equal action-type1 action-type) (or (null subject) (equal subject1 subject)))
          (return-from find-prev-step-of-type prev-step))
        ((and (listp action-type) (member action-type1 action-type) (or (null subject) (equal subject1 subject)))
          (return-from find-prev-step-of-type prev-step)))
      (setq prev-step (plan-step-prev-step prev-step)))
  
    ; If no such step found in current plan, recursively try in superplan (if exists)
    (cond
      ((plan-subplan-of plan)
        (find-prev-step-of-type (plan-step-step-of (plan-subplan-of plan)) subject action-type))
      (t nil))
)) ; END find-prev-step-of-type



(defun get-parent-ep-name (plan)
;`````````````````````````````````
; If plan is a subplan of a step, get the episode name
; corresponding to that step.
;
  (let ((superstep (plan-subplan-of plan)))
    (if superstep (plan-step-ep-name superstep)))
) ; END get-parent-ep-name



(defun has-next-step? (plan) 
;`````````````````````````````
; Returns t if plan has another step, nil otherwise.
;
  (if (and plan (plan-curr-step plan)) t nil)
) ; END has-next-step?



(defun inquire-truth-of-next-episode (plan)
;`````````````````````````````````````````````
; Checks the truth of the immediately pending episode in the plan,
; through a process of "self-inquiry" (i.e. checking the system's
; context/memory, potentially with some level of inference (TBC) as well).
; TODO: in addition to updating the plan accordingly, this should
; return t if the inquiry was a success, or nil otherwise.
; 
  (let (curr-step ep-var ep-name wff match)
  
    ; Get current expected step, expected wff, and episode var
    (setq curr-step (plan-curr-step plan))
    (setq ep-var (plan-step-ep-name curr-step))
    (setq wff (plan-step-wff curr-step))

    ; Inquire about truth of wff in context; use first match
    (setq match (get-from-context wff))
    (if (equal match T) (setq match (list wff)))
    (when match
      (setq match (car match))

      ; Get episode name corresponding to contextual fact
      (setq ep-name (get-episode-from-contextual-fact match))
      
      ; Substitute that episode name for the episode variable in the plan
      (bind-variable-in-plan plan ep-name ep-var)

      ; Make all variable substitutions needed to unify wff and match
      (mapcar (lambda (x y) (if (and (variable? x) y) (bind-variable-in-plan plan y x)))
        wff match)

      ; Remove the matched predicate from context if a telic predicate, i.e., assume
      ; something like (^you say-to.v ^me ...) is no longer relevant after matched once.
      ; TODO: I'm not sure if this is a safe or realistic assumption to make... but it's
      ; currently necessary to prevent the program from automatically looping in the case
      ; where a :repeat-until episode consists of the user saying something and the agent
      ; replying, since the say-to.v expectation will keep matching the same fact in context.
      (if (member (second match) *verbs-telic*) (remove-old-contextual-fact match))

      ; Advance the plan
      (advance-plan plan)))
) ; END inquire-truth-of-next-episode



(defun check-goal-satisfied (goal)
;`````````````````````````````````````
; Check whether a goal is satisfied through process of "self-inquiry",
; i.e. checking context to verify whether the content of the goal
; (assuming, for now, a standard "want that ..." goal) is true in context.
; TODO: should also check knowledge base and/or memory if the goal is
; something like "want that me know ...".
;
  (let (goal-var goal-wff bindings goal-clause)
    (setq goal-var (first goal))
    (setq goal-wff (second goal))

    ; Check goal wff (currently only 'want that ...' goals are supported)
    (cond
      ((setq bindings (bindings-from-ttt-match '(^me want.v (that _!)) goal-wff))
        (setq goal-clause (get-single-binding bindings))
        ; Check if goal clause is true in context
        (if (get-from-context goal-clause) t nil))
      ; Support for tensed version as well
      ((setq bindings (bindings-from-ttt-match '(^me ((pres want.v) (that _!))) goal-wff))
        (setq goal-clause (get-single-binding bindings))
        ; Check if goal clause is true in context
        (if (get-from-context goal-clause) t nil))

      (t
        ;; (format t "~%*** UNSUPPORTED GOAL ~a (~a) " goal-var goal-wff) ; DEBUGGING
        nil))
)) ; END check-goal-satisfied



(defun replan-for-goal (plan goal)
;```````````````````````````````````````
; Given an unsatisfied goal, use a transduction tree to determine an appropriate subplan to instantiate
; and attach to the current plan step.
;
  (let (curr-step goal-var goal-wff bindings goal-words choice schema-name args subplan)

    ; Get current expected step, expected wff, and instantiated ep-name
    (setq curr-step (plan-curr-step plan))
    (setq goal-var (first goal))
    (setq goal-wff (second goal))

    ; Select subplan for replanning
    (setq choice (choose-result-for goal-wff '*replan-tree*))

    ; Create subplan depending on directive
    (cond
      ; :schema directive
      ((eq (car choice) :schema)
        (setq schema-name (cdr choice))
        (setq subplan (init-plan-from-schema (get-stored-schema schema-name) nil)))

      ; :schema+args directive
      ((eq (car choice) :schema+args)
        (setq schema-name (first (cdr choice)) args (second (cdr choice)))
        (setq subplan (init-plan-from-schema (get-stored-schema schema-name) args))))
    
    ; If subplan was obtained, attach to current step and return t, otherwise return nil
    (when subplan
      (add-subplan-curr-step plan subplan)
      t)

)) ; END replan-for-goal



(defun determine-next-episode-failed (plan)
;``````````````````````````````````````````````
; Determine that the immediately pending episode in the plan is a
; 'failed' episode; i.e. an expected episode which did not end up
; coming true during the "period" of expectation (governed by the
; certainty of the episode). Instantiate the episode with a new episode
; name characterized as a failure.
; Should return t after instantiating failed episode.
;
  (let (curr-step ep-name wff)

    ; Instantiate the episode variable of the new step and substitute
    (instantiate-curr-step plan)

    ; Get current expected step, expected wff, and instantiated ep-name
    (setq curr-step (plan-curr-step plan))
    (setq ep-name (plan-step-ep-name curr-step))
    (setq wff (plan-step-wff curr-step))

    ; Add (^you do.v (no.d thing.n)) to context, characterizing <ep-name>. This is
    ; essentially a no-op and isn't currently used for any further inference or replanning.
    ; TODO: this needs to be reworked after working out semantics for failed episodes.
    (store-contextual-fact-characterizing-episode `(^you do.v (no.d thing.n)) ep-name)

    ; Advance the plan
    (advance-plan plan)
  
)) ; END determine-next-episode-failed



(defun process-next-episode (plan) 
;```````````````````````````````````````
; Executes the immediately pending episode in the plan.
;
; Successful execution of an action returns a pair of variable bindings
; for any variables instantiated during execution of the action, and a
; newly generated subplan (possibly nil). The appropriate substitutions
; are made in the plan. If a new subplan was obtained, it's added as a
; subplan to the current step; otherwise, the plan is advanced.
;
; TODO: Why not use the names of nonprimitive steps themselves as
; subplan names? Answer: We want to potentially allow for associating
; multiple alternative subplans with a given step (if we do this, we
; should change 'subplan' to 'subplans', which will point to a *list* 
; of subplan names); when one subplan fails, the step may still be
; achievable with an alternative subplan. (For user inputs, different
; subplans represent alternative expectations about user behavior, and
; this eventually opens the door to an AND-OR style of planning, as in
; two-person games.)
;
  (let (curr-step wff ret bindings new-subplan)

    ; Current step becomes whatever the current step of plan is
    (setq curr-step (plan-curr-step plan))

    ; If no curr-step, return nil
    (if (null curr-step) (return-from process-next-episode nil))

    ;; (format t "~%steps of currently due plan ~a are: ~%" (plan-plan-name plan))
    ;; (print-current-plan-steps plan) ; DEBUGGING

    (setq wff (plan-step-wff curr-step))

    ; Instantiate the episode variable of the new step and substitute
    (instantiate-curr-step plan)

    ; Perform the episode corresponding to the current step accordingly,
    ; returning a pair of variable bindings obtained by the action, as
    ; well as a subplan generated by the action (if any, otherwise this is nil),
    ; e.g., (((var1 val1) (var2 val2)) PLAN788)
    (setq ret (if (eq (car wff) '^me)
      (implement-next-eta-action plan)
      (implement-next-plan-episode plan)))

    (setq bindings (first ret))
    (setq new-subplan (second ret))

    ;; (when bindings
    ;;   (format t "variable substitutions to be made: ~%  ~a~%" bindings)) ; DEBUGGING
    ;; (when new-subplan
    ;;   (format t "new subplan generated: ~a~%" (plan-plan-name new-subplan))) ; DEBUGGING

    ; Make all variable substitutions in the plan
    (dolist (binding bindings)
      (bind-variable-in-plan plan (second binding) (first binding)))

    ; If a new subplan was generated, add it as a subplan to the
    ; current step. Otherwise, advance the current (sub)plan.
    (if new-subplan
      (add-subplan-curr-step plan new-subplan)
      (advance-plan plan))

  wff
)) ; END process-next-episode



(defun bind-variable-in-plan (plan val var) 
;`````````````````````````````````````````````
; Traverses the linked list of steps, starting from the current step,
; and destructively substitutes val for var in the ep-name and wff
; of each step (this should also bind them in the corresponding schema,
; if the plan has any defined).
; TODO: need to think of whether this should also substitute val for var
; in any parent plan containing var in the 'vars' slot of the plan structure.
; I've left the step-of pointer in case this is done in the future.
;
  (let ((curr-step (plan-curr-step plan)))

    ; Iterate through each subsequent step and substitute val for var
    (loop while (not (null curr-step)) do
      (setf (plan-step-ep-name curr-step)
        (subst val var (plan-step-ep-name curr-step)))
      (nsubst val var (plan-step-wff curr-step))
      (setq curr-step (plan-step-next-step curr-step)))

    ; If plan has a schema, bind variable in schema
    (when (plan-schema plan)
      (bind-variable-in-schema (plan-schema plan) var val))

)) ; END bind-variable-in-plan



(defun subst-duplicate-variables (episodes certainties obligations) 
;`````````````````````````````````````````````````````````````````````
; Substitutes all variables in an episode list with duplicate variables.
; Also make substitutions in certainties and obligations lists if given.
;
  (let* ((episode-vars (get-episode-vars episodes))
        (new-episode-vars (mapcar (lambda (episode-var)
          (gentemp (string episode-var))) episode-vars))
        (episodes-new episodes)
        (certainties-new certainties)
        (obligations-new obligations))
    (mapcar (lambda (var new-var)
        (setq episodes-new (subst new-var var episodes-new))
        (setq certainties-new (subst new-var var certainties-new))
        (setq obligations-new (subst new-var var obligations-new)))
      episode-vars new-episode-vars)
  (list episodes-new certainties-new obligations-new)
)) ; END subst-duplicate-variables



(defun get-step-obligations (plan-step)
;````````````````````````````````````````
; Gets any obligations associated with a particular step in a plan in the
; schema that the step is part of (look at the parent step as well in case of
; no obligations).
; TODO: this will likely need to be changed in the future once a more general
; mechanism is figured out.
;
  (let ((obligations (plan-step-obligation plan-step)) superstep)
    (when (and (plan-step-step-of plan-step) (plan-subplan-of (plan-step-step-of plan-step)))
      (setq superstep (plan-subplan-of (plan-step-step-of plan-step))))
    ; TODO: this is a bit hacky currently because say-to.v actions may need to access
    ; the parent paraphrase-to.v actions in order to access obligations. Rather, it seems
    ; that the say-to.v actions should inherit the obligations upon creation.
    (when (and superstep (null obligations))
      (setq obligations (plan-step-obligation superstep)))

    (if (member 'and obligations)
      (remove 'and obligations)
      (list obligations))
)) ; END get-step-obligations



(defun get-episode-vars (episodes)
;```````````````````````````````````
; Form a list of all episode vars (in proposition form) from a list of episodes.
;
  (let (var vars)
    (cond
      ; Base case - if episodes is a symbol, return the symbol if it is an action
      ; var, or nil otherwise.
      ((symbolp episodes)
        (if (variable? episodes)
          `(,(if (ep-var? episodes) (intern (format nil "~a" episodes)) episodes)) nil))
      ; Recursive case
      (t
        (remove-duplicates
          (remove nil (apply #'append (mapcar #'get-episode-vars episodes)))
          :test #'equal))))
) ; END get-episode-vars



(defun get-curr-pending-step (plan)
;`````````````````````````````````````
; Gets the currently pending step of a given (sub)plan.
;
  (plan-curr-step plan)
) ; END get-curr-pending-step



(defun get-step-ep-name (plan-step)
;`````````````````````````````````````
; Gets the episode name associated with a plan step.
;
  (plan-step-ep-name plan-step)
) ; END get-step-ep-name



(defun get-step-wff (plan-step)
;`````````````````````````````````````
; Gets the wff associated with a plan step.
;
  (plan-step-wff plan-step)
) ; END get-step-wff



(defun get-step-certainty (plan-step)
;``````````````````````````````````````
; Gets the wff associated with a plan step.
;
  (plan-step-certainty plan-step)
) ; END get-step-certainty



;; (defun print-current-plan-steps (plan) 
;; ;``````````````````````````````````````
;; ; Prints each subsequent step in a plan, starting from the current
;; ; step, showing the ep-name and wff of each. Does not include subplans.
;; ; For debugging purposes.
;; ;
;;   (let ((curr-step (plan-curr-step plan)))

;;     ; Iterate through each subsequent step and print ep-name and wff
;;     (loop while (not (null curr-step)) do
;;       (format t "~a ~a~%" (plan-step-ep-name curr-step) (plan-step-wff curr-step))
;;       (setq curr-step (plan-step-next-step curr-step))))
;; ) ; END print-current-plan-steps



(defun format-plan-step (step) ; {@}
;`````````````````````````````````````
; Formats the step corresponding to a given plan node, as:
; ep-name : wff [certainty]
;
  (format nil "~a : ~a [~a]"
    (plan-step-ep-name step)
    (plan-step-wff step)
    (plan-step-certainty step))
) ; END format-plan-step



(defun print-current-plan-status (node &key (before 3) (after 5)) ; {@}
;``````````````````````````````````````````````````````````````````
; Prints the current plan status (i.e., steps that are currently in
; the surface plan, with a pointer to the currently due step). Allows
; the number of steps to be shown before and after this pointer to be
; specified as key arguments.
;
  (let ((prev (plan-node-prev node)) (next (plan-node-next node))
        steps-prev step-curr steps-next)
    (loop while (and prev (> before 0)) do
      (push (format-plan-step (plan-node-step prev)) steps-prev)
      (setq prev (plan-node-prev prev))
      (decf before))
    (setq step-curr (format-plan-step (plan-node-step node)))
    (loop while (and next (> after 0)) do
      (push (format-plan-step (plan-node-step next)) steps-next)
      (setq next (plan-node-next next))
      (decf after))
    ; Print
    (format t "~% --- CURRENT PLAN STATUS: ----------~%")
    (if prev (format t "   ...~%"))
    (dolist (step-prev steps-prev)
      (format t "   ~a~%" step-prev))
    (format t ">> ~a~%" step-curr)
    (dolist (step-next (reverse steps-next))
      (format t "   ~a~%" step-next))
    (if next (format t "   ...~%"))
    (format t " -----------------------------------~%")
)) ; END print-current-plan-status



;; (defun print-current-plan-status (plan) 
;; ;````````````````````````````````````````
;; ; Prints the current plan status. Shows ep-name and wff of
;; ; current pending step in plan, as well as the status of
;; ; any subplans of that step. For debugging purposes.
;; ;
;;   (let ((curr-plan plan) curr-step superstep subplan (cont t))

;;     ; Print top-level information about plan
;;     (format t "Status of ~a "
;;       (plan-plan-name plan))
;;     (setq superstep (plan-subplan-of plan))
;;     (if superstep
;;       (format t "(subplan-of ~a):~%" (plan-step-ep-name superstep))
;;       (format t "(no superstep):~%"))

;;     ; Print each current step and repeat for subplan, if any
;;     (loop while cont do
;;       (setq curr-step (plan-curr-step curr-plan))
;;       (when (null curr-step)
;;         (format t "  No more steps in ~a.~%" (plan-plan-name curr-plan))
;;         (format t "  --------------------~%")
;;         (return-from print-current-plan-status nil))
;;       (format t "  rest of ~a = (~a ~a ...)~%" (plan-plan-name curr-plan)
;;         (plan-step-ep-name curr-step) (plan-step-wff curr-step))
;;       (setq subplan (plan-step-subplan curr-step))
;;       (cond
;;         (subplan
;;           (format t "  subplan ~a of ~a:"
;;             (plan-plan-name subplan) (plan-step-ep-name curr-step))
;;           (setq curr-plan subplan))
;;         (t (setq cont nil)))))
;; ) ; END print-current-plan-status



(defun print-plan-tree-from-node (plan-node) ; {@}
;`````````````````````````````````````````````
; Prints the subtree of the plan structure reachable from the given node.
;
  (print-plan-tree-from-surface-step (plan-node-step plan-node))
) ; END print-plan-tree-from-node



(defun print-plan-tree-from-surface-step (plan-step) ; {@}
;``````````````````````````````````````````````````````
; Prints the subtree of the plan structure reachable from the given surface step.
;
  (let ((indent-str "       "))
    (labels ((print-tree-recur (step i)
      (when (null step) (return-from print-tree-recur nil))
      (format t "~a~a~%" (str-repeat indent-str i) (format-plan-step step))
      (mapcar (lambda (superstep) (print-tree-recur superstep (+ i 1))) (plan-step-supersteps step))))  
    (print-tree-recur plan-step 0)
    nil
))) ; END print-plan-tree-from-surface-step



(defun print-plan-tree-from-root-step (plan-step) ; {@}
;`````````````````````````````````````````````````
; Prints the subtree of the plan structure reachable from the given root step.
;
  (let ((indent-str "       "))
    (labels ((print-tree-recur (step i)
      (when (null step) (return-from print-tree-recur nil))
      (format t "~a~a~%" (str-repeat indent-str i) (format-plan-step step))
      (mapcar (lambda (substep) (print-tree-recur substep (+ i 1))) (plan-step-substeps step))))  
    (print-tree-recur plan-step 0)
    nil
))) ; END print-plan-tree-from-root-step



;; (defun print-plan-as-tree (plan)
;; ;`````````````````````````````````````````````````
;; ; Prints the given plan as a tree, showing the sequence of steps for each (sub)plan.
;; ;
;;   (let ((indent-str "       "))
;;     (labels (
;;       (print-plan-steps-recur (plan-step direction i)
;;         (when (null plan-step) (return-from print-plan-steps-recur nil))
;;         (format t
;;           (if (equal direction 'curr)
;;             "~a>>>[~a] ~a~%"
;;             "~a-  [~a] ~a~%")
;;           (str-repeat indent-str i)
;;           (plan-step-ep-name plan-step)
;;           (plan-step-wff plan-step))
;;         (when (plan-step-subplan plan-step)
;;           (print-plan-as-tree-recur (plan-step-subplan plan-step) (+ i 1)))
;;         (cond
;;           ((equal direction 'before)
;;             (print-plan-steps-recur (plan-step-prev-step plan-step) 'before i))
;;           ((equal direction 'after)
;;             (print-plan-steps-recur (plan-step-next-step plan-step) 'after i))))

;;       (print-plan-as-tree-recur (plan i)
;;         (when (null plan) (return-from print-plan-steps-recur nil))
;;         (when (plan-curr-step plan)
;;           (format t "~a|- ~a~%" (str-repeat indent-str i) (plan-plan-name plan))
;;           (print-plan-steps-recur (plan-step-prev-step (plan-curr-step plan)) 'before i)
;;           (print-plan-steps-recur (plan-curr-step plan) 'curr i)
;;           (print-plan-steps-recur (plan-step-next-step (plan-curr-step plan)) 'after i))))
          
;;     (print-plan-as-tree-recur plan 0)
;; ))) ; END print-plan-as-tree



(defun get-all-unique-plan-step-ids (plan-node) ; {@}
;`````````````````````````````````````````````````
; This is a test function to make sure plan methods (primarily deepcopy)
; are working correctly; it returns all unique ids traversable within a plan
; structure, beginning at the current plan-node.
;
  (let (ret)
    (labels
      ((get-all-unique-plan-step-ids-recur1 (node left right)
        (get-all-unique-plan-step-ids-recur2 (plan-node-step node))
        (when (and (plan-node-prev node) left)
          (get-all-unique-plan-step-ids-recur1 (plan-node-prev node) t nil))
        (when (and (plan-node-next node) right)
          (get-all-unique-plan-step-ids-recur1 (plan-node-next node) nil t)))
      (get-all-unique-plan-step-ids-recur2 (step)
        (setq ret (cons (plan-step-id step) ret))
        (mapcar #'get-all-unique-plan-step-ids-recur2 (plan-step-supersteps step))))
  (get-all-unique-plan-step-ids-recur1 plan-node t t)
  (remove-duplicates ret)
))) ; END get-all-unique-plan-step-ids



(defun get-all-plan-structure-roots (plan-node) ; {@}
;`````````````````````````````````````````````````
; Get all root plan-steps in a plan structure
; (i.e., those without any supersteps).
;
  (let (ret)
    (labels
      ((get-all-plan-structure-roots-recur1 (node left right)
        (get-all-plan-structure-roots-recur2 (plan-node-step node))
        (when (and (plan-node-prev node) left)
          (get-all-plan-structure-roots-recur1 (plan-node-prev node) t nil))
        (when (and (plan-node-next node) right)
          (get-all-plan-structure-roots-recur1 (plan-node-next node) nil t)))
      (get-all-plan-structure-roots-recur2 (step)
        (when (null (plan-step-supersteps step))
          (setq ret (cons step ret)))
        (mapcar #'get-all-plan-structure-roots-recur2 (plan-step-supersteps step))))
  (get-all-plan-structure-roots-recur1 plan-node t t)
  (remove-duplicates ret :test (lambda (x y) (equal (plan-step-id x) (plan-step-id y))))
))) ; END get-all-plan-structure-roots



(defun make-test-plan-structure () ; {@}
;```````````````````````````````````````````
; Creates an artificial plan structure for testing purposes.
;
  (let* (
    (pe1  (make-plan-step :ep-name 'e1))
    (pe2  (make-plan-step :ep-name 'e2))
    (pe3  (make-plan-step :ep-name 'e3))
    (pe4  (make-plan-step :ep-name 'e4))
    (pe5  (make-plan-step :ep-name 'e5))
    (pe6  (make-plan-step :ep-name 'e6))
    (pe7  (make-plan-step :ep-name 'e7))
    (pe8  (make-plan-step :ep-name 'e8))
    (pe9  (make-plan-step :ep-name 'e9))
    (pe10 (make-plan-step :ep-name 'e10))
    (pe11 (make-plan-step :ep-name 'e11))
    (pe12 (make-plan-step :ep-name 'e12))
    (n8  (make-plan-node :step pe8))
    (n9  (make-plan-node :step pe9))
    (n10 (make-plan-node :step pe10))
    (n11 (make-plan-node :step pe11))
    (n12 (make-plan-node :step pe12))
    (n7  (make-plan-node :step pe7))
    )
  (setf (plan-step-substeps pe1) (list pe3 pe4 pe5))
  (setf (plan-step-substeps pe2) (list pe4 pe6 pe7))
  (setf (plan-step-substeps pe3) (list pe8 pe9))
  (setf (plan-step-substeps pe4) (list pe10))
  (setf (plan-step-substeps pe5) (list pe9 pe11))
  (setf (plan-step-substeps pe6) (list pe12))
  (setf (plan-step-supersteps pe3) (list pe1))
  (setf (plan-step-supersteps pe4) (list pe1 pe2))
  (setf (plan-step-supersteps pe5) (list pe1))
  (setf (plan-step-supersteps pe6) (list pe2))
  (setf (plan-step-supersteps pe7) (list pe2))
  (setf (plan-step-supersteps pe8) (list pe3))
  (setf (plan-step-supersteps pe9) (list pe3 pe5))
  (setf (plan-step-supersteps pe10) (list pe4))
  (setf (plan-step-supersteps pe11) (list pe5))
  (setf (plan-step-supersteps pe12) (list pe6))
  (setf (plan-node-next n8) n9)
  (setf (plan-node-prev n9) n8)
  (setf (plan-node-next n9) n10)
  (setf (plan-node-prev n10) n9)
  (setf (plan-node-next n10) n11)
  (setf (plan-node-prev n11) n10)
  (setf (plan-node-next n11) n12)
  (setf (plan-node-prev n12) n11)
  (setf (plan-node-next n12) n7)
  (setf (plan-node-prev n7) n12)
  n11
)) ; END make-test-plan-structure