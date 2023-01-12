;; *ask-why-pain-medication-not-working*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-why-pain-medication-not-working*

'(event-schema :header (((set-of ^me ^you) ask-why-pain-medication-not-working.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to know why her pain medication isn't working anymore
  ?g1 (^me ((pres want.v) (to (know.v (ans-to (sub why.pq (((^me 's) (pain.n medication.n))
        ((pres prog) not (work.v anymore.adv-e *h)))))))))
)

:preconds (
  ; Sophie's pain medication isn't working anymore
  ?p1 (((^me 's) (pain.n medication.n)) ((pres prog) not (work.v anymore.adv-e)))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Why isn\'t the pain medication working anymore ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-why-pain-medication-not-working*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-why-pain-medication-not-working.v '*ask-why-pain-medication-not-working*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-why-pain-medication-not-working* 'semantics) (make-hash-table))
(setf (get '*ask-why-pain-medication-not-working* 'gist-clauses) (make-hash-table))
(setf (get '*ask-why-pain-medication-not-working* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-why-pain-medication-not-working*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-why-pain-medication-not-working*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-why-pain-medication-not-working*))
  '()
) ; END mapcar #'store-topic-keys
