;; *react-emotionally*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *react-emotionally*

'(event-schema :header (((set-of ^me ^you) react-emotionally.v) ** ?e)
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
  ; Sophie's cancer has spread
  ?s3 (((^me 's) cancer.n) ((pres perf) spread.v))
)

:preconds (
  ; The user just told Sophie bad news about her condition
  ?p1 (^you just.adv-e ((past tell.v) ^me (bad.a news.n) (adv-a (about.p ((^me 's) condition.n)))))
  ; Sophie is extremely upset and emotional
  ?p2 (^me ((pres be.v) ((extremely.mod-a upset.a) and.cc emotional.a)))
)

:goals (
)

:episodes (

?e1 (^me say-to.v ^you ?words)
 
?e2 (^you reply-to.v ?e1)

)

:obligations (
  !o1 (?e1 obligates (^you be.v empathetic.a))
)

)) ; END defparameter *react-emotionally*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'react-emotionally.v '*react-emotionally*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*react-emotionally* 'semantics) (make-hash-table))
(setf (get '*react-emotionally* 'gist-clauses) (make-hash-table))
(setf (get '*react-emotionally* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*react-emotionally*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*react-emotionally*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*react-emotionally*))
  '()
) ; END mapcar #'store-topic-keys
