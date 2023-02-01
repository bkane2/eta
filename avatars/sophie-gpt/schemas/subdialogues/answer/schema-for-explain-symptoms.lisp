;; *explain-symptoms*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *explain-symptoms*

'(event-schema :header (((set-of ^me ^you) explain-symptoms.v) ** ?e)
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
  ; Sophie has pain
  ?s2 (^me ((pres have.v) (k pain.n)))
  ; Sophie has constipation
  ?s3 (^me ((pres have.v) (k constipation.n)))
  ; Sophie's appetite is worse
  ?s4 (((^me 's) appetite.n) ((pres be.v) worse.a))
)

:preconds (
)

:goals (
  ; Sophie wants the user to know her symptoms
  ?g1 (^me ((pres want.v) ^you (to (know.v ((^me 's) (plur symptom.n))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I have pain and constipation and my appetite is worse \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *explain-symptoms*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'explain-symptoms.v '*explain-symptoms*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*explain-symptoms* 'semantics) (make-hash-table))
(setf (get '*explain-symptoms* 'gist-clauses) (make-hash-table))
(setf (get '*explain-symptoms* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*explain-symptoms*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*explain-symptoms*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*explain-symptoms*))
  '()
) ; END mapcar #'store-topic-keys
