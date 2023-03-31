;; *say-preference-for-informal-language*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-preference-for-informal-language*

'(event-schema :header (((set-of ^me ^you) say-preference-for-informal-language.v) ** ?e)
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

)

:goals (
  ; Sophie wants to tell her family about the prognosis alone
  ?g1 (^me ((pres want.v) (to (tell.v ((^me 's) family.n) (about.p-arg ((^me 's) prognosis.n)) alone.adv))))

  ; Sophie wants the doctor to not speak with technical language.
  ?g2 (^me ((pres want.v) (^you (not (to (speak.v (to.p me.n) ({with}.p-args (technical.a language.n))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I prefer that you not speak to me with technical language \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *say-preference-for-informal-language*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'say-preference-for-informal-language.v '*say-preference-for-informal-language*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*say-preference-for-informal-language* 'semantics) (make-hash-table))
(setf (get '*say-preference-for-informal-language* 'gist-clauses) (make-hash-table))
(setf (get '*say-preference-for-informal-language* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*say-preference-for-informal-language*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*say-preference-for-informal-language*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*say-preference-for-informal-language*))
  '()
) ; END mapcar #'store-topic-keys
