;; *acknowledge-empathy*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *acknowledge-empathy*

'(event-schema :header (((set-of ^me ^you) acknowledge-empathy.v) ** ?e)
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
  ; Sophie's cancer has spread
  ?s2 (((^me 's) cancer.n) ((pres perf) spread.v))
  ; Sophie finds it difficult and emotional to hear that her cancer has spread
  ?s3 (^me ((pres find.v) it.pro (difficult.a and.cc emotional.a) (to (hear.v (that (((^me 's) cancer.n) ((pres perf) spread.v)))))))
)

:preconds (
  ; Sophie's pain has become worse recently
  ?p1 (((^me 's) pain.n) ((pres perf) got.v worse.a recently.adv-e))
  ; The user was empathetic towards Sophie
  ?p2 (^you ((past be.v) empathetic.a (adv-a (towards.p ^me))))
  ; Sophie is glad that the user is there to answer her questions
  ?p3 (^me ((pres be.v) glad.a (that (^you ((pres be.v) there.pro (to (answer.v ((^me 's) (plur question.n)))))))))
)

:goals (
  ; Sophie wants to acknowledge the doctor's help with a short statement
  ?g1 (^me ((pres want.v) (to (acknowledge.v ((^you 's) help.n) (with.p-arg (a.d (short.a statement.n)))))))
)

:episodes (

?e1 (^me say-to.v ^you ?words)
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *acknowledge-empathy*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'acknowledge-empathy.v '*acknowledge-empathy*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*acknowledge-empathy* 'semantics) (make-hash-table))
(setf (get '*acknowledge-empathy* 'gist-clauses) (make-hash-table))
(setf (get '*acknowledge-empathy* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*acknowledge-empathy*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*acknowledge-empathy*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*acknowledge-empathy*))
  '()
) ; END mapcar #'store-topic-keys
