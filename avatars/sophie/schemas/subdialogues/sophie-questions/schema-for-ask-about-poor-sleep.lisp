;; *ask-about-poor-sleep*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-poor-sleep*

'(event-schema :header (((set-of ^me ^you) ask-about-poor-sleep.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:episodes (

?e0 (^me say-to.v ^you '(test \.))
?e1 (^me paraphrase-to.v ^you '(Why have I not been sleeping well ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-about-poor-sleep*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-poor-sleep.v '*ask-about-poor-sleep*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-poor-sleep* 'semantics) (make-hash-table))
(setf (get '*ask-about-poor-sleep* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-poor-sleep* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-poor-sleep*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-poor-sleep*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-poor-sleep*))
  '()
) ; END mapcar #'store-topic-keys
