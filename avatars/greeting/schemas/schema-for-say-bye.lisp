;; *say-bye*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-bye*

'(event-schema :header (((set-of ?s ?h) say-bye.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:types (
  !t1 (?s person.n)
  !t2 (?h person.n)
)

:rigid-conds (
)

:static-conds (
)

:preconds (
)

:goals (
  ; Eta wants to finish the conversation
  ?g1 (?s ((pres want.v) (to (finish.v (the.d conversation.n)))))
)

:episodes (

  ;; ?e1 (?s paraphrase-to.v ?h '(Goodbye \.))
  ;; ?e1 (?s say-to.v ?h ?words)
  
  ?e2 (:repeat-until ((the.d conversation.n) be.v over.a)
  
    ;; ?e3 (?h reply-to.v ?e1)

    ;; ?e4 (?s react-to.v ?e3)

    ?e3 (?s say-to.v ?h ?words)

    ?e4 (?h reply-to.v ?e3)

  )

  ?e3 (?s paraphrase-to.v ?h '(Thank you for talking with me today \. Bye \.))
  ?e4 (?s say-bye-to.v ?h)

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
