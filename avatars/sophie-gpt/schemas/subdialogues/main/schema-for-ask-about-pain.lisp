;; *ask-about-pain*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-pain*

'(event-schema :header (((set-of ^me ^you) ask-about-pain.v) ** ?e)
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
  ; Sophie has pain in her chest
  ?s2 (^me ((pres have.v) (k (n+preds pain.n (in.p ((^me 's) chest.n))))))
  ; Sophie is taking Lortab for her pain
  ?s3 (^me ((pres take.v) (k |Lortab|.n) (adv-a (for.p ((^me 's) pain.n)))))
)

:preconds (
  ; Sophie's pain has become worse recently
  ?p1 (((^me 's) pain.n) ((pres perf) got.v worse.a recently.adv-e))
  ; Sophie doesn't fully understand her condition
  ?p2 (^me ((pres do.aux-s) not (fully.adv-a understand.v ((^me 's) condition.n))))
)

:goals (
  ; Sophie wants to know more about her condition
  ?g1 (^me ((pres want.v) (to (know.v (more.d (n+preds {information}.n
        (about.p ((^me 's) condition.n))))))))
  ; Sophie wants stronger pain medication
  ?g2 (^me ((pres want.v) (k (stronger.a (pain.n medication.n)))))
)

:episodes (

  ?e1 (^me paraphrase-to.v ^you '(Why has my pain been getting worse recently ?))
  ?e2 (^you reply-to.v ?e1)

  ; If not empathetic, express fear about condition
  ?e3 (:if (not (^you be.v empathetic.a))
  
    ?e4 (^me paraphrase-to.v ^you '(I\'m really scared about my worsening condition \.))
    ?e5 (^you reply-to.v ?e4)

    ; If not empathetic again, escalate emotions
    ?e6 (:if (not (^you be.v empathetic.a))
    
      ?e7 (^me paraphrase-to.v ^you '(I don\'t think you understand how hard this is for me !))
      ?e8 (^you reply-to.v ?e7)

      ; If not empathetic a third time, escalate emotions further
      ; (presumably, the conversation would be paused here and rewound)
      ?e9 (:if (not (^you be.v empathetic.a))
      
        ?e10 (^me paraphrase-to.v ^you '(I don\'t think I can handle this right now \. I need a break \.))
        ?e11 ((set-of ^me ^you) pause-conversation.v))))

  ; Once the user is empathetic, proceed (but make sure that the user has actually answered Sophie's question)
  ?e12 (:if (not (^you tell.v ^me (about.p-arg ((^me 's) condition.n))))
  
    ?e13 (^me paraphrase-to.v ^you '(I appreciate your empathy \, but can you tell me about my condition ?))
    ?e14 (^you reply-to.v ?e10)

    :else (
      ?e13 (^me paraphrase-to.v ^you '(It\'s difficult to hear that my cancer has spread\, but I appreciate your empathy \.))))

)

)) ; END defparameter *ask-about-pain*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-pain.v '*ask-about-pain*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-pain* 'semantics) (make-hash-table))
(setf (get '*ask-about-pain* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-pain* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-pain*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-pain*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-pain*))
  '()
) ; END mapcar #'store-topic-keys
