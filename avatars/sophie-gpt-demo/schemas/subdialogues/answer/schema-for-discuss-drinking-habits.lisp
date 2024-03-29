;; *discuss-drinking-habits*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *discuss-drinking-habits*

'(event-schema :header (((set-of ^me ^you) discuss-drinking-habits.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:types (
  !t1 (^me person.n)
  !t2 (^you person.n)
)

:rigid-conds (
  ; Sophie is a woman
  !r1 (^me ((pres be.v) (= (a.d woman.n))))
  ; Sophie is 65 years old
  !r2 (^me ((pres be.v) ((mod-a (65.a (plur year.n))) old.a)))
)

:static-conds (
  ; Sophie has lung cancer
  ?s1 (^me ((pres have.v) (k (lung.n cancer.n))))
)

:preconds (
  ; Sophie had a history of alcohol abuse
  ?p1 (^me ((past have.v) (a.d (n+preds history.n (of.p (alcohol.n abuse.n))))))
  ; Sophie does not drink now
  ?p2 (^me ((pres do.aux-s) not (drink.v now.adv-e)))
)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I have a history of alcohol abuse but do not drink now \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *discuss-drinking-habits*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'discuss-drinking-habits.v '*discuss-drinking-habits*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*discuss-drinking-habits* 'semantics) (make-hash-table))
(setf (get '*discuss-drinking-habits* 'gist-clauses) (make-hash-table))
(setf (get '*discuss-drinking-habits* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*discuss-drinking-habits*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*discuss-drinking-habits*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*discuss-drinking-habits*))
  '()
) ; END mapcar #'store-topic-keys
