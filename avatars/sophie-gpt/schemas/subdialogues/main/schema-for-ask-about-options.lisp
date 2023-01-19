;; *ask-about-options*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-options*

'(event-schema :header (((set-of ^me ^you) ask-about-options.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to know more about her possible options for treatment
  ?g1 (^me ((pres want.v) (to (know.v (more.d
        (n+preds {information}.n (about.p ((^me 's)
          (n+preds (possible.a (plur option.n)) (for.p (k treatment.n)))))))))))
)

:preconds (
  ; Sophie is not currently getting treatment
  ?p1 (^me ((pres prog) not currently.adv-e (get.v (k treatment.n))))
)

:episodes (

  ?e1 (^me paraphrase-to.v ^you '(What are my options for treatment ?))
  
  ?e2 (:repeat-until (^you be.v empowering.a)
  
    ?e3 (^you reply-to.v ?e1)

    ?e4 (^me reply-to.v ?e3)

  )

)

)) ; END defparameter *ask-about-options*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-options.v '*ask-about-options*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-options* 'semantics) (make-hash-table))
(setf (get '*ask-about-options* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-options* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-options*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-options*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-options*))
  '()
) ; END mapcar #'store-topic-keys
