;; *deny-symptom*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *deny-symptom*

'(event-schema :header (((set-of ^me ^you) deny-symptom.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:episodes (

?e1 (^me paraphrase-to.v ^you '(I do not have the symptom you mentioned \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *deny-symptom*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'deny-symptom.v '*deny-symptom*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*deny-symptom* 'semantics) (make-hash-table))
(setf (get '*deny-symptom* 'gist-clauses) (make-hash-table))
(setf (get '*deny-symptom* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*deny-symptom*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*deny-symptom*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*deny-symptom*))
  '()
) ; END mapcar #'store-topic-keys
