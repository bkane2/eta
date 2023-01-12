;; *explain-here-alone*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *explain-here-alone*

'(event-schema :header (((set-of ^me ^you) explain-here-alone.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
)

:preconds (
  ; Sophie is here alone
  ?p1 (^me ((pres be.v) here.adv-e alone.adv-a))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I am here alone \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *explain-here-alone*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'explain-here-alone.v '*explain-here-alone*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*explain-here-alone* 'semantics) (make-hash-table))
(setf (get '*explain-here-alone* 'gist-clauses) (make-hash-table))
(setf (get '*explain-here-alone* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*explain-here-alone*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*explain-here-alone*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*explain-here-alone*))
  '()
) ; END mapcar #'store-topic-keys
