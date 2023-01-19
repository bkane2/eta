;; *ask-about-pain-medication-side-effects*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-pain-medication-side-effects*

'(event-schema :header (((set-of ^me ^you) ask-about-pain-medication-side-effects.v) ** ?e)
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
  ; Sophie does not know the side effects of stronger pain medication
  ?p1 (^me ((pres do.aux-s) not (know.v
        (the.d (n+preds (side.a (plur effect.n)) (of.p (k (stronger.a (pain.n medication.n)))))))))
)

:goals (
  ; Sophie wants to know the side effects of stronger pain medication
  ?g1 (^me ((pres want.v) (to (know.v
        (the.d (n+preds (side.a (plur effect.n)) (of.p (k (stronger.a (pain.n medication.n))))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(What are the side effects of stronger pain medication ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *ask-about-pain-medication-side-effects*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-pain-medication-side-effects.v '*ask-about-pain-medication-side-effects*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-pain-medication-side-effects* 'semantics) (make-hash-table))
(setf (get '*ask-about-pain-medication-side-effects* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-pain-medication-side-effects* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-pain-medication-side-effects*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-pain-medication-side-effects*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-pain-medication-side-effects*))
  '()
) ; END mapcar #'store-topic-keys
