;; *say-pain-location*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-pain-location*

'(event-schema :header (((set-of ^me ^you) say-pain-location.v) ** ?e)
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
  ; Sophie has pain in the left side of her chest.
  ?s2 (^me ((pres have.v) (k (n+preds pain.n (in.p (left.a side.n (of.p ((^me 's) chest.n))))))))
  ; Sophie has pain in the middle of her back.
  ?s3 (^me ((pres have.v) (k (n+preds pain.n (in.p (middle.a side.n (of.p ((^me 's) back.n))))))))

  ; Sophie is taking Lortab for her pain
  ?s4 (^me ((pres take.v) (k |Lortab|.n) (adv-a (for.p ((^me 's) pain.n)))))
)

:preconds (
  ; Sophie's pain has recently spread to her shoulder blade.
  ?p1 (((^me 's) pain.n) ((pres perf) recently.adv-e ((prog spread.v) (to.p ((^me 's) (k (shoulder.n blade.n)))))))
)

:goals (
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I have pain in the left side of my chest and the middle of my back \, and the pain has recently spread to my shoulder blade \.))
 
?e2 (^you reply-to.v ?e1)

)

:obligations (
  !o1 (?e1 obligates (^you be.v empathetic.a))
)

)) ; END defparameter *say-pain-location*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'say-pain-location.v '*say-pain-location*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*say-pain-location* 'semantics) (make-hash-table))
(setf (get '*say-pain-location* 'gist-clauses) (make-hash-table))
(setf (get '*say-pain-location* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*say-pain-location*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*say-pain-location*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*say-pain-location*))
  '()
) ; END mapcar #'store-topic-keys
