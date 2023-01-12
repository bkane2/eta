;; *mention-anxiety*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *mention-anxiety*

'(event-schema :header (((set-of ^me ^you) mention-anxiety.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
)

:preconds (
  ; Sophie feels anxious about her future
  ?p1 (^me ((pres feel.v) anxious.a (about.p-arg ((^me 's) future.n))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I feel anxious about my future \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *mention-anxiety*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'mention-anxiety.v '*mention-anxiety*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*mention-anxiety* 'semantics) (make-hash-table))
(setf (get '*mention-anxiety* 'gist-clauses) (make-hash-table))
(setf (get '*mention-anxiety* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*mention-anxiety*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*mention-anxiety*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*mention-anxiety*))
  '()
) ; END mapcar #'store-topic-keys
