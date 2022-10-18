;; *explain-why-future-feels-out-of-control*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *explain-why-future-feels-out-of-control*

'(event-schema :header (((set-of ^me ^you) explain-why-future-feels-out-of-control.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:episodes (

?e1 (^me paraphrase-to.v ^you '(My future feels out of my control because I do not know how much time I have remaining to live \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *explain-why-future-feels-out-of-control*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'explain-why-future-feels-out-of-control.v '*explain-why-future-feels-out-of-control*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*explain-why-future-feels-out-of-control* 'semantics) (make-hash-table))
(setf (get '*explain-why-future-feels-out-of-control* 'gist-clauses) (make-hash-table))
(setf (get '*explain-why-future-feels-out-of-control* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*explain-why-future-feels-out-of-control*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*explain-why-future-feels-out-of-control*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*explain-why-future-feels-out-of-control*))
  '()
) ; END mapcar #'store-topic-keys
