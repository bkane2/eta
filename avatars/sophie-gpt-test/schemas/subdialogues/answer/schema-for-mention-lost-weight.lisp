;; *mention-lost-weight*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *mention-lost-weight*

'(event-schema :header (((set-of ^me ^you) mention-lost-weight.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
)

:preconds (
  ; Sophie has lost weight
  ?p1 (^me ((pres perf) (lose.v (k weight.n))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I have lost weight \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *mention-lost-weight*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'mention-lost-weight.v '*mention-lost-weight*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*mention-lost-weight* 'semantics) (make-hash-table))
(setf (get '*mention-lost-weight* 'gist-clauses) (make-hash-table))
(setf (get '*mention-lost-weight* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*mention-lost-weight*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*mention-lost-weight*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*mention-lost-weight*))
  '()
) ; END mapcar #'store-topic-keys
