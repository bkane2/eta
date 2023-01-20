;; *ask-about-prognosis*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-prognosis*

'(event-schema :header (((set-of ^me ^you) ask-about-prognosis.v) ** ?e)
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
  ; Sophie does not know her prognosis
  ?p1 (^me ((pres do.aux-v) not (know.v ((^me 's) prognosis.n))))
)

:goals (
  ; Sophie wants to know more about her prognosis
  ?g1 (^me ((pres want.v) (to (know.v (more.d
        (n+preds {information}.n (about.p ((^me 's) prognosis.n))))))))
)

:episodes (

  ?e1 (^me paraphrase-to.v ^you '(What does my cancer mean for my future ?))
  ?e2 (^you reply-to.v ?e1)
  
  ; If not explicit about Sophie's prognosis, ask for more detail
  ?e3 (:if (not ((^you be.v explicit.a) and (^you tell.v ^me (about.p-arg ((^me 's) prognosis.n)))))
  
    ?e4 (^me paraphrase-to.v ^you '(I know that my condition is bad\, but I want you to be honest with me \.
                                    How long do you think I have ?))
    ?e5 (^you reply-to.v ?e4)

    ; If not explicit again, start to distrust doctor
    ?e6 (:if (not ((^you be.v explicit.a) and (^you tell.v ^me (about.p-arg ((^me 's) prognosis.n)))))
    
      ?e7 (^me paraphrase-to.v ^you '(I feel like you\'re avoiding my question \. As much as it will hurt\,
                                      I need to know about my future \.))
      ?e8 (^you reply-to.v ?e7)

      ; If not explicit a third time, escalate again (presumably, the conversation would be paused here and rewound)
      ?e9 (:if (not ((^you be.v explicit.a) and (^you tell.v ^me (about.p-arg ((^me 's) prognosis.n)))))
      
        ?e10 (^me paraphrase-to.v ^you '(I\'m not sure I can trust your prognosis \. I need to find another
                                         doctor who can be honest with me \.))
        ?e11 ((set-of ^me ^you) pause-conversation.v))))

  ; Once the user is explicit, proceed
  ?e12 (^me paraphrase-to.v ^you '(It\'s really hard to hear my prognosis \. I thought for sure I would have longer than
                                   that \. Thank you for being honest\, though \.))

)

)) ; END defparameter *ask-about-prognosis*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-prognosis.v '*ask-about-prognosis*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-prognosis* 'semantics) (make-hash-table))
(setf (get '*ask-about-prognosis* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-prognosis* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-prognosis*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-prognosis*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-prognosis*))
  '()
) ; END mapcar #'store-topic-keys
