;; *explain-symptoms*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *explain-symptoms*

'(event-schema :header (((set-of ^me ^you) explain-symptoms.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants the user to know her symptoms
  ?g1 (^me ((pres want.v) ^you (to (know.v ((^me 's) (plur symptom.n))))))
)

:preconds (
  ; Sophie has pain
  ?p1 (^me ((pres have.v) (k pain.n)))
  ; Sophie has constipation
  ?p2 (^me ((pres have.v) (k constipation.n)))
  ; Sophie's appetite is worse
  ?p3 (((^me 's) appetite.n) ((pres be.v) worse.a))
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
