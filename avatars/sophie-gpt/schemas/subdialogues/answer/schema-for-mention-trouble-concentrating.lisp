;; *mention-trouble-concentrating*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *mention-trouble-concentrating*

'(event-schema :header (((set-of ^me ^you) mention-trouble-concentrating.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
)

:preconds (
  ; Sophie has trouble concentrating
  ?p1 (^me ((pres have.v) trouble.a ({with}.p-arg (ka concentrate.v))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I have had trouble concentrating \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

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
