;; *ask-about-poor-sleep*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-poor-sleep*

'(event-schema :header (((set-of ^me ^you) ask-about-poor-sleep.v) ** ?e)
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
  ; Sophie hasn't been sleeping well
  ?p1 (^me ((pres perf) not ((prog sleep.v) well.a)))
)

:goals (
  ; Sophie wants to know why she hasn't been sleeping well
  ?g1 (^me ((pres want.v) (to (know.v (ans-to
        (sub why.pq (^me ((pres perf) not ((prog sleep.v) well.a *h)))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Why have I not been sleeping well ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *ask-about-poor-sleep*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-poor-sleep.v '*ask-about-poor-sleep*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-poor-sleep* 'semantics) (make-hash-table))
(setf (get '*ask-about-poor-sleep* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-poor-sleep* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-poor-sleep*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-poor-sleep*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-poor-sleep*))
  '()
) ; END mapcar #'store-topic-keys
