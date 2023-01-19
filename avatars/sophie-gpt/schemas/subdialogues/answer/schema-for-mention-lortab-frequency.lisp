;; *mention-lortab-frequency*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *mention-lortab-frequency*

'(event-schema :header (((set-of ^me ^you) mention-lortab-frequency.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
)

:preconds (
  ; Sophie is taking Lortab every three hours
  ?p1 (^me ((pres prog) (take.v |Lortab| (adv-e ({for}.p (every.d (three.a (plur hour.n))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I am taking Lortab every three hours \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *mention-lortab-frequency*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'mention-lortab-frequency.v '*mention-lortab-frequency*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*mention-lortab-frequency* 'semantics) (make-hash-table))
(setf (get '*mention-lortab-frequency* 'gist-clauses) (make-hash-table))
(setf (get '*mention-lortab-frequency* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*mention-lortab-frequency*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*mention-lortab-frequency*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*mention-lortab-frequency*))
  '()
) ; END mapcar #'store-topic-keys
