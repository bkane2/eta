;; *thank-for-explain-test-results*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; REVISION: New schema so that SOPHIE can express her thank for the doctor explaining her test results.


(defparameter *thank-for-explain-test-results*

'(event-schema :header (((set-of ^me ^you) thank-for-explain-test-results.v) ** ?e)
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
  ; Sophie knows she received a second CT scan. 
  ?p1 (^you ((pres intend.v) (to (explain.v (k (test.n results.n))))))
)

:goals (
  ; Sophie wants the user to know her understanding of her condition
  ?g1 (^me ((pres want.v) ^you (to (know.v (that (^me (pres be.v) (thankful.a (that (^you (pres explain.v (k (test.n results.n))))))))))))
)

:episodes (

    ?e1 (^me paraphrase-to.v ^you '(I am thankful that you've taken the time to explain my test results to me \.))
 
    ?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *thank-for-explain-test-results*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'thank-for-explain-test-results.v '*thank-for-explain-test-results*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*thank-for-explain-test-results* 'semantics) (make-hash-table))
(setf (get '*thank-for-explain-test-results* 'gist-clauses) (make-hash-table))
(setf (get '*thank-for-explain-test-results* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*thank-for-explain-test-results*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*thank-for-explain-test-results*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*thank-for-explain-test-results*))
  '()
) ; END mapcar #'store-topic-keys
