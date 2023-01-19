;; *say-reason-cancer-worse*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-reason-cancer-worse*

'(event-schema :header (((set-of ^me ^you) say-reason-cancer-worse.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````````

:goals (
  ; Sophie wants the user to know why she believes her cancer has become worse
  ?g1 (^me ((pres want.v) ^you (to (know.v (ans-to (sub why.pq
        (^me ((pres believe.v) (tht (((^me 's) cancer.n) ((pres perf)
          (become.v worse.a ({because}.ps *h)))))))))))))
)

:preconds (
  ; Sophie believes her cancer has become worse because her pain has been becoming worse
  ?p1 (^me ((pres believe.v) (tht (((^me 's) cancer.n) ((pres perf) (become.v worse.a
        (because.ps (((^me 's) pain.n) ((pres perf) ((prog become.v) worse.a))))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I believe my cancer has gotten worse because my pain has also gotten worse \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *say-reason-cancer-worse*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'say-reason-cancer-worse.v '*say-reason-cancer-worse*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*say-reason-cancer-worse* 'semantics) (make-hash-table))
(setf (get '*say-reason-cancer-worse* 'gist-clauses) (make-hash-table))
(setf (get '*say-reason-cancer-worse* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*say-reason-cancer-worse*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*say-reason-cancer-worse*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*say-reason-cancer-worse*))
  '()
) ; END mapcar #'store-topic-keys
