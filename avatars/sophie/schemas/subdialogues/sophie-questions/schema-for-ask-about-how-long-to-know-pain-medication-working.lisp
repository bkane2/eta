;; *ask-how-long-to-know-pain-medication-working*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-how-long-to-know-pain-medication-working*

'(event-schema :header (((set-of ^me ^you) ask-how-long-to-know-pain-medication-working.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

; TODO: although inquiring about a stronger pain medication might be the ultimate goal of the agent
; pursuing this line of questioning, it isn't the immediate goal, and so shouldn't be the immediate
; goal of this schema. However, this is currently necessary (until Eta is modified to support multiple
; inferences from the same gist clause) to prevent the agent from asking this question in the case where
; the agent already has "stronger" knowledge that they're being prescribed a stronger pain medication.
:goals (
  ?g1 (^me want.v (that (^me know.v (ans-to '(Can I have a stronger pain medication ?)))))
)

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
