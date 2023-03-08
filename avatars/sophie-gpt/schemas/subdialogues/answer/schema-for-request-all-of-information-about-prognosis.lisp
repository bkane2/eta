;; *request-all-of-information-about-prognosis*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *request-all-of-information-about-prognosis*

'(event-schema :header (((set-of ^me ^you) request-all-of-information-about-prognosis.v) ** ?e)
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
)

:goals (
  ; Sophie wants a stronger pain medication
  ?g1 (^me ((pres want.v) (to (have.v (all-of.p (information.n (about.p prognosis.n)))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I want to know as much information about my prognosis as you can tell me \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *request-all-of-information-about-prognosis*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'request-all-of-information-about-prognosis.v '*request-all-of-information-about-prognosis*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*request-all-of-information-about-prognosis* 'semantics) (make-hash-table))
(setf (get '*request-all-of-information-about-prognosis* 'gist-clauses) (make-hash-table))
(setf (get '*request-all-of-information-about-prognosis* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*request-all-of-information-about-prognosis*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*request-all-of-information-about-prognosis*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*request-all-of-information-about-prognosis*))
  '()
) ; END mapcar #'store-topic-keys
