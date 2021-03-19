;; *ask-about-what-happens-without-chemotherapy.lisp*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-what-happens-without-chemotherapy.lisp*

'(event-schema :header (((set-of ^me ^you) ask-about-what-happens-without-chemotherapy.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:episodes (

?e1 (^me paraphrase-to.v ^you '(What happens if I do not do chemotherapy ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-about-what-happens-without-chemotherapy.lisp*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-what-happens-without-chemotherapy.v '*ask-about-what-happens-without-chemotherapy.lisp*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-what-happens-without-chemotherapy.lisp* 'semantics) (make-hash-table))
(setf (get '*ask-about-what-happens-without-chemotherapy.lisp* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-what-happens-without-chemotherapy.lisp* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-what-happens-without-chemotherapy.lisp*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-what-happens-without-chemotherapy.lisp*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-what-happens-without-chemotherapy.lisp*))
  '()
) ; END mapcar #'store-topic-keys
