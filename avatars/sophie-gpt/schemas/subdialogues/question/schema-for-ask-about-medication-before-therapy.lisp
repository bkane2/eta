;; *ask-about-medication-before-therapy*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-medication-before-therapy*

'(event-schema :header (((set-of ^me ^you) ask-about-medication-before-therapy.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to know whether she should try medication before she tries chemotherapy
  ?g1 (^me ((pres want.v) (to (know.v (whether (^me ((pres should.aux-s) (try.v (k medication.n)
        (before.ps (^me ((pres try.v) (k chemotherapy.n))))))))))))
)

:preconds (
  ; Sophie is not currently getting chemotherapy
  ?p1 (^me ((pres prog) not currently.adv-e (get.v (k chemotherapy.n))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Should I try medication before I try therapy ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-about-medication-before-therapy*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-medication-before-therapy.v '*ask-about-medication-before-therapy*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-medication-before-therapy* 'semantics) (make-hash-table))
(setf (get '*ask-about-medication-before-therapy* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-medication-before-therapy* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-medication-before-therapy*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-medication-before-therapy*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-medication-before-therapy*))
  '()
) ; END mapcar #'store-topic-keys
