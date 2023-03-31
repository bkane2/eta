;; *say-preference-for-no-chemotherapy*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-preference-for-no-chemotherapy*

'(event-schema :header (((set-of ^me ^you) say-preference-for-no-chemotherapy.v) ** ?e)
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
    ;; Sophie thinks chemotherapy would be painful.
    ?p1 (^me ((pres think.v) (that (chemotherapy.n (pres be.v) painful.n))))
    ;; Sophie thinks chemotherapy would be exhausting.
    ?p2 (^me ((pres think.v) (that (chemotherapy.n (pres be.v) exhausting.n))))

)

:goals (
 ; Sophie wants the doctor to know she doesn't want chemotherapy.
  ?g1 (^me ((pres want.v) (^you (to (know.v (that (^me (not (pres want.v) chemotherapy.n))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Chemotherapy sounds too unpleasant and exhausting for me at this stage of my cancer \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *say-preference-for-no-chemotherapy*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'say-preference-for-no-chemotherapy.v '*say-preference-for-no-chemotherapy*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*say-preference-for-no-chemotherapy* 'semantics) (make-hash-table))
(setf (get '*say-preference-for-no-chemotherapy* 'gist-clauses) (make-hash-table))
(setf (get '*say-preference-for-no-chemotherapy* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*say-preference-for-no-chemotherapy*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*say-preference-for-no-chemotherapy*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*say-preference-for-no-chemotherapy*))
  '()
) ; END mapcar #'store-topic-keys
