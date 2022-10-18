;; *say-bye*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-bye*

'(event-schema :header (((set-of ^me ^you) say-bye.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ?g1 "Sophie wants to finish the conversation."
  ;; ?g1 (^me want.v (to (finish.v (the.d conversation.n))))
)

:preconds (
  ?p1 "Sophie is done talking about her condition for now."
  ;; ?p1 (^me be.v done.a ({with}.p-arg (ka (talk.v (about.p ((^me 's) condition.n)))))
  ;;       (adv-e (for.p (k now.n))))
)

:episodes (

  ?e1 (^me paraphrase-to.v ^you '(Goodbye \.))
  
  ?e2 (^you reply-to.v ?e1)

  ?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *say-bye*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'say-bye.v '*say-bye*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*say-bye* 'semantics) (make-hash-table))
(setf (get '*say-bye* 'gist-clauses) (make-hash-table))
(setf (get '*say-bye* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*say-bye*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*say-bye*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*say-bye*))
  '()
) ; END mapcar #'store-topic-keys
