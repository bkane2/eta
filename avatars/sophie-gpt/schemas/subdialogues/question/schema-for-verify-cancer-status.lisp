;; *verify-cancer-status*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *verify-cancer-status*

'(event-schema :header (((set-of ^me ^you) verify-cancer-status.v) ** ?e)
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
)

:preconds (
  ; The user doesn't think Sophie's cancer has gotten worse
  ?p1 (^you ((pres do.aux-s) not (think.v (tht (((^me 's) cancer.n) ((pres perf) (got.v worse.a)))))))
)

:goals (
  ; Sophie wants to know more about her condition
  ?g1 (^me ((pres want.v) (to (know.v more.a (about.p-arg ((^me 's) condition.n))))))
  ; Sophie wants to confirm that the user does not think her cancer has gotten worse
  ?g2 (^me ((pres want.v) (to (confirm.v (that (^you ((pres do.aux-s) not (think.v
        (tht (((^me 's) cancer.n) ((pres perf) (got.v worse.a))))))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Are you sure the cancer has not gotten worse ?))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *verify-cancer-status*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'verify-cancer-status.v '*verify-cancer-status*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*verify-cancer-status* 'semantics) (make-hash-table))
(setf (get '*verify-cancer-status* 'gist-clauses) (make-hash-table))
(setf (get '*verify-cancer-status* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*verify-cancer-status*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*verify-cancer-status*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*verify-cancer-status*))
  '()
) ; END mapcar #'store-topic-keys
