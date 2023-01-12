;; *discuss-history-mental-illness*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *discuss-history-mental-illness*

'(event-schema :header (((set-of ^me ^you) discuss-history-mental-illness.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
)

:preconds (
  ; Nobody in Sophie's family has a history of mental illness
  ?p1 ((np+preds nobody.pro (in.p ((^me 's) family.n))) ((pres have.v) (a.d (n+preds history.n (of.p (mental.a illness.n))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Nobody in my family has a history of mental illness \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *discuss-history-mental-illness*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'discuss-history-mental-illness.v '*discuss-history-mental-illness*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*discuss-history-mental-illness* 'semantics) (make-hash-table))
(setf (get '*discuss-history-mental-illness* 'gist-clauses) (make-hash-table))
(setf (get '*discuss-history-mental-illness* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*discuss-history-mental-illness*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*discuss-history-mental-illness*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*discuss-history-mental-illness*))
  '()
) ; END mapcar #'store-topic-keys
