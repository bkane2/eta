;; *mention-stress-about-test-results*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; REVISION: Allows SOPHIE to respond to questions about feelings on test results.

(defparameter *mention-stress-about-test-results*

'(event-schema :header (((set-of ^me ^you) mention-stress-about-test-results.v) ** ?e)
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
  ; Sophie feels stressed about her test results.
  ?p1 (^me ((pres feel.v) anxious.a (about.p-arg ((^me 's) (k (test.n results.n))))))
)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I feel stressed over what my test results mean for my future \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *mention-stress-about-test-results*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'mention-stress-about-test-results.v '*mention-stress-about-test-results*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*mention-stress-about-test-results* 'semantics) (make-hash-table))
(setf (get '*mention-stress-about-test-results* 'gist-clauses) (make-hash-table))
(setf (get '*mention-stress-about-test-results* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*mention-stress-about-test-results*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*mention-stress-about-test-results*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*mention-stress-about-test-results*))
  '()
) ; END mapcar #'store-topic-keys
