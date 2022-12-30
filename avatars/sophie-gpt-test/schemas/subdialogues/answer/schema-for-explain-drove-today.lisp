;; *explain-drove-today*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *explain-drove-today*

'(event-schema :header (((set-of ^me ^you) explain-drove-today.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to explain to the user how she travelled here today
  ?g1 (^me ((pres want.v) (to (explain.v (to.p-arg ^you)
        (ans-to (sub how.pq (^me ((past travel.v) here.pro today.adv-e *h))))))))
)

:preconds (
  ; Sophie drove here today
  ?p1 (^me ((past drive.v) here.pro today.adv-e))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I drove here today \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *explain-drove-today*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'explain-drove-today.v '*explain-drove-today*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*explain-drove-today* 'semantics) (make-hash-table))
(setf (get '*explain-drove-today* 'gist-clauses) (make-hash-table))
(setf (get '*explain-drove-today* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*explain-drove-today*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*explain-drove-today*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*explain-drove-today*))
  '()
) ; END mapcar #'store-topic-keys
