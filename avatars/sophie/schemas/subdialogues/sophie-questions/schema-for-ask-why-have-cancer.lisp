;; *ask-why-have-cancer*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-why-have-cancer*

'(event-schema :header (((set-of ^me ^you) ask-why-have-cancer.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ?g1 (^me want.v (that (^me know.v (ans-to '(Why do I have cancer ?)))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Why do I have cancer ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-why-have-cancer*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-why-have-cancer.v '*ask-why-have-cancer*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-why-have-cancer* 'semantics) (make-hash-table))
(setf (get '*ask-why-have-cancer* 'gist-clauses) (make-hash-table))
(setf (get '*ask-why-have-cancer* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-why-have-cancer*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-why-have-cancer*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-why-have-cancer*))
  '()
) ; END mapcar #'store-topic-keys
