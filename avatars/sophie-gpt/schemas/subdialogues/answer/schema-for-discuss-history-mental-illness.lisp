;; *discuss-history-mental-illness*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *discuss-history-mental-illness*

'(event-schema :header (((set-of ^me ^you) discuss-history-mental-illness.v) ** ?e)
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
  ; Nobody in Sophie's family has a history of mental illness
  ?p1 ((np+preds nobody.pro (in.p ((^me 's) family.n))) ((pres have.v) (a.d (n+preds history.n (of.p (mental.a illness.n))))))
)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Nobody in my family has a history of mental illness \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *discuss-history-mental-illness*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'discuss-history-mental-illness.v '*discuss-history-mental-illness*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*discuss-history-mental-illness* 'semantics) (make-hash-table))
(setf (get '*discuss-history-mental-illness* 'gist-clauses) (make-hash-table))
(setf (get '*discuss-history-mental-illness* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*discuss-history-mental-illness*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*discuss-history-mental-illness*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*discuss-history-mental-illness*))
  '()
) ; END mapcar #'store-topic-keys
