;; *discuss-parent-deaths*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *discuss-parent-deaths*

'(event-schema :header (((set-of ^me ^you) discuss-parent-deaths.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
)

:preconds (
  ; Sophie's mother died from diabetes
  ?p1 (((^me 's) mother.n) ((past die.v) (adv-a (from.p (k diabetes.n)))))
  ; Sophie's father died from prostate cancer
  ?p2 (((^me 's) father.n) ((past die.v) (adv-a (from.p (k (prostate.n cancer.n))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(My mother died from diabetes and my father died from prostate cancer \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *discuss-parent-deaths*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'discuss-parent-deaths.v '*discuss-parent-deaths*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*discuss-parent-deaths* 'semantics) (make-hash-table))
(setf (get '*discuss-parent-deaths* 'gist-clauses) (make-hash-table))
(setf (get '*discuss-parent-deaths* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*discuss-parent-deaths*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*discuss-parent-deaths*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*discuss-parent-deaths*))
  '()
) ; END mapcar #'store-topic-keys
