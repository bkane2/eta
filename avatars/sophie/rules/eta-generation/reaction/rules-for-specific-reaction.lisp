; The rules defined in this file contain reactions to specific gist-clauses of user statements (reactions to
; questions are defined in rules-for-question-reaction.lisp).
; All trees defined in this file should be named using format *<topic-key>-reaction*.
;
; Current list of topics:
; - cancer-worse
; - medical-history
; - medicine-side-effects
; - appointment
; - chemotherapy-details
; - diagnosis-details
; - energy
; - medicine
; - pain
; - radiation
; - sleep
; - chemotherapy
; - comfort-care
; - medicine-request
; - medicine-working
; - prognosis
; - sleep-poorly
; - tell-family
; - test-results
; - treatment-option
(READRULES '*cancer-worse-reaction*
; (0 cancer 2 gotten worse 0)
'(
  1 (my cancer has gotten worse \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (my cancer has not gotten worse \.)
    2 *verify-cancer-status* (100 :schema)
    2 ([HAPPY] okay \. Well \, that makes me feel a little bit better \.) (0 :out)
  1 (you are not sure whether my cancer has gotten worse \.)
    2 ([SAD] that\'s not very reassuring \.) (0 :out)
  1 (0)
    2 (I see \.) (0 :out)
)) ; END *cancer-worse-reaction*


(READRULES '*medical-history-reaction*
; (0 congratulations 0)
'(
  1 (0 .CONGRATULATIONS 0)
    2 (Well \, truth be told \, I simply lost my taste for it \. But \, I appreciate your congratulations all the same \.) (0 :out)
)) ; END *medical-history-reaction*


(READRULES '*medicine-side-effects-reaction*
; (0 side effect 3 medication 0)
'(
  1 (addiction is not a side .EFFECT of the medication \.)
    2 *ask-for-stronger-pain-medication* (100 :schema)
    2 (I didn\'t know that \. It\'s good to know that stronger pain medication is an option without risking addiction \.) (0 :out)
  1 (a side .EFFECT of the medication .BE 2 .SIDE-EFFECTS-SIGNIFICANT 2 \.)
    2 (I don\'t want to risk any issues with 8 9 10 \. I think I should hold off for now and think about it more \.) (0 :out)
  1 (a side .EFFECT of the medication .BE 2 .SIDE-EFFECTS-MODERATE 2 \.)
    2 *ask-for-stronger-pain-medication* (100 :schema)
    2 (I think I should try the medicine and see if I have problems with 8 9 10 \.) (0 :out)
  1 (a side .EFFECT of the medication .BE 2 .SIDE-EFFECTS-INSIGNIFICANT 2 \.)
    2 *ask-for-stronger-pain-medication* (100 :schema)
    2 (I already have 8 9 10 \, so I think the new medicine is worth a try \.) (0 :out)
  1 (0)
    2 *ask-for-stronger-pain-medication* (100 :schema)
    2 (I think it\'s worth giving it a try \.) (0 :out)
)) ; END *medicine-side-effects-reaction*


(READRULES '*appointment-reaction*
'(
)) ; END *appointment-reaction*


(READRULES '*chemotherapy-details-reaction*
; (0 chemotherapy details 0 \.)
; (0 side effect 0 chemotherapy 0 \.)
; (0 way 1 to get 2 chemotherapy 0 \.)
'(
  1 (.ONE way to get .CHEMOTHERAPY is 0)
    2 (0 .TWO .CHEMOTHERAPY 0)
      3 (I didn\'t know that was possible \. But it makes sense \.) (0 :out)
    2 (If I do chemotherapy \, I would prefer a port or iv \. I don\'t like needles \.) (0 :out)
  1 (a side .EFFECT of .CHEMOTHERAPY is 6 \.)
    2 *ask-how-chemotherapy-works* (100 :schema)
    2 (I see \. I think it might be worth giving it a try \.) (0 :out)
  1 (0)
    2 (Ah \, I see \. I\'ll have to read more about chemotherapy \.) (100 :out)
    2 (Good to know \. I\'ll look into chemotherapy a bit further with my daughter later \.) (0 :out)
)) ; END *chemotherapy-details-reaction*


(READRULES '*diagnosis-details-reaction*
'(
)) ; END *diagnosis-details-reaction*


(READRULES '*energy-reaction*
; (0 energy 0 \.)
; (0 ment-treatment 0)
'(
  1 (you .CAN .GIVE me an .ANTIDEPRESSANT \.)
    2 *ask-about-antidepressant* (100 :schema)
    2 (Okay \. I\'ll give the antidepressant medication a shot \.) (0 :out)
  1 (I .SHOULD .TAKE an .ANTIDEPRESSANT \.)
    2 *ask-about-antidepressant* (100 :schema)
    2 (Okay \. I\'ll give the antidepressant medication a shot \.) (0 :out)
  1 (I .SHOULD see a therapist \.)
    2 *ask-about-medication-before-therapy* (100 :schema)
    2 (Okay \. I\'ll give the therapy a shot \.) (0 :out)
  1 (I am sorry you .HAVE been .FEELING down .RECENTLY \.)
    2 *mention-anxiety* (100 :schema)
    2 (Thank you for the kind words \. They mean a lot to me right now \. I think that things will get better though as I spend more time around my family \. Especially my sweet grandson \.) (0 :gist)
)) ; END *energy-reaction*


(READRULES '*medicine-reaction*
; (0 stronger pain medication 0 help me sleep 0)
'(
  ;; 1 (0 you will give me more medicine 0)
  ;;   2 (Great\, thank you !) (0 :out)
  1 (a stronger .PAIN medication will .HELP me .SLEEP \.)
    2 *ask-about-pain-medication-side-effects* (100 :schema)
    2 ([SAD] if I continue to have trouble sleeping \, I might call in for stronger pain medication later \.) (0 :out)
  1 (a stronger .PAIN medication will not .HELP me .SLEEP \.)
    2 ([SAD] I guess it\'s just something i\'ll have to live with \.) (0 :out)
  1 (0)
    2 (I see \.) (0 :out)
)) ; END *medicine-reaction*


(READRULES '*pain-reaction*
; (0 pain 0)
'(
  1 (you are sorry that I am .IN .PAIN 1)
    2 ([SAD] thanks \, I just hope the pain can be treated \.) (0 :out)
)) ; END *pain-reaction*


(READRULES '*radiation-reaction*
; (0 radiation 0)
'(
  1 (0)
    2 *ask-about-will-chemotherapy-help* (0 :schema)
)) ; END *radiation-reaction*


(READRULES '*sleep-reaction*
'(
)) ; END *sleep-reaction*


(READRULES '*chemotherapy-reaction*
; (0 chemotherapy 0 \.)
'(
  1 (you .DO not think I need .CHEMOTHERAPY 0)
    2 (you .DO not think I need .CHEMOTHERAPY .BECAUSE I .SHOULD get comfort .CARE instead \.)
      3 *ask-about-comfort-care* (100 :schema)
      3 (I think holding off on chemotherapy for now makes sense \, given that my priority is just to be comfortable \.) (0 :out)
    2 (I see \. I think it will be best to hold off on chemotherapy \, at least for now \.) (0 :out)
  1 (0)
    2 *ask-about-chemotherapy-side-effects* (100 :schema)
    2 *ask-how-chemotherapy-works* (100 :schema)
    2 (I see \. I think it might be worth giving it a try \.) (0 :out)
)) ; END *chemotherapy-reaction*


(READRULES '*comfort-care-reaction*
; (0 comfort care 0 \.)
'(
  1 (you .DO not think I need comfort .CARE \.)
    2 *confirm-no-comfort-care* (100 :schema)
    2 (Okay \, I see \. I will think about starting chemotherapy right away then \.) (0 :out)
  1 (comfort .CARE .SHOULD alleviate my .PAIN \.)
    2 *ask-how-comfort-care-works* (0 :schema)
  1 (you think I need comfort .CARE \.)
    2 ([HAPPY] great \. I also think comfort care is the best option for me right now \.) (0 :out)
  1 (I would need a .REFERRAL to start comfort .CARE \.)
    2 *ask-about-comfort-care* (0 :schema)
  1 (receiving comfort .CARE .IN a dedicated facility is an .OPTION \.)
    2 *ask-about-comfort-care* (0 :schema)
  1 (receiving comfort .CARE from a specialized service is an .OPTION \.)
    2 *ask-about-comfort-care* (0 :schema)
  1 (receiving comfort .CARE .IN my own .HOME is an .OPTION \.)
    2 *ask-about-comfort-care* (0 :schema)
  1 (receiving comfort .CARE from a .NURSE is an .OPTION \.)
    2 *ask-about-comfort-care* (0 :schema)
  1 (0)
    ; OPPORTUNITY for open-ended question: "Can you tell me a little more about your treatment goals?", "What worries you most for the future?"
    2 ([SAD] [OPPORTUNITY] i\'d like to think some more about starting comfort care \. If i\'m not going to make it \, I want to at least be comfortable and spend time with family for as long as possible \.) (100 :out)
    2 (I think that comfort care is the best option for me right now \.) (0 :out)
)) ; END *comfort-care-reaction*


(READRULES '*medicine-request-reaction*
; (0 stronger 1 medication 0 \.)
; (0 refill 2 medication 0 \.)
; (0 med-narcotic 0 \.)
'(
  1 (I .SHOULD .TAKE 1 .MED-NARCOTIC \.)
    2 *ask-about-narcotic-addiction* (100 :schema)
    2 (I think having the stronger pain medication would help \.) (0 :out)
  1 (I .SHOULD .TAKE stronger .PAIN medication \.)
    2 *ask-about-pain-medication-side-effects* (100 :schema)
    2 (I think having the stronger pain medication would help \.) (0 :out)
  1 (I .CAN .GIVE you stronger .PAIN medication \.)
    2 ([HAPPY] thank you very much \, I hope that will help with the pain \.) (0 :out)
  1 (I cannot .GIVE you stronger .PAIN medication \.)
    2 (I see \. For now i\'ll stick with my current medication \, but will let you know if the pain starts getting worse \.) (0 :out)
  1 (I .CAN .GIVE you a refill of .PAIN medication \.)
    2 ([HAPPY] thanks \, I appreciate it !) (0 :out)
  1 (I cannot .GIVE you a refill of .PAIN medication \.)
    2 ([SAD] okay \. I will try to do without it \, but if the pain gets worse i\'m going to call you back for more pain medication \.) (0 :out)
  1 (0)
    2 (Okay \, I see \.) (0 :out)
)) ; END *medicine-request-reaction*


(READRULES '*medicine-working-reaction*
; (0 medication 4 work 0 \.)
; (0 take 3 different \.)
'(
  1 (I .SHOULD .TAKE something different \.)
    2 *ask-about-pain-medication-side-effects* (0 :schema)
  1 (I .SHOULD .TAKE .MED-NARCOTIC \.)
    2 *ask-about-narcotic-addiction* (100 :schema)
    2 (I think having the stronger pain medication would help \.) (0 :out)
  1 (I .SHOULD .TAKE stronger .PAIN medication \.)
    2 *ask-about-pain-medication-side-effects* (100 :schema)
    2 (I think having the stronger pain medication would help \.) (0 :out)
  1 (I .SHOULD wait to see if the .PAIN medication works \.)
    2 (Okay \, for now i\'ll keep taking the lortab \, and create a follow up appointment if it doesn\'t work after a few weeks \.) (0 :out)
  1 (0)
    2 (I see \.) (0 :out)
)) ; END *medicine-working-reaction*


(READRULES '*prognosis-reaction*
; (0 prognosis 0 \.)
'(
  ; I asked my doctor in Florida about what’s going to happen next, he just did not want to say. 
  ; He said” These things are always hard to predict.” 
  ; OPPORTUNITY: After SOPHIE expresses her fear, the doctor could ask her "What scares you the most about your future?" or "Were you nervous for this appointment?"
  1 (I may live for .NUMBER-PLUR .ELAPSED-TIME-PLUR \.)
    2 *ask-if-can-trust-prognosis* (100 :schema)
    2 ([SAD] [OPPORTUNITY] that\'s very difficult to hear \. I thought I would have more time than that \. At this point \, I just hope I can enjoy those 9 10 with family \, but i\'m afraid of what the future will bring \.) (0 :out)
  1 (the prognosis is that I may live for .NUMBER-TOTAL .ELAPSED-TIME \.)
    2 *ask-if-can-trust-prognosis* (100 :schema)
    2 ([SAD] [OPPORTUNITY] that\'s very difficult to hear \. I thought I would have more time than that \. At this point \, I just hope I can enjoy that 9 10 with family \, but i\'m afraid of what the future will bring \.) (0 :out)
  1 (the prognosis is that I may live for several .ELAPSED-TIME \.)
    2 *ask-about-prognosis* (100 :schema)
    2 *ask-if-can-trust-prognosis* (100 :schema)
    2 ([SAD] [OPPORTUNITY] that\'s very difficult to hear \. I thought I would have more time than that \. At this point \, I just hope I can enjoy those 10 with family \, but i\'m afraid of what the future will bring \.) (0 :out)
  1 (the prognosis is that I .DO not .HAVE .LONG .LEFT to live \.)
    2 *ask-about-prognosis* (100 :schema)
    2 *ask-if-can-trust-prognosis* (100 :schema)
    2 ([SAD] [OPPORTUNITY] that\'s very difficult to hear \. I thought I would have more time than that \. At this point \, I just hope I can enjoy my time left with family \, but i\'m afraid of what the future will bring \.) (0 :out)
  1 (the prognosis is that I may live for a .ELAPSED-TIME \.)
    2 *ask-if-can-trust-prognosis* (100 :schema)
    2 ([SAD] [OPPORTUNITY] that\'s very difficult to hear \. I thought I would have more time than that \. At this point \, I just hope I can enjoy that 10 with family \, but i\'m afraid of what the future will bring \.) (0 :out)
  1 (the prognosis is that I cannot .BE cured \.)
    2 *ask-about-prognosis* (100 :schema)
    2 *ask-about-will-experimental-therapies-help* (100 :schema)
    ; OPPORTUNITY for open-ended questions: "What are your treatment goals?", "How are you feeling?", "What worries you the most?"
    2 ([SAD] [OPPORTUNITY] I guess I need to make peace with it \.) (0 :out)
  1 (the prognosis is that I will survive \.)
    2 ([HAPPY] my previous doctor didn\'t seem so optimistic \, so that\'s quite the relief that you think i\'ll get better \.) (0 :out)
  1 (the prognosis is that my cancer .SHOULD .BE treated with .CHEMOTHERAPY \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (the prognosis is that my cancer .SHOULD .BE treated with comfort .CARE \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (the prognosis is hard to .PREDICT \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (my understanding of my prognosis is .INCORRECT \.)
    2 *ask-if-can-outlive-prognosis-health-now* (100 :schema)
    2 ([SAD] oh \. That is hard to hear \. I\'m afraid of what the future may bring \, but at least i\'ll be able to spend this remaining time with my family \.) (0 :out)
  1 (my understanding of my prognosis is correct \.)
    2 *ask-if-can-outlive-prognosis-health-now* (100 :schema)
    2 ([HAPPY] that\'s great to hear \. My previous doctor wasn\'t so optimistic \, so it\'s a relief that you think I have a chance \.) (0 :out)
  1 (my understanding of my prognosis may .BE correct \.)
    2 *ask-if-can-outlive-prognosis-health-now* (100 :schema)
    2 (I have heard these things are hard to predict \. It\'s good to know at least I have a chance \.) (0 :out)
  1 (I will outlive my prognosis \.)
    2 (Oh \, that\'s good to hear \. A little bit of extra time with my children and grandchildren makes all the difference to me \.) (0 :out)
  1 (I will not outlive my prognosis \.)
    2 ([SAD] [OPPORTUNITY] that\'s frustrating \. I feel already as though there\'s so little I can do to help my future \. But at least I know I can spend the remaining time with my family \.) (0 :out)
  1 (I may outlive my prognosis \.)
    2 (I wish I could know for sure \, but I understand how hard these things are to predict \. No matter what happens \, i\'ll have to make the best of the time I have left \.) (0 :out)
  1 (my prognosis is that I will not live to attend the graduation of my grandson \.)
    2 (Oh \. That\'s very hard to hear \. But i\'m glad that you\'re telling me now \. I\'ll be sure to prepare for the worst and cherish the remaining time with my family \.) (0 :out)
  1 (my prognosis is that I will live to attend the graduation of my grandson \.)
    2 ([HAPPY] that\'s good to hear \. My grandson is incredibly important to me and I want to make it at least to his graduation \. I know i\'ll cherish all the time I have left with him \.) (0 :out)
  1 (my prognosis is that I .MIGHT live to attend the graduation of my grandson \.)
    2 (Oh \. Well \, I know how difficult these things are to figure out \. I\'ll keep spending time with my grandson and hope for the best \.) (0 :out)
  1 (the majority of people .DO not .HAVE an accurate prognosis \.)
    2 *ask-if-can-outlive-prognosis-health-practices* (0 :schema)
  1 (the majority of people .HAVE an accurate prognosis \.)
    2 *ask-if-can-outlive-prognosis-health-practices* (0 :schema)
  1 (quitting smoking will not make my prognosis better \.)
    2 *ask-if-can-outlive-prognosis-graduation* (0 :schema)
  1 (quitting smoking will make my prognosis better \.)
    2 *ask-if-can-outlive-prognosis-graduation* (0 :schema)
  1 (quitting smoking .MIGHT make my prognosis better \.)
    2 *ask-if-can-outlive-prognosis-graduation* (0 :schema)
  1 (.EXPERIMENTAL treatments will make my prognosis better \.)
    2 ([HAPPY] i\'m happy to hear you think it\'s worth a shot \. I may talk things over with my family though before I look into those sort of treatments \. No matter how much time I have left being around them will always be my top priority \.) (0 :out)
  1 (.EXPERIMENTAL treatments .MIGHT make my prognosis better \.)
    2 ([HAPPY] thank you \. It\'s good to hear that there\'s at least a chance \. Still \, I may talk this over with my family before I make any big decisions \. No matter how long I have left \, spending time with them is my top priority \.) (0 :out)
  1 (.EXPERIMENTAL treatments will not make my prognosis better \.)
    2 ([SAD] oh \. In that case \, I don\'t think i\'ll try it then \. It\'s probably for the best \. No matter how much time I have left \, I want to focus on spending time with my family \.) (0 :out)
  1 (.HEALTHY habits will not .HELP me outlive my prognosis \.)
    2 ([SAD] oh \. That\'s unfortunate \. Still \, I hope I can keep this good health as long as i\'m able and use it to spend time with my family \.) (0 :out)
  1 (my health right .NOW does not change my prognosis \.)
    2 ([SAD] oh \. That\'s unfortunate \. Still \, I hope I can keep this good health as long as i\'m able and use it to spend time with my family \.) (0 :out)
  1 (.HEALTHY habits will .HELP me outlive my prognosis \.)
    2 *ask-if-can-outlive-prognosis-graduation* (0 :schema)
  1 (my health right .NOW improves my prognosis \.)
    2 ([HAPPY] that\'s great to hear \. I hope I can live in good health as long as possible and spend time with my family \.) (0 :out)
  1 (.HEALTHY habits may .HELP me outlive my prognosis \.)
    2 *ask-if-can-outlive-prognosis-graduation* (0 :schema)
  1 (my health right .NOW may change my prognosis \.)
    2 (Well \, that\'s certainly better than nothing \. I hope I can keep up this good health as long as possible and spend my remaining time with my family \.) (0 :out)
  1 (you .SHOULD obtain a .SECOND opinion about the prognosis \.)
    2 (That\'s good to know \. In that case \, I may look into getting a second opinion on my prognosis \.) (0 :out)
  1 (it is up to you whether you obtain a .SECOND opinion \.)
    2 (Okay \. In that case \, I may look into getting a second opinion on my prognosis \. Thank you so much for giving me your opinion \.) (0 :out)
  1 (you .SHOULD not obtain a .SECOND opinion about the prognosis \.)
    2 (In that case \, it might not be worth the bother to find a second opinion \. Thank you for letting me know \.) (0 :out)
  1 (I .SHOULD .SPEND the time predicted by my prognosis with my .FAMILY \.)
    2 (You\'re right \. No matter how much time I have left \, being with my children and grandchild is the most important thing for me right now \.) (0 :out)
  1 (0)
    ;; 2 (I\'m not entirely sure I fully understand what this means for my future\, but I want to be prepared for the worst
    ;;    and to spend time with family \.) (100 :out)
    ;; 2 ([SAD] I\'m not entirely sure I understand what this means for my future \. I want to be fully prepared for the worst\,
    ;;   though \.) (100 :out)
    ;; 2 (I see \.) (100 :out)
    2 (I guess it\'s not easy to say for sure \. I would like to be fully prepared for the future though \.) (100 :out)
    2 ([SAD] I suppose these things can be hard to predict \.) (100 :out)
    2 (I see \.) (0 :out)
)) ; END *prognosis-reaction*


(READRULES '*sleep-poorly-reaction*
; (0 sleeping poorly 0 \.)
'(
  1 (I am sleeping poorly .BECAUSE of a side .EFFECT from a medication \.)
    2 (I see \. If the medicine is going to make me tired no matter what \, i\'d rather at least have the pain controlled \.) (0 :out)
  1 (I am sleeping poorly .BECAUSE of my .PAIN \.)
    2 *ask-if-stronger-medication-will-help-sleep* (0 :schema)
  1 (I am sleeping poorly .BECAUSE the cancer has .SPREAD \.)
    2 *ask-if-cancer-worse* (0 :schema)
  1 (I am sleeping poorly .BECAUSE of my mental health \.)
    2 *discuss-depression* (0 :schema)
  1 (you are sorry that I am sleeping poorly \.)
    2 *ask-about-poor-sleep* (0 :schema)
  1 (0)
    2 (Okay \.) (0 :out)
)) ; END *sleep-poorly-reaction*


(READRULES '*tell-family-reaction*
; (0 tell 1 family 0 \.)
; (Comfort care allows me to spend time with my family \.)
'(
  1 (comfort .CARE allows me to .SPEND time with my .FAMILY \.)
    2 *ask-about-comfort-care* (0 :schema)
  1 (I .SHOULD .TELL my .FAMILY the full truth about my cancer \.)
    2 ([SAD] okay \. It will be hard to give them such bleak news \, but they deserve to know the truth \.) (0 :out)
  1 (I .SHOULD .REASSURE my .FAMILY about my cancer \.)
    2 (Certainly \. I\'ll try to be gentle with them \, even if the news is bleak \. They deserve to know how much I love them \.) (100 :out)
    2 (Of course \. I\'ll do my best to soften the blow \.) (0 :out)
  1 (you will .BE .AVAILABLE to .HELP me and my .FAMILY during my cancer .TREATMENT \.)
    2 *ask-what-to-tell-family* (0 :schema)
    2 (Thank you \. I can\'t tell you how happy I am to know I have you by my side throughout all this \.) (0 :out)
  1 (you will .HELP me and my .FAMILY through the .TREATMENT process \.)
    2 (Thank you \. Knowing that you\'ll be by our side throughout all this is a huge weight off my shoulders \.) (100 :out)
    2 (Thank you \. I appreciate having someone else in my corner so to speak \.) (0 :out)
  1 (I .SHOULD plan to .SPEND my remaining time with my .FAMILY after I .TELL them about the prognosis \.)
    2 (Yes \, i\'ll certainly have to talk to them about how we\'re going to make the most of our remaining time \.) (100 :out)
    2 (That\'s right \! After all \, that\'s why I moved up to new york \, to spend as much time with them as possible \.) (0 :out)
  1 (0)
    2 ([SAD] okay \. It will be difficult \, but my family and I will have to be strong \.) (0 :out)
)) ; END *tell-family-reaction*


(READRULES '*positive-reaction*
; (Doctor expresses positive sentiment)
'(
  1 (0)
    2 (Excellent !) (100 :out)
    2 (Good to hear \.) (100 :out)
    2 (Great !) (0 :out)
)) ; END *positive-reaction*


(READRULES '*test-results-reaction*
; (0 test results 0 \.)
'(
  1 (the test results .DO not appear conclusive \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (the test results show that the cancer hasn\'t .SPREAD \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (the test results show that I cannot .BE cured \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (the test results show that my cancer has .SPREAD \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (you are not sure what my test results mean \.)
    2 *ask-about-test-results* (100 :schema)
  ;; 2 *ask-about-test-results* (100 :schema)
  1 (the test results show that the radiation is not working \.)
    2 *ask-about-prognosis* (100 :schema)
  1 (0)
    2 (Okay \.) (100 :out)
    2 (I see \.) (0 :out)
)) ; END *test-results-reaction*


(READRULES '*treatment-option-reaction*
; (0 treatment option 0 \.)
'(
  1 (maintaining .GOOD quality of life is a .TREATMENT .OPTION \.)
    2 *ask-about-treatment-options* (100 :schema)
  1 (radiation is a .TREATMENT .OPTION \.)
    2 *ask-about-will-radiation-help* (0 :schema)
  1 (.CHEMOTHERAPY is a .TREATMENT .OPTION \.)
    2 *ask-about-what-happens-without-chemotherapy* (100 :schema)
    2 *ask-about-will-chemotherapy-help* (0 :schema)
  1 (comfort .CARE is a .TREATMENT .OPTION \.)
    2 *ask-how-comfort-care-works* (0 :schema)
  1 (you need more tests .BEFORE .TALKING about .TREATMENT options \.)
    2 *ask-about-treatment-options* (100 :schema)
    2 (I understand that some further tests might be necessary \. I\'ll try to get that done before discussing treatment options \.) (0 :out)
  1 (0)
    2 *ask-about-treatment-options* (100 :schema)
    2 (I will have to think about what you said more \. I have some more specific questions about treatment \, though \.) (0 :out)
)) ; END *treatment-option-reaction*


(READRULES '*treatment-goals-reaction*
; (0 cancer-fight 0)
; (0 cancer-live 0)
; (0 cancer-goals 0)
'(
  1 (.DO I .WANT to .TRY to .FIGHT the cancer ?)
    2 *ask-about-treatment-options* (0 :schema)
  1 (what are my .TREATMENT goals ?)
    2 *ask-about-treatment-options* (0 :schema)
)) ; END *treatment-goals-reaction*


(READRULES '*reason-for-cancer-reaction*
; (0 cause 0)
; (0 wish 4 not 1 cancer 0)
; (0 sorry 4 cancer 0)
'(
  1 (you wish that I .DO not .HAVE cancer \.)
    2 (I know I wish that I had more time \, but I suppose I should just make the best of what I have \. I certainly appreciate all the help you\'ve been giving me along the way \.) (100 :out)
    2 (I wish with all my heart that I had more time \, but I imagine i\'ve just got to make the best of what I have \. Thank you for your help with everything though \.) (0 :out)
  1 (you are sorry that I .HAVE cancer \.)
    2 (Thank you \. I only wish I had more time with my grandson \. But who knows \, there\'s always at least a chance I may get more time with him \.) (100 :out)
    2 (Thank you \. I appreciate all you\'ve been doing to help me \. I\'ll try to do the best I can with the time I have left \.) (0 :out)
  1 (my cancer is the .RESULT of my smoking \.)
    ;; 2 *ask-if-can-outlive-prognosis-quit-smoke* (100 :schema)
    2 ([SAD] I never should have smoked when I was younger \. I\'ll have to tell my grandson before I go to never smoke a cigarette in his life \. I only wish I had more time with him \.) (0 :out)
  1 (my cancer is caused by a mutation that .SPREAD through my cells \.)
    2 *ask-why-have-cancer* (0 :schema)
  1 (the .CAUSE of my cancer is unclear \.)
    2 *ask-why-have-cancer* (100 :schema)
    2 (I know it\'s hard to say for sure \. And I suppose \, in the end \, it won\'t change anything if I have cancer for one reason or another \. All I can do is make the most of the time I have left \.) (0 :gist)
  1 (cancer .CAN affect anyone \.)
    2 *mention-anxiety* (0 :schema)
  1 (cancer .CAN affect the human .BODY suddenly \.)
    2 *mention-anxiety* (0 :schema)
)) ; END *reason-for-cancer-reaction*