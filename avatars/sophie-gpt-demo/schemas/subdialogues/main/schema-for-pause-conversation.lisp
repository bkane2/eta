;; *pause-conversation*: development version 6
;;
;; Dialogue for blocks world conversation 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *pause-conversation*

'(event-schema :header (((set-of ^me ^you) pause-conversation.v) ** ?e)
;````````````````````````````````````````````````````````````````````````
; The user and the agent suspend dialogue until the user says something
; interpreted as a resumption request.
;


:episodes (

  ; Eta "pauses" by repeatedly listening to the user say something, and ignoring it
  ; unless it is interpreted as a resumption request, in which case the loop is broken.
  ?e13 (:repeat-until (?e13 finished2.a)

    ; User says something which is ignored unless it is a special request.
    ?e15 (^you say-to.v ^me ?words)

    ; If user makes 'continue' special request, store the fact that ?e13 is finished.
    ?e16 (:if (^you paraphrase-to.v ^me '(Continue \.))
      ?e17 (^me commit-to-STM.v (that (?e13 finished2.a)))
      ?e18 (^me say-to.v ^you '(Okay\, I\'ll continue from here \.))))
)

)) ; END defparameter *pause-conversation*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'pause-conversation.v '*pause-conversation*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*pause-conversation* 'semantics) (make-hash-table))
(setf (get '*pause-conversation* 'gist-clauses) (make-hash-table))
(setf (get '*pause-conversation* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*pause-conversation*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*pause-conversation*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*pause-conversation*))
  '()
) ; END mapcar #'store-topic-keys
