;; *ETA-SCHEMA*: development version 6
;;
;; TODO
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *eta-schema*

'(event-schema :header (((set-of ^me ^you) have-eta-dialog.v) ** ?e)
;`````````````````````````````````````````````````````````````````````
; An Eta dialogue where a "suggester" listens to patient-doctor utterance,
; and provides feedback/suggestions to the doctor.
;

:episodes (

  ; Repeat prompting the user for a spatial question until finished.
  ?e1 (:repeat-until (?e1 finished2.a)

    ; Prompt the user for a spatial question.
    ?e2 (^you say-to.v ^me ?input)

    ; Either (3a) user requests goodbye, (3b) user gives some other input.
    ?e3 (:try-in-sequence

      ; (3a)
      (:if (^you say-bye.v)

        ; Store the fact that ?e1 is finished.
        ?e4 (^me commit-to-STM.v (that (?e1 finished2.a))))

      ; (3b)
      (:else

        ; Provide suggestion based on the input.
        ?e5 (^me react-to.v ?e2))))
)

)) ; END defparameter *eta-schema*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'have-eta-dialog.v '*eta-schema*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*eta-schema* 'semantics) (make-hash-table))
(setf (get '*eta-schema* 'gist-clauses) (make-hash-table))
(setf (get '*eta-schema* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*eta-schema*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*eta-schema*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*eta-schema*))
  '(
  )
) ; END mapcar #'store-topic-keys
