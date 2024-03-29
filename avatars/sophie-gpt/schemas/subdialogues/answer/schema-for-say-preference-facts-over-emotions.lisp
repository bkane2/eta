;; *say-preference-facts-over-emotions*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-preference-facts-over-emotions*

'(event-schema :header (((set-of ^me ^you) say-preference-facts-over-emotions.v) ** ?e)
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
  ; Sophie wants the doctor to not concentrate on emotions.
  ?g1 (^me ((pres want.v) (^you (not (to (concentrate.v ({on}.p-args ((^me 's) (plur emotion.n)) ) ))))))
  ; Sophie wants the doctor to concentrate on facts.
  ?g2 (^me ((pres want.v) (^you (to (concentrate.v ({on}.p-args ((^me 's) (plur emotion.n)) ) )))))


)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I prefer that you concetrate on facts rather than my emotions right now \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *say-preference-facts-over-emotions*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'say-preference-facts-over-emotions.v '*say-preference-facts-over-emotions*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*say-preference-facts-over-emotions* 'semantics) (make-hash-table))
(setf (get '*say-preference-facts-over-emotions* 'gist-clauses) (make-hash-table))
(setf (get '*say-preference-facts-over-emotions* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*say-preference-facts-over-emotions*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*say-preference-facts-over-emotions*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*say-preference-facts-over-emotions*))
  '()
) ; END mapcar #'store-topic-keys
