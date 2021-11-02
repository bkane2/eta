;; *ask-if-can-trust-prognosis*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-if-can-trust-prognosis*

'(event-schema :header (((set-of ^me ^you) ask-if-can-trust-prognosis.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````


:goals (
  ?g1 (^me want.v (that (^me know.v (ans-to '(Can I trust your prognosis ?)))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Can I trust your prognosis ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-if-can-trust-prognosis*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-if-can-trust-prognosis.v '*ask-if-can-trust-prognosis*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-if-can-trust-prognosis* 'semantics) (make-hash-table))
(setf (get '*ask-if-can-trust-prognosis* 'gist-clauses) (make-hash-table))
(setf (get '*ask-if-can-trust-prognosis* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-if-can-trust-prognosis*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-if-can-trust-prognosis*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-if-can-trust-prognosis*))
  '()
) ; END mapcar #'store-topic-keys
