;; *say-appreciate-doctor-words*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *say-appreciate-doctor-words*

'(event-schema :header (((set-of ^me ^you) say-appreciate-doctor-words.v) ** ?e)
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
  ; Sophie appreciates the doctor's admiration.
  ?p1 (^me (pres appreciate.v) ((^you 's) admiration.n))
  ; Sophie would prefer not having cancer to the doctor's admiration.
  ?p2 (^me (pres prefer.v) (to (not ((pres perf) cancer.n) ({over}.p-args ((^you 's) admiration.n) ))))
)

:goals (
 

)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I am glad that you think I am handling my illness well\, but I would prefer not to have it at all \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *say-appreciate-doctor-words*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'say-appreciate-doctor-words.v '*say-appreciate-doctor-words*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*say-appreciate-doctor-words* 'semantics) (make-hash-table))
(setf (get '*say-appreciate-doctor-words* 'gist-clauses) (make-hash-table))
(setf (get '*say-appreciate-doctor-words* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*say-appreciate-doctor-words*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*say-appreciate-doctor-words*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*say-appreciate-doctor-words*))
  '()
) ; END mapcar #'store-topic-keys
