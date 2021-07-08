;; *ask-if-can-outlive-prognosis-health-now*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-if-can-outlive-prognosis-health-now*

'(event-schema :header (((set-of ^me ^you) ask-if-can-outlive-prognosis-health-now.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````


:goals (
  ?g1 (^me want.v (that (^me know.v (ans-to '(Can I outlive your prognosis if I am healthy now ?)))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Can I outlive your prognosis if I am healthy now ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-if-can-outlive-prognosis-health-now*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-if-can-outlive-prognosis-health-now.v '*ask-if-can-outlive-prognosis-health-now*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-if-can-outlive-prognosis-health-now* 'semantics) (make-hash-table))
(setf (get '*ask-if-can-outlive-prognosis-health-now* 'gist-clauses) (make-hash-table))
(setf (get '*ask-if-can-outlive-prognosis-health-now* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-if-can-outlive-prognosis-health-now*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-if-can-outlive-prognosis-health-now*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-if-can-outlive-prognosis-health-now*))
  '()
) ; END mapcar #'store-topic-keys
