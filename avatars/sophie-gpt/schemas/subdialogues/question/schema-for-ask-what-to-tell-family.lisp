;; *ask-what-to-tell-family*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-what-to-tell-family*

'(event-schema :header (((set-of ^me ^you) ask-what-to-tell-family.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to know what she should tell her family
  ?g1 (^me ((pres want.v) (to (know.v (ans-to (sub what.pro
        (^me ((pres should.aux-s) (tell.v ((^me 's) family.n) *h)))))))))
)

:preconds (
  ; Sophie hasn't told her family about her cancer yet
  ?p1 (^me ((pres perf) not (tell.v ((^me 's) family.n) (about.p-arg ((^me 's) cancer.n)) yet.adv-e)))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(What should I tell my family ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *ask-what-to-tell-family*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-what-to-tell-family.v '*ask-what-to-tell-family*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-what-to-tell-family* 'semantics) (make-hash-table))
(setf (get '*ask-what-to-tell-family* 'gist-clauses) (make-hash-table))
(setf (get '*ask-what-to-tell-family* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-what-to-tell-family*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-what-to-tell-family*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-what-to-tell-family*))
  '()
) ; END mapcar #'store-topic-keys
