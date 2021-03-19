;; *discuss-history-mental-illness.lisp*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *discuss-history-mental-illness.lisp*

'(event-schema :header (((set-of ^me ^you) discuss-history-mental-illness.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:episodes (

?e1 (^me paraphrase-to.v ^you '(Nobody in my family has a history of mental illness \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *discuss-history-mental-illness.lisp*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'discuss-history-mental-illness.v '*discuss-history-mental-illness.lisp*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*discuss-history-mental-illness.lisp* 'semantics) (make-hash-table))
(setf (get '*discuss-history-mental-illness.lisp* 'gist-clauses) (make-hash-table))
(setf (get '*discuss-history-mental-illness.lisp* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*discuss-history-mental-illness.lisp*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*discuss-history-mental-illness.lisp*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*discuss-history-mental-illness.lisp*))
  '()
) ; END mapcar #'store-topic-keys
