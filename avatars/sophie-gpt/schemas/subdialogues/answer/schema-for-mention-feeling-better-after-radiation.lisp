;; *mention-feeling-better-after-radiation*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *mention-feeling-better-after-radiation*

'(event-schema :header (((set-of ^me ^you) mention-feeling-better-after-radiation.v) ** ?e)
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
  ; Sophie was feeling a little better after radiation
  ?p1 (^me ((past prog) (feel.v (a_little.mod-a better.a) (adv-e (after.p (k radiation.n))))))
)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I was feeling a little better after radiation \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *mention-feeling-better-after-radiation*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'mention-feeling-better-after-radiation.v '*mention-feeling-better-after-radiation*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*mention-feeling-better-after-radiation* 'semantics) (make-hash-table))
(setf (get '*mention-feeling-better-after-radiation* 'gist-clauses) (make-hash-table))
(setf (get '*mention-feeling-better-after-radiation* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*mention-feeling-better-after-radiation*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*mention-feeling-better-after-radiation*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*mention-feeling-better-after-radiation*))
  '()
) ; END mapcar #'store-topic-keys
