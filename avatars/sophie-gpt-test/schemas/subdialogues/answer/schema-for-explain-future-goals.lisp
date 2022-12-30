;; *explain-future-goals*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *explain-future-goals*

'(event-schema :header (((set-of ^me ^you) explain-future-goals.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to explain her goals to the user
  ?g1 (^me ((pres want.v) (to (explain.v ((^me 's) (plur goal.n)) (to.p-arg ^you)))))
)

:preconds (
  ; Sophie's goal is to survive for enough time to be there for her family
  ?p1 (((^me 's) goal.n) ((pres be.v) (to.p-arg (ke (survive.v
        (adv-e (for.p (enough.d (n+preds time.n
          ({for}.p (to (be.v there.adv-e (adv-a (for.p ((^me 's) family.n)))))))))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(My goal is to survive long enough to be there for my family \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *explain-future-goals*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'explain-future-goals.v '*explain-future-goals*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*explain-future-goals* 'semantics) (make-hash-table))
(setf (get '*explain-future-goals* 'gist-clauses) (make-hash-table))
(setf (get '*explain-future-goals* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*explain-future-goals*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*explain-future-goals*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*explain-future-goals*))
  '()
) ; END mapcar #'store-topic-keys
