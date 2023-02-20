;; Aug 5/2020
;; ===========================================================
;;
;; Contains the schema-based planning module used by Eta, built around
;; the 'plan' and 'plan-step' structures defined below (essentially a doubly-linked-list
;; with pointers for subplan relations.)
;;
;; Functions described in more detail in their headers.
;;

(setf *print-circle* t) ; needed to prevent recursive loop when printing plan-step

(defstruct plan
;```````````````````````````````
; contains the following fields:
; plan-name       : the generated name for the plan
; schema-name     : the name of the schema used to generate the plan (if any)
; schema-contents : the contents of the schema used to generate the plan (if any)
; curr-step       : the current (to be processed) step of the plan
; vars            : contains any local variables in plan (potentially inherited)
; subplan-of      : points to a plan-step that the plan is a subplan of
; (the following fields are inherited from the schema (if any))
; types           : contains formulas for types in plan
; var-roles       : contains formulas for var-roles in plan
; rigid-conds     : contains formulas for rigid conditions of plan
; static-conds    : contains formulas for static conditions of plan
; preconds        : contains formulas for preconditions of plan
; goals           : contains formulas for goals of plan
;
  plan-name
  schema-name
  schema-contents
  curr-step
  vars
  subplan-of
  ; == facts inherited from schema ==
  types
  var-roles
  rigid-conds
  static-conds
  preconds
  goals
) ; END defstruct plan



(defstruct plan-step
;```````````````````````````````
; contains the following fields:
; step-of   : points to the plan structure that this is a step of
; prev-step : points to the previous step in the plan
; next-step : points to the next step in the plan
; ep-name   : episode name of step (gist-clauses, etc. are implicitly attached to ep-name)
; wff       : action formula corresponding to episode name
; subplan   : subplan of step (if any)
; certainty : how certain the step is (if the step is an expected step). The patience of the
;             system in waiting to observe the step is proportional to this
; obligation : the obligation(s) associated with the step
;
  step-of
  prev-step
  next-step
  ep-name
  wff
  (certainty 1.0) ; defaults to 1, i.e. a certain step
  obligation
  subplan
) ; END defstruct plan-step



(defun init-plan-from-schema (schema-name args) 
;````````````````````````````````````````````````
; Given a schema name (e.g. '*eta-schema*), instantiate the
; schema that a plan is to be based on. For non-nil 'args', we
; replace successive variables occurring in the header (excluding
; the episode variable ?e itself) by successive elements of 'args'.
;
; TODO: should ?e be instantiated and (<schema-header> ** E1) be
; stored in context at this point?
;
  (let (plan schema sections ep-vars)
    ; Make plan structure plan-name corresponding to schema-name
    (setq plan (make-plan))
    (setf (plan-plan-name plan) (gensym "PLAN"))
    (setf (plan-schema-name plan) schema-name)

    ;; (format t "'schema-name' of ~a has been set to ~a~%"
    ;;   (plan-plan-name plan) (plan-schema-name plan)) ; DEBUGGING

    ; Retrieve schema contents from schema-name
    ; (copying so destructive edits can be made)
    (setq schema (copy-tree (eval schema-name)))

    ; Substitute all episode vars in schema with globally unique vars,
    ; to avoid conflicts when using property lists
    (setq ep-vars (remove-duplicates (remove-if-not #'ep-var? (flatten schema))))
    (dolist (ep-var ep-vars)
      (setq schema (subst (gensym (string ep-var)) ep-var schema)))

    (setf (plan-schema-contents plan) schema)

    ; Return error if schema has no :episodes keyword
    (when (not (find :episodes schema))
      (format t "*** Attempt to form plan ~a from schema ~a with no :episodes keyword"
        (plan-plan-name plan) (plan-schema-name plan))
      (return-from init-plan-from-schema nil))

    ;; (format t "schema used to initialize plan ~a is ~% ~a~%"
    ;;   (plan-plan-name plan) (plan-schema-contents plan)) ; DEBUGGING

    ; Destructively ubstitute the arguments 'args' (if non-nil) for the variables
    ; in the plan/schema header (other than the episode variable)
    (if args (nsubst-schema-args args schema))

    ;; (format t "schema used for plan ~a, with arguments instantiated ~% ~a~%"
    ;;   (plan-plan-name plan) (plan-schema-contents plan)) ; DEBUGGING

    ; Get schema sections. 'sections' is a hash table with schema sections as keys
    (setq sections (get-schema-sections schema))

    ; Process each part of the schema separately
    (process-schema-types             plan (gethash :types sections))
    (process-schema-var-roles         plan (gethash :var-roles sections))
    (process-schema-rigid-conds       plan (gethash :rigid-conds sections))
    (process-schema-static-conds      plan (gethash :static-conds sections))
    (process-schema-preconds          plan (gethash :preconds sections))
    (process-schema-goals             plan (gethash :goals sections))
    (process-schema-episode-relations plan (gethash :episode-relations sections))
    (process-schema-necessities       plan (gethash :necessities sections))
    (process-schema-certainties       plan (gethash :certainties sections))
    (process-schema-obligations       plan (gethash :obligations sections))
    ; Process episodes last so things like certainties can be used
    (process-schema-episodes          plan (gethash :episodes sections))

  ; If goals of plan are already satisfied, skip over plan by returning nil,
  ; otherwise return new plan
  (if (and (plan-goals plan) (every #'check-goal-satisfied (plan-goals plan)))
    nil
    plan)
)) ; END init-plan-from-schema



(defun init-plan-from-episode-list (episodes) 
;```````````````````````````````````````````````
; Given a list of episodes, create a plan corresponding to that
; sequence of episodes. Used for creating subplans from certain
; non-primitive actions.
;
  (let (plan)
    ; Make plan structure plan-name
    (setq plan (make-plan))
    (setf (plan-plan-name plan) (gensym "PLAN"))

    ; Remove :episodes keyword (if given)
    (if (equal :episodes (car episodes)) (setq episodes (cdr episodes)))

    ; Process episodes
    (process-schema-episodes plan episodes)

  plan)
) ; END init-plan-from-episode-list



(defun process-schema-types (plan types) 
;`````````````````````````````````````````
; Add all types to context.
; TODO: This is incomplete and needs to be updated in the future.
; Currently doesn't do anything with the proposition variables e.g. !t1
; TODO: Should typed variables try to find a value right away? Probably not,
; if I'm requiring all variables "local" to a schema to be included in
; the :types section. For now, I've kept this the same as before though.
;
  (let ((type-pairs (form-name-wff-pairs types)) type-name type-wff var)
    (dolist (type-pair type-pairs)
      (setq type-name (first type-pair))
      (setq type-wff (second type-pair))
      ; If typed variable, find value for variable through observation and
      ; substitute in both type and in contents of each schema section.
      (when (variable? (car type-wff))
        (setq var (car type-wff))
        (push var (plan-vars plan))
        ; Get skolem name and replace in schema.
        (setq sk-name (observe-variable-type var (second type-wff)))
        (nsubst sk-name var (plan-schema-contents plan))
        (setq type-wff (subst sk-name var type-wff)))
      ; Store type as fact in context.
      (store-in-context type-wff))
      (push (list type-name type-wff) (plan-types plan)))
) ; END process-schema-types



(defun process-schema-var-roles (plan var-roles)
;```````````````````````````````````````````````````
; TBC
; e.g., !r9 (?ka1 (kind1-of.n action1.n))
;
  (let ((var-role-pairs (form-name-wff-pairs var-roles)) var-role-name var-role-wff)
    (dolist (var-role-pair var-role-pairs)
      (setq var-role-name (first var-role-pair))
      (setq var-role-wff (second var-role-pair))
      (push (list var-role-name var-role-wff) (plan-var-roles plan))))
) ; END process-schema-var-roles



(defun process-schema-rigid-conds (plan rigid-conds)
;`````````````````````````````````````````````````````
; Add all rigid-conds to context.
; TODO: This is incomplete and needs to be updated in the future.
; Currently doesn't handle formula variables at all (e.g., for a
; rigid-cond like (?b1 red.a)), or do anything with the proposition
; variables e.g. !r1
;
  (let ((rigid-cond-pairs (form-name-wff-pairs rigid-conds)) rigid-cond-name rigid-cond-wff)
    (dolist (rigid-cond-pair rigid-cond-pairs)
      (setq rigid-cond-name (first rigid-cond-pair))
      (setq rigid-cond-wff (second rigid-cond-pair))
      (store-in-context rigid-cond-wff)
      (push (list rigid-cond-name rigid-cond-wff) (plan-rigid-conds plan))))
) ; END process-schema-rigid-conds



(defun process-schema-static-conds (plan static-conds)
;````````````````````````````````````````````````````````
; Adds any static conditions of the schema to the plan structure, as a list (static-cond-name static-cond-wff).
; e.g., ?s2 (^you at-loc.p |Table|) gets added as:
; (?s2 (^you at-loc.p |Table|))
; TBC
;
  (let ((static-cond-pairs (form-name-wff-pairs static-conds)) static-cond-name static-cond-wff)
    (dolist (static-cond-pair static-cond-pairs)
      (setq static-cond-name (first static-cond-pair))
      (setq static-cond-wff (second static-cond-pair))
      (push (list static-cond-name static-cond-wff) (plan-static-conds plan))))
) ; END process-schema-static-conds



(defun process-schema-preconds (plan preconds)
;```````````````````````````````````````````````
; Adds any preconditions of the schema to the plan structure, as a list (precond-name precond-wff).
; e.g., ?p1 (some ?c ((?c member-of.p ?cc) and (not (^you understand.v ?c)))) gets added as:
; (?p1 (some ?c ((?c member-of.p ?cc) and (not (^you understand.v ?c)))))
; TBC
;
  (let ((precond-pairs (form-name-wff-pairs preconds)) precond-name precond-wff)
    (dolist (precond-pair precond-pairs)
      (setq precond-name (first precond-pair))
      (setq precond-wff (second precond-pair))
      (push (list precond-name precond-wff) (plan-preconds plan))))
) ; END process-schema-preconds



(defun process-schema-goals (plan goals)
;`````````````````````````````````````````
; Adds any goals of the schema to the plan structure, as a list (goal-name goal-wff).
; e.g., ?g1 (^me want1.v (that (^you understand1.v ?c))) gets added as:
; (?g1 (^me want1.v (that (^you understand1.v ?c))))
;
  (let ((goal-pairs (form-name-wff-pairs goals)) goal-name goal-wff)
    (dolist (goal-pair goal-pairs)
      (setq goal-name (first goal-pair))
      (setq goal-wff (second goal-pair))
      (push (list goal-name goal-wff) (plan-goals plan))))
) ; END process-schema-goals



(defun process-schema-episodes (plan episodes)
;```````````````````````````````````````````````
; Converts episodes contents of schema to a linked list
; representing the steps in a plan. Returns the first
; plan step.
; TODO: eventually, it seems like we should allow for steps
; to be added to the plan non-sequentially, based on the
; episode-relations defined in the schema.
;
  (let ((steps (form-name-wff-pairs episodes)) first-step prev-step curr-step)

    ; Give error if first element of first pair isn't episode variable starting with '?'
    (when (not (variable? (caar steps)))
      (format t "*** malformed step ~a while trying to form plan ~a from schema ~a (doesn't begin with episode variable)~%"
        (car steps) (plan-plan-name plan) (plan-schema-name plan))
      (return-from process-schema-episodes nil))

    ; Iterate over steps in episodes list
    (dolist (step steps)

      ; Make plan step structure and set data
      (setq curr-step (make-plan-step))
      (setf (plan-step-step-of curr-step) plan)
      (if (null first-step) (setq first-step curr-step))
      (setf (plan-step-ep-name curr-step) (first step))
      (setf (plan-step-wff curr-step) (second step))
      ; When episode name has certainty associated, add to step
      (when (get (first step) 'certainty)
        (setf (plan-step-certainty curr-step) (get (first step) 'certainty)))
      ; When episode name has obligation associated, add to step
      (when (get (first step) 'obligation)
        (setf (plan-step-obligation curr-step) (get (first step) 'obligation)))
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

)) ; END process-schema-episodes



(defun process-schema-episode-relations (plan episode-relations)
;``````````````````````````````````````````````````````````````````
; TBC
; e.g., !w8 (?e8 before1.p ?e9)
;
  (let ((episode-relation-pairs (form-name-wff-pairs episode-relations)) episode-relation-name episode-relation-wff)
    (dolist (episode-relation-pair episode-relation-pairs)
      (setq episode-relation-name (first episode-relation-pair))
      (setq episode-relation-wff (second episode-relation-pair))
    )
  )
) ; END process-schema-episode-relations



(defun process-schema-necessities (plan necessities)
;``````````````````````````````````````````````````````
; TBC
; e.g., !n1 (!bb .99)
;
  (let ((necessity-pairs (form-name-wff-pairs necessities)) necessity-name necessity-wff)
    (dolist (necessity-pair necessity-pairs)
      (setq necessity-name (first necessity-pair))
      (setq necessity-wff (second necessity-pair))
    )
  )
) ; END process-schema-necessities



(defun process-schema-certainties (plan certainties)
;``````````````````````````````````````````````````````
; Processes certainty formulas in the schema, adding the certainty to a
; property list of the episode var/name.
; e.g., !c1 (!e1 .8)
;
  (let ((certainty-pairs (form-name-wff-pairs certainties)) certainty-name certainty-wff
        episode-name certainty)
    (dolist (certainty-pair certainty-pairs)
      (setq certainty-name (first certainty-pair))
      (setq certainty-wff (second certainty-pair))
      (setq episode-name (first certainty-wff))
      (setq certainty (second certainty-wff))
      ; ((that ,episode-name) is-necessary-to-degree ,certainty)
      (setf (get (dual-var episode-name) 'certainty) certainty)
    )
  )
) ; END process-schema-certainties



(defun process-schema-obligations (plan obligations)
;``````````````````````````````````````````````````````
; Processes obligation formulas in the schema, adding the obligation to a
; property list of the episode var/name.
; e.g., !o1 (?e1 obligates (...))
;
  (let ((obligation-pairs (form-name-wff-pairs obligations)) obligation-name obligation-wff
        episode-name obligation)
    (dolist (obligation-pair obligation-pairs)
      (setq obligation-name (first obligation-pair))
      (setq obligation-wff (second obligation-pair))
      (setq episode-name (first obligation-wff))
      (setq obligation (third obligation-wff))
      (setf (get episode-name 'obligation) obligation)
    )
  )
) ; END process-schema-obligations



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



(defun form-name-wff-pairs (contents)
;`````````````````````````````````````
; Groups contents of a schema section, assumed to be a series of
; declarations of the following form:
; <name> <wff>
; into a list of (name wff) pairs. Here, name is assumed to be
; a variable of the form ?x or !x.
;
  (cond
    ((null contents) nil)
    (t (cons (list (first contents) (second contents))
             (form-name-wff-pairs (cddr contents)))))
) ; END form-name-wff-pairs



(defun add-subplan-curr-step (plan subplan) 
;````````````````````````````````````````````
; Given a plan and a subplan, attaches the subplan to the
; currently active step of the plan using the add-subplan function.
; Unless the subplan already has an associated schema name/contents, it
; inherits the schema name/contents of the schema used to create the subplan.
; TODO: should this inherit variables defined in the parent plan at all?
; 
  (add-subplan (plan-curr-step plan) subplan)
  (unless (plan-schema-name subplan)
    (setf (plan-schema-name subplan) (plan-schema-name plan))
    (setf (plan-schema-contents subplan) (plan-schema-contents plan))
    (setf (plan-types subplan) (plan-types plan))
    (setf (plan-var-roles subplan) (plan-var-roles plan))
    (setf (plan-rigid-conds subplan) (plan-rigid-conds plan))
    (setf (plan-static-conds subplan) (plan-static-conds plan))
    (setf (plan-preconds subplan) (plan-preconds plan))
    (setf (plan-goals subplan) (plan-goals plan)))
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
          (when (plan-goals subplan)
            (setq unsatisfied-goals (remove-if #'check-goal-satisfied (plan-goals subplan)))
            (when unsatisfied-goals
              ;; (dolist (ug unsatisfied-goals) (format t "~%  unsatisfied goal: ~a" ug)) ; DEBUGGING
              (setq replanned? (replan-for-goal plan (car unsatisfied-goals)))
              (if replanned? (return-from update-plan-state nil))))

          ;; (format t "subplan ~a has no curr-step, so advancing plan ~a past step: ~%  ~a ~a ~%"
          ;;   (plan-plan-name subplan) (plan-plan-name plan) (plan-step-ep-name curr-step) (plan-step-wff curr-step)) ; DEBUGGING

          ; Advance plan if subplan is finished and goals (if any) satisfied
          (advance-plan plan)))))
) ; END update-plan-state



(defun instantiate-curr-step (plan) 
;`````````````````````````````````````
; Instantiates the first episode in the plan, destructively substituting
; the skolemized episode wherever it occurs in the plan. Also attaches
; any properties from the hash tables associated with the episode variable
; in the schema.
;
  (let ((curr-step (plan-curr-step plan)) ep-var ep-name schema-name
        gist-clauses semantics topic-keys)

    ; If no curr-step, return nil
    (if (null curr-step) (return-from instantiate-curr-step nil))
    
    ; Get episode-var (if already instantiated, return nil)
    (setq ep-var (plan-step-ep-name curr-step))
    (if (not (variable? ep-var)) (return-from instantiate-curr-step nil))

    ; Generate a constant for the episode and destructively substitute in plan
    (setq ep-name (episode-name))
    ; TODO: use episode-relations formulas to assert relations in timegraph
    (store-init-time-of-episode ep-name)
    (nsubst-variable plan ep-name ep-var)

    ;; (format t "action list after substituting ~a for ~a:~%" ep-name ep-var)
    ;; (print-current-plan-steps plan) ; DEBUGGING

    ; Attach wff to episode name (likely not used, but for convenience's sake)
    ; TODO: should (wff ** ep-name) be stored in context at this point?
    ;       as well as instantiating the non-fluent variable, e.g. '!e1'?
    (setf (get ep-name 'wff) (plan-step-wff curr-step))
    
    ; In the case of an Eta or joint action, transfer properties from ep-var hash tables
    (setq schema-name (plan-schema-name plan))
    (when (or (eq '^me (car (plan-step-wff curr-step))) 
              (and (listp (car (plan-step-wff curr-step)))
                   (member '^me (car (plan-step-wff curr-step)))))
      ; Gist clauses
      (when (get schema-name 'gist-clauses)
        (setq gist-clauses (gethash ep-var (get schema-name 'gist-clauses)))
        (dolist (gist-clause gist-clauses)
          (store-gist-clause-characterizing-episode gist-clause ep-name '^me '^you)))

      ;; (format t "Gist clauses attached to ~a (~a) from ~a =~% ~a~%"
      ;;   ep-name (plan-step-wff curr-step) ep-var (get-gist-clauses-characterizing-episode ep-name)) ; DEBUGGING

      ; Logical forms
      (when (get schema-name 'semantics)
        (setq semantics (gethash ep-var (get schema-name 'semantics)))
        (dolist (wff semantics)
          (store-semantic-interpretation-characterizing-episode wff ep-name '^me '^you)))

      ;; (format t "Semantics attached to ~a (~a) from ~a =~% ~a~%"
      ;;   ep-name (plan-step-wff curr-step) ep-var (get-semantic-interpretations-characterizing-episode ep-name)) ; DEBUGGING

      ; Topic-keys
      (when (get schema-name 'topic-keys)
        (setq topic-keys (gethash ep-var (get schema-name 'topic-keys)))
        (setf (get ep-name 'topic-keys) topic-keys))

      ;; (format t "Topic keys attached to ~a =~% ~a (from ~a ~a)~%"
      ;;   ep-name (get ep-name 'topic-keys) ep-var (plan-step-wff curr-step)) ; DEBUGGING
  ))
) ; END instantiate-curr-step



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
      (nsubst-variable plan ep-name ep-var)

      ; Make all variable substitutions needed to unify wff and match
      (mapcar (lambda (x y) (if (and (variable? x) y) (nsubst-variable plan y x)))
        wff match)

      ; Attach wff to episode name (likely not used, but for convenience's sake)
      (setf (get ep-name 'wff) match)

      ; Remove the matched predicate from context if a telic predicate, i.e., assume
      ; something like (^you say-to.v ^me ...) is no longer relevant after matched once.
      ; TODO: I'm not sure if this is a safe or realistic assumption to make... but it's
      ; currently necessary to prevent the program from automatically looping in the case
      ; where a :repeat-until episode consists of the user saying something and the agent
      ; replying, since the say-to.v in the schema will keep matching the same fact in context.
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
        (setq subplan (init-plan-from-schema schema-name nil)))

      ; :schema+args directive
      ((eq (car choice) :schema+args)
        (setq schema-name (first (cdr choice)) args (second (cdr choice)))
        (setq subplan (init-plan-from-schema schema-name args))))
    
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
      (nsubst-variable plan (second binding) (first binding)))

    ; If a new subplan was generated, add it as a subplan to the
    ; current step. Otherwise, advance the current (sub)plan.
    (if new-subplan
      (add-subplan-curr-step plan new-subplan)
      (advance-plan plan))

  wff
)) ; END process-next-episode



(defun nsubst-variable (plan val var) 
;```````````````````````````````````````
; Traverses the linked list of steps, starting from the current step,
; and destructively substitutes val for var in the ep-name and wff
; of each step (this should also replace them in schema-contents, if
; the plan has any defined).
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
  
    ; If plan has schema-contents, substitute val for var there too
    (nsubst val var (plan-schema-contents plan)))
) ; END nsubst-variable



(defun nsubst-schema-args (args schema) 
;```````````````````````````````````````
; Substitute the successive arguments in the 'args' list for successive
; variables occurring in the schema or plan header exclusive of the 
; episode variable characterized by the header predication (for 
; episodic headers). In relational schemas, headers are assumed to 
; be simple (infix) predications,
;          (<term> <pred> <term> ... <term>),
; and for event schemas they are of form
;          ((<term> <pred> <term> ... <term>) ** <term>).
; We look for variables among the terms (exclusive of the one following
; "**" in the latter header type), and replace them in succession by
; the members of 'args'.
;
  (let (header predication vars)
    (setq header (second (member :header schema)))
    (if (eq (second header) '**)
      (setq predication (first header)) ; episodic
      (setq predication header)) ; nonepisodic
    (if (atom predication) ; unexpected
      (return-from nsubst-schema-args schema))
    (dolist (x predication)
      (if (variable? x) (push x vars)))
    (when (null vars) ; unexpected
      (format t "@@@ Warning: Attempt to substitute values~%    ~a~%    in header ~a, which has no variables~%"
                args predication)
      (return-from nsubst-schema-args schema))
    (setq vars (reverse vars))
    (cond
      ((> (length args) (length vars))
        (format t "@@@ Warning: More values supplied, viz.,~%    ~a,~%    than header ~a has variables~%"
                  args predication)
        (setq args (butlast args (- (length args) (length vars)))))
      ((< (length args) (length vars))
        (format t "@@@ Warning: Fewer values supplied, viz.,~%    ~a,~%    than header ~a has variables~%"
                  args predication)
        (setq vars (butlast vars (- (length vars) (length args))))))
            
      ; Length of 'args' and 'vars' are equal (or have just been equalized)
    (dotimes (i (length args))
      (nsubst (pop args) (pop vars) schema))

    schema)
) ; END nsubst-schema-args



(defun subst-duplicate-variables (plan episodes) 
;``````````````````````````````````````````````````
; Substitutes all variables in an episode list with duplicate variables,
; inheriting the gist-clauses, semantics, etc. attached to them in the schema
; used (directly or indirectly) to create the current plan.
;
  (let* ((episode-vars (get-episode-vars episodes))
        (new-episode-vars (mapcar (lambda (episode-var)
          (duplicate-variable plan episode-var)) episode-vars))
        (result episodes))
    (mapcar (lambda (var new-var)
      (setq result (subst new-var var result)))
      episode-vars new-episode-vars)
  result)
) ; END subst-duplicate-variables



(defun duplicate-variable (plan var) 
;`````````````````````````````````````````````
; Duplicates an episode variable, inheriting the gist-clauses,
; semantics, etc. attached to it in the schema used (directly or
; indirectly) to create the current plan.
;
  (let (new-var schema-name)
    ; Create new episode variable
    (setq new-var
      (intern (format nil "~a" (gentemp (string var)))))
    (setq schema-name (plan-schema-name plan))
    ; Inherit gist-clauses, semantics, and topic keys
    (setf (gethash new-var (get schema-name 'gist-clauses))
      (gethash var (get schema-name 'gist-clauses)))
    (setf (gethash new-var (get schema-name 'semantics))
      (gethash var (get schema-name 'semantics)))
    (setf (gethash new-var (get schema-name 'topic-keys))
      (gethash var (get schema-name 'topic-keys)))
    ; New var has same certainty and obligation as old var
    (setf (get new-var 'certainty) (get var 'certainty))
    (setf (get new-var 'obligation) (get var 'obligation))
  ; Return new var
  new-var)
) ; END duplicate-variable



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



(defun print-current-plan-steps (plan) 
;``````````````````````````````````````
; Prints each subsequent step in a plan, starting from the current
; step, showing the ep-name and wff of each. Does not include subplans.
; For debugging purposes.
;
  (let ((curr-step (plan-curr-step plan)))

    ; Iterate through each subsequent step and print ep-name and wff
    (loop while (not (null curr-step)) do
      (format t "~a ~a~%" (plan-step-ep-name curr-step) (plan-step-wff curr-step))
      (setq curr-step (plan-step-next-step curr-step))))
) ; END print-current-plan-steps



(defun print-current-plan-status (plan) 
;````````````````````````````````````````
; Prints the current plan status. Shows ep-name and wff of
; current pending step in plan, as well as the status of
; any subplans of that step. For debugging purposes.
;
  (let ((curr-plan plan) curr-step superstep subplan (cont t))

    ; Print top-level information about plan
    (format t "Status of ~a (schema ~a) "
      (plan-plan-name plan) (plan-schema-name plan))
    (setq superstep (plan-subplan-of plan))
    (if superstep
      (format t "(subplan-of ~a):~%" (plan-step-ep-name superstep))
      (format t "(no superstep):~%"))

    ; Print each current step and repeat for subplan, if any
    (loop while cont do
      (setq curr-step (plan-curr-step curr-plan))
      (when (null curr-step)
        (format t "  No more steps in ~a.~%" (plan-plan-name curr-plan))
        (format t "  --------------------~%")
        (return-from print-current-plan-status nil))
      (format t "  rest of ~a = (~a ~a ...)~%" (plan-plan-name curr-plan)
        (plan-step-ep-name curr-step) (plan-step-wff curr-step))
      (setq subplan (plan-step-subplan curr-step))
      (cond
        (subplan
          (format t "  subplan ~a of ~a:"
            (plan-plan-name subplan) (plan-step-ep-name curr-step))
          (setq curr-plan subplan))
        (t (setq cont nil)))))
) ; END print-current-plan-status



(defun print-plan-as-tree (plan)
;`````````````````````````````````````````````````
; Prints the given plan as a tree, showing the sequence of steps for each (sub)plan.
;
  (let ((indent-str "       "))
    (labels (
      (print-plan-steps-recur (plan-step direction i)
        (when (null plan-step) (return-from print-plan-steps-recur nil))
        (format t
          (if (equal direction 'curr)
            "~a>>>[~a] ~a~%"
            "~a-  [~a] ~a~%")
          (str-repeat indent-str i)
          (plan-step-ep-name plan-step)
          (plan-step-wff plan-step))
        (when (plan-step-subplan plan-step)
          (print-plan-as-tree-recur (plan-step-subplan plan-step) (+ i 1)))
        (cond
          ((equal direction 'before)
            (print-plan-steps-recur (plan-step-prev-step plan-step) 'before i))
          ((equal direction 'after)
            (print-plan-steps-recur (plan-step-next-step plan-step) 'after i))))

      (print-plan-as-tree-recur (plan i)
        (when (null plan) (return-from print-plan-steps-recur nil))
        (when (plan-curr-step plan)
          (format t "~a|- ~a~%" (str-repeat indent-str i) (plan-plan-name plan))
          (print-plan-steps-recur (plan-step-prev-step (plan-curr-step plan)) 'before i)
          (print-plan-steps-recur (plan-curr-step plan) 'curr i)
          (print-plan-steps-recur (plan-step-next-step (plan-curr-step plan)) 'after i))))
          
    (print-plan-as-tree-recur plan 0)
))) ; END print-plan-as-tree
