;; *discuss-smoking-habits*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *discuss-smoking-habits*

'(event-schema :header (((set-of ^me ^you) discuss-smoking-habits.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
)

:preconds (
  ; Sophie has a history of heavy smoking
  ?p1 (^me ((pres have.v) (a.d (n+preds history.n (of.p (ka (heavy.adv-a smoke.v)))))))
  ; Sophie quit smoking six months ago
  ?p2 (^me ((past quit.v) (ka smoke.v) (adv-e (sub (six.d (plur month.n)) (ago.p *h)))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I have a history of smoking but quit six months ago \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *discuss-smoking-habits*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'discuss-smoking-habits.v '*discuss-smoking-habits*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*discuss-smoking-habits* 'semantics) (make-hash-table))
(setf (get '*discuss-smoking-habits* 'gist-clauses) (make-hash-table))
(setf (get '*discuss-smoking-habits* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*discuss-smoking-habits*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*discuss-smoking-habits*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*discuss-smoking-habits*))
  '()
) ; END mapcar #'store-topic-keys
