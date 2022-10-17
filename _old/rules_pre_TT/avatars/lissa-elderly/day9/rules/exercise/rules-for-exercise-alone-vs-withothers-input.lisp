;; 	Do you like to exercise on your own or with other people?  
;;	(0 I like to exercise alone 0)  ;; one can extend the gist clause by adding some reason and make the appropriate reaction
;;	(0 I like to exercise with other people 0)
;;	exercise-alone-vs-withothers
;;	(Do you like to exercise alone or with other people ?) 
;;	(3 Do you like 2 exercise alone or with other people 3) 


;; I don't like either
;; Response: "If your doctor strongly recommended you exercise, would you prefer doing it alone or with others?"

(MAPC 'ATTACHFEAT
'(
  (alt-focus focus concentrate concentration motivate motivated motivating)
  (alt-distracted distracted distracting annoying annoy annoyed)
  (alt-alone alone myself own)
  (alt-judge judge judgement judging embarrass embarrassing conscious shy)
  (alt-fun fun exciting engaging social entertaining)
  (alt-others others other friend friends group groups team class)
))


(READRULES '*exercise-alone-vs-withothers-input*
'(
  ; Questions
  1 (0 what 2 you 0 ?)
      2 (Do I like to exercise alone or with other people ?) (0 :gist)
  1 (0 how 2 you 0 ?)
      2 (Do I like to exercise alone or with other people ?) (0 :gist)

  ; Specific answers
  1 (0 alt-alone 4 alt-focus 0)
    2 ((You like to exercise alone because it helps you focus better \.) (Exercise-alone-vs-withothers)) (0 :gist)
  1 (0 alt-alone 4 NEG 1 alt-distracted 0)
    2 ((You like to exercise alone because it helps you focus better \.) (Exercise-alone-vs-withothers)) (0 :gist)
  1 (0 alt-alone 4 alt-judge 0)
    2 ((You like to exercise alone because you feel self conscious \.) (Exercise-alone-vs-withothers)) (0 :gist)
  1 (0 alt-others 4 alt-fun 0)
    2 ((You like to exercise with other people because it is more fun \.) (Exercise-alone-vs-withothers)) (0 :gist)
  1 (0 alt-others 4 alt-focus 0)
    2 ((You like to exercise with other people because it helps you focus better \.) (Exercise-alone-vs-withothers)) (0 :gist)
  1 (0 alt-others 4 NEG 1 alt-distracted 0)
    2 ((You like to exercise with other people because it helps you focus better \.) (Exercise-alone-vs-withothers)) (0 :gist)
  1 (0 alt-alone 0)
    2 ((You like to exercise alone \.) (Exercise-alone-vs-withothers)) (0 :gist)
  1 (0 alt-others 0)
    2 ((You like to exercise with other people \.) (Exercise-alone-vs-withothers)) (0 :gist)

  1 (0)
    2 ((NIL gist \: Nothing found for if you like to exercise alone \.) (Exercise-alone-vs-withothers)) (0 :gist)
))


(READRULES '*reaction-to-exercise-alone-vs-withothers-input*
'( 
  1 (0 helps you focus 0)
    2 (I understand\, sometimes talking with people while exercising can be a big interruption\.) (100 :out)
  1 (0 feel self conscious 0)
    2 (Many people feel shy when exercising\! People usually don\'t judge you as much as you think they do though\.) (100 :out)
  1 (0 helps you focus 0)
    2 (Having others to motivate you certainly does make a difference\!) (100 :out)
  1 (0 is more fun 0)
    2 (Exercising with other people does help make it feel a lot less boring\.) (100 :out)
  1 (0 like to exercise alone 0)
    2 (Exercising alone is understandable\, sometimes being in a group can be very distracting\.) (100 :out)
  1 (0 like to exercise with other people 0)
    2 (Exercising with others is a great way to be social as well as get fit\.) (100 :out)

  1 (0 NIL gist 0)
    2 (Everyone has their own preferences when it comes to exercising\. Either way is fine as long as you have some way to get yourself excited for it\!) (100 :out)
))
