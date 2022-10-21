;; *ask-about-prognosis*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-prognosis*

'(event-schema :header (((set-of ^me ^you) ask-about-prognosis.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ?g1 (Sophie wants to know more about her prognosis \.)
  ;; ?g1 (^me want.v (to (know.v (more.d
  ;;       (n+preds {information}.n (about.p ((^me 's) prognosis.n)))))))
)

:preconds (
  ?p1 (Sophie does not know her prognosis \.)
  ;; ?p1 (^me do.aux-v not (know.v ((^me 's) prognosis.n)))
)

:episodes (

  ?e1 (^me paraphrase-to.v ^you '(What is my prognosis ?))
  
  ?e2 (^you reply-to.v ?e1)

  ?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-about-prognosis*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-prognosis.v '*ask-about-prognosis*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-prognosis* 'semantics) (make-hash-table))
(setf (get '*ask-about-prognosis* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-prognosis* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-prognosis*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-prognosis*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-prognosis*))
  '()
) ; END mapcar #'store-topic-keys
