;; *say-pain-worse*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-pain-worse*

'(event-schema :header (((set-of ^me ^you) say-pain-worse.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:types (
  !t1 (^me person.n)
  !t2 (^you person.n)
)

:rigid-conds (
  ; Sophie is a woman
  !r1 (^me ((pres be.v) (= (a.d woman.n))))
  ; Sophie is 65 years old
  !r2 (^me ((pres be.v) ((mod-a (65.a (plur year.n))) old.a)))
)

:static-conds (
  ; Sophie has lung cancer
  ?s1 (^me ((pres have.v) (k (lung.n cancer.n))))
)

:preconds (
  ; Sophie's pain has recently been getting worse
  ?p1 (((^me 's) pain.n) ((pres perf) recently.adv-e ((prog get.v) worse.a)))
)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(My pain has recently been getting worse \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *say-pain-worse*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'say-pain-worse.v '*say-pain-worse*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*say-pain-worse* 'semantics) (make-hash-table))
(setf (get '*say-pain-worse* 'gist-clauses) (make-hash-table))
(setf (get '*say-pain-worse* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*say-pain-worse*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*say-pain-worse*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*say-pain-worse*))
  '()
) ; END mapcar #'store-topic-keys
