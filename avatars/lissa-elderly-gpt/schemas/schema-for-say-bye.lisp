;; *say-bye*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-bye*

'(event-schema :header (((set-of ^me ^you) say-bye.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

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

:goals (
  ; Sophie wants to finish the conversation
  ?g1 (^me ((pres want.v) (to (finish.v (the.d conversation.n)))))
)

:preconds (
  ; Sophie is done talking about her condition for now
  ?p1 (^me ((pres be.v) done.a ({with}.p-arg (ka (talk.v (about.p ((^me 's) condition.n)))))
        (adv-e (for.p (k now.n)))))
)

:episodes (

  ;; ?e1 (^me paraphrase-to.v ^you '(Goodbye \.))
  ;; ?e1 (^me say-to.v ^you ?words)
  
  ?e2 (:repeat-until ((the.d conversation.n) be.v over.a)
  
    ;; ?e3 (^you reply-to.v ?e1)

    ;; ?e4 (^me react-to.v ?e3)

    ?e3 (^me say-to.v ^you ?words)

    ?e4 (^you reply-to.v ?e3)

  )

  ?e3 (^me paraphrase-to.v ^you '(Thank you for meeting with me today \. Bye \.))
  ?e4 (^me say-bye-to.v ^you)

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
