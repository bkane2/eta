;; *mention-taking-naps*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *mention-taking-naps*

'(event-schema :header (((set-of ^me ^you) mention-taking-naps.v) ** ?e)
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

:preconds (
  ; Sophie usually takes a nap during the day
  ?p1 (^me usually.adv-e ((pres take.v) (a.d nap.n) (adv-e (during.p (the.d day.n)))))
)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I usually take a nap during the day \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *mention-taking-naps*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'mention-taking-naps.v '*mention-taking-naps*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*mention-taking-naps* 'semantics) (make-hash-table))
(setf (get '*mention-taking-naps* 'gist-clauses) (make-hash-table))
(setf (get '*mention-taking-naps* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*mention-taking-naps*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*mention-taking-naps*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*mention-taking-naps*))
  '()
) ; END mapcar #'store-topic-keys
