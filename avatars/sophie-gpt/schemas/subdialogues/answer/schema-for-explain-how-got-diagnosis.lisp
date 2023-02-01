;; *explain-how-got-diagnosis*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *explain-how-got-diagnosis*

'(event-schema :header (((set-of ^me ^you) explain-how-got-diagnosis.v) ** ?e)
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
  ; Sophie got her diagnosis after visiting a lung doctor
  ?p1 (^me ((past got.v) ((^me 's) diagnosis.n) (after.ps (^me ((past visit.v) (a.d (lung.n doctor.n)))))))
)

:goals (
  ; Sophie wants the user to know how she got her diagnosis
  ?g1 (^me ((pres want.v) ^you (to (know.v (ans-to (sub how.pq (^me ((past got.v) ((^me 's) diagnosis.n) *h))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I got my diagnosis after visiting a lung doctor \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *explain-how-got-diagnosis*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'explain-how-got-diagnosis.v '*explain-how-got-diagnosis*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*explain-how-got-diagnosis* 'semantics) (make-hash-table))
(setf (get '*explain-how-got-diagnosis* 'gist-clauses) (make-hash-table))
(setf (get '*explain-how-got-diagnosis* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*explain-how-got-diagnosis*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*explain-how-got-diagnosis*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*explain-how-got-diagnosis*))
  '()
) ; END mapcar #'store-topic-keys
