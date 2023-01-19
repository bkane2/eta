;; *ask-about-antidepressant*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-antidepressant*

'(event-schema :header (((set-of ^me ^you) ask-about-antidepressant.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to lessen her pain
  ?g1 (^me ((pres want.v) (to (lessen.v ((^me 's) pain.n)))))
  ; Sophie wants to know whether taking an antidepressant will help with her pain
  ?g2 (^me ((pres want.v) (to (know.v (whether ((ka (take.v (an.d antidepressant.n)))
        ((pres will.aux-s) (help.v (with.p-arg ((^me 's) pain.n))))))))))
)

:preconds (
  ; Sophie is not currently taking antidepressants
  ?p1 (^me ((pres prog) not currently.adv-e (take.v (k (plur antidepressant.n)))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Will an antidepressant help with my pain ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *ask-about-antidepressant*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-antidepressant.v '*ask-about-antidepressant*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-antidepressant* 'semantics) (make-hash-table))
(setf (get '*ask-about-antidepressant* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-antidepressant* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-antidepressant*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-antidepressant*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-antidepressant*))
  '()
) ; END mapcar #'store-topic-keys
