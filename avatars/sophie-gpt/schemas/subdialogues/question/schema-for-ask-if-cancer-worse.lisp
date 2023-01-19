;; *ask-if-cancer-worse*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-if-cancer-worse*

'(event-schema :header (((set-of ^me ^you) ask-if-cancer-worse.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to know whether her cancer has gotten worse
  ?g1 (^me ((pres want.v) (to (know.v (whether (((^me 's) cancer.n) ((pres perf) (got.v worse.a))))))))
)

:preconds (
  ; Sophie does not understand her condition
  ?p1 (^me ((pres do.aux-s) not (understand.v ((^me 's) condition.n))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Has the cancer gotten worse ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *ask-if-cancer-worse*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-if-cancer-worse.v '*ask-if-cancer-worse*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-if-cancer-worse* 'semantics) (make-hash-table))
(setf (get '*ask-if-cancer-worse* 'gist-clauses) (make-hash-table))
(setf (get '*ask-if-cancer-worse* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-if-cancer-worse*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-if-cancer-worse*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-if-cancer-worse*))
  '()
) ; END mapcar #'store-topic-keys
