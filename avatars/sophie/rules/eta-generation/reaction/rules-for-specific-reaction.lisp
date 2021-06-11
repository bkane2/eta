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
  1 (My cancer has gotten worse \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (My cancer has not gotten worse \.)
    2 *verify-cancer-status* (100 :schema)
    2 ([HAPPY] Okay\. Well\, that makes me feel a little bit better \.) (0 :out)
  1 (You are not sure whether my cancer has gotten worse \.)
    2 ([SAD] That\'s not very reassuring \.) (0 :out)

  1 (0)
    2 (I see \.) (0 :out)

)) ; END *cancer-worse-reaction*



(READRULES '*medical-history-reaction*
; (0 congratulations 0)
'(
  1 (0 congratulations 0)
    2 (Well\, truth be told\, I simply lost my taste for it\. But\, I appreciate your congratulations all the same\.) (0 :out)
    
)) ; END *medical-history-reaction*



(READRULES '*medicine-side-effects-reaction*
; (0 side effect 3 medication 0)
'(
  1 (Addiction is not a side effect of the medication \.)
    2 *ask-for-stronger-pain-medication* (100 :schema)
    2 (I didn\'t know that\. It\'s good to know that stronger pain medication is an option without risking addiction \.) (0 :out)
  1 (A side effect of the medication be 2 side-effects-significant 2 \.)
    2 (I don\'t want to risk any issues with 8 9 10 \. I think I should hold off for now and think about it more \.) (0 :out)
  1 (A side effect of the medication be 2 side-effects-moderate 2 \.)
    2 *ask-for-stronger-pain-medication* (100 :schema)
    2 (I think I should try the medicine and see if I have problems with 8 9 10 \.) (0 :out)
  1 (A side effect of the medication be 2 side-effects-insignificant 2 \.)
    2 *ask-for-stronger-pain-medication* (100 :schema)
    2 (I already have 8 9 10 \, so I think the new medicine is worth a try\.) (0 :out)

  1 (0)
    2 *ask-for-stronger-pain-medication* (100 :schema)
    2 (I think it\'s worth giving it a try\.) (0 :out)

)) ; END *medicine-side-effects-reaction*



(READRULES '*appointment-reaction*
'(
)) ; END *appointment-reaction*



(READRULES '*chemotherapy-details-reaction*
; (0 chemotherapy details 0 \.)
; (0 side effect 0 chemotherapy 0 \.)
; (0 way 1 to get 2 chemotherapy 0 \.)
'(

  1 (One way to get chemotherapy is 0)
    2 (0 two chemotherapy 0)
      3 (I didn\'t know that was possible\. But it makes sense\.) (0 :out)
    2 (If I do chemotherapy\, I would prefer a port or IV \. I don\'t like needles\.) (0 :out)
  1 (A side effect of chemotherapy is 6 \.)
    2 *ask-how-chemotherapy-works* (100 :schema)
    2 (I see \. I think it might be worth giving it a try \.) (0 :out)

  1 (0)
    2 (Ah\, I see\. I\'ll have to read more about chemotherapy\.) (0 :out)

)) ; END *chemotherapy-details-reaction*



(READRULES '*diagnosis-details-reaction*
'(
)) ; END *diagnosis-details-reaction*



(READRULES '*energy-reaction*
; (0 energy 0 \.)
; (0 ment-treatment 0)
'(
  1 (You can give me an antidepressant \.)
    2 *ask-about-antidepressant* (100 :schema)
    2 (Okay\. I\'ll give the antidepressant medication a shot\.) (0 :out)
  1 (I should take an antidepressant \.)
    2 *ask-about-antidepressant* (100 :schema)
    2 (Okay\. I\'ll give the antidepressant medication a shot\.) (0 :out)
  1 (I should see a therapist \.)
    2 *ask-about-medication-before-therapy* (100 :schema)
    2 (Okay\. I\'ll give the therapy a shot\.) (0 :out)

)) ; END *energy-reaction*



(READRULES '*medicine-reaction*
; (0 stronger pain medication 0 help me sleep 0)

'(
  ;; 1 (0 you will give me more medicine 0)
  ;;   2 (Great\, thank you !) (0 :out)
  1 (A stronger pain medication will help me sleep \.)
    2 *ask-about-pain-medication-side-effects* (100 :schema)
    2 ([SAD] If I continue to have trouble sleeping\, I might call in for stronger pain medication later \.) (0 :out)
  1 (A stronger pain medication will not help me sleep \.)
    2 ([SAD] I guess it\'s just something I\'ll have to live with \.) (0 :out)

  1 (0)
    2 (I see \.) (0 :out)

)) ; END *medicine-reaction*



(READRULES '*pain-reaction*
; (0 pain 0)
'(
  1 (You are sorry that I am in pain 1)
    2 ([SAD] Thanks\, I just hope the pain can be treated \.) (0 :out)

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
  1 (You do not think I need chemotherapy 0)
    2 (You do not think I need chemotherapy because I should get comfort care instead \.)
      3 *ask-about-comfort-care* (100 :schema)
      3 (I think holding off on chemotherapy for now makes sense\, given that my priority is just to be comfortable \.) (0 :out)
    2 (I see \. I think it will be best to hold off on chemotherapy\, at least for now \.) (0 :out)

  1 (0)
    2 *ask-about-chemotherapy-side-effects* (100 :schema)
    2 *ask-how-chemotherapy-works* (100 :schema)       
    2 (I see \. I think it might be worth giving it a try \.) (0 :out)

)) ; END *chemotherapy-reaction*



(READRULES '*comfort-care-reaction*
; (0 comfort care 0 \.)
'(
  1 (You do not think I need comfort care \.)
    2 *confirm-no-comfort-care* (100 :schema)
    2 (Okay\, I see\. I will think about starting chemotherapy right away then\.) (0 :out)

  1 (Comfort care should alleviate my pain \.)
    2 ([HAPPY] I\'m happy to hear that \. Right now\, my priorities are just to remain free of pain and spend time with my family \. In that case\, comfort care
       sounds like the best option to me \.) (0 :out)

  1 (You think I need comfort care \.)
    2 ([HAPPY] Great\. I also think comfort care is the best option for me right now \.) (0 :out)

  1 (0)
    ; OPPORTUNITY for open-ended question: "Can you tell me a little more about your treatment goals?", "What worries you most for the future?"
    2 ([SAD] [OPPORTUNITY] I\'d like to think some more about starting comfort care \. If I\'m not going to make it\,
       I want to at least be comfortable and spend time with family for as long as possible \.) (100 :out)
    2 (I think that comfort care is the best option for me right now \.) (0 :out)

)) ; END *comfort-care-reaction*



(READRULES '*medicine-request-reaction*
; (0 stronger 1 medication 0 \.)
; (0 refill 2 medication 0 \.)
; (0 med-narcotic 0 \.)
'(
  1 (I should take 1 med-narcotic \.)
    2 *ask-about-narcotic-addiction* (100 :schema)
    2 (I think having the stronger pain medication would help \.) (0 :out)
  1 (I should take stronger pain medication \.)
    2 *ask-about-pain-medication-side-effects* (100 :schema)
    2 (I think having the stronger pain medication would help \.) (0 :out)
  1 (I can give you stronger pain medication \.)
    2 ([HAPPY] Thank you very much\, I hope that will help with the pain \.) (0 :out)
  1 (I cannot give you stronger pain medication \.)
    2 (I see \. For now I\'ll stick with my current medication\, but will let you know if the pain starts getting worse \.) (0 :out)

  1 (I can give you a refill of pain medication \.)
    2 ([HAPPY] Thanks\, I appreciate it \!) (0 :out)
  1 (I cannot give you a refill of pain medication \.)
    2 ([SAD] Okay\. I will try to do without it\, but if the pain gets worse I\'m going to call you back for more pain medication \.) (0 :out)

  1 (0)
    2 (Okay\, I see \.) (0 :out)

)) ; END *medicine-request-reaction*



(READRULES '*medicine-working-reaction*
; (0 medication 4 work 0 \.)
; (0 take 3 different \.)
'(
  1 (I should take something different \.)
    2 *ask-about-pain-medication-side-effects* (0 :schema)
  1 (I should take med-narcotic \.)
    2 *ask-about-narcotic-addiction* (100 :schema)
    2 (I think having the stronger pain medication would help \.) (0 :out)
  1 (I should take stronger pain medication \.)
    2 *ask-about-pain-medication-side-effects* (100 :schema)
    2 (I think having the stronger pain medication would help \.) (0 :out)

  1 (I should wait to see if the pain medication works \.)
    2 (Okay\, for now I\'ll keep taking the Lortab\, and create a follow up appointment if it doesn\'t
       work after a few weeks \.) (0 :out)

  1 (0)
    2 (I see \.) (0 :out)
)) ; END *medicine-working-reaction*



(READRULES '*prognosis-reaction*
; (0 prognosis 0 \.)
'(
  ; I asked my doctor in Florida about what’s going to happen next, he just did not want to say. 
  ; He said” These things are always hard to predict.” 
  ; OPPORTUNITY: After SOPHIE expresses her fear, the doctor could ask her "What scares you the most about your future?" or "Were you nervous for this appointment?"
  1 (The prognosis is that I may live for number-plur elapsed-time-plur \.)
    2 *ask-if-can-trust-prognosis* (100 :schema)
    2 ([SAD] [OPPORTUNITY] That\'s very difficult to hear\. I thought I would have more time than that\.
      At this point\, I just hope I can enjoy those 9 10 with family\, but I\'m afraid of what the future will bring\.) (0 :out)
  1 (The prognosis is that I may live for number elapsed-time \.)
    2 *ask-if-can-trust-prognosis* (100 :schema)
    2 ([SAD] [OPPORTUNITY] That\'s very difficult to hear\. I thought I would have more time than that\.
       At this point\, I just hope I can enjoy that 9 10 with family\, but I\'m afraid of what the future will bring\.) (0 :out)
  1 (The prognosis is that I may live for several elapsed-time \.)
    2 *ask-about-prognosis* (100 :schema)
    2 *ask-if-can-trust-prognosis* (100 :schema)
    2 ([SAD] [OPPORTUNITY] That\'s very difficult to hear\. I thought I would have more time than that\.
       At this point\, I just hope I can enjoy those 10 with family\, but I\'m afraid of what the future will bring\.) (0 :out)
  1 (The prognosis is that I do not have long left to live \.)
    2 *ask-about-prognosis* (100 :schema)
    2 *ask-if-can-trust-prognosis* (100 :schema)
    2 ([SAD] [OPPORTUNITY] That\'s very difficult to hear\. I thought I would have more time than that\.
       At this point\, I just hope I can enjoy my time left with family\, but I\'m afraid of what the future will bring\.) (0 :out)
  1 (The prognosis is that I may live for a elapsed-time \.)
    2 *ask-if-can-trust-prognosis* (100 :schema) 
    2 ([SAD] [OPPORTUNITY] That\'s very difficult to hear\. I thought I would have more time than that\.
      At this point\, I just hope I can enjoy that 10 with family\, but I\'m afraid of what the future will bring\.) (0 :out)
    


  1 (The prognosis is that I cannot be cured \.)
    2 *ask-about-prognosis* (100 :schema)
    2 *ask-about-will-experimental-therapies-help* (100 :schema)
    ; OPPORTUNITY for open-ended questions: "What are your treatment goals?", "How are you feeling?", "What worries you the most?"
    2 ([SAD] [OPPORTUNITY] I guess I need to make peace with it \.) (0 :out)

  1 (The prognosis is that I will survive \.)
    2 ([HAPPY] My previous doctor didn\'t seem so optimistic\, so that\'s quite the relief that you think I\'ll get better \.) (0 :out)

  1 (The prognosis is that my cancer should be treated with chemotherapy \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (The prognosis is hard to predict \.)
    2 *ask-about-prognosis* (0 :schema)

  1 (My understanding of my prognosis is incorrect \.)
    2 *ask-if-can-outlive-prognosis* (100 :schema) 
    2 ([SAD] Oh \. \. \. That is hard to hear \. I\'m afraid of what the future may bring \, but at least I\'ll be able to spend 
       this remaining time with my family \. ) (0 :out)

  1 (My understanding of my prognosis is correct \.)
    2 *ask-if-can-outlive-prognosis* (100 :schema) 
    2 ([HAPPY] That\'s great to hear \. My previous doctor wasn\'t so optimistic \, so it\'s a relief that you think I have a chance \.) (0 :out)

  1 (My understanding of my prognosis may be correct \.)
    2 *ask-if-can-outlive-prognosis* (100 :schema) 
    2 (I have heard these things are hard to predict \. It\'s good to know at least I have a chance \. ) (0 :out)

  1 (I will outlive my prognosis \.)
    2 (Oh\, that\s good to hear\. I\'m glad there\'s something I can do that might help my chances and maximize my remaining time with my family \.) (0 :out)

  1 (I will not outlive my prognosis \.)
    2 ([SAD] That\'s frustrating\. I feel already as though there\'s so little I can do to help my future\. But at least I know I can spend
       the remaining time with my family \.) (0 :out)

  1 (I may outlive my prognosis \.)
    2 (I wish I could know for sure\, but I understand how difficult these things are to predict \. Still\, it\'s nice to know there may be something I can do to help my future \.) (0 :out)

  1 (I will not live to attend the graduation of my grandson \.)
    2 (Oh\. That\'s very hard to hear \. But I\'m glad that you\'re telling me now\. I\'ll be sure to prepare for the worst and cherish the remaining time with my family \.) (0 :out)

  1 (I will live to attend the graduation of my grandson \.)
    2 ([HAPPY] That\'s good to hear \. My grandson is incredibly important to me and I want to make it at least to his graduation \. I know I\'ll cherish all the time I have left with him \.) (0 :out)
    
  1 (I might live to attend the graduation of my grandson \.)
    2 (Oh\. Well\, I know how difficult these things are to figure out \. I\'ll keep spending time with my grandson and hope for the best \.) (0 :out)

  1 (The majority of people do not have an accurate prognosis \.)
    2 *ask-if-can-outlive-prognosis* (0 :schema)

  1 (The majority of people have an accurate prognosis \.)
    2 *ask-if-can-outlive-prognosis* (0 :schema)

  1 (Quitting smoking will not make my prognosis better \.)
    2 *ask-if-can-outlive-prognosis* (0 :schema) 

  1 (Quitting smoking will make my prognosis better \.)
    2 *ask-if-can-outlive-prognosis* (0 :schema) 

  1 (Quitting smoking might make my prognosis better \.)
    2 *ask-if-can-outlive-prognosis* (0 :schema) 

  1 (Experimental treatments will make my prognosis better \.)
    2 ([HAPPY] I\'m happy to hear you think it\'s worth a shot \. I may talk things over with my family though before I look into those sort of treatments \. No matter how much time I have left
       being around them will always be my top priority \.) (0 :out)
  
  1 (Experimental treatments might make my prognosis better \.)
    2 ([HAPPY] Thank you \. It\'s good to hear that there\'s at least a chance \. Still\, I may talk this over with my family before I make any big decisions \. No matter how
       long I have left \, spending time with them is my top priority \.) (0 :out)

  1 (Experimental treatments will not make my prognosis better \.)
    2 ([SAD] Oh \. In that case \, I don\'t think I\'ll try it then \. It\'s probably for the best \. No matter how much time I have left \, I want to focus on spending time with 
         my family \.) (0 :out)

  1 (A history of good health will not make my prognosis better \.)
    2 ([SAD] Oh \. That\'s unfortunate \. Still \, I hope I can keep this good health as long as I\'m able and use it to spend time with my family \.) (0 :out)

  1 (My health right now does not change my prognosis \.)
    2 ([SAD] Oh \. That\'s unfortunate \. Still \, I hope I can keep this good health as long as I\'m able and use it to spend time with my family \.) (0 :out)

  1 (A history of good health will make my prognosis better \.)
    2 *ask-if-can-outlive-prognosis* (0 :schema) 

  1 (My health right now improves my prognosis \.)
    2 ([HAPPY] That\'s great to hear\. I hope I can live in good health as long as possible and spend time with his family \.) (0 :out)

  1 (A history of good health might make my prognosis better \.)
    2 *ask-if-can-outlive-prognosis* (0 :schema) 

  1 (You should obtain a second opinion about the prognosis \.)
    2 (That\'s good to know \. In that case\, I may look into getting a second opinion on my prognosis \.) (0 :out)
  1 (It is up to you whether you obtain a second opinion \.)
    2 (Okay \. In that case\, I may look into getting a second opinion on my prognosis \. Thank you so much for giving me your opinion \.) (0 :out)
  1 (You should not obtain a second opinion about the prognosis \.)
    2 (In that case\, it might not be worth the bother to find a second opinion \. Thank you for letting me know \.) (0 :out)

  1 (0)
    ;; 2 (I\'m not entirely sure I fully understand what this means for my future\, but I want to be prepared for the worst
    ;;    and to spend time with family \.) (100 :out)
    2 ([SAD] I\'m not entirely sure I understand what this means for my future \. I want to be fully prepared for the worst\,
       though \.) (100 :out)
    ;; 2 (I see \.) (100 :out)
    2 ([SAD] I suppose these things can be hard to predict \.) (0 :out)

)) ; END *prognosis-reaction*
 


(READRULES '*sleep-poorly-reaction*
; (0 sleeping poorly 0 \.)
'(
  1 (I am sleeping poorly because of a side effect from a medication \.)
    2 (I see\. If the medicine is going to make me tired no matter what\, I\'d rather at least have the pain controlled \.) (0 :out)
  1 (I am sleeping poorly because of my pain \.)
    2 *ask-if-stronger-medication-will-help-sleep* (0 :schema)
  1 (I am sleeping poorly because the cancer has spread \.)
    2 *ask-if-cancer-worse* (0 :schema)
  1 (I am sleeping poorly because of my mental health \.)
     2 *discuss-depression* (0 :schema)

  1 (You are sorry that I am sleeping poorly \.)
    2 *ask-about-poor-sleep* (0 :schema)
    
  1 (0)
    2 (Okay \.) (0 :out)

)) ; END *sleep-poorly-reaction*



(READRULES '*tell-family-reaction*
; (0 tell 1 family 0 \.)
'(
  
  1 (0)
    2 ([SAD] Okay\. It will be difficult\, but my family and I will have to be strong \.) (0 :out)

)) ; END *tell-family-reaction*



(READRULES '*test-results-reaction*
; (0 test results 0 \.)
'(
  1 (The test results show that the cancer hasn\'t spread \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (The test results show that I cannot be cured \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (The test results show that my cancer has spread \.)
    2 *ask-about-prognosis* (0 :schema)

  1 (You are not sure what my test results mean \.)
    2 *ask-about-test-results* (100 :schema)
    ;; 2 *ask-about-test-results* (100 :schema)

  1 (The test results show that the radiation is not working \.)
    2 *ask-about-test-results* (100 :schema)

  1 (0)
    2 (Okay \.) (0 :out)

)) ; END *test-results-reaction*



(READRULES '*treatment-option-reaction*
; (0 treatment option 0 \.)
'(
  1 (Maintaining good quality of life is a treatment option \.)
    2 *ask-about-treatment-options* (100 :schema)
  
  1 (Radiation is a treatment option \.)
    2 *ask-about-will-radiation-help* (0 :schema)

  1 (Chemotherapy is a treatment option \.)
    2 *ask-about-what-happens-without-chemotherapy* (100 :schema)
    2 *ask-about-will-chemotherapy-help* (0 :schema)
    
  1 (Comfort care is a treatment option \.)
    2 *ask-how-comfort-care-works* (0 :schema)

  1 (You need more tests before talking about treatment options \.)
    2 *ask-about-treatment-options* (100 :schema)
    2 (I understand that some further tests might be necessary \. I\'ll try to get that done
       before discussing treatment options \.) (0 :out)

  1 (0)
    2 *ask-about-treatment-options* (100 :schema)
    2 (I will have to think about what you said more \. I have some more specific questions
       about treatment\, though \.) (0 :out)

)) ; END *treatment-option-reaction*



(READRULES '*treatment-goals-reaction*
; (0 cancer-fight 0)
; (0 cancer-live 0)
; (0 cancer-goals 0)
'(
  1 (Do I want to try to fight the cancer ?)
    2 *ask-about-treatment-options* (0 :schema)

  1 (What are my treatment goals ?)
    2 *ask-about-treatment-options* (0 :schema)
    
)) ; END *treatment-goals-reaction*