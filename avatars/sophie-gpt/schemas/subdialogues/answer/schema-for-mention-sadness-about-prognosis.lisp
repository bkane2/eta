;; *mention-sadness-about-prognosis*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *mention-sadness-about-prognosis*

'(event-schema :header (((set-of ^me ^you) mention-sadness-about-prognosis.v) ** ?e)
;`````````````````````````````````````````````````````````````````````````````````````

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
  ; Sophie feels sad about her prognosis
  ?p1 (^me ((pres feel.v) sad.a (adv-a (about.p ((^me 's) prognosis.n)))))
  ; Sophie is extremely upset and emotional
  ?p2 (^me ((pres be.v) ((extremely.mod-a upset.a) and.cc emotional.a)))
)

:goals (
  ?g1 (^me ((pres want.v) (to (let.v ^you (ka (know.v ((^me 's) (plur feeling.n))))))))
)

:episodes (

?e1 (^me say-to.v ^you ?words)
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *mention-sadness-about-prognosis*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'mention-sadness-about-prognosis.v '*mention-sadness-about-prognosis*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*mention-sadness-about-prognosis* 'semantics) (make-hash-table))
(setf (get '*mention-sadness-about-prognosis* 'gist-clauses) (make-hash-table))
(setf (get '*mention-sadness-about-prognosis* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*mention-sadness-about-prognosis*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*mention-sadness-about-prognosis*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*mention-sadness-about-prognosis*))
  '()
) ; END mapcar #'store-topic-keys
