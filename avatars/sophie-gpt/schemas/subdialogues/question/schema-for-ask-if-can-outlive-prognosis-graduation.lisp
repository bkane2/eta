;; *ask-if-can-outlive-prognosis-graduation*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-if-can-outlive-prognosis-graduation*

'(event-schema :header (((set-of ^me ^you) ask-if-can-outlive-prognosis-graduation.v) ** ?e)
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
  ; Sophie doesn't fully accept her prognosis
  ?p1 (^me ((pres do.aux-s) not fully.adv-a (accept.v ((^me 's) prognosis.n))))
)

:goals (
  ; Sophie wants to know more about her prognosis
  ?g1 (^me ((pres want.v) (to (know.v (more.d
        (n+preds {information}.n (about.p ((^me 's) prognosis.n))))))))
  ; Sophie wants to know whether she can outlive the user's prognosis until the graduation of her grandson
  ?g2 (^me ((pres want.v) (to (know.v (whether (^me ((pres can.aux-s) (outlive.v ((^you 's) prognosis.n)
        (adv-e (until.p (the.d (n+preds graduation.n (of.p ((^me 's) grandson.n))))))))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Can I outlive your prognosis until the graduation of my grandson ?))
 
?e2 (^you reply-to.v ?e1)

)

:obligations (
  !o1 (?e1 obligates ((^you be.v explicit.a) and (^you tell.v ^me (about.p-arg ((^me 's) prognosis.n)))))
)

)) ; END defparameter *ask-if-can-outlive-prognosis-graduation*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-if-can-outlive-prognosis-graduation.v '*ask-if-can-outlive-prognosis-graduation*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-if-can-outlive-prognosis-graduation* 'semantics) (make-hash-table))
(setf (get '*ask-if-can-outlive-prognosis-graduation* 'gist-clauses) (make-hash-table))
(setf (get '*ask-if-can-outlive-prognosis-graduation* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-if-can-outlive-prognosis-graduation*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-if-can-outlive-prognosis-graduation*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-if-can-outlive-prognosis-graduation*))
  '()
) ; END mapcar #'store-topic-keys
