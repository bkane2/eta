;; *ask-for-clarification*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-for-clarification*

'(event-schema :header (((set-of ^me ^you) ask-for-clarification.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:types (
  !t1 (^me person.n)
  !t2 (^you person.n)
)

:rigid-conds (
  ; Sophie is a woman
  !r1 (^me ((pres be.v) (= (a.d woman.n))))
  ; Sophie is 65 years old
  !r2 (^me ((pres be.v) ((mod-a (65.a (plur year.n))) old.a)))
)

:static-conds (
  ; Sophie has lung cancer
  ?s1 (^me ((pres have.v) (k (lung.n cancer.n))))
)

:preconds (
  ; Sophie did not understand the user's question
  ?p1 (^me ((past do.aux-s) not (understand.v ((^you 's) question.n))))
)

:goals (
  ; Sophie wants the user to rephrase their question
  ?g1 (^me ((pres want.v) ^you (to (rephrase.v ((^you 's) question.n)))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Can you rephrase your question ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *ask-for-clarification*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-for-clarification.v '*ask-for-clarification*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-for-clarification* 'semantics) (make-hash-table))
(setf (get '*ask-for-clarification* 'gist-clauses) (make-hash-table))
(setf (get '*ask-for-clarification* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-for-clarification*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-for-clarification*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-for-clarification*))
  '()
) ; END mapcar #'store-topic-keys
