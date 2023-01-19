;; *discuss-radiation-symptoms*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *discuss-radiation-symptoms*

'(event-schema :header (((set-of ^me ^you) discuss-radiation-symptoms.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
)

:preconds (
  ; Sophie had some hair loss and redness at the site of radiation
  ?p1 (^me ((past have.v) ((some.d (hair.n loss.n)) and.cc (k redness.n))
        (at.p-arg (the.d (n+preds site.n (of.p (k radiation.n)))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I had some hair loss and redness at the site of radiation \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *discuss-radiation-symptoms*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'discuss-radiation-symptoms.v '*discuss-radiation-symptoms*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*discuss-radiation-symptoms* 'semantics) (make-hash-table))
(setf (get '*discuss-radiation-symptoms* 'gist-clauses) (make-hash-table))
(setf (get '*discuss-radiation-symptoms* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*discuss-radiation-symptoms*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*discuss-radiation-symptoms*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*discuss-radiation-symptoms*))
  '()
) ; END mapcar #'store-topic-keys
