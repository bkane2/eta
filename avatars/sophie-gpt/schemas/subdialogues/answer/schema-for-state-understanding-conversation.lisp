;; *state-understanding-conversation*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *state-understanding-conversation*

'(event-schema :header (((set-of ^me ^you) state-understanding-conversation.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````````````

:types (
  !t1 (^me person.n)
  !t2 (^you person.n)
)

:rigid-conds (
  ; Sophie is a woman
  !r1 (^me ((pres be.v) (= (a.d woman.n))))
  ; Sophie is 65 years old
  !r2 (^me ((pres be.v) ((mod-a (65.a (plur year.n))) old.a)))
)

:static-conds (
  ; Sophie has lung cancer
  ?s1 (^me ((pres have.v) (k (lung.n cancer.n))))
)

:preconds (
  
)

:goals (
  ; Sophie wants the user to know the conversation is going fine.
  ?g1 (^me ((pres want.v) ^you (to (know.v (the.d conversation.n) ((pres prog) (go.v fine.a))))))
  ; Sophie wants you to know there's a large amount of information for her to take in.
  ?g2 (^me ((pres want.v) ^you (to (know.v (that ((pres be.v) (mod-a (large.a amount-of.a) (information.n) {for}.p (^me (to (pres process.v))))))))))
)

:episodes (

    ?e1 (^me paraphrase-to.v ^you '(The conversation is going well\, but there\'s a lot of information for to me to take in\.))
 
    ?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *state-understanding-conversation*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'state-understanding-conversation.v '*state-understanding-conversation*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*state-understanding-conversation* 'semantics) (make-hash-table))
(setf (get '*state-understanding-conversation* 'gist-clauses) (make-hash-table))
(setf (get '*state-understanding-conversation* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*state-understanding-conversation*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*state-understanding-conversation*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*state-understanding-conversation*))
  '()
) ; END mapcar #'store-topic-keys
