;; *explain-family-understanding-of-prognosis*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *explain-family-understanding-of-prognosis*

'(event-schema :header (((set-of ^me ^you) explain-family-understanding-of-prognosis.v) ** ?e)
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
  ; Sophie accepts her prognosis.
  ?p1 (^me ((pres do.aux-v) (accept.v ((^me 's) prognosis.n))))
  ; Sophie hasn't told her family about her prognosis yet
  ?p2 (^me ((pres perf) not (tell.v ((^me 's) family.n) (about.p-arg ((^me 's) prognosis.n)) yet.adv-e)))
  ; Sophie has told her family about her cancer.
  ?p2 (^me ((pres perf) (tell.v ((^me 's) family.n) (about.p-arg ((^me 's) cancer.n)))))
  
)

:goals (
  ; Sophie wants the user to know her family's understanding of her condition
  ?g1 (^me ((pres want.v) ^you (to (know.v ((^me 's) family.n 's) (n+preds understanding.n (of.p ((^me 's) condition.n)))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(My family knows that I have lung cancer\, but they have no idea about my prognosis \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *explain-family-understanding-of-prognosis*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'explain-family-understanding-of-prognosis.v '*explain-family-understanding-of-prognosis*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*explain-family-understanding-of-prognosis* 'semantics) (make-hash-table))
(setf (get '*explain-family-understanding-of-prognosis* 'gist-clauses) (make-hash-table))
(setf (get '*explain-family-understanding-of-prognosis* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*explain-family-understanding-of-prognosis*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*explain-family-understanding-of-prognosis*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*explain-family-understanding-of-prognosis*))
  '()
) ; END mapcar #'store-topic-keys
