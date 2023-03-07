;; *say-bye*: development version 6
;;
;; Dialogue for blocks world conversation 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(store-schema 'say-bye.v

'(event-schema :header (((set-of ^me ^you) say-bye.v) ** ?e)
;````````````````````````````````````````````````````````````````````````
; The user and the agent quit conversation.
;

:episodes (

  ; David "pauses" by repeatedly listening to the user say something, and ignoring it
  ; unless it is interpreted as a resumption request, in which case the loop is broken.
  ?e1 (^me say-to.v ^you '(Oh \, thank you for the questions \. Good bye for now \!))
  ?e2 (^me say-bye-to.v ^you)
)

)) ; END say-bye.v