;; *ask-if-can-trust-prognosis*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-if-can-trust-prognosis*

'(event-schema :header (((set-of ^me ^you) ask-if-can-trust-prognosis.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to know more about her prognosis
  ?g1 (^me ((pres want.v) (to (know.v (more.d
        (n+preds {information}.n (about.p ((^me 's) prognosis.n))))))))
  ; Sophie wants to know whether she can trust the user's prognosis
  ?g2 (^me ((pres want.v) (to (know.v (whether (^me ((pres can.aux-s) (trust.v ((^you 's) prognosis.n)))))))))
)

:preconds (
  ; Sophie doesn't fully accept her prognosis
  ?p1 (^me ((pres do.aux-s) not fully.adv-a (accept.v ((^me 's) prognosis.n))))
  ; Sophie doesn't trust the user's prognosis
  ?p2 (^me ((pres do.aux-s) not (trust.v ((^you 's) prognosis.n))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Can I trust your prognosis ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *ask-if-can-trust-prognosis*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-if-can-trust-prognosis.v '*ask-if-can-trust-prognosis*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-if-can-trust-prognosis* 'semantics) (make-hash-table))
(setf (get '*ask-if-can-trust-prognosis* 'gist-clauses) (make-hash-table))
(setf (get '*ask-if-can-trust-prognosis* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-if-can-trust-prognosis*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-if-can-trust-prognosis*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-if-can-trust-prognosis*))
  '()
) ; END mapcar #'store-topic-keys
