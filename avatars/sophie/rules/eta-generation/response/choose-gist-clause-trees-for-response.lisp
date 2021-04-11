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
  1 (Can I have a stronger pain medication 1)
    2 (*response-tree-medication-stronger-request*) (0 :subtrees)
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
  1 (What are my treatment options if I do not do chemotherapy 1)
    2 (What are my treatment options if I don\'t do chemotherapy ?) (0 :out)
  1 (I would like a refill of medicine 1)
    2 (I need a refill of my Lortab \.) (0 :out)
  1 (Will stronger pain medication help me sleep 1)
    2 (It seems like my pain is the root of my sleeping problems \. Do you think having
       stronger pain medication would help with that ?) (0 :out)
  ; The following are from the top-level dialogue track
  1 (Why have I not been sleeping well 1)
    2 (One thing I\'ve noticed in the last few weeks is that I haven\'t been sleeping very well \. Most nights I
       have to take medication for my pain \. I\'m not sure if it\'s only the pain\, but I keep waking up at night \.
       Do you know why I keep waking up like this ?) (100 :out)
    2 (Do you know what the specific cause of my poor sleep is ?) (0 :out)
  1 (How will I know if my pain medication is working 1)
    2 (I just started on my new pain medication fairly recently\, a couple weeks after radiation \.
       How long will it be before I know if it\'s working ?) (0 :out)
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
  1 (I feel anxious about my future 1)
    2 (Sometimes I get some pretty bad anxiety about my future\, and what this all means for me \.) (0 :out)
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
  1 (I take some pain medication and read a book before I sleep 1)
    2 (I take some Lortab about an hour before I go to bed\, and then I read a book until I start to fall asleep \.) (0 :out)

  ; By default, simply output the gist-clause
  1 (0)
    2 (1) (0 :out)
    
))