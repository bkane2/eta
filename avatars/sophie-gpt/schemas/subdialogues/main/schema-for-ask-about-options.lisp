;; *ask-about-options*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-options*

'(event-schema :header (((set-of ^me ^you) ask-about-options.v) ** ?e)
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
  ; Sophie wants to be able to watch her grandson graduate
  ?s2 (^me ((pres want.v) (to (be.v able.a (to (watch.v ((^me 's) grandson.n) (ke graduate.v)))))))
)

:preconds (
  ; Sophie is not currently getting treatment
  ?p1 (^me ((pres prog) not currently.adv-e (get.v (k treatment.n))))
)

:goals (
  ; Sophie wants to know more about her possible options for treatment
  ?g1 (^me ((pres want.v) (to (know.v (more.d
        (n+preds {information}.n (about.p ((^me 's)
          (n+preds (possible.a (plur option.n)) (for.p (k treatment.n)))))))))))
)

:episodes (

  ?e1 (^me paraphrase-to.v ^you '(What are my options for treatment ?))
  ?e2 (^you reply-to.v ?e1)
  
  ; If not empowering, express doubts
  ?e3 (:if (not (^you be.v empowering.a))
  
    ?e4 (^me paraphrase-to.v ^you '(I\'m finding it stressful to decide which treatment option to take \.))
    ?e5 (^you reply-to.v ?e4)

    ; If not empowering again, escalate emotions
    ?e6 (:if (not (^you be.v empowering.a))
    
      ?e7 (^me paraphrase-to.v ^you '(I really need to know how these treatments help with my own goals \.
                                      I don\'t want to let my family down \.))
      ?e8 (^you reply-to.v ?e7)

      ; If not empowering a third time, escalate emotions further
      ; (presumably, the conversation would be paused here and rewound)
      ?e9 (:if (not (^you be.v empowering.a))
      
        ?e10 (^me paraphrase-to.v ^you '(You\'re giving me too much information at once and not listening to my goals \.
                                         I need to take a break to process this information \.))
        ?e11 (^me say-to.v ^you '([NEUTRAL] Let\'s pause here for feedback on this conversation \.))
        ?e12 (^me say-bye-to.v ^you))))

  ; Once the user is empowering, proceed (but make sure that the user has actually answered Sophie's question adequately)
  ?e13 (:try-in-sequence

    (:if (not (^you tell.v ^me (about.p-arg ((^me 's) (plur option.n)))))
    
      ?e14 (^me paraphrase-to.v ^you '(Given the goals that we discussed \, what option do you think is the best ?))
      ?e15 (^you reply-to.v ?e14))

    (:if (not (^you tell.v ^me (about.p-arg (k chemotherapy.n))))
    
      ?e14 (^me paraphrase-to.v ^you '(Do you think I need chemotherapy ?))
      ?e15 (^you reply-to.v ?e14))

    (:if (not (^you tell.v ^me (about.p-arg (k (comfort.n care.n)))))
    
      ?e14 (^me paraphrase-to.v ^you '(I\'ve heard about something called comfort care \. Do you think that\'s an option ?))
      ?e15 (^you reply-to.v ?e14)))

  ?e16 (^me paraphrase-to.v ^you '(Thank you for telling me about my options \.
                                   I need to think about them more and discuss them with my family \.))

  ?e17 (^me say-to.v ^you '([NEUTRAL] Let\'s pause here for feedback on this conversation \.))

)

)) ; END defparameter *ask-about-options*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-options.v '*ask-about-options*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-options* 'semantics) (make-hash-table))
(setf (get '*ask-about-options* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-options* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-options*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-options*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-options*))
  '()
) ; END mapcar #'store-topic-keys
