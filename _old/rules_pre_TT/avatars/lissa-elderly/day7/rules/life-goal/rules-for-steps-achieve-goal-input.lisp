;; NOTE: Proposed new gist clause: "(0 step that I have taken to achieve my goal 0)"
;; New tag: steps-achieve-goal

;; 	What steps have you taken to achive this goal?
;; (0 step that I have taken to achieve my goal 0)
;; steps-achieve-goal
;; (What steps have you taken to achieve your goal ?)
;; (3 What steps 4 achieve your goal 3) 


;; MEETING WITH KIM NOTES (8/4/2017)

;; New question prompt: "What steps have you taken to achieve this goal?"

;; See doctor
;; Support group
;; Take medicine / meds
;; Keeping reminders / checking calendar
;; Started an excersize routine
;; Started diet / watched my eating
;; Joining a gym
;; Joining Silver Sneakers (YMCA program)
;; Try to be more diligent
;; Priorities / effort
;; Commitment
;; Decide to do it / Make up my mind to do it

(MAPC 'ATTACHFEAT
'(
  (alt-see see seeing visit visiting go going talk talking appointment appointments)
  (alt-doctor doctor doctors nurse nurses physician physicians)
  (alt-keeping keeping keep checking check looking look writing write watching watch taking take)
  (alt-reminder reminder reminders notes note calendar schedule record records)
  (alt-routine routine routines plan plans procedure procedures pattern patterns schedule schedules method methods system systems)
  (alt-watch watch watching monitor monitoring track tracking record recording check checking decrease decreasing)
  (alt-eating eat eating food calories sugar intake consumption)
  (alt-diligence diligence diligent priorities priority effort commitment committed commitments discipline disciplined)
))
  

(READRULES '*steps-achieve-goal-input*
'(
  ; Questions
  1 (0 what 2 you 0 ?)
      2 (What steps have I taken to achieve my goal ?) (0 :gist)
  1 (0 how 2 you 0 ?)
      2 (What steps have I taken to achieve my goal ?) (0 :gist)

  ; Specific answers
  1 (0 alt-see 2 alt-doctor 0)
    2 ((A step that you have taken to achieve your goal is seeing a doctor \.) (Steps-achieve-goal)) (0 :gist)
  1 (0 support group 0)
    2 ((A step that you have taken to achieve your goal is going to a support group \.) (Steps-achieve-goal)) (0 :gist)
  1 (0 alt-taking 2 alt-pills 0)
    2 ((A step that you have taken to achieve your goal is taking medicine \.) (Steps-achieve-goal)) (0 :gist)
  1 (0 alt-keeping 2 alt-reminder 0)
    2 ((A step that you have taken to achieve your goal is keeping reminders \.) (Steps-achieve-goal)) (0 :gist)
  1 (0 alt-exercise 2 alt-routine 0)
    2 ((A step that you have taken to achieve your goal is starting an exercise routine \.) (Steps-achieve-goal)) (0 :gist)
  1 (0 exercise-types-two exercise-types-two 0)
    2 ((A step that you have taken to achieve your goal is getting more exercise by 2 3 \.) (Steps-achieve-goal)) (0 :gist)
  1 (0 exercise-types 0)
    2 ((A step that you have taken to achieve your goal is getting more exercise by 2 \.) (Steps-achieve-goal)) (0 :gist)
  1 (0 alt-diet 0)
    2 ((A step that you have taken to achieve your goal is going on a diet \.) (Steps-achieve-goal)) (0 :gist)
  1 (0 alt-watch 2 alt-eating 0)
    2 ((A step that you have taken to achieve your goal is going on a diet \.) (Steps-achieve-goal)) (0 :gist)
  1 (0 alt-weight 1 alt-change 0)
    2 ((A step that you have taken to achieve your goal is changing your weight \.) (Steps-achieve-goal)) (0 :gist)
  1 (0 alt-change 2 alt-weight 0)
    2 ((A step that you have taken to achieve your goal is changing your weight \.) (Steps-achieve-goal)) (0 :gist)
  1 (0 alt-diligence 0)
    2 ((A step that you have taken to achieve your goal is being more diligent \.) (Steps-achieve-goal)) (0 :gist)
  1 (0 working harder 0)
    2 ((A step that you have taken to achieve your goal is being more diligent \.) (Steps-achieve-goal)) (0 :gist)
  1 (0 make up 1 mind 0)
    2 ((A step that you have taken to achieve your goal is making up your mind \.) (Steps-achieve-goal)) (0 :gist)
  1 (0 set my mind 0)
    2 ((A step that you have taken to achieve your goal is making up your mind \.) (Steps-achieve-goal)) (0 :gist)
  1 (0 decide 2 do 0)
    2 ((A step that you have taken to achieve your goal is making up your mind \.) (Steps-achieve-goal)) (0 :gist)

  1 (0)
    2 ((NIL gist \: Nothing found for step that you have taken to achieve your goal \.) (Steps-achieve-goal)) (0 :gist)
))


(READRULES '*reaction-to-steps-achieve-goal-input*
'( 
  1 (0 seeing a doctor 0)
    2 (Seeing your doctor frequently is an important step\! They can help you with things you may not know about yourself\.) (100 :out)
  1 (0 going to a support group 0)
    2 (Support groups are great\. They help you with your problems while at the same time making you feel welcome and connected\.) (100 :out)
  1 (0 taking medicine 0)
    2 (It\'s good to remember your medicine without missing a day\. Otherwise you might get bad symptoms\.) (100 :out)
  1 (0 keeping reminders 0)
    2 (Reminders are a good way to keep track of important things in life\. Personally\, I use a calendar app on my phone to keep track of important dates\!) (100 :out)
  1 (0  starting an exercise routine 0)
    2 (It\'s great that you found the motivation to get regular exercise\! I am sure it will start paying off soon\.) (100 :out)
  1 (0 getting more exercise by exercise-types-two exercise-types-two 0)
    2 (It\'s great that you found the motivation to get regular exercise\! I am sure it will start paying off soon\.) (100 :out)
  1 (0 getting more exercise by exercise-types 0)
    2 (It\'s great that you found the motivation to get regular exercise\! I am sure it will start paying off soon\.) (100 :out)
  1 (0 going on a diet 0)
    2 (It\'s great that you found the motivation to go on a diet\! I am sure it will start paying off soon\.) (100 :out)
  1 (0 changing your weight 0)
    2 (Working on keeping a healthy weight is an important step to being generally healthy\. Plus\, it makes you feel better about yourself\!) (100 :out)
  1 (0 being more diligent 0)
    2 (Diligence and hard work are necessary when trying to change yourself for the better\.) (100 :out)
  1 (0 making up your mind 0)
    2 (Sometimes putting your mind to something and deciding to just do it is the most important step in achieving your goal\.) (100 :out)

  1 (0 NIL gist 0)
    2 (Sometimes the most important parts of achieving your health goals are to have a solid plan\, to be dedicated\, and to just set your mind to it\.) (100 :out)
))
