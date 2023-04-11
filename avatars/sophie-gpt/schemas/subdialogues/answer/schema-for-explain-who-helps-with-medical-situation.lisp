;; *explain-who-helps-with-medical-situation*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *explain-who-helps-with-medical-situation*

'(event-schema :header (((set-of ^me ^you) explain-who-helps-with-medical-situation.v) ** ?e)
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
  ; Sophie has a daughter
  ?s1 (^me ((pres have.v) (k daughter.n)))
  ; Sophie has lung cancer
  ?s2 (^me ((pres have.v) (k (lung.n cancer.n))))
  
  

)

:preconds (
  ; Sophie's daughter has supported her during her cancer treatment
  ?p1 (((^me 's) daughter.n) (pres perf) ((prog support.v ) ^me) (adv-e (during.p ((^me 's) (k cancer.n treatment.n)))))

)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(My daughter has supported me throughout my cancer treatment \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *explain-who-helps-with-medical-situation*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'explain-who-helps-with-medical-situation.v '*explain-who-helps-with-medical-situation*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*explain-who-helps-with-medical-situation* 'semantics) (make-hash-table))
(setf (get '*explain-who-helps-with-medical-situation* 'gist-clauses) (make-hash-table))
(setf (get '*explain-who-helps-with-medical-situation* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*explain-who-helps-with-medical-situation*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*explain-who-helps-with-medical-situation*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*explain-who-helps-with-medical-situation*))
  '()
) ; END mapcar #'store-topic-keys
