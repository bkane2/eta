;; *discuss-activities*: development version 5 (UNDER CONSTRUCTION)
;;
;; After defining *discuss-activities*, we create a hash table 
;;       *output-semantics* 
;; containing interpretations of Lissa outputs, under hash keys 
;; like (*discuss-activities* ?e1). The main goal is to be able later
;; to match certain user inputs to question interpretations, to
;; see if the inputs already answer the questions, making them
;; redundant.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *discuss-activities*

'(event-schema :header (((set-of ^me ^you) discuss-activities.v) ** ?e)
;````````````````````````````````````````````````````````````````````````````
; LISSA introduces herself, sets the scene, asks about the user's 
; major, responds to the user's reply, and starts the "Rochester"
; part of the dialog.

:types (
      !t1 (^me person.n)
      !t2 (^you person.n)
)

:rigid-conds (
)

:static-conds (
      ; Lissa used to play tennis
      ?s1 (Lissa used to play tennis \.)
      ; Lissa can't play tennis currently because of an injured back
      ?s2 (Lissa can\'t play tennis currently because of an injured back \.)
      ; Lissa likes to read
      ?s3 (Lissa likes to read \.)
      ; Lissa likes the library near her
      ?s4 (Lissa likes the library near her \.)
)

:preconds (
      ; Lissa doesn't know the user's hobbies
      ?p1 (Lissa doesn\'t know the other person\'s hobbies \.)
)

:goals (
      ; Lissa wants to know about the user's hobbies
      ?g1 (Lissa wants to know about the other person\'s hobbies \.)
)

:episodes (

?e1 (^me paraphrase-to.v ^you '(Do you have any hobbies or anything in particular you like to do for fun ?))
 
?e2 (^you reply-to.v ?e1)

?e3 (^me paraphrase-to.v ^you '(I used to play tennis\, but can\'t anymore \.))

?e4 (^me paraphrase-to.v ^you '(I love to read \. Do you like to read ?))

?e5 (^you reply-to.v ?e4)

; This is better off being a reaction
?e6 (^me paraphrase-to.v ^you '(What kind of things you like to read ?))

?e7 (^you reply-to.v ?e6)

?e8 (^me paraphrase-to.v ^you '(How do you spend your days ?))

?e9 (^you reply-to.v ?e8)

?e10 (^me paraphrase-to.v ^you '(What kind of things do you like to do in your neighborhood ?))

?e11 (^you reply-to.v ?e10)

)

)) ; END defparameter *discuss-activities*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'discuss-activities.v '*discuss-activities*)



;````````````````````````````````````````````````````````
; Create empty hash tables for semantics,
; gist-clauses, and topic-keys
;
(setf (get '*discuss-activities* 'semantics) (make-hash-table))
(setf (get '*discuss-activities* 'gist-clauses) (make-hash-table))
(setf (get '*discuss-activities* 'topic-keys) (make-hash-table))



;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*discuss-activities*))
  '()
) ; END mapcar #'store-output-semantics



;````````````````````````````````````````````````````````
; Gist clauses
;
(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*discuss-activities*))
  '()
) ; END mapcar #'store-output-gist-clauses



;````````````````````````````````````````````````````````
; Topic keys
;
(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*discuss-activities*))
  '()
) ; END mapcar #'store-topic-keys
