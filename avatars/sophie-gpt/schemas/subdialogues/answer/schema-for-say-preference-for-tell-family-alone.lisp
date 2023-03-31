;; *say-preference-for-tell-family-alone*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-preference-for-tell-family-alone*

'(event-schema :header (((set-of ^me ^you) say-preference-for-tell-family-alone.v) ** ?e)
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
)

:goals (
  ; Sophie wants to tell her family about the prognosis alone
  ?g1 (^me ((pres want.v) (to (tell.v ((^me 's) family.n) (about.p-arg ((^me 's) prognosis.n)) alone.adv))))
  
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I believe it would be easier for me to tell my family about the prognosis on my own \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *say-preference-for-tell-family-alone*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'say-preference-for-tell-family-alone.v '*say-preference-for-tell-family-alone*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*say-preference-for-tell-family-alone* 'semantics) (make-hash-table))
(setf (get '*say-preference-for-tell-family-alone* 'gist-clauses) (make-hash-table))
(setf (get '*say-preference-for-tell-family-alone* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*say-preference-for-tell-family-alone*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*say-preference-for-tell-family-alone*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*say-preference-for-tell-family-alone*))
  '()
) ; END mapcar #'store-topic-keys
