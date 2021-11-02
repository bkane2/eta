;; *mention-blood-medication*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *mention-blood-medication*

'(event-schema :header (((set-of ^me ^you) mention-blood-medication.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:episodes (

?e1 (^me paraphrase-to.v ^you '(I am taking Cozar to help with blood pressure \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *mention-blood-medication*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'mention-blood-medication.v '*mention-blood-medication*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*mention-blood-medication* 'semantics) (make-hash-table))
(setf (get '*mention-blood-medication* 'gist-clauses) (make-hash-table))
(setf (get '*mention-blood-medication* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*mention-blood-medication*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*mention-blood-medication*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*mention-blood-medication*))
  '()
) ; END mapcar #'store-topic-keys
