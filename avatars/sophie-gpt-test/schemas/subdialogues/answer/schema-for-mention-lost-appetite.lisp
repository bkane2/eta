;; *mention-lost-appetite*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *mention-lost-appetite*

'(event-schema :header (((set-of ^me ^you) mention-lost-appetite.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
)

:preconds (
  ; Sophie has lost her appetite
  ?p1 (^me ((pres perf) (lose.v ((^me 's) appetite.n))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I have lost my appetite \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *mention-lost-appetite*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'mention-lost-appetite.v '*mention-lost-appetite*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*mention-lost-appetite* 'semantics) (make-hash-table))
(setf (get '*mention-lost-appetite* 'gist-clauses) (make-hash-table))
(setf (get '*mention-lost-appetite* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*mention-lost-appetite*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*mention-lost-appetite*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*mention-lost-appetite*))
  '()
) ; END mapcar #'store-topic-keys
