;; *ask-about-narcotic-addiction*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-narcotic-addiction*

'(event-schema :header (((set-of ^me ^you) ask-about-narcotic-addiction.v) ** ?e)
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
  ; Sophie wants to know whether she can get addicted to narcotics
  ?g1 (^me ((pres want.v) (to (know.v (whether
        (^me ((pres can.aux-s) (get.v (addicted.a (to.p-arg (k (plur narcotic.n))))))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Can I get addicted to narcotics ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *ask-about-narcotic-addiction*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-narcotic-addiction.v '*ask-about-narcotic-addiction*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-narcotic-addiction* 'semantics) (make-hash-table))
(setf (get '*ask-about-narcotic-addiction* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-narcotic-addiction* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-narcotic-addiction*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-narcotic-addiction*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-narcotic-addiction*))
  '()
) ; END mapcar #'store-topic-keys
