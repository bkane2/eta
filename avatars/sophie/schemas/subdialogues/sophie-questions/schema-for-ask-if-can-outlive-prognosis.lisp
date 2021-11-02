;; *ask-if-can-outlive-prognosis*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-if-can-outlive-prognosis*

'(event-schema :header (((set-of ^me ^you) ask-if-can-outlive-prognosis.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````


:goals (
  ?g1 (^me want.v (that (^me know.v (ans-to '(Can I outlive your prognosis ?)))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Can I outlive your prognosis ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-if-can-outlive-prognosis*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-if-can-outlive-prognosis.v '*ask-if-can-outlive-prognosis*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-if-can-outlive-prognosis* 'semantics) (make-hash-table))
(setf (get '*ask-if-can-outlive-prognosis* 'gist-clauses) (make-hash-table))
(setf (get '*ask-if-can-outlive-prognosis* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-if-can-outlive-prognosis*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-if-can-outlive-prognosis*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-if-can-outlive-prognosis*))
  '()
) ; END mapcar #'store-topic-keys
