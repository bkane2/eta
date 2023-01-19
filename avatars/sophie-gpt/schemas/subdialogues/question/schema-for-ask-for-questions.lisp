;; *ask-for-questions*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-for-questions*

'(event-schema :header (((set-of ^me ^you) ask-for-questions.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to know what questions the user has
  ?g1 (^me ((pres want.v) (to (know.v (ans-to (sub (what.d (plur question.n)) (^you ((pres have.v) *h))))))))
)

:preconds (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(What are your questions ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *ask-for-questions*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-for-questions.v '*ask-for-questions*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-for-questions* 'semantics) (make-hash-table))
(setf (get '*ask-for-questions* 'gist-clauses) (make-hash-table))
(setf (get '*ask-for-questions* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-for-questions*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-for-questions*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-for-questions*))
  '()
) ; END mapcar #'store-topic-keys
