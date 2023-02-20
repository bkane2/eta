;; *ask-about-treatment-options*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-treatment-options*

'(event-schema :header (((set-of ^me ^you) ask-about-treatment-options.v) ** ?e)
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
  ; Sophie does not know her options for treatment
  ?p1 (^me ((pres do.aux-s) not (know.v ((^me 's) (n+preds (plur option.n) (for.p (k treatment.n)))))))
)

:goals (
  ; Sophie wants to know her options for treatment
  ?g1 (^me ((pres want.v) (to (know.v ((^me 's) (n+preds (plur option.n) (for.p (k treatment.n))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(What are my options for treatment ?))
 
?e2 (^you reply-to.v ?e1)

)

:obligations (
  !o1 (?e1 obligates (^you be.v empowering.a))
)


)) ; END defparameter *ask-about-treatment-options*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-treatment-options.v '*ask-about-treatment-options*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-treatment-options* 'semantics) (make-hash-table))
(setf (get '*ask-about-treatment-options* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-treatment-options* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-treatment-options*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-treatment-options*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-treatment-options*))
  '()
) ; END mapcar #'store-topic-keys
