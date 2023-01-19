;; *mention-blood-medication*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *mention-blood-medication*

'(event-schema :header (((set-of ^me ^you) mention-blood-medication.v) ** ?e)
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
  ; Sophie is taking Cozar to help with blood pressure
  ?p1 (^me ((pres prog) (take.v |Cozar| ({for}.p (to (help.v (with.p-arg (k (blood.n pressure.n)))))))))
)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I am taking Cozar to help with blood pressure \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *mention-blood-medication*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'mention-blood-medication.v '*mention-blood-medication*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*mention-blood-medication* 'semantics) (make-hash-table))
(setf (get '*mention-blood-medication* 'gist-clauses) (make-hash-table))
(setf (get '*mention-blood-medication* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*mention-blood-medication*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*mention-blood-medication*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*mention-blood-medication*))
  '()
) ; END mapcar #'store-topic-keys
