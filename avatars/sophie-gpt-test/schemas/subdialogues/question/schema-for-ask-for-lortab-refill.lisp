;; *ask-for-lortab-refill*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-for-lortab-refill*

'(event-schema :header (((set-of ^me ^you) ask-for-lortab-refill.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants a refill of her Lortab
  ?g1 (^me ((pres want.v) (a.d (n+preds refill.n (of.p ((^me 's) |Lortab|.n))))))
)

:preconds (
  ; Sophie is out of her Lortab
  ?p1 (^me ((pres be.v) (out.a (of.p-arg ((^me 's) |Lortab|.n)))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I would like a refill of medicine \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-for-lortab-refill*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-for-lortab-refill.v '*ask-for-lortab-refill*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-for-lortab-refill* 'semantics) (make-hash-table))
(setf (get '*ask-for-lortab-refill* 'gist-clauses) (make-hash-table))
(setf (get '*ask-for-lortab-refill* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-for-lortab-refill*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-for-lortab-refill*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-for-lortab-refill*))
  '()
) ; END mapcar #'store-topic-keys
