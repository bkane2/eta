;; *accept-stronger-pain-medication*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *accept-stronger-pain-medication*

'(event-schema :header (((set-of ^me ^you) accept-stronger-pain-medication.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to take stronger pain medication
  ?g1 (^me ((pres want.v) (to (take.v (k (stronger.a (pain.n medication.n)))))))
)

:preconds (
  ; The user agreed to give Sophie stronger pain medication
  ?p1 (^you ((past agree.v) (to (give.v ^me (k (stronger.a (pain.n medication.n)))))))
  ; Sophie accepts stronger pain medication
  ?p2 (^me ((pres accept.v) (k (stronger.a (pain.n medication.n)))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I want to start taking the stronger pain medication \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *accept-stronger-pain-medication*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'accept-stronger-pain-medication.v '*accept-stronger-pain-medication*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*accept-stronger-pain-medication* 'semantics) (make-hash-table))
(setf (get '*accept-stronger-pain-medication* 'gist-clauses) (make-hash-table))
(setf (get '*accept-stronger-pain-medication* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*accept-stronger-pain-medication*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*accept-stronger-pain-medication*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*accept-stronger-pain-medication*))
  '()
) ; END mapcar #'store-topic-keys
