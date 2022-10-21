;; *ask-about-pain*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *ask-about-pain*

'(event-schema :header (((set-of ^me ^you) ask-about-pain.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ?g1 (Sophie wants to know more about her condition \.)
  ;; ?g1 (^me want.v (to (know.v (more.d
  ;;       (n+preds {information}.n (about.p ((^me 's) condition.n)))))))
  ?g2 (Sophie wants stronger pain medication \.)
  ;; ?g2 (^me want.v (k (stronger.a (pain.n medication.n))))
)

:preconds (
  ?p1 (Sophie\'s pain has become worse recently \.)
  ;; ?p1 (((^me 's) pain.n) (perf become.v worse.a recently.adv-e))
  ?p2 (Sophie doesn\'t fully understand her condition \.)
  ;; ?p2 (^me do.aux-v not (fully.adv-a understand.v ((^me 's) condition.n)))
)

:episodes (

  ?e1 (^me paraphrase-to.v ^you '(Why has my pain been getting worse recently ?))
  
  ?e2 (^you reply-to.v ?e1)

  ?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *ask-about-pain*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'ask-about-pain.v '*ask-about-pain*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*ask-about-pain* 'semantics) (make-hash-table))
(setf (get '*ask-about-pain* 'gist-clauses) (make-hash-table))
(setf (get '*ask-about-pain* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*ask-about-pain*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*ask-about-pain*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*ask-about-pain*))
  '()
) ; END mapcar #'store-topic-keys
