;; *explain-not-sleeping-well*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *explain-not-sleeping-well*

'(event-schema :header (((set-of ^me ^you) explain-not-sleeping-well.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants the user to know she hasn't been sleeping well
  ?g1 (^me ((pres want.v) ^you (to (know.v (tht (^me ((pres perf) not ((prog sleep.v) well.adv-a))))))))
)

:preconds (
  ; Sophie has not been sleeping well
  ?p1 (^me ((pres perf) not ((prog sleep.v) well.adv-a)))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I have not been sleeping well \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *explain-not-sleeping-well*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'explain-not-sleeping-well.v '*explain-not-sleeping-well*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*explain-not-sleeping-well* 'semantics) (make-hash-table))
(setf (get '*explain-not-sleeping-well* 'gist-clauses) (make-hash-table))
(setf (get '*explain-not-sleeping-well* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*explain-not-sleeping-well*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*explain-not-sleeping-well*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*explain-not-sleeping-well*))
  '()
) ; END mapcar #'store-topic-keys
