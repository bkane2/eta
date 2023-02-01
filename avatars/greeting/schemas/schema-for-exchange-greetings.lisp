;; *exchange-greetings*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *exchange-greetings*

'(event-schema :header ((?s exchange-greetings.v ?h) ** ?e)
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
  ?g1 (?s ((pres want.v) (to (greet.v ?h))))
)

:episodes (

  ;; ?e1 (?s say-hello-to.v ?h)
  ?e1 (?s say-to.v ?h '(Hello \.))

  ;; ?e2 (?s inquire.v (about.p-arg (th x (x (well-being-of.p ?h)))))
  ?e2 (?s paraphrase-to.v ?h '(How are you doing ?))

  ?e3 (?h reply-to.v ?e2)

  ?e4 (:if ((?h do.v (no.d thing.n)) ** ?e3)
    ?e5 (?s say-to.v ?h '(I see you\'re not interested in talking with me right now\. That\'s fine\.)))

)

:certainties (
  !c1 (!e3 0.1)
)

)) ; END defparameter *exchange-greetings*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'exchange-greetings.v '*exchange-greetings*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*exchange-greetings* 'semantics) (make-hash-table))
(setf (get '*exchange-greetings* 'gist-clauses) (make-hash-table))
(setf (get '*exchange-greetings* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*exchange-greetings*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*exchange-greetings*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*exchange-greetings*))
  '()
) ; END mapcar #'store-topic-keys
