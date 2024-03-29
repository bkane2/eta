;; *ask-how-chemotherapy-works*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-how-chemotherapy-works*

'(event-schema :header (((set-of ^me ^you) ask-how-chemotherapy-works.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ?g1 (^me want.v (that (^me know.v (ans-to '(How does chemotherapy work ?)))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(How does chemotherapy work ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-how-chemotherapy-works*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-how-chemotherapy-works.v '*ask-how-chemotherapy-works*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-how-chemotherapy-works* 'semantics) (make-hash-table))
(setf (get '*ask-how-chemotherapy-works* 'gist-clauses) (make-hash-table))
(setf (get '*ask-how-chemotherapy-works* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-how-chemotherapy-works*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-how-chemotherapy-works*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-how-chemotherapy-works*))
  '()
) ; END mapcar #'store-topic-keys
