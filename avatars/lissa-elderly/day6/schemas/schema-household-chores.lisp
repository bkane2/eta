;; *have-household-chores-dialog*: development version 5 (UNDER CONSTRUCTION)
;;
;; After defining *have-household-chores-dialog*, we create a hash table 
;;       *output-semantics* 
;; containing interpretations of Lissa outputs, under hash keys 
;; like (*have-household-chores-dialog* ?e1). The main goal is to be able later
;; to match certain user inputs to question interpretations, to
;; see if the inputs already answer the questions, making them
;; redundant.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *have-household-chores-dialog*

'(event-schema :header (((set-of ^me ^you) have-household-chores-dialog.v) ** ?e)
;`````````````````````````````````````````````````````````````````````````````````
; LISSA introduces herself, sets the scene, asks about the user's 
; major, responds to the user's reply, and starts the "Rochester"
; part of the dialog.

; In future, I expect something closer to the following for the
; initial LISSA dialog schema; the acions would be matched and 
; elaborated into text by a language generator:
;  (^me explain-to.v ^you ((nnp lissa) ((nn dialog) framework.n)))
;  (^me tell.v ^you (my academic-major.n))
;  (^me ask.v ^you (id-of (your academic-major.n)))
;  ...
; But since the eventual EL representation allows for quoting, 
; we can make life easy for ourselves at first.

; I'm not sure if the speech generator makes use of upper-/lower-case
; distinctions. If so, we'll eventually have to use character-string
; output here, and a tokenizer that changes this to special Lisp atoms
; like |Hi| I |am| |Lissa|, ... (Using ~a rather than ~s in format
; statements will output such atoms without the escape characters.)
; Note: Lisp atoms with an internal or final '.' are ok, but commas
; and semicolons are not allowed without a preceding '\' or in a |...|
; context.

:episodes ( ; we start execution at this keyword
         ; (I've omitted other schema components for the time being.)
         ; Lissa's lengthy initial utterance may eventually be broken into
         ; a few higher-level (nonprimitive) actions such as introducing
         ; herself, the purpose and structure of the dialog, and the 
         ; explanation of the icons, with each nonprimitive action broken 
         ; down in turn into a number of (primitive) saying-acts.
?e1 (^me say-to.v ^you 
      '(I would like to begin our today\'s chat by talking about housework\.
	   What household chores did you work on today or yesterday?))

?e2 (^you reply-to.v ?e1)   ; This is a nonprimitive action by the user, to be
                             ; elaborated by creation of an action description
                             ; subordinate to '?e4' (or rather, to a new action-
                             ; proposition name Gensym'd for ?e4'), followed by
                             ; a (READWORDS) call that obtains the user input,
                             ; insertion of a wff of type (^you say-to.v ^me '(...))
                             ; as the content of the subordinate action description,
                             ; and "interpretation" (expansion) of the input, where
                             ; this interpretation consists of a list of clauses
                             ; attached (as 'interpretation') to the new subordinate
                             ; action description, the first clause being the main
                             ; content (answer to Lissa's question), and the rest
                             ; being any potentially useful supplementary pieces
                             ; of information extracted from the input.

     ; At this point we want to allow for selection and insertion of 
     ; a subdialog (usually just a 1-utterance reaction, if any) that is
     ; appropriate for the user's reply, viewed as an answer to question
     ; ?e3 We branch to the right choice tree by use of the "gist clause"
     ; of the question the user has just replied to -- here '(What is your
     ; major ?)', as per ?e3 (which is referenced in ?e4).

?e4 (^me react-to.v ?e2); react to the "gist" of the user's input

     ; This may be particularized to a response of type '(^me say-to.v ^you '...).
     ; But we don't want to discard the original action specification; so it
     ; seems we want to have a link from (the name introduced for) '?e5' to
     ; its particularization as '(^me say-to.v ^you '...) and possibly further
     ; actions -- a subplan. [WHAT ABOUT INTERLEAVING OF MULTIPLE PLANS
     ; AIMED AT DIFFERENT GOALS?]

?e5 (^me say-to.v ^you '(Most of us like some chores more than others\. What\’s the chore you enjoy the most?))

?e6 (^you reply-to.v ?e5) ; again leads to a (READWORDS) call, and 
                         ; formation of a subordinate 
                         ; (^you say-to.v ^me '(...)) plan
?e8 (^me react-to.v ?e6)

?e9 (^me say-to.v ^you '(Tell me about a time you helped someone else with a chore\. How did it make you feel?))


?e10 (^you reply-to.v ?e9) 
?e11 (^me react-to.v ?e10)


?e13 (^me say-to.v ^you
      '(lets pause here so i can give you feedback))
))); end of defparameter *have-household-chores-dialog*



;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'have-household-chores-dialog.v
                  '*have-household-chores-dialog*)



(setf (get '*have-household-chores-dialog* 'semantics) (make-hash-table))
 ; EL formulas (not yet used)



(mapcar #'(lambda (x) 
           (store-output-semantics (first x) (second x) '*have-household-chores-dialog*))
;``````````````````````````````````````````````````````````````````````
; There seem to be two alternative ways of supplying semantics for
; Lissa's outputs. The first is to assume that our dialog schema
; supplies English outputs directly via quotation, as is currently
; done. The second is to assume that dialog schemas in general
; specify what to do as logical formulas -- which are then rendered
; into verbal output via schemas, world knowledge, and knowledge
; of English (esp. structuring knowledge for output, and surface
; generation). In the latter case, the plan itself already supplies
; the semantics of what is to be said, and which is used as basis
; for generating output. 
;
; Since the current method is the former one, here is an attempt 
; to supply meaning representations for the steps. 
;
; [But even that is rather premature -- for interpreting a user input
; in light of a prior Lissa output, we're currently assuming that the
; "interpretations" of the outputs are just English "gist" clauses,
; plus perhaps additional clauses (as word lists). For example, 
; ?e3below ends with "how about you?", so a suitable gist clause
; would be (What is your major ?), which is quite adequate for 
; guiding the pattern matching in "interpreting" the user's reply
; (such as "I'm in physics", yielding (I am a physics major)). So
; we also specify ]
;
 '((?e1 ; Hi I am LISSA. I am an autonomous avatar ... etc.
         (^me explain-to.v ^you (ans-to (wh ?x ((we do.v ?x) @ ?e)))))
   (?e2 ; Alright, let's get to know each other more
         (^me suggest-to.v ^you (that ((we (become.v acquainted.a)) @ ?e))))
   (?e3 ; I am a senior comp sci major, how about you?
         ((^me tell.v ^you
           (that 
             ((^me (be.v (nn (nn computer.n science.n) major.n))) @ Now)))
          and (^me ask.v ^you 
                  (ans-to (wh ?x ((^you (have-as.v major.n) ?x) @ Now))))))
   (?e7 ; What was your favourite class so far?
         (^me ask.v ^you 
            (ans-to (wh ?x ((^you have-as.v (favourite.a class.n) ?x) @ Now)))))
   (?e11 ; Did you find it hard?
          (^me ask.v ^you
            (whether (the ?x ((^you have-as.v (favourite.a class.n) ?x) @ Now)
                             (^you (find.v hard.a) @ (time-of.f ?x))))))
                             ; ^^^^THIS INFO MAY HAVE BEEN SUPPLIED ALREADY
   (?e15 ; I liked Artificial Intelligence! that was my favourite by far!
          (^me tell.v ^you
             (that (the ?x (?x (nn AI.n class.n))
                           (((^me like.v ?x) @ (time-of.f ?x)) and
                            (^me have-as.v 
                              ((by-far.adv favourite.a) class.n) ?x))))))
   ; I'm skipping ahead to questions that may become redundant because
   ; the user may have answered them already.
   (?e24 ; And what do you not like about it?
          (^me ask.v ^you
            (ans-to (wh ?x ((Rochester.name have-as.s property.n ?x) and
                            (^you dislike.v 
                              (that (Rochester.name have-as.s property.n
                                                                 ?x))))))))
                    ; ^^^^THIS INFO MAY HAVE BEEN SUPPLIED ALREADY
   (?e43 ; have you been to Dinosaur Barbecue?
          (^me ask.v ^you
             (whether (some ?e (?e before Now)
                               ((^you (be.v (at-loc.p Dinosaur_Barbecue))) ** ?e)))))
                                ; ^^^^THIS INFO MAY HAVE BEEN SUPPLIED ALREADY
 )); end of mapcar #'store-output-semantics


(setf (get '*have-household-chores-dialog* 'gist-clauses) (make-hash-table))



(mapcar #'(lambda (x) 
           (store-output-gist-clauses (first x) (second x) '*have-household-chores-dialog*))
;``````````````````````````````````````````````````````````````````````````
; Use of the logical formulas provided via 'store-output-semantics' 
; above is beyond the current methodology.
;
; So here we instead supply information of type
;      (<gist clause1> <gist clause2> <gist clause3> ...)
; where any question gist clause is assumed to come last (as is
; normal in dialogue), and will provide the main context for interpreting
; the next user input.
;
 '((?e1 ; What household chores did you work on today or yesterday?
          ((What household chores did you work on today ?)))
   (?e5 ; What’s the chore you enjoy the most?
          ((What is the household chore you enjoy the most ?)))
   (?e9 ; Tell me about a time you helped someone else with a chore. How did it make you feel? 
          ((How did you feel a time you helped someone else with a household chore ?)))
   (?e13 ; Let\’s pause here so I can give you feedback.
          ((lets pause for a feedback \.)))
 )); end of mapcar #'store-output-gist-clauses


(setf (get '*have-household-chores-dialog* 'topic-keys) (make-hash-table))



(mapcar #'(lambda (x) 
           (store-topic-keys (first x) (second x) '*have-household-chores-dialog*))
;``````````````````````````````````````````````````````````````````
; The topic keys are currently needed in order to recognize cases 
; where a previous user input with the same topic keys as a question
; about to be asked by Lissa has already been answered (so that
; Lissa should refrain from answering the question).
;
; NOTE: For multiple-sentence outputs by Lissa, if they include a
;       question, the gist version of the question is assumed to
;       always come last. Thus it is unambiguous as to which gist
;       clause falls under the stored topic-keys. (For now, topic
;       keys are stored only for questions, not assertions by Lissa.)
;
 '((?e1 ; What household chores did you work on today?
          (householdChores-today))
   (?e5 ; What is the household chore you enjoy the most?
          (householdChore-enjoy))
   (?e9 ; How did it make you feel a time you helped someone else with a household chore?
          (householdChore-help-others))
   )); end of mapcar
