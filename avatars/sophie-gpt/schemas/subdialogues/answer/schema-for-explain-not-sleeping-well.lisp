;; *explain-not-sleeping-well*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *explain-not-sleeping-well*

'(event-schema :header (((set-of ^me ^you) explain-not-sleeping-well.v) ** ?e)
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
  ; Sophie has pain in her chest
  ?s2 (^me ((pres have.v) (k (n+preds pain.n (in.p ((^me 's) chest.n))))))
  ; Sophie is taking Lortab for her pain
  ?s3 (^me ((pres take.v) (k |Lortab|.n) (adv-a (for.p ((^me 's) pain.n)))))
)

:preconds (
  ; Sophie has not been sleeping well
  ?p1 (^me ((pres perf) not ((prog sleep.v) well.adv-a)))
)

:goals (
  ; Sophie wants the user to know she hasn't been sleeping well
  ?g1 (^me ((pres want.v) ^you (to (know.v (tht (^me ((pres perf) not ((prog sleep.v) well.adv-a))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I have not been sleeping well \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *explain-not-sleeping-well*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'explain-not-sleeping-well.v '*explain-not-sleeping-well*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*explain-not-sleeping-well* 'semantics) (make-hash-table))
(setf (get '*explain-not-sleeping-well* 'gist-clauses) (make-hash-table))
(setf (get '*explain-not-sleeping-well* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*explain-not-sleeping-well*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*explain-not-sleeping-well*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*explain-not-sleeping-well*))
  '()
) ; END mapcar #'store-topic-keys
