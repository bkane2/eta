;; *bargain-about-prognosis*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *bargain-about-prognosis*

'(event-schema :header (((set-of ^me ^you) bargain-about-prognosis.v) ** ?e)
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
  ; Sophie is not ready to talk about treatment options yet
  ?s3 (^me ((pres be.v) not ready.a (to (talk.v (about.p-arg (k (plur (treatment.n option.n)))) yet.adv-e))))
)

:preconds (
  ; Sophie doesn't fully accept her prognosis
  ?p1 (^me ((pres do.aux-s) not fully.adv-a (accept.v ((^me 's) prognosis.n))))
  ; Sophie has an uncle Fred who outlived his prognosis
  ?p2 (^me ((pres have.v) (an.d (n+preds uncle.n (= |Fred|) (who.rel ((past outlive.v) (his.d prognosis.n)))))))
)

:goals (
  ; Sophie wants to know more about her prognosis
  ?g1 (^me ((pres want.v) (to (know.v (more.d
        (n+preds {information}.n (about.p ((^me 's) prognosis.n))))))))
) 

:episodes (

  ?e1 (^me paraphrase-to.v ^you '(I had an uncle Fred who outlived his prognosis \. Do you think I could do the same ?))
  ?e2 (^you reply-to.v ?e1)
  
  ; If user doesn't address bargaining in explicit way, escalate emotions
  ?e3 (:if (not (((^you be.v explicit.a) ** ?e2) and ((^you tell.v ^me (about.p-arg ((^me 's) prognosis.n))) ** ?e2)))
  
    ?e4 (^me paraphrase-to.v ^you '(I don\'t see how you could possibly know that prediction for sure !))
    ?e5 (^you reply-to.v ?e4)

    ; If not explicit again, start to distrust doctor
    ?e6 (:if (not (((^you be.v explicit.a) ** ?e5) and ((^you tell.v ^me (about.p-arg ((^me 's) prognosis.n))) ** ?e5)))

      ?e7 (^me paraphrase-to.v ^you '([ANGRY] That\'s ridiculous \. I know I have more time than that \.))
      ?e8 (^you reply-to.v ?e7)))


  ; Once the user is explicit, proceed
  ?e13 (^me paraphrase-to.v ^you '(I see \. Well\, I guess I am pretty anxious about my future \. I just want to make sure I'm there for my grandson \.))
  ?e14 (^you reply-to.v ?e13)

)

:obligations (
  !o1 (?e1 obligates ((^you be.v explicit.a) and (^you tell.v ^me (about.p-arg ((^me 's) prognosis.n)))))
  !o2 (?e4 obligates ((^you be.v explicit.a) and (^you tell.v ^me (about.p-arg ((^me 's) prognosis.n)))))
  !o3 (?e7 obligates ((^you be.v explicit.a) and (^you tell.v ^me (about.p-arg ((^me 's) prognosis.n)))))
)

)) ; END defparameter *bargain-about-prognosis*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'bargain-about-prognosis.v '*bargain-about-prognosis*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*bargain-about-prognosis* 'semantics) (make-hash-table))
(setf (get '*bargain-about-prognosis* 'gist-clauses) (make-hash-table))
(setf (get '*bargain-about-prognosis* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*bargain-about-prognosis*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*bargain-about-prognosis*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*bargain-about-prognosis*))
  '()
) ; END mapcar #'store-topic-keys
