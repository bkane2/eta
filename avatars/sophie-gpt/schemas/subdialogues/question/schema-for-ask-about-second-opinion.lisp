;; *ask-about-second-opinion*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-second-opinion*

'(event-schema :header (((set-of ^me ^you) ask-about-second-opinion.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to get a second opinion on her prognosis
  ?g1 (^me ((pres want.v) (to (get.v (a.d (n+preds (second.a opinion.n) (on.p ((^me 's) prognosis.n))))))))
  ; Sophie wants to know whether she should get a second opinion on her prognosis
  ?g2 (^me ((pres want.v) (to (know.v (whether (^me ((pres should.aux-s)
        (get.v (a.d (n+preds (second.a opinion.n) (on.p ((^me 's) prognosis.n))))))))))))
)

:preconds (
  ; Sophie doesn't fully accept her prognosis
  ?p1 (^me ((pres do.aux-s) not fully.adv-a (accept.v ((^me 's) prognosis.n))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Should I get a second opinion on my prognosis ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-about-second-opinion*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-second-opinion.v '*ask-about-second-opinion*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-second-opinion* 'semantics) (make-hash-table))
(setf (get '*ask-about-second-opinion* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-second-opinion* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-second-opinion*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-second-opinion*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-second-opinion*))
  '()
) ; END mapcar #'store-topic-keys
