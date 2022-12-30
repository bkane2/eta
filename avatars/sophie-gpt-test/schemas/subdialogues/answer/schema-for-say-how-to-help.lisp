;; *say-how-to-help*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-how-to-help*

'(event-schema :header (((set-of ^me ^you) say-how-to-help.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants the user to know that they can help by answering all of her questions
  ?g1 (^me ((pres want.v) ^you (to (know.v (that (^you ((pres can.aux-s)
        (help.v (by.p-arg (ka (answer.v (all_of.d ((^me 's) (plur question.n))))))))))))))
)

:preconds (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(You can help me by answering all of my questions \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *say-how-to-help*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'say-how-to-help.v '*say-how-to-help*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*say-how-to-help* 'semantics) (make-hash-table))
(setf (get '*say-how-to-help* 'gist-clauses) (make-hash-table))
(setf (get '*say-how-to-help* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*say-how-to-help*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*say-how-to-help*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*say-how-to-help*))
  '()
) ; END mapcar #'store-topic-keys
