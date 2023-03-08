;; *ask-what-metastasis-means*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-what-metastasis-means*

'(event-schema :header (((set-of ^me ^you) ask-what-metastasis-means.v) ** ?e)
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
  ; Sophie does not understand what metastasis means
  ?p1 (^me ((pres do.aux-s) not (know.v (ans-to
        (sub what.pq ((k metastasis.n) ((pres mean.v) *h)))))))
)

:goals (
  ; Sophie wants to know what metastasis means
  ?g1 (^me ((pres want.v) (to (know.v (ans-to
        (sub what.pq ((k metastasis.n) ((pres mean.v) *h))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(What does metastasis mean ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *ask-what-metastasis-means*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-what-metastasis-means.v '*ask-what-metastasis-means*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-what-metastasis-means* 'semantics) (make-hash-table))
(setf (get '*ask-what-metastasis-means* 'gist-clauses) (make-hash-table))
(setf (get '*ask-what-metastasis-means* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-what-metastasis-means*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-what-metastasis-means*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-what-metastasis-means*))
  '()
) ; END mapcar #'store-topic-keys
