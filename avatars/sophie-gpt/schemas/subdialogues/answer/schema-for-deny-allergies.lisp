;; *deny-allergies*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *deny-allergies*

'(event-schema :header (((set-of ^me ^you) deny-allergies.v) ** ?e)
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
  ; Sophie is not allergic to any medicine
  ?p1 (^me ((pres be.v) not allergic.a (to.p-arg (any.d medicine.n))))
)

:goals (
  ; The user wants to know whether Sophie is allergic to any medicine
  ?g1 (^you ((pres want.v) (to (know.v (whether (^me ((pres be.v) allergic.a (to.p-arg (any.d medicine.n)))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I don\'t have allergies to any medicine \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *deny-allergies*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'deny-allergies.v '*deny-allergies*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*deny-allergies* 'semantics) (make-hash-table))
(setf (get '*deny-allergies* 'gist-clauses) (make-hash-table))
(setf (get '*deny-allergies* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*deny-allergies*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*deny-allergies*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*deny-allergies*))
  '()
) ; END mapcar #'store-topic-keys
