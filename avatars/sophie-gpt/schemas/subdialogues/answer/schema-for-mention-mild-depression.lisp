;; *mention-mild-depression*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *mention-mild-depression*

'(event-schema :header (((set-of ^me ^you) mention-mild-depression.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
)

:preconds (
  ; Sophie feels mildly depressed
  ?p1 (^me ((pres feel.v) (mildly.mod-a depressed.a)))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I feel mildly depressed \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *mention-mild-depression*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'mention-mild-depression.v '*mention-mild-depression*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*mention-mild-depression* 'semantics) (make-hash-table))
(setf (get '*mention-mild-depression* 'gist-clauses) (make-hash-table))
(setf (get '*mention-mild-depression* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*mention-mild-depression*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*mention-mild-depression*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*mention-mild-depression*))
  '()
) ; END mapcar #'store-topic-keys
