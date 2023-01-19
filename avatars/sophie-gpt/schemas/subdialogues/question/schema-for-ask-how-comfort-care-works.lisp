;; *ask-how-comfort-care-works*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-how-comfort-care-works*

'(event-schema :header (((set-of ^me ^you) ask-how-comfort-care-works.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to know how comfort care works
  ?g1 (^me ((pres want.v) (to (know.v (ans-to
        (sub how.pq ((k (comfort.n care.n)) ((pres work.v) *h))))))))
)

:preconds (
  ; Sophie does not understand how comfort care works
  ?p1 (^me ((pres do.aux-s) not (understand.v (ans-to
        (sub how.pq ((k (comfort.n care.n)) ((pres work.v) *h)))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(How does comfort care work ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *ask-how-comfort-care-works*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-how-comfort-care-works.v '*ask-how-comfort-care-works*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-how-comfort-care-works* 'semantics) (make-hash-table))
(setf (get '*ask-how-comfort-care-works* 'gist-clauses) (make-hash-table))
(setf (get '*ask-how-comfort-care-works* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-how-comfort-care-works*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-how-comfort-care-works*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-how-comfort-care-works*))
  '()
) ; END mapcar #'store-topic-keys
