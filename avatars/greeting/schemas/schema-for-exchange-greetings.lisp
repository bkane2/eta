;; *exchange-greetings*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *exchange-greetings*

'(event-schema :header ((^me exchange-greetings.v ^you) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:types (
  !t1 (^me person.n)
  !t2 (^you person.n)
)

:rigid-conds (
)

:static-conds (
)

:preconds (
)

:goals (
)

:episodes (

  ;; ?e1 (^me say-hello-to.v ^you)
  ?e1 (^me say-to.v ^you '(Hello \.))

  ;; ?e2 (^me inquire.v (about.p-arg (th x (x (well-being-of.p ^you)))))
  ?e2 (^me paraphrase-to.v ^you '(How are you doing ?))

  ?e3 (^you reply-to.v ?e2)

  ?e4 (^me say-to.v ^you '(Test \.))

  ?e5 (:if ((^you do.v (no.d thing.n)) ** ?e3)
    ?e6 (^me say-to.v ^you '(I see you\'re not interested in talking with me right now\. That\'s fine\.)))

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
