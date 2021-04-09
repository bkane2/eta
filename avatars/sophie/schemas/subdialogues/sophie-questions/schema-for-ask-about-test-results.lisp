;; *ask-about-test-results*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-test-results*

'(event-schema :header (((set-of ^me ^you) ask-about-test-results.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ?g1 (^me want.v (that (^me know.v (ans-to '(What do my test results mean ?)))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(What do my test results mean ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

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
