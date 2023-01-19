;; *ask-about-chemotherapy-side-effects*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-chemotherapy-side-effects*

'(event-schema :header (((set-of ^me ^you) ask-about-chemotherapy-side-effects.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to know the side effects of chemotherapy
  ?g1 (^me ((pres want.v) (to (know.v
        (the.d (n+preds (side.a (plur effect.n)) (of.p (k (chemotherapy.n)))))))))
)

:preconds (
  ; Sophie does not know the side effects of chemotherapy
  ?p1 (^me ((pres do.aux-s) not (know.v
        (the.d (n+preds (side.a (plur effect.n)) (of.p (k (chemotherapy.n))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(What are the side effects of chemotherapy ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *ask-about-chemotherapy-side-effects*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-chemotherapy-side-effects.v '*ask-about-chemotherapy-side-effects*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-chemotherapy-side-effects* 'semantics) (make-hash-table))
(setf (get '*ask-about-chemotherapy-side-effects* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-chemotherapy-side-effects* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-chemotherapy-side-effects*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-chemotherapy-side-effects*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-chemotherapy-side-effects*))
  '()
) ; END mapcar #'store-topic-keys
