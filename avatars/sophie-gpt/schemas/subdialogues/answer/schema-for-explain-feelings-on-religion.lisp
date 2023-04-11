;; *explain-feelings-on-religion*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *explain-feelings-on-religion*

'(event-schema :header (((set-of ^me ^you) explain-feelings-on-religion.v) ** ?e)
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
  ; Sophie was a part of the Protestant church.
  ; Sophie grew apart from the church after her children grew up.

  ; Sophie has lung cancer
  ?s2 (^me ((pres have.v) (k (lung.n cancer.n))))

)

:preconds (
  ; Sophie believes in a heaven but still finds death scary.
)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I was a part of the Protestant church until my kids grew up and I do believe in a heaven \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *explain-feelings-on-religion*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'explain-feelings-on-religion.v '*explain-feelings-on-religion*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*explain-feelings-on-religion* 'semantics) (make-hash-table))
(setf (get '*explain-feelings-on-religion* 'gist-clauses) (make-hash-table))
(setf (get '*explain-feelings-on-religion* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*explain-feelings-on-religion*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*explain-feelings-on-religion*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*explain-feelings-on-religion*))
  '()
) ; END mapcar #'store-topic-keys
