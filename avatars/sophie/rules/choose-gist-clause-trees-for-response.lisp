(READRULES '*gist-clause-trees-for-response*
'(
  ; Subtrees for elaborating questions
  1 (can 1 rephrase 1 question 1)
    2 (*response-tree-rephrase*) (0 :subtrees)
  1 (How does chemotherapy work 1)
    2 (*response-tree-chemotherapy-explanation*) (0 :subtrees)
  1 (Do you think chemotherapy will help 1)
    2 (*response-tree-treatment-chemotherapy*) (0 :subtrees)
  1 (what is 1 prognosis 1)
    2 (*response-tree-prognosis*) (0 :subtrees)
  1 (What are the side effects of stronger pain medication 1)
    2 (*response-tree-medication*) (0 :subtrees)
  1 (What do my test results mean 1)
    2 (*response-tree-test-results*) (0 :subtrees)
  1 (Do I need chemotherapy 1)
    2 (*response-tree-chemotherapy*) (0 :subtrees)
  1 (Why isn\'t the pain medication working anymore 1)
    2 (*response-tree-pain-medication-not-working*) (0 :subtrees)
  1 (How does comfort care work 1)
    2 (*response-tree-comfort-care*) (0 :subtrees)
  1 (What are my options for treatment 1)
    2 (*response-tree-treatment-options*) (0 :subtrees)

  ; Subtrees for elaborating answers
  1 (My pain has recently been getting worse 1)
    2 (*response-tree-pain*) (0 :subtrees)
  1 (I have lost weight 1)
    2 (*response-tree-weight*) (0 :subtrees)
  1 (I have not been sleeping well 1)
    2 (*response-tree-sleep*) (0 :subtrees)
  1 (I am only taking Lortab to treat my pain 1)
    2 (*response-tree-medication*) (0 :subtrees)
  1 (I am taking Lortab every three hours 1)
    2 (*response-tree-lortab-frequency*) (0 :subtrees)

  ; Direct rules for elaborating questions
  ; NOTE: if there are ever multiple contexts where these are warranted with different
  ; surface utterances, these need to be pulled out into separate subtrees. For now,
  ; we assume that these occur in a specific context and can thus have a specific elaboration.
  1 (Are you sure the cancer has not gotten worse 1)
    2 (Are you sure it\'s not gotten worse ? The pain seems to have gotten worse \.) (0 :out)
  1 (Will an antidepressant help with my pain 1)
    2 (I see \. Would this help me with me pain ?) (0 :out)
  1 (Should I try medication before I try therapy 1)
    2 (I am not sure \. Do you think there\'s any medication I can try first ?) (0 :out)
  1 (What are the side effects of chemotherapy 1)
    2 (I hear about people getting sick and losing hair during chemotherapy \. What are some of the side effects ?) (0 :out)
  1 (Are you sure that I do not need comfort care 1)
    2 (Are you sure I don\'t need hospice ? At this point I would really just prefer to be comfortable \.) (0 :out)
  1 (Can I get addicted to narcotics 1)
    2 (Usually when I hear about narcotics \, it\'s people getting addicted to them \. Is that a possibility here ?) (0 :out)
  1 (I am sleeping poorly because of my mental health 1) ; CHECK
    2 (I see \. I do try to keep carrying on\, but sometimes I just feel down \.) (0 :out)
  1 (Has the cancer gotten worse 1)
    2 (Does that mean that the cancer has gotten worse ?) (0 :out)
  1 (Do you think radiation will help 1)
    2 (Do you think radiation is really going to help at this point ?) (0 :out)
  1 (What happens if I do not do chemotherapy 1)
    2 (What happens if I don\'t do chemotherapy ?) (0 :out)
  1 (I would like a refill of medicine 1)
    2 (I need a refill of my Lortab \.) (0 :out)
  ; The following are from the top-level dialogue track
  1 (Why have I not been sleeping well 1)
    2 (One thing I\'ve noticed in the last few weeks is that I haven\'t been sleeping very well \. Most nights I
       have to take medication for my pain \. I\'m not sure if it\'s only the pain\, but I keep waking up at night \.
       Do you know why I keep waking up like this ?) (0 :out)
  1 (How will I know if my pain medication is working 1)
    2 (I just started on my new pain medication recently \. How long will it be before I know if it\'s working ?) (0 :out)
  1 (Can I have a stronger pain medication 1)
    2 (You know\, I\'m in a lot of pain\, and the Lortab just isn\'t working \. I think maybe I need something
       stronger for my pain \.) (0 :out)
  1 (Should I get comfort care 1)
    2 (You know\, I really just prefer to be comfortable at this point \. Do you think I should
       start considering comfort care ?) (0 :out)
  1 (What should I tell my family 1)
    2 (I haven\'t told my family everything yet \. I wanted to wait to talk to you first \.
       What should I say to them ?) (0 :out)

  ; Direct rules for elaborating answers
  ; NOTE: if there are ever multiple contexts where these are warranted with different
  ; surface utterances, these need to be pulled out into separate subtrees. For now,
  ; we assume that these occur in a specific context and can thus have a specific elaboration.
  1 (I got my diagnosis after visiting a lung doctor 1)
    2 (Well\, I first went to my regular doctor\, but he didn\'t find anything and just thought I had a bad
       cold \. But after the pain and cough got really bad\, I went to the ER \. They thought it was just pneumonia
       and gave me antibiotics and Lortab for pain \. When they told me how much I weighed\, I realized that I
       had lost fifteen pounds over the course of the past six months \. A couple of days ago after I went to the
       ER\, I made appointments to go for a bunch of tests \. That took a couple of weeks \. I had to get a bone scan\,
       and I was sent to the lung doctor for a biopsy \. After all that \, the lung doctor told me that I had lung cancer \.) (0 :out)
  1 (I have constipation and my appetite is worse 1)
    2 (I have constipation\, though I have had that for a year \. My appetite is worse \. I don\'t eat much anymore \.) (0 :out)
  1 (I have lost my appetite 1)
    2 (I have lost my appetite a bit \. The food looks good\, but I can only take a couple bites and then I am done \.) (0 :out)
  1 (I do not have the symptom you mentioned 1)
    2 (No\, I haven\'t had problems with that \.) (0 :out)
  1 (I had radiation treatment for five weeks 1)
    2 (I did get radiation treatment\, for about five weeks \. I finished about six weeks ago \.) (0 :out)
  1 (I had some hair loss and redness at the site of radiation 1)
    2 (I had a little bit of hair loss and redness at the site\, but it\'s mostly gone now \.) (0 :out)
  1 (I was feeling a little better after radiation 1)
    2 (I were feeling a little better after radiation\, for a few weeks \.) (0 :out)
  1 (I drove here today 1)
    2 (I drove here today \. I have just been taking my time with it \.) (0 :out)
  1 (I am here alone 1)
    2 (I am staying with my daughter now \. She took the day off to come in today\, but someone called in sick where she works \.
       So\, she had to go in \. She really wanted to be here \.) (0 :out)
  1 (I usually take a nap during the day 1)
    2 (I usually take a nap during the day \. About one hour to two hours \.) (0 :out)
  1 (I have been fatigued 1)
    2 (I have been fatigued most days for the past month \. If I\'m just doing something normal\, I am fine\, but I don\'t
       have as much energy as I used to \.) (0 :out)
  1 (I have had trouble concentrating 1)
    2 (I have only had trouble concentrating sometimes \.) (0 :out)
  1 (I feel mildly depressed 1)
    2 (Well\, I do try to keep carrying on\, but sometimes I just feel down \.) (0 :out)
  1 (I don\'t have allergies to any medicine 1)
    2 (No\, I don\'t believe I have any allergies \.) (0 :out)
  1 (I am taking blood pressure medicine 1)
    2 (I have been taking Cozar for blood pressure for about ten years \.) (0 :out)
  1 (I have a history of alcohol abuse but do not drink now 1)
    2 (There was a point in my life that I drank fairly often \. But I cut back on my own\, and I don\'t really drink a lot now \.
       Truth be told\, ever since the diagnosis\, I have kind of lost my taste for alcohol \.) (0 :out)
  1 (I have a history of smoking but quit six months ago 1)
    2 (I was a pretty heavy smoker once \. I started my senior year in high school\, then smoked about a pack a day up until
       about six months ago \. Now I don\'t smoke at all \.) (0 :out)
  1 (Nobody in my family has a history of mental illness 1)
    2 (I don\'t think so \. As far as I know\, no one in my family has experienced that sort of thing \.) (0 :out)
  1 (My mother died from diabetes and my father died from prostate cancer 1)
    2 (My parents passed on a few years ago \. Both at seventy three\, if you would believe it \. 
       My mother died from complications with her diabetes \. She was a smoker\, something she passed onto me \.
       My father\, though\, died when his prostate cancer went into his bones \. Near the end of his life\, he was in a
       lot of pain\, which I guess is why I worry about my medications \.) (0 :out)

  ; By default, simply output the gist-clause
  1 (0)
    2 (1) (0 :out)
))

; Below here are specific subtrees for elaborating questions or answers based on context of previous user utterance
;```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````

(READRULES '*response-tree-treatment-options*
'(
  1 (0 Maintaining good quality of life is a treatment option 0)
    2 (Keeping a high quality of life for the rest of my time is the most important thing to me right now \.
       What\'s the best option for making sure this is possible ?) (0 :out)
  1 (0)
    2 (What are my choices at this point ?) (0 :out)
))

(READRULES '*response-tree-comfort-care*
'(
  1 (0 Comfort care is a treatment option 0)
    2 (Comfort care sounds good to me \. What I want is to try to get my life back to normal as much as possible \.
       You know\, spend time with my family\. What do I have to do for that ?) (0 :out)
  1 (0 Have I considered comfort care 0)
    2 (I haven\'t thought about it\, but it sounds like what I really need \. A way to maintain quality of life
       during the time I have left \. Can you tell me about it ?) (0 :out)
))

(READRULES '*response-tree-pain-medication-not-working*
'(
  1 (0 Is the pain medication working at all 0)
    2 (The lortab is working a little bit\, but not much \.) (0 :out)
  1 (0 Is the pain medication working 0)
    2 (No\, it\'s not really working anymore \. So I have been taking the pills every three hours instead of every four \.) (0 :out)
  1 (0)
    2 (Could you tell me why the pain medication isn\'t working anymore ?) (0 :out)
))

(READRULES '*response-tree-lortab-frequency*
'(
  1 (0 How often am I taking medication 0)
    2 (I am taking two pills of lortab every three hours now for the past couple of weeks\, since this pain has come back \.) (0 :out)
  1 (0 Does taking medication more frequently help 0)
    2 (Taking the lortab more often seems to help a little \. I am already taking it every three hours \.) (0 :out)
))

(READRULES '*response-tree-sleep*
'(
  1 (0 Have I been sleeping okay 0)
    2 (I have been having a bit of trouble \. I keep waking up at night \. Most nights I have to take my pain medication
       before falling back to sleep again \.) (0 :out)
  1 (0 How often am I waking up at night 0)
    2 (I haven\'t really been keeping track \. Maybe about four or five times in a night \.) (0 :out)
  1 (0 What is on my mind when I try to sleep 0)
    2 (When I actually sleep\, I don\'t really have anything on my mind \. When I have trouble sleeping I usually can\'t think
       of anything except for the pain \.) (0 :out)
))

(READRULES '*response-tree-test-results*
'(
  1 (0 Do I know what the tests say 0)
    2 (I don\'t really understand the test results \. Can you explain them ?) (0 :out)
  1 (0)
    2 (Could you explain to me what my test results mean ?) (0 :out)
))

(READRULES '*response-tree-weight*
'(
  1 (0 Have I changed weight 0)
    2 (I have lost some weight \.) (0 :out)
  1 (0 How much weight have I lost 0)
    2 (I have lost about twenty five pounds since they started \. I gained seven back in radiation\, but I am still down a bit \.) (0 :out)
))

(READRULES '*response-tree-pain*
'(
  1 (0 Can I tell you about my pain 0)
    2 (The pain was pretty much under control for a while\, but in the past week it has been more difficult \.
       it used to be in my back and left side of my chest\, but now it\'s in my shoulder blade too\, and on
       the other side from where it started \.) (2 :out)
    2 (The pain doesn\'t really go into other areas \. It\'s dull and constant\, and aches a lot \. It usually
       hurts to take deep breathes \.) (0 :out)
  1 (0 How do I rate my pain 0)
    2 (The pain is about a seven out of ten \. With medication\, it goes down to about a five \.) (0 :out)
  1 (0 Where is the pain located 0)
    2 (The pain is primarily in the left side of my chest\, and in the middle of my back \. Recently\,
       it also moved to the right side of my chest \.) (0 :out)
  1 (0 Does it hurt to 0)
    2 (It hurts whenever I take a deep breath \. It used to hurt to swallow during radiation\, but that isn\'t as bad now \.) (0 :out)
  1 (0 Did my pain come back 0)
    2 (My pain came back a couple weeks after I finished radiation \. It\'s been getting worse recently \.) (0 :out)
))

(READRULES '*response-tree-medication*
'(
  1 (0 I should take stronger pain medication 0)
    2 (Yeah\, I think I should take a stronger pain medication \. The current one isn\'t working well \. What are the side effects ?) (100 :out)
    2 (Yeah \, a stronger pain medication would be good \. What would the side effects be ?) (0 :out)
  1 (0 Do I want stronger pain medication 0)
    2 (I think I could use a stronger pain medication \. Something to help make me more comfortable \. What are the side effects ?) (100 :out)
    2 (I think having the stronger pain medication would help \.) (0 :out)
  1 (0 I should take something different 0)
    2 (I think something stronger for the pain would be good \. What would the side effects be for a different pain medication ?) (0 :out)
  1 (0 What medicine am I taking 0)
    2 (I am just taking the lortab for pain right now \.) (0 :out)
  1 (0 Am I taking pain-med 0)
    2 (I think so \. I am taking lortab for pain right now \.) (0 :out)
  1 (0 Am I taking pain-med-other 0)
    2 (No\, I am not taking any of those \. Just the lortab \.) (0 :out)
  1 (0 What is my history with med-narcotic 0)
    2 (I took some pain medication for a fractured ankle about fifteen or so years ago\, but I don\'t believe it was a narcotic \. 
       besides that\, my doctor prescribed me lortab about three weeks ago \.) (0 :out)
  1 (0 Am I taking med-narcotic 0)
    2 (No\, I am not taking any of those \. Just the lortab \.) (0 :out)
))

(READRULES '*response-tree-treatment-chemotherapy*
'(
  1 (0 Chemotherapy is a treatment option 0)
    2 (Do you think chemotherapy is really going to help ?) (0 :out)
  1 (0)
    2 (What about chemotherapy ?) (0 :out)
))

(READRULES '*response-tree-chemotherapy-explanation*
'(
  1 (0 A side effect of chemotherapy is 0)
    2 (Okay \. How does chemotherapy usually work ?) (0 :out)
  1 (0)
    2 (How does chemotherapy usually work ?) (0 :out)
))

(READRULES '*response-tree-chemotherapy*
'(
  1 (0 Did my doctor mention chemotherapy 0)
    2 (My doctor mentioned something about chemotherapy\, but said that I should wait to see how
       things go after the radiation is done \. Why? Do you think I need chemotherapy ?) (0 :out)
  1 (0)
    2 (My previous doctor mentioned something about chemotherapy\, but he said to wait to see how
       things go after the radiation \. Do you think I need chemotherapy ?) (100 :out)
    2 (Do you think I need chemotherapy ?) (0 :out)
))

(READRULES '*response-tree-prognosis*
'(
  1 (0 My cancer has gotten worse 0)
    2 (What does that mean for me ?) (0 :out)
  1 (0 The prognosis is that I cannot be cured 0)
    2 (I feared as much \, though it\'s still pretty upsetting \. How long do you think I have ?) (0 :out)
  1 (0 The prognosis is that my cancer should be treated with chemotherapy 0)
    2 (I want to talk about my options in a minute\, but first I just want to know how bad it really is \. How long do you think I have ?) (0 :out)
  1 (0 The prognosis is hard to predict 0)
    2 (My last doctor also just said it would be hard to predict \. I think I am ready to hear though \. Could you please just tell me what the worst case looks like ?) (0 :out)
  1 (0 The test results show that the cancer hasn\'t spread 0)
    2 (My previous doctor didn\'t seem very optimistic \. So what do you think this all means for me ?) (0 :out)
  1 (0 The test results show that me cannot be cured 0)
    2 (That\'s distressing \. I was fearing the worst\, but in the back of my mind I didn\'t think it would all happen so quickly \. My family will be distraught \.
       What I am wondering at this point is\, how much time do I have left ?) (0 :out)
  1 (0 The test results show that my cancer has spread 0)
    2 (Those are not the words I wanted to hear \. I mean\, I was bracing for the worst\, since I could tell by the pain that it\'s bad \.
       But to hear that the cancer has spread is quite depressing \. What does it all mean for me ?) (0 :out)
  1 (0)
    2 (I want you to be honest with me \. How long do you think I have ?) (0 :out)
))

(READRULES '*response-tree-rephrase*
'(
  1 (0)
    2 (I am sorry\, I didn\'t quite understand\. Can you say it again ?) (3 :out)
    2 (Would you mind rephrasing ?) (3 :out)
    2 (Could you repeat that one more time using a different phrasing ?) (0 :out)
))