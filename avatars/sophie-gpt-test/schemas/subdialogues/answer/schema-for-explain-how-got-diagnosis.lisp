;; *explain-how-got-diagnosis*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *explain-how-got-diagnosis*

'(event-schema :header (((set-of ^me ^you) explain-how-got-diagnosis.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants the user to know how she got her diagnosis
  ?g1 (^me ((pres want.v) ^you (to (know.v (ans-to (sub how.pq (^me ((past got.v) ((^me 's) diagnosis.n) *h))))))))
)

:preconds (
  ; Sophie got her diagnosis after visiting a lung doctor
  ?p1 (^me ((past got.v) ((^me 's) diagnosis.n) (after.ps (^me ((past visit.v) (a.d (lung.n doctor.n)))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I got my diagnosis after visiting a lung doctor \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *explain-how-got-diagnosis*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'explain-how-got-diagnosis.v '*explain-how-got-diagnosis*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*explain-how-got-diagnosis* 'semantics) (make-hash-table))
(setf (get '*explain-how-got-diagnosis* 'gist-clauses) (make-hash-table))
(setf (get '*explain-how-got-diagnosis* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*explain-how-got-diagnosis*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*explain-how-got-diagnosis*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*explain-how-got-diagnosis*))
  '()
) ; END mapcar #'store-topic-keys
