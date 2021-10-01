(MAPC 'ATTACHFEAT
  '(
    (structure concept)
    (bigger larger taller wider longer)
    (smaller shorter narrower)
   ))


(READRULES '*clause-inference-tree*
; TODO: It seems that the ungainly 'spatial-question' in the gist clause here can
; now be removed, since we can resolve such a gist clause to an ask-question.v action,
; adding an appropriate conditional in the tutoring/QA schemas.
  '(
    1 (spatial-question 0)
      2 (^you ask-question.v) (0 :ulf)
    1 (Goodbye 0)
      2 (^you say-bye.v) (0 :ulf)
    1 (Pause for 1 moment 0)
      2 (^you ask-to-pause.v) (0 :ulf)
    1 (1 I make 1 correct move 1)
      2 (^you verify-correctness.v) (0 :ulf)
    1 (1 I understand 1 concept 1)
      2 (^you say-yes.v) (0 :ulf)
    1 (0 I do not 2 make 1 bigger example of 1 structure 1)
      2 (^you say-no.v) (0 :ulf)
    1 (0 I 2 make 1 bigger example of 1 structure 0)
      2 (^you ask-to-make-structure-bigger.v) (0 :ulf)
    1 (0 I 2 make 1 smaller example of 1 structure 0)
      2 (^you ask-to-make-structure-smaller.v) (0 :ulf)
))