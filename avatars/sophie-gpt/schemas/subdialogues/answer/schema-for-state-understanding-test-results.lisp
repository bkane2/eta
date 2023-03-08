;; *state-understanding-test-results*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; REVISION: New schema so that SOPHIE can state her understanding of her test results if the doctor asks.


(defparameter *state-understanding-test-results*

'(event-schema :header (((set-of ^me ^you) state-understanding-test-results.v) ** ?e)
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
  ?p1 (^me ((pres know.v) (that (^me ((past have.v) (mod-a (2.a (k (CT.n scan.n)))))))))
  ; Sophie knows the CT scan shows that her tumor is still there.
  ?p2 (^me ((pres know.v) (that ((k (CT.n scan.n)) ((pres show.v) (that ((k (lung.n cancer)) (pres remain.v))))))))
  ; Sophie knows the CT scan mentioned metastasis.
  ?p3 (^me ((pres know.v) (that ((k (CT.n scan.n)) ((pres mention.v) metastasis.n)))))
  ; Sophie does not know what metastasis is.
  ?p2 (^me ((pres do.aux-s) not (know.v (ans-to (sub what.mod-a metastasis.n (pres be.v))))))
)

:goals (
  ; Sophie wants the user to know her understanding of her condition
  ?g1 (^me ((pres want.v) ^you (to (know.v (their.d (n+preds understanding.n (of.p ((^me 's) (plur (k (lung.n cancer.n)))))))))))
)

:episodes (

    ?e1 (^me paraphrase-to.v ^you '(I know that I received a second CT scan\, that the CT scan shows the tumor is still there\, but I do not know what metastasis is \.))
 
    ?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *state-understanding-test-results*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'state-understanding-test-results.v '*state-understanding-test-results*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*state-understanding-test-results* 'semantics) (make-hash-table))
(setf (get '*state-understanding-test-results* 'gist-clauses) (make-hash-table))
(setf (get '*state-understanding-test-results* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*state-understanding-test-results*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*state-understanding-test-results*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*state-understanding-test-results*))
  '()
) ; END mapcar #'store-topic-keys
