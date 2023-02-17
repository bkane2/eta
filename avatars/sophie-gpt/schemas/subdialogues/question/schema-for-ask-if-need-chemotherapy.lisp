;; *ask-if-need-chemotherapy*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-if-need-chemotherapy*

'(event-schema :header (((set-of ^me ^you) ask-if-need-chemotherapy.v) ** ?e)
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
  ; Sophie does not know whether she needs chemotherapy
  ?p1 (^me ((pres do.aux-s) not (know.v (whether (^me ((pres need.v) (k chemotherapy.n)))))))
)

:goals (
  ; Sophie wants to know whether she needs chemotherapy
  ?g1 (^me ((pres want.v) (to (know.v (whether (^me ((pres need.v) (k chemotherapy.n))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Do I need chemotherapy ?))
 
?e2 (^you reply-to.v ?e1)

)

:obligations (
  !o1 (?e1 obligates ((^you be.v explicit.a) and (^you tell.v ^me (about.p-arg (k chemotherapy.n)))))
)

)) ; END defparameter *ask-if-need-chemotherapy*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-if-need-chemotherapy.v '*ask-if-need-chemotherapy*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-if-need-chemotherapy* 'semantics) (make-hash-table))
(setf (get '*ask-if-need-chemotherapy* 'gist-clauses) (make-hash-table))
(setf (get '*ask-if-need-chemotherapy* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-if-need-chemotherapy*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-if-need-chemotherapy*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-if-need-chemotherapy*))
  '()
) ; END mapcar #'store-topic-keys
