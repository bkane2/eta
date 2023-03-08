;; *say-grandson-graduation*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; REVISION: new schema so that Sophie can reply to questions about the time that her grandson graduates.

(defparameter *say-grandson-graduation*

'(event-schema :header (((set-of ^me ^you) say-grandson-graduation.v) ** ?e)
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
  ;; Sophie has a grandson
  ?s1 (^me ((pres have.v) (k grandson.n)))
  ; Sophie has lung cancer
  ?s2 (^me ((pres have.v) (k (lung.n cancer.n))))
  

)

:preconds (
  ; Sophie knows that her grandson will graduate from middle school in 6 months.
  ; Debatable grammer here.
  ?p1 (^me ((pres know.v) (that (((^me 's) grandson) (((pres will.aux-s) graduate.v) (adv-a (adv-a (from.p (k (middle.n school.n)))) (in.p (mod-a (6.a (plur month.n))))))))))
)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(My grandson will graduate from middle school in six months \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *say-grandson-graduation*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'say-grandson-graduation.v '*say-grandson-graduation*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*say-grandson-graduation* 'semantics) (make-hash-table))
(setf (get '*say-grandson-graduation* 'gist-clauses) (make-hash-table))
(setf (get '*say-grandson-graduation* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*say-grandson-graduation*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*say-grandson-graduation*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*say-grandson-graduation*))
  '()
) ; END mapcar #'store-topic-keys
