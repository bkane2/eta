;; *explain-understanding-of-condition*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *explain-understanding-of-condition*

'(event-schema :header (((set-of ^me ^you) explain-understanding-of-condition.v) ** ?e)
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
  ; Sophie knows that her cancer got worse
  ?p1 (^me ((pres know.v) (that (((^me 's) cancer.n) ((past got.v) worse.a)))))
  ; Sophie does not know just how bad her cancer is
  ?p2 (^me ((pres do.aux-s) not (know.v (ans-to (sub (just.mod-a (how.mod-a bad.a)) (((^me 's) cancer.n) ((pres be.v) *h)))))))
)

:goals (
  ; Sophie wants the user to know her understanding of her condition
  ?g1 (^me ((pres want.v) ^you (to (know.v ((^me 's) (n+preds understanding.n (of.p ((^me 's) condition.n))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I know that my cancer has gotten worse\, but I\'m not sure how bad it is \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *explain-understanding-of-condition*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'explain-understanding-of-condition.v '*explain-understanding-of-condition*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*explain-understanding-of-condition* 'semantics) (make-hash-table))
(setf (get '*explain-understanding-of-condition* 'gist-clauses) (make-hash-table))
(setf (get '*explain-understanding-of-condition* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*explain-understanding-of-condition*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*explain-understanding-of-condition*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*explain-understanding-of-condition*))
  '()
) ; END mapcar #'store-topic-keys
