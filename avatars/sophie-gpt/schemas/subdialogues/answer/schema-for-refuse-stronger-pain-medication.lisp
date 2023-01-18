;; *refuse-stronger-pain-medication*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *refuse-stronger-pain-medication*

'(event-schema :header (((set-of ^me ^you) refuse-stronger-pain-medication.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants to not take stronger pain medication at the moment
  ?g1 (^me ((pres want.v) (to (not (take.v (k (stronger.a (pain.n medication.n))) (adv-e (at.p (the.d moment.n))))))))
)

:preconds (
  ; Sophie is concerned about the side effects of stronger pain medication
  ?p1 (^me ((pres be.v) concerned.a (about.p-arg (the.d (n+preds (side.a (plur effect.n))
          (of.p (k (stronger.a (pain.n medication.n)))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I think I should hold off on stronger pain medication and think about it more \.))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me react-to.v ?e2)

)

)) ; END defparameter *refuse-stronger-pain-medication*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'refuse-stronger-pain-medication.v '*refuse-stronger-pain-medication*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*refuse-stronger-pain-medication* 'semantics) (make-hash-table))
(setf (get '*refuse-stronger-pain-medication* 'gist-clauses) (make-hash-table))
(setf (get '*refuse-stronger-pain-medication* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*refuse-stronger-pain-medication*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*refuse-stronger-pain-medication*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*refuse-stronger-pain-medication*))
  '()
) ; END mapcar #'store-topic-keys
