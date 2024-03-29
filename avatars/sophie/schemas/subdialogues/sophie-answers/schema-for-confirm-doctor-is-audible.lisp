;; *confirm-doctor-is-audible*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *confirm-doctor-is-audible*

'(event-schema :header (((set-of ^me ^you) confirm-doctor-is-audible.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:episodes (

?e1 (^me paraphrase-to.v ^you '(I can hear you \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *confirm-doctor-is-audible*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'confirm-doctor-is-audible.v '*confirm-doctor-is-audible*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*confirm-doctor-is-audible* 'semantics) (make-hash-table))
(setf (get '*confirm-doctor-is-audible* 'gist-clauses) (make-hash-table))
(setf (get '*confirm-doctor-is-audible* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*confirm-doctor-is-audible*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*confirm-doctor-is-audible*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*confirm-doctor-is-audible*))
  '()
) ; END mapcar #'store-topic-keys
