;; *ask-about-comfort-care*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-comfort-care*

'(event-schema :header (((set-of ^me ^you) ask-about-comfort-care.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to know whether she should get comfort care
  ?g1 (^me ((pres want.v) (to (know.v (whether
        (^me ((pres should.aux-s) (get.v (k (comfort.n care.n))))))))))
)

:preconds (
  ; Sophie does not know whether she should get comfort care
  ?p1 (^me ((pres do.aux-s) not (know.v (whether
        (^me ((pres should.aux-s) (get.v (k (comfort.n care.n)))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Should I get comfort care ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-about-comfort-care*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-comfort-care.v '*ask-about-comfort-care*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-comfort-care* 'semantics) (make-hash-table))
(setf (get '*ask-about-comfort-care* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-comfort-care* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-comfort-care*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-comfort-care*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-comfort-care*))
  '()
) ; END mapcar #'store-topic-keys
