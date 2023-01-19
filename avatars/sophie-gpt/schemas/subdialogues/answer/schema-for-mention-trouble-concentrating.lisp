;; *mention-trouble-concentrating*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *mention-trouble-concentrating*

'(event-schema :header (((set-of ^me ^you) mention-trouble-concentrating.v) ** ?e)
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
  ; Sophie has trouble concentrating
  ?p1 (^me ((pres have.v) trouble.a ({with}.p-arg (ka concentrate.v))))
)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I have had trouble concentrating \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *mention-trouble-concentrating*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'mention-trouble-concentrating.v '*mention-trouble-concentrating*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*mention-trouble-concentrating* 'semantics) (make-hash-table))
(setf (get '*mention-trouble-concentrating* 'gist-clauses) (make-hash-table))
(setf (get '*mention-trouble-concentrating* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*mention-trouble-concentrating*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*mention-trouble-concentrating*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*mention-trouble-concentrating*))
  '()
) ; END mapcar #'store-topic-keys
