;; *ask-how-long-to-know-pain-medication-working*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-how-long-to-know-pain-medication-working*

'(event-schema :header (((set-of ^me ^you) ask-how-long-to-know-pain-medication-working.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:episodes (

?e1 (^me paraphrase-to.v ^you '(How will I know if my pain medication is working ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-how-long-to-know-pain-medication-working*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-how-long-to-know-pain-medication-working.v '*ask-how-long-to-know-pain-medication-working*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-how-long-to-know-pain-medication-working* 'semantics) (make-hash-table))
(setf (get '*ask-how-long-to-know-pain-medication-working* 'gist-clauses) (make-hash-table))
(setf (get '*ask-how-long-to-know-pain-medication-working* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-how-long-to-know-pain-medication-working*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-how-long-to-know-pain-medication-working*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-how-long-to-know-pain-medication-working*))
  '()
) ; END mapcar #'store-topic-keys
