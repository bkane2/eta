;; *say-preference-for-resuscitation*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-preference-for-resuscitation*

'(event-schema :header (((set-of ^me ^you) say-preference-for-resuscitation.v) ** ?e)
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
    ;; Sophie thinks resuscitation would be unnecessary.
    ?p1 (^me ((pres think.v) (that (resuscitation.n (pres be.v) unnecessary.n))))
    ;; Sophie thinks chemotherapy would be exhausting.
    ?p2 (^me ((pres think.v) (that (resuscitation.n (pres be.v) painful.n (adv-a ({for}.p ((^me 's) family.n)))))))

)

:goals (
 ; Sophie wants the doctor to know she doesn't want chemotherapy.
  ?g1 (^me ((pres want.v) (^you (to (know.v (that (^me (not (pres want.v) resuscitation.n))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I think that resuscitation could cause my family pain and is unnecessary \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *say-preference-for-resuscitation*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'say-preference-for-resuscitation.v '*say-preference-for-resuscitation*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*say-preference-for-resuscitation* 'semantics) (make-hash-table))
(setf (get '*say-preference-for-resuscitation* 'gist-clauses) (make-hash-table))
(setf (get '*say-preference-for-resuscitation* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*say-preference-for-resuscitation*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*say-preference-for-resuscitation*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*say-preference-for-resuscitation*))
  '()
) ; END mapcar #'store-topic-keys
