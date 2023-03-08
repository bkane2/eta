;; *mention-taking-lortab*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *mention-taking-lortab*

'(event-schema :header (((set-of ^me ^you) mention-taking-lortab.v) ** ?e)
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
  ; Sophie is only taking Lortab to treat her pain
  ?p1 (^me ((pres prog) (take.v only.adv-s |Lortab| (adv-a ({for}.p (to (treat.v ((^me 's) pain.n))))))))
)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I am only taking Lortab to treat my pain \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *mention-taking-lortab*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'mention-taking-lortab.v '*mention-taking-lortab*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*mention-taking-lortab* 'semantics) (make-hash-table))
(setf (get '*mention-taking-lortab* 'gist-clauses) (make-hash-table))
(setf (get '*mention-taking-lortab* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*mention-taking-lortab*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*mention-taking-lortab*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*mention-taking-lortab*))
  '()
) ; END mapcar #'store-topic-keys
