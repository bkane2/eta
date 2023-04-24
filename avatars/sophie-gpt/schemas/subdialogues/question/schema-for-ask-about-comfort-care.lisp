;; *ask-about-comfort-care*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-comfort-care*

'(event-schema :header (((set-of ^me ^you) ask-about-comfort-care.v) ** ?e)
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
  ; Sophie does not know whether she should get comfort care
  ?p1 (^me ((pres do.aux-s) not (know.v (whether
        (^me ((pres should.aux-s) (get.v (k (comfort.n care.n)))))))))
)

:goals (
  ; Sophie wants to know whether she should get comfort care
  ?g1 (^me ((pres want.v) (to (know.v (whether
        (^me ((pres should.aux-s) (get.v (k (comfort.n care.n))))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Should I get comfort care ?))
 
?e2 (^you reply-to.v ?e1)

)

:obligations (
  !o1 (?e1 obligates ((^you be.v empowering.a) and (^you be.v explicit.a) and (^you tell.v ^me (about.p-arg (k (comfort.n care.n))))))
)

)) ; END defparameter *ask-about-comfort-care*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-comfort-care.v '*ask-about-comfort-care*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-comfort-care* 'semantics) (make-hash-table))
(setf (get '*ask-about-comfort-care* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-comfort-care* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-comfort-care*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-comfort-care*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-comfort-care*))
  '()
) ; END mapcar #'store-topic-keys
