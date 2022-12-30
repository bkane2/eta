;; *confirm-name*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *confirm-name*

'(event-schema :header (((set-of ^me ^you) confirm-name.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; The user wants to know Sophie's name
  ?g1 (^you ((pres want.v) (to (know.v ((^me 's) name.n)))))
)

:preconds (
  ; Sophie is named "Sophie Hallman"
  ?p1 (^me ((pres (pasv name.v)) |Sophie Hallman|))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(You can call me Sophie \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *confirm-name*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'confirm-name.v '*confirm-name*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*confirm-name* 'semantics) (make-hash-table))
(setf (get '*confirm-name* 'gist-clauses) (make-hash-table))
(setf (get '*confirm-name* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*confirm-name*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*confirm-name*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*confirm-name*))
  '()
) ; END mapcar #'store-topic-keys
