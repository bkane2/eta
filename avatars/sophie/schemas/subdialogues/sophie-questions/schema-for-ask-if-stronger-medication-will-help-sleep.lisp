;; *ask-if-stronger-medication-will-help-sleep*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-if-stronger-medication-will-help-sleep*

'(event-schema :header (((set-of ^me ^you) ask-if-stronger-medication-will-help-sleep.v) ** ?e)
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

?e1 (^me paraphrase-to.v ^you '(Will stronger pain medication help me sleep ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-if-stronger-medication-will-help-sleep*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-if-stronger-medication-will-help-sleep.v '*ask-if-stronger-medication-will-help-sleep*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-if-stronger-medication-will-help-sleep* 'semantics) (make-hash-table))
(setf (get '*ask-if-stronger-medication-will-help-sleep* 'gist-clauses) (make-hash-table))
(setf (get '*ask-if-stronger-medication-will-help-sleep* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-if-stronger-medication-will-help-sleep*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-if-stronger-medication-will-help-sleep*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-if-stronger-medication-will-help-sleep*))
  '()
) ; END mapcar #'store-topic-keys
