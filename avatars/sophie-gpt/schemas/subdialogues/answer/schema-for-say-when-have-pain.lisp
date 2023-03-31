;; *say-when-have-pain*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-when-have-pain*

'(event-schema :header (((set-of ^me ^you) say-when-have-pain.v) ** ?e)
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
  ; Sophie has pain in her chest
  ?s2 (^me ((pres have.v) (k (n+preds pain.n (in.p ((^me 's) chest.n))))))
  ; Sophie is taking Lortab for her pain
  ?s3 (^me ((pres take.v) (k |Lortab|.n) (adv-a (for.p ((^me 's) pain.n)))))
)

:preconds (
  ; Sophie's pain has recently been getting worse
  ?p1 (((^me 's) pain.n) ((pres perf) recently.adv-e ((prog get.v) worse.a)))
  ;; Sophie has pain when she takes a deep breath.
  ?p2 (^me ((pres have.v) (k (n+preds pain.n (when.p (^me (pres breath.v)))))))
  ;; Sophie had pain when she swallowed throughout radiation.
  ?p3 (^me ((past have.v) (k (n+preds pain.n (when.p (^me (past swallow.v))))) (adv-e (during.p ((^me 's) (k (radiation.n treatment.n)))))))
)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I have pain when I take a deep breath \, and I used to have pain when I swallowed throughout my radiation treatment \.))
 
?e2 (^you reply-to.v ?e1)

)

:obligations (
  !o1 (?e1 obligates (^you be.v empathetic.a))
)

)) ; END defparameter *say-when-have-pain*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'say-when-have-pain.v '*say-when-have-pain*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*say-when-have-pain* 'semantics) (make-hash-table))
(setf (get '*say-when-have-pain* 'gist-clauses) (make-hash-table))
(setf (get '*say-when-have-pain* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*say-when-have-pain*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*say-when-have-pain*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*say-when-have-pain*))
  '()
) ; END mapcar #'store-topic-keys
