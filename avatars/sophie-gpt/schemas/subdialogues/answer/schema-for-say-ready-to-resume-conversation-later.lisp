;; *say-ready-to-resume-conversation-later*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-ready-to-resume-conversation-later*

'(event-schema :header (((set-of ^me ^you) say-ready-to-resume-conversation-later.v) ** ?e)
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
    ;; SOPHIE is willing to continue the conversation at a later appointment.

)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I am willing to continue the conversation at a later appointment \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *say-ready-to-resume-conversation-later*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'say-ready-to-resume-conversation-later.v '*say-ready-to-resume-conversation-later*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*say-ready-to-resume-conversation-later* 'semantics) (make-hash-table))
(setf (get '*say-ready-to-resume-conversation-later* 'gist-clauses) (make-hash-table))
(setf (get '*say-ready-to-resume-conversation-later* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*say-ready-to-resume-conversation-later*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*say-ready-to-resume-conversation-later*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*say-ready-to-resume-conversation-later*))
  '()
) ; END mapcar #'store-topic-keys
