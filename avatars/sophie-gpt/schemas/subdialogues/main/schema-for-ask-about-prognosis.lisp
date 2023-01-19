;; *ask-about-prognosis*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-prognosis*

'(event-schema :header (((set-of ^me ^you) ask-about-prognosis.v) ** ?e)
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
  ; Sophie does not know her prognosis
  ?p1 (^me ((pres do.aux-v) not (know.v ((^me 's) prognosis.n))))
)

:goals (
  ; Sophie wants to know more about her prognosis
  ?g1 (^me ((pres want.v) (to (know.v (more.d
        (n+preds {information}.n (about.p ((^me 's) prognosis.n))))))))
)

:episodes (

  ?e1 (^me paraphrase-to.v ^you '(What does my cancer mean for my future ?))
  
  ; TODO: in order to prevent this from being skipped if user already was explicit, need
  ; to add additional ULF (^me understand.v ((^me 's) prognosis.n)) or something similar.
  ; Need to check if :and is supported in conditions, as well as template nodes for ULF transduction.
  ?e2 (:repeat-until (^you be.v explicit.a)
  
    ?e3 (^you reply-to.v ?e1)

    ?e4 (^me reply-to.v ?e3)

  )

)

)) ; END defparameter *ask-about-prognosis*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-prognosis.v '*ask-about-prognosis*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-prognosis* 'semantics) (make-hash-table))
(setf (get '*ask-about-prognosis* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-prognosis* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-prognosis*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-prognosis*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-prognosis*))
  '()
) ; END mapcar #'store-topic-keys
