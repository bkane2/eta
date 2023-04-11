;; *demonstrate-interest-in-reviewing-condition*: development version 6
;;
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *demonstrate-interest-in-reviewing-condition*

'(event-schema :header (((set-of ^me ^you) demonstrate-interest-in-reviewing-condition.v) ** ?e)
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
    ;; Sophie thinks a review would be helpful for her understanding.
    ?p1 (^me ((pres think.v) (that ((a.d. review.n) (pres be.v) helpful.n (adv-a ({for}.p ((^me 's) understanding.n)))))))
   
)

:goals (
 ; Sophie wants the doctor to know she doesn't want chemotherapy.
  ?g1 (^me ((pres want.v) (^you (to (know.v (that ((a.d. review.n) (pres be.v) helpful.n (adv-a ({for}.p ((^me 's) understanding.n))))))))))
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(I think that a review of my medical situation would help with my understanding \.))
 
?e2 (^you reply-to.v ?e1)

)

)) ; END defparameter *demonstrate-interest-in-reviewing-condition*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'demonstrate-interest-in-reviewing-condition.v '*demonstrate-interest-in-reviewing-condition*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*demonstrate-interest-in-reviewing-condition* 'semantics) (make-hash-table))
(setf (get '*demonstrate-interest-in-reviewing-condition* 'gist-clauses) (make-hash-table))
(setf (get '*demonstrate-interest-in-reviewing-condition* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*demonstrate-interest-in-reviewing-condition*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*demonstrate-interest-in-reviewing-condition*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*demonstrate-interest-in-reviewing-condition*))
  '()
) ; END mapcar #'store-topic-keys
