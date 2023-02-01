;; *ask-why-have-cancer*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-why-have-cancer*

'(event-schema :header (((set-of ^me ^you) ask-why-have-cancer.v) ** ?e)
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
  ; Sophie does not understand why she has cancer
  ?p1 (^me ((pres do.aux-s) not (understand.v (ans-to (sub why.pq (^me ((pres have.v) (k cancer.n) *h)))))))
)

:goals (
  ; Sophie wants to know why she has cancer
  ?g1 (^me ((pres want.v) (to (know.v (ans-to (sub why.pq (^me ((pres have.v) (k cancer.n) *h))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Why do I have cancer ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *ask-why-have-cancer*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-why-have-cancer.v '*ask-why-have-cancer*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-why-have-cancer* 'semantics) (make-hash-table))
(setf (get '*ask-why-have-cancer* 'gist-clauses) (make-hash-table))
(setf (get '*ask-why-have-cancer* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-why-have-cancer*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-why-have-cancer*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-why-have-cancer*))
  '()
) ; END mapcar #'store-topic-keys
