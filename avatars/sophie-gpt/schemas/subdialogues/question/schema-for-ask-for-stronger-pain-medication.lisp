;; *ask-for-stronger-pain-medication*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-for-stronger-pain-medication*

'(event-schema :header (((set-of ^me ^you) ask-for-stronger-pain-medication.v) ** ?e)
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
  ; Sophie's current pain medication isn't working well
  ?p1 (((^me 's) (current.a (pain.n medication.n))) ((pres prog) not (work.v well.a)))
)

:goals (
  ; Sophie wants a stronger pain medication
  ?g1 (^me ((pres want.v) (a.d (stronger.a (pain.n medication.n)))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Can I have a stronger pain medication ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *ask-for-stronger-pain-medication*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-for-stronger-pain-medication.v '*ask-for-stronger-pain-medication*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-for-stronger-pain-medication* 'semantics) (make-hash-table))
(setf (get '*ask-for-stronger-pain-medication* 'gist-clauses) (make-hash-table))
(setf (get '*ask-for-stronger-pain-medication* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-for-stronger-pain-medication*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-for-stronger-pain-medication*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-for-stronger-pain-medication*))
  '()
) ; END mapcar #'store-topic-keys
