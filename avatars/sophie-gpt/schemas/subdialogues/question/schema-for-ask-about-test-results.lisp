;; *ask-about-test-results*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-test-results*

'(event-schema :header (((set-of ^me ^you) ask-about-test-results.v) ** ?e)
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
  ; Sophie does not understand her test results
  ?p1 (^me ((pres do.aux-s) not (understand.v ((^me 's) (test.n (plur result.n))))))
)

:goals (
  ; Sophie wants to know what her test results mean
  ?g1 (^me ((pres want.v) (to (know.v (ans-to
        (sub what.pro (((^me 's) (test.n (plur result.n))) ((pres mean.v) *h))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(What do my test results mean ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *ask-about-test-results*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-test-results.v '*ask-about-test-results*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-test-results* 'semantics) (make-hash-table))
(setf (get '*ask-about-test-results* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-test-results* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-test-results*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-test-results*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-test-results*))
  '()
) ; END mapcar #'store-topic-keys
