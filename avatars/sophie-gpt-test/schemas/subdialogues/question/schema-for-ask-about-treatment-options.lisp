;; *ask-about-treatment-options*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-treatment-options*

'(event-schema :header (((set-of ^me ^you) ask-about-treatment-options.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to know her options for treatment
  ?g1 (^me ((pres want.v) (to (know.v ((^me 's) (n+preds (plur option.n) (for.p (k treatment.n))))))))
)

:preconds (
  ; Sophie does not know her options for treatment
  ?p1 (^me ((pres do.aux-s) not (know.v ((^me 's) (n+preds (plur option.n) (for.p (k treatment.n)))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(What are my options for treatment ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-about-treatment-options*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-treatment-options.v '*ask-about-treatment-options*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-treatment-options* 'semantics) (make-hash-table))
(setf (get '*ask-about-treatment-options* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-treatment-options* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-treatment-options*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-treatment-options*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-treatment-options*))
  '()
) ; END mapcar #'store-topic-keys
