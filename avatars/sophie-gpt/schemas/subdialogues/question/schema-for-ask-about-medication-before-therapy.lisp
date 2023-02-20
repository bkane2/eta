;; *ask-about-medication-before-therapy*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-medication-before-therapy*

'(event-schema :header (((set-of ^me ^you) ask-about-medication-before-therapy.v) ** ?e)
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
  ; Sophie is not currently getting chemotherapy
  ?p1 (^me ((pres prog) not currently.adv-e (get.v (k chemotherapy.n))))
)

:goals (
  ; Sophie wants to know whether she should try medication before she tries chemotherapy
  ?g1 (^me ((pres want.v) (to (know.v (whether (^me ((pres should.aux-s) (try.v (k medication.n)
        (before.ps (^me ((pres try.v) (k chemotherapy.n))))))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Should I try medication before I try therapy ?))
 
?e2 (^you reply-to.v ?e1)

)

:obligations (
  !o1 (?e1 obligates ((^you be.v explicit.a) and (^you tell.v ^me (about.p-arg ((^me 's) (plur option.n))))))
)

)) ; END defparameter *ask-about-medication-before-therapy*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-medication-before-therapy.v '*ask-about-medication-before-therapy*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-medication-before-therapy* 'semantics) (make-hash-table))
(setf (get '*ask-about-medication-before-therapy* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-medication-before-therapy* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-medication-before-therapy*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-medication-before-therapy*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-medication-before-therapy*))
  '()
) ; END mapcar #'store-topic-keys
