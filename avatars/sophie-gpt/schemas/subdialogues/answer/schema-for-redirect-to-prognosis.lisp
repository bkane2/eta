;; *redirect-to-prognosis*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *redirect-to-prognosis*

'(event-schema :header (((set-of ^me ^you) redirect-to-prognosis.v) ** ?e)
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
  ; The user is not currently talking about Sophie's prognosis
  ?p1 (^you ((pres prog) not currently.adv-e (talk.v (adv-a (about.p ((^me 's) prognosis.n))))))
)

:goals (
  ; Sophie wants to talk about her prognosis
  ?g1 (^me ((pres want.v) (to (talk.v (adv-a (about.p ((^me 's) prognosis.n)))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I want to talk about my prognosis today \.))
 
?e2 (^you reply-to.v ?e1)

)

:obligations (
  !o1 (?e1 obligates ((^you be.v explicit.a) and (^you tell.v ^me (about.p-arg ((^me 's) prognosis.n)))))
)

)) ; END defparameter *redirect-to-prognosis*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'redirect-to-prognosis.v '*redirect-to-prognosis*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*redirect-to-prognosis* 'semantics) (make-hash-table))
(setf (get '*redirect-to-prognosis* 'gist-clauses) (make-hash-table))
(setf (get '*redirect-to-prognosis* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*redirect-to-prognosis*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*redirect-to-prognosis*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*redirect-to-prognosis*))
  '()
) ; END mapcar #'store-topic-keys
