;; *ask-about-future*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-future*

'(event-schema :header (((set-of ^me ^you) ask-about-future.v) ** ?e)
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
  ; Sophie is not ready to talk about treatment options yet
  ?s2 (^me ((pres be.v) not ready.a (to (talk.v (about.p-arg (k (plur (treatment.n option.n)))) yet.adv-e))))
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

  ; Question: should the user be expected to give a "warning shot" here before delivering the
  ; bad news, such that SOPHIE escalates emotions if the user neglects this step?
  
  ; If not explicit about Sophie's future, ask for more detail
  ?e3 (:if (not ((^you be.v explicit.a) and (^you tell.v ^me (that (((^me 's) cancer.n) be.v terminal.a)))))
    
      ?e4 (^me paraphrase-to.v ^you '(I want you to be honest with me \. How bad does my future look ?))
      ?e5 (^you reply-to.v ?e4)

      ; If not explicit again, start to distrust doctor
      ?e6 (:if (not ((^you be.v explicit.a) and (^you tell.v ^me (that (((^me 's) cancer.n) be.v terminal.a)))))

        ?e7 (^me paraphrase-to.v ^you '(I don\'t really understand your prognosis \. Could you be more clear ?))
        ?e8 (^you reply-to.v ?e7)))


  ?e13 (:try-in-sequence

    ; If user is too explicit, enter denial behavior
    (:if (^you tell.v ^me (a.d (vague.a (prognosis.n timeframe.n))))

      ?e14 ((set-of ^me ^you) deny-prognosis.v))


    ; If user mentioned cancer terminal without timeframe, proceed with prognosis question
    (:else
    
      ?e15 ((set-of ^me ^you) ask-about-prognosis.v)))

)

:obligations (
  !o1 (?e1 obligates ((^you be.v explicit.a) and (^you tell.v ^me (about.p-arg ((^me 's) prognosis.n)))))
  !o2 (?e4 obligates ((^you be.v explicit.a) and (^you tell.v ^me (about.p-arg ((^me 's) prognosis.n)))))
  !o3 (?e7 obligates ((^you be.v explicit.a) and (^you tell.v ^me (about.p-arg ((^me 's) prognosis.n)))))
)

)) ; END defparameter *ask-about-future*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-future.v '*ask-about-future*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-future* 'semantics) (make-hash-table))
(setf (get '*ask-about-future* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-future* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-future*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-future*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-future*))
  '()
) ; END mapcar #'store-topic-keys
