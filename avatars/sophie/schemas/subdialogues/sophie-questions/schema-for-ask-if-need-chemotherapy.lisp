;; *ask-if-need-chemotherapy*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-if-need-chemotherapy*

'(event-schema :header (((set-of ^me ^you) ask-if-need-chemotherapy.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ?g1 (^me want.v (that (^me know.v (ans-to '(Do I need chemotherapy ?)))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Do I need chemotherapy ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-if-need-chemotherapy*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-if-need-chemotherapy.v '*ask-if-need-chemotherapy*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-if-need-chemotherapy* 'semantics) (make-hash-table))
(setf (get '*ask-if-need-chemotherapy* 'gist-clauses) (make-hash-table))
(setf (get '*ask-if-need-chemotherapy* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-if-need-chemotherapy*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-if-need-chemotherapy*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-if-need-chemotherapy*))
  '()
) ; END mapcar #'store-topic-keys
