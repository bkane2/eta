;; *ask-if-can-outlive-prognosis-like-uncle*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-if-can-outlive-prognosis-like-uncle*

'(event-schema :header (((set-of ^me ^you) ask-if-can-outlive-prognosis-like-uncle.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to know more about her prognosis
  ?g1 (^me ((pres want.v) (to (know.v (more.d
        (n+preds {information}.n (about.p ((^me 's) prognosis.n))))))))
  ; Sophie wants to know whether she can outlive the user's prognosis like her uncle did
  ?g2 (^me ((pres want.v) (to (know.v (whether (^me ((pres can.aux-s) (outlive.v ((^you 's) prognosis.n)
        (like.ps (((^me 's) uncle.n) ((past do.aux-s) {that}.pro)))))))))))
)

:preconds (
  ; Sophie doesn't fully accept her prognosis
  ?p1 (^me ((pres do.aux-s) not fully.adv-a (accept.v ((^me 's) prognosis.n))))
  ; Sophie has an uncle Fred who outlived his prognosis
  ?p2 (^me ((pres have.v) (an.d (n+preds uncle.n (= |Fred|) (who.rel ((past outlive.v) (his.d prognosis.n)))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Can I outlive your prognosis like my uncle Fred did ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-if-can-outlive-prognosis-like-uncle*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-if-can-outlive-prognosis-like-uncle.v '*ask-if-can-outlive-prognosis-like-uncle*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-if-can-outlive-prognosis-like-uncle* 'semantics) (make-hash-table))
(setf (get '*ask-if-can-outlive-prognosis-like-uncle* 'gist-clauses) (make-hash-table))
(setf (get '*ask-if-can-outlive-prognosis-like-uncle* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-if-can-outlive-prognosis-like-uncle*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-if-can-outlive-prognosis-like-uncle*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-if-can-outlive-prognosis-like-uncle*))
  '()
) ; END mapcar #'store-topic-keys
