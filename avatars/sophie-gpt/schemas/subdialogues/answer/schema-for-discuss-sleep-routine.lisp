;; *discuss-sleep-routine*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *discuss-sleep-routine*

'(event-schema :header (((set-of ^me ^you) discuss-sleep-routine.v) ** ?e)
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
  ; Sophie takes some pain medication and reads a book before she sleeps
  ?p1 (^me ((((pres take.v) (some.d (pain.n medication.n))) and.cc ((pres read.v) (a.d book.n)))
        (adv-e (before.p (ke (^me sleep.v))))))
)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I take some pain medication and read a book before I sleep \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *discuss-sleep-routine*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'discuss-sleep-routine.v '*discuss-sleep-routine*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*discuss-sleep-routine* 'semantics) (make-hash-table))
(setf (get '*discuss-sleep-routine* 'gist-clauses) (make-hash-table))
(setf (get '*discuss-sleep-routine* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*discuss-sleep-routine*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*discuss-sleep-routine*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*discuss-sleep-routine*))
  '()
) ; END mapcar #'store-topic-keys
