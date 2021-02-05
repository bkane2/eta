;; *discuss-parent-deaths.lisp*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *discuss-parent-deaths.lisp*

'(event-schema :header (((set-of ^me ^you) discuss-parent-deaths.lisp.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:episodes (

?e1 (^me paraphrase-to.v ^you '(My mother died from diabetes and my father died from prostate cancer \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *discuss-parent-deaths.lisp*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'discuss-parent-deaths.lisp.v '*discuss-parent-deaths.lisp*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*discuss-parent-deaths.lisp* 'semantics) (make-hash-table))
(setf (get '*discuss-parent-deaths.lisp* 'gist-clauses) (make-hash-table))
(setf (get '*discuss-parent-deaths.lisp* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*discuss-parent-deaths.lisp*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*discuss-parent-deaths.lisp*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*discuss-parent-deaths.lisp*))
  '()
) ; END mapcar #'store-topic-keys
