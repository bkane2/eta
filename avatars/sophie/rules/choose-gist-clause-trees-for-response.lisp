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
    2 (Am I sure it\'s not gotten worse ? The pain seems to have gotten worse \.) (0 :out)
  1 (Will an antidepressant help with my pain 1)
    2 (You see \. Would this help you with your pain ?) (0 :out)
  1 (Should I try medication before I try therapy 1)
    2 (You are not sure \. Do I think there\'s any medication you can try first ?) (0 :out)
  1 (What are the side effects of chemotherapy 1)
    2 (You hear about people getting sick and losing hair during chemotherapy \. What are some of the side effects ?) (0 :out)
  1 (Are you sure that I do not need comfort care 1)
    2 (Am I sure you don\'t need hospice ? At this point you would really just prefer to be comfortable \.) (0 :out)
  1 (Can I get addicted to narcotics 1)
    2 (Usually when you hear about narcotics \, it\'s people getting addicted to them \. Is that a possibility here ?) (0 :out)
  1 (You are sleeping poorly because of your mental health 1)
    2 (You see \. You do try to keep carrying on\, but sometimes you just feel down \.) (0 :out)
  1 (Has the cancer gotten worse 1)
    2 (Does that mean that the cancer has gotten worse ?) (0 :out)
  1 (What are my options for treatment 1)
    2 (Keeping a high quality of life for the rest of your time is the most important thing to you right now \.
       What\'s the best option for making sure this is possible ?) (0 :out)
  1 (Do you think radiation will help 1)
    2 (Do I think radiation is really going to help at this point ?) (0 :out)
  1 (What happens if I do not do chemotherapy 1)
    2 (What happens if you don\'t do chemotherapy ?) (0 :out)
  1 (I would like a refill of medicine 1)
    2 (I need a refill of my Lortab \.) (0 :out)

  ; Direct rules for elaborating answers
  ; NOTE: if there are ever multiple contexts where these are warranted with different
  ; surface utterances, these need to be pulled out into separate subtrees. For now,
  ; we assume that these occur in a specific context and can thus have a specific elaboration.
  1 (I got my diagnosis after visiting a lung doctor 1)
    2 (Well\, you first went to your regular doctor\, but he didn\'t find anything and just thought you had a bad
       cold \. But after the pain and cough got really bad\, you went to the ER \. They thought it was just pneumonia
       and gave you antibiotics and Lortab for pain \. When they told you how much you weighed\, you realized that you
       had lost fifteen pounds over the course of the past six months \. A couple of days ago after you went to the
       ER\, you made appointments to go for a bunch of tests \. That took a couple of weeks \. You had to get a bone scan\,
       and you were sent to the lung doctor for a biopsy \. After all that \, the lung doctor told you that you had lung cancer \.) (0 :out)
  1 (I have constipation and my appetite is worse 1)
    2 (You have constipation\, though you have had that for a year \. Your appetite is worse \. You don\'t eat much anymore \.) (0 :out)
  1 (I have lost my appetite 1)
    2 (You have lost your appetite a bit \. The food looks good\, but you can only take a couple bites and then you are done \.) (0 :out)
  1 (I do not have the symptom you mentioned 1)
    2 (No\, you haven\'t had problems with that \.) (0 :out)
  1 (I had radiation treatment for five weeks 1)
    2 (You did get radiation treatment\, for about five weeks \. You finished about six weeks ago \.) (0 :out)
  1 (I had some hair loss and redness at the site of radiation 1)
    2 (You had a little bit of hair loss and redness at the site\, but it\'s mostly gone now \.) (0 :out)
  1 (I was feeling a little better after radiation 1)
    2 (You were feeling a little better after radiation\, for a few weeks \.) (0 :out)
  1 (I drove here today 1)
    2 (You drove here today \. You have just been taking your time with it \.) (0 :out)
  1 (I am here alone 1)
    2 (You are staying with your daughter now \. She took the day off to come in today\, but someone called in sick where she works \.
       So\, she had to go in \. She really wanted to be here \.) (0 :out)
  1 (I usually take a nap during the day 1)
    2 (You usually take a nap during the day \. About one hour to two hours \.) (0 :out)
  1 (I have been fatigued 1)
    2 (You have been fatigued most days for the past month \. If you are just doing something normal\, you are fine\, but you don\'t
       have as much energy as you used to \.) (0 :out)
  1 (I have had trouble concentrating 1)
    2 (You have only had trouble concentrating sometimes \.) (0 :out)
  1 (I feel mildly depressed 1)
    2 (Well\, you do try to keep carrying on\, but sometimes you just feel down \.) (0 :out)
  1 (I don\'t have allergies to any medicine 1)
    2 (No\, you don\'t believe you have any allergies \.) (0 :out)
  1 (I am taking blood pressure medicine 1)
    2 (You have been taking Cozar for blood pressure for about ten years \.) (0 :out)
  1 (I have a history of alcohol abuse but do not drink now 1)
    2 (There was a point in your life that you drank fairly often \. But you cut back on your own\, and you don\'t really drink a lot now \.
       Truth be told\, ever since the diagnosis\, you have kind of lost your taste for alcohol \.) (0 :out)
  1 (I have a history of smoking but quit six months ago 1)
    2 (You were a pretty heavy smoker once \. You started your senior year in high school\, then smoked about a pack a day up until
       about six months ago \. Now you don\'t smoke at all \.) (0 :out)
  1 (Nobody in my family has a history of mental illness 1)
    2 (You don\'t think so \. As far as you know\, no one in your family has experienced that sort of thing \.) (0 :out)
  1 (My mother died from diabetes and my father died from prostate cancer 1)
    2 (Your parents passed on a few years ago \. Both at seventy three\, if I would believe it \. 
       Your mother died from complications with her diabetes \. She was a smoker\, something she passed onto you \.
       Your father\, though\, died when his prostate cancer went into his bones \. Near the end of his life\, he was in a
       lot of pain\, which I guess is why you worry about your medications \.) (0 :out)

  ; By default, simply output the gist-clause
  1 (0)
    2 (1) (0 :out)
))

; Below here are specific subtrees for elaborating questions or answers based on context of previous user utterance
;```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````

(READRULES '*response-tree-comfort-care*
'(
  1 (Comfort care is a treatment option 1)
    2 (Comfort care sounds good to you \. What you want is to try to get your life back to normal as much as possible \.
       You know\, spend time with your family\. What do you have to do for that ?) (0 :out)
  1 (Have you considered comfort care 1)
    2 (You haven\'t thought about it\, but it sounds like what you really need \. A way to maintain quality of life
       during the time you have left \. Can I tell you about it ?) (0 :out)
))

(READRULES '*response-tree-pain-medication-not-working*
'(
  1 (Is the pain medication working at all 1)
    2 (The Lortab is working a little bit\, but not much \.) (0 :out)
  1 (Is the pain medication working 1)
    2 (No\, it\'s not really working anymore \. So you have been taking the pills every three hours instead of every four \.) (0 :out)
  1 (0)
    2 (Could I tell you why the pain medication isn\'t working anymore ?) (0 :out)
))

(READRULES '*response-tree-lortab-frequency*
'(
  1 (How often are you taking medication 1)
    2 (You are taking two pills of Lortab every three hours now for the past couple of weeks\, since this pain has come back \.) (0 :out)
  1 (Does taking medication more frequently help 1)
    2 (Taking the Lortab more often seems to help a little \. You are already taking it every three hours \.) (0 :out)
))

(READRULES '*response-tree-sleep*
'(
  1 (Have you been sleeping okay 1)
    2 (You have been having a bit of trouble \. You keep waking up at night \. Most nights you have to take your pain medication
       before falling back to sleep again \.) (0 :out)
  1 (How often are you waking up at night 1)
    2 (You haven\'t really been keeping track \. Maybe about four or five times in a night \.) (0 :out)
  1 (What is on your mind when you try to sleep 1)
    2 (When you actually sleep\, you don\'t really have anything on your mind \. When you have trouble sleeping you usually can\'t think
       of anything except for the pain \.) (0 :out)
))

(READRULES '*response-tree-test-results*
'(
  1 (Do you know what the tests say 1)
    2 (You don\'t really understand the test results \. Can I explain them ?) (0 :out)
  1 (0)
    2 (Could I explain what your test results mean ?) (0 :out)
))

(READRULES '*response-tree-weight*
'(
  1 (Have you changed weight 1)
    2 (You have lost some weight \.) (0 :out)
  1 (How much weight have you lost 1)
    2 (You have lost about twenty five pounds since they started \. You gained seven back in radiation\, but You are still down a bit \.) (0 :out)
))

(READRULES '*response-tree-pain*
'(
  1 (Can you tell me about your pain 1)
    2 (The pain was pretty much under control for a while\, but in the past week it has been more difficult \.
       It used to be in your back and left side of your chest\, but now it\'s in your shoulder blade too\, and on
       the other side from where it started \.) (2 :out)
    2 (The pain doesn\'t really go into other areas \. It\'s dull and constant\, and aches a lot \. It usually
       hurts to take deep breathes \.) (0 :out)
  1 (How do you rate your pain 1)
    2 (The pain is about a seven out of ten \. With medication\, it goes down to about a five \.) (0 :out)
  1 (Where is the pain located 1)
    2 (The pain is primarily in the left side of your chest\, and in the middle of your back \. Recently\,
       it also moved to the right side of your chest \.) (0 :out)
  1 (Does it hurt to 3)
    2 (It hurts whenever you take a deep breath \. It used to hurt to swallow during radiation\, but that isn\'t as bad now \.) (0 :out)
  1 (Did your pain come back 1)
    2 (Your pain came back a couple weeks after you finished radiation \. It\'s been getting worse recently \.) (0 :out)
))

(READRULES '*response-tree-medication*
'(
  1 (You should take stronger pain medication 1)
    2 (Yeah\, you think you should take a stronger pain medication \. The current one isn\'t working well \. What are the side effects ?) (100 :out)
    2 (Yeah \, a stronger pain medication would be good \. What would the side effects be ?) (0 :out)
  1 (Do you want stronger pain medication 1)
    2 (You think you could use a stronger pain medication \. Something to help make you more comfortable \. What are the side effects ?) (100 :out)
    2 (You think having the stronger pain medication would help \.) (0 :out)
  1 (You should take something different 1)
    2 (You think something stronger for the pain would be good \. What would the side effects be for a different pain medication ?) (0 :out)
  1 (What medicine are you taking 1)
    2 (You are just taking the Lortab for pain right now \.) (0 :out)
  1 (Are you taking pain-med 1)
    2 (You think so \. You are taking Lortab for pain right now \.) (0 :out)
  1 (Are you taking pain-med-other 1)
    2 (No\, you are not taking any of those \. Just the Lortab \.) (0 :out)
  1 (What is your history with med-narcotic 1)
    2 (You took some pain medication for a fractured ankle about fifteen or so years ago\, but you don\'t believe it was a narcotic \. 
       Besides that\, your doctor prescribed you Lortab about three weeks ago \.) (0 :out)
  1 (Are you taking med-narcotic 1)
    2 (No\, you are not taking any of those \. Just the Lortab \.) (0 :out)
))

(READRULES '*response-tree-treatment-chemotherapy*
'(
  1 (Chemotherapy is a treatment option 1)
    2 (Do I think chemotherapy is really going to help ?) (0 :out)
  1 (0)
    2 (What about chemotherapy ?) (0 :out)
))

(READRULES '*response-tree-chemotherapy-explanation*
'(
  1 (A side effect of chemotherapy is 8)
    2 (Okay \. How does chemotherapy usually work ?) (0 :out)
  1 (0)
    2 (How does chemotherapy usually work ?) (0 :out)
))

(READRULES '*response-tree-chemotherapy*
'(
  1 (Did your doctor mention chemotherapy 1)
    2 (Your doctor mentioned something about chemotherapy\, but said that you should wait to see how
       things go after the radiation is done \. Why? Do I think you need chemotherapy ?) (0 :out)
  1 (0)
    2 (Do I think you need chemotherapy ?) (0 :out)
))

(READRULES '*response-tree-prognosis*
'(
  1 (Your cancer has gotten worse 1)
    2 (What does that mean for you ?) (0 :out)
  1 (The prognosis is that you cannot be cured 1)
    2 (You feared as much \, though it\'s still pretty upsetting \. How long do I think you have ?) (0 :out)
  1 (The prognosis is that your cancer should be treated with chemotherapy 1)
    2 (You want to talk about your options in a minute\, but first you just want to know how bad it really is \. How long do I think you have ?) (0 :out)
  1 (The prognosis is hard to predict 1)
    2 (Your last doctor also just said it would be hard to predict \. You think you are ready to hear though \. Could I please just tell you what the worst case looks like ?) (0 :out)
  1 (The test results show that the cancer hasn\'t spread 1)
    2 (Your previous doctor didn\'t seem very optimistic \. So what do I think this all means for you ?) (0 :out)
  1 (The test results show that you cannot be cured 1)
    2 (That\'s distressing \. You were trying to prepare for the worst\, though \. What you are wondering at this point is\, how much time do you have left ?) (0 :out)
  1 (The test results show that your cancer has spread 1)
    2 (You see \. That sounds pretty bleak \. What does it mean for you ?) (0 :out)
))

(READRULES '*response-tree-rephrase*
'(
  1 (0)
    2 (You are sorry\, you didn\'t quite understand\. Can I say it again ?) (3 :out)
    2 (Would I mind rephrasing ?) (3 :out)
    2 (Could I repeat that one more time using a different phrasing ?) (0 :out)
))