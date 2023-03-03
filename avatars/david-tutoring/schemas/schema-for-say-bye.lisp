;; *say-bye*: development version 6
;;
;; Dialogue for blocks world conversation 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-bye*

'(event-schema :header (((set-of ^me ^you) say-bye.v) ** ?e)
;````````````````````````````````````````````````````````````````````````
; The user and the agent quit conversation.
;


:episodes (

  ; David "pauses" by repeatedly listening to the user say something, and ignoring it
  ; unless it is interpreted as a resumption request, in which case the loop is broken.
  ?e1 (^me say-to.v ^you '(Oh \, thank you for participating \. Good bye for now \!))
  ?e2 (^me say-bye-to.v ^you)
)

)) ; END defparameter *say-bye*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'say-bye.v '*say-bye*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*say-bye* 'semantics) (make-hash-table))
(setf (get '*say-bye* 'gist-clauses) (make-hash-table))
(setf (get '*say-bye* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*say-bye*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*say-bye*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*say-bye*))
  '()
) ; END mapcar #'store-topic-keys
