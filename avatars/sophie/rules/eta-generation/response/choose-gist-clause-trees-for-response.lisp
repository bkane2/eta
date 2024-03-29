(READRULES '*gist-clause-trees-for-response*
'(
  ; Subtrees for elaborating questions
  1 (.CAN 1 rephrase 1 .QUESTION 1)
    2 (*response-tree-rephrase*) (0 :subtrees)
  1 (what are your questions 1)
    2 (*response-tree-questions*) (0 :subtrees)
  1 (how does .CHEMOTHERAPY .WORK 1)
    2 (*response-tree-chemotherapy-explanation*) (0 :subtrees)
  1 (.DO you think .CHEMOTHERAPY will .HELP 1)
    2 (*response-tree-treatment-chemotherapy*) (0 :subtrees)
  1 (what is 1 prognosis 1)
    2 (*response-tree-prognosis*) (0 :subtrees)
  1 (.SHOULD I get a .SECOND opinion on my prognosis 1)
    2 (*response-tree-prognosis*) (0 :subtrees)
  1 (.CAN I trust your prognosis 1)
    2 (*response-tree-prognosis-denial*) (0 :subtrees)
  1 (.CAN I outlive your prognosis if I .HAVE .HEALTHY habits 1)
    2 (*response-tree-bargaining-habits*) (0 :subtrees)
  1 (.CAN I outlive your prognosis if I am .HEALTHY .NOW 1)
    2 (*response-tree-bargaining-now*) (0 :subtrees)
  1 (.CAN I outlive your prognosis until the graduation of my grandson 1)
    2 (*response-tree-bargaining-graduation*) (0 :subtrees)
  1 (what are the side effects of stronger .PAIN medication 1)
    2 (*response-tree-medication*) (0 :subtrees)
  1 (.CAN I .HAVE a stronger .PAIN medication 1)
    2 (*response-tree-medication-stronger-request*) (0 :subtrees)
  1 (what .DO my test results mean 1)
    2 (*response-tree-test-results*) (0 :subtrees)
  1 (.DO I need .CHEMOTHERAPY 1)
    2 (*response-tree-chemotherapy*) (0 :subtrees)
  1 (why isn\'t the .PAIN medication working anymore 1)
    2 (*response-tree-pain-medication-not-working*) (0 :subtrees)
  1 (how does comfort .CARE .WORK 1)
    2 (*response-tree-comfort-care*) (0 :subtrees)
  1 (.SHOULD I get comfort .CARE 1)
    2 (*response-tree-comfort-care*) (0 :subtrees)
  1 (what are my options for .TREATMENT 1)
    2 (*response-tree-treatment-options*) (0 :subtrees)
  1 (.DO you think .EXPERIMENTAL therapies will .HELP 1)
    2 (*response-tree-treatment-options*) (0 :subtrees)
  1 (what are the side effects of .CHEMOTHERAPY 1)
    2 (*response-tree-chemotherapy-side-effects*) (0 :subtrees)
  1 (what .SHOULD I .TELL my .FAMILY 1)
    2 (*response-tree-tell-family*) (0 :subtrees)
  1 (I feel mildly depressed 1)
    2 (*response-tree-mental-health*) (0 :subtrees)
  1 (I feel anxious about my future 1)
    2 (*response-tree-anxiety*) (0 :subtrees)
  1 (why .DO I .HAVE cancer 1)
    2 (*response-tree-reason-for-cancer*) (0 :subtrees)
  1 (.CAN I outlive your prognosis if I .QUIT smoking 1)
    2 (*response-tree-bargaining-quit-smoking*) (0 :subtrees)
  ; Subtrees for elaborating answers
  1 (my .PAIN has .RECENTLY been getting worse 1)
    2 (*response-tree-pain*) (0 :subtrees)
  1 (I .HAVE lost weight 1)
    2 (*response-tree-weight*) (0 :subtrees)
  1 (I .HAVE not been sleeping well 1)
    2 (*response-tree-sleep*) (0 :subtrees)
  1 (why .HAVE I not been sleeping well 1)
    2 (*response-tree-sleep*) (0 :subtrees)
  1 (I am only taking lortab to treat my .PAIN 1)
    2 (*response-tree-medication*) (0 :subtrees)
  1 (I am taking lortab every .THREE hours 1)
    2 (*response-tree-lortab-frequency*) (0 :subtrees)
  1 (I .KNOW that my cancer has gotten worse \, but i\'m not sure how .BAD it is 1)
    2 (*response-tree-understanding-of-condition*) (0 :subtrees)
  1 (I .BELIEVE my cancer has gotten worse .BECAUSE my .PAIN has also gotten worse 1)
    2 (*response-tree-understanding-of-condition*) (0 :subtrees)
  1 (I .WANT to .TALK about my prognosis today 1)
    2 (*response-tree-redirect-to-prognosis*) (0 :subtrees)
  ; Direct rules for elaborating questions
  ; NOTE: if there are ever multiple contexts where these are warranted with different
  ; surface utterances, these need to be pulled out into separate subtrees. For now,
  ; we assume that these occur in a specific context and can thus have a specific elaboration.
  1 (are you sure the cancer has not gotten worse 1)
    2 (Are you sure it\'s not gotten worse ? The pain seems to have gotten worse \.) (0 :out)
  1 (will an .ANTIDEPRESSANT .HELP with my .PAIN 1)
    2 (I see \. Would this help me with me pain ?) (0 :out)
  1 (.SHOULD I .TRY medication .BEFORE I .TRY .THERAPY 1)
    2 (I am not sure \. Do you think there\'s any medication I can try first ?) (0 :out)
  1 (are you sure that I .DO not need comfort .CARE 1)
    2 (Are you sure I don\'t need hospice ? At this point I would really just prefer to be comfortable \.) (0 :out)
  1 (.CAN I get addicted to narcotics 1)
    2 (Usually when I hear about narcotics \, it\'s people getting addicted to them \. Is that a possibility here ?) (0 :out)
  1 (I am sleeping poorly .BECAUSE of my mental health 1) ; CHECK
    2 ([SAD] I see \. I do try to keep carrying on \, but sometimes I just feel down \.) (0 :out)
  1 (has the cancer gotten worse 1)
    2 ([SAD] does that mean that the cancer has gotten worse ?) (0 :out)
  1 (.DO you think radiation will .HELP 1)
    2 (Do you think radiation is really going to help at this point ?) (0 :out)
  1 (what are my .TREATMENT options if I .DO not .DO .CHEMOTHERAPY 1)
    2 (I\'m not sure i\'m ready to start another treatment right now \. Are there any other options if I don\'t do chemotherapy ?) (0 :out)
  1 (I would .LIKE a refill of .MEDICINE 1)
    2 (I need a refill of my lortab \.) (0 :out)
  1 (will stronger .PAIN medication .HELP me .SLEEP 1)
    2 (It seems like my pain is the root of my sleeping problems \. Do you think having stronger pain medication would help with that ?) (0 :out)
  1 (my future feels out of my control .BECAUSE I .DO not .KNOW how .MUCH time I .HAVE remaining to live 1)
    2 (To be honest \, my future has felt out of my control since my cancer diagnosis \. I\'ve been living with the fear that i\'ll wake up one morning and be unable to take care of myself \, or worse \, not wake up at all \. This news today only makes that worse \.) (100 :out)
    2 (After the cancer diagnosis \, I began to worry that I won\'t have enough time left to do everything that I want to \. This news only worsens that fear \. I simply don\'t know how much longer i\'ll have left \.) (0 :out)
  ; The following are from the top-level dialogue track
  1 (how will I .KNOW if my .PAIN medication is working 1)
    2 (I just started on my new pain medication fairly recently \, a couple weeks after radiation \. How long will it be before I know if it\'s working ?) (0 :out)
  ; Direct rules for elaborating answers
  ; NOTE: if there are ever multiple contexts where these are warranted with different
  ; surface utterances, these need to be pulled out into separate subtrees. For now,
  ; we assume that these occur in a specific context and can thus have a specific elaboration.
  1 (I got my diagnosis after visiting a .LUNG doctor 1)
    2 (Well \, I first went to my regular doctor \, but he didn\'t find anything and just thought I had a bad cold \. But after the pain and cough got really bad \, I went to the er \. They thought it was just pneumonia and gave me antibiotics and lortab for pain \. When they told me how much I weighed \, I realized that I had lost fifteen pounds over the course of the past six months \. A couple of days ago after I went to the er \, I made appointments to go for a bunch of tests \. That took a couple of weeks \. I had to get a bone scan \, and I was sent to the lung doctor for a biopsy \. After all that \, the lung doctor told me that I had lung cancer \.) (0 :out)
  1 (I .HAVE .PAIN and constipation and my appetite is worse 1)
    2 (I have pain in my back and chest \, and now my shoulder too \. I have constipation \, though I have had that for a year \. My appetite is worse \. I don\'t eat much anymore \.) (100 :out)
    2 (It feels like my pain has spread \, and i\'m not as hungry as I used to be \.) (0 :out)
  1 (I .HAVE lost my appetite 1)
    2 (I have lost my appetite a bit \. The food looks good \, but I can only take a couple bites and then I am done \.) (0 :out)
  1 (I .DO not .HAVE the .SYMPTOM you mentioned 1)
    2 (No \, I haven\'t had problems with that \.) (0 :out)
  1 (I had radiation .TREATMENT for .FIVE weeks 1)
    2 (I did get radiation treatment \, for about five weeks \. I finished about six weeks ago \.) (0 :out)
  1 (I had some hair loss and .REDNESS at the site of radiation 1)
    2 (I had a little bit of hair loss and redness at the site \, but it\'s mostly gone now \.) (0 :out)
  1 (I was .FEELING a little better after radiation 1)
    2 (I was feeling a little better after radiation \, for a few weeks \.) (0 :out)
  1 (I drove here today 1)
    2 (I drove here today \. I have just been taking my time with it \.) (0 :out)
  1 (I am here .ALONE 1)
    2 (I am staying with my daughter now \. She took the day off to come in today \, but someone called in sick where she works \. So \, she had to go in \. She really wanted to be here \.) (0 :out)
  1 (I usually .TAKE a nap during the .DAY 1)
    2 (I usually take a nap during the day \. About one hour to two hours \.) (0 :out)
  1 (I .HAVE been fatigued 1)
    2 (I have been fatigued most days for the past month \. If i\'m just doing something normal \, I am fine \, but I don\'t have as much energy as I used to \.) (0 :out)
  1 (I .HAVE had .TROUBLE concentrating 1)
    2 (I have only had trouble concentrating sometimes \.) (0 :out)
  1 (I don\'t .HAVE allergies to any .MEDICINE 1)
    2 (No \, I don\'t believe I have any allergies \.) (0 :out)
  1 (I am taking blood pressure .MEDICINE 1)
    2 (I have been taking cozar for blood pressure for about ten years \.) (0 :out)
  1 (I .HAVE a .HISTORY of alcohol abuse but .DO not .DRINK .NOW 1)
    2 (There was a point in my life that I drank fairly often \. But I cut back on my own \, and I don\'t really drink a lot now \. Truth be told \, ever since the diagnosis \, I have kind of lost my taste for alcohol \.) (0 :out)
  1 (I .HAVE a .HISTORY of smoking but .QUIT .SIX months ago 1)
    2 (I was a pretty heavy smoker once \. I started my senior year in high school \, then smoked about a pack a day up until about six months ago \. Now I don\'t smoke at all \.) (0 :out)
  1 (nobody .IN my .FAMILY has a .HISTORY of mental illness 1)
    2 (I don\'t think so \. As far as I know \, no one in my family has experienced that sort of thing \.) (0 :out)
  1 (my .MOTHER died from diabetes and my .FATHER died from prostate cancer 1)
    2 (My parents passed on a few years ago \. Both at seventy three \, if you would believe it \. My mother died from complications with her diabetes \. She was a smoker \, something she passed onto me \. My father \, though \, died when his prostate cancer went into his bones \. Near the end of his life \, he was in a lot of pain \, which I guess is why I worry about my medications \.) (0 :out)
  1 (I .TAKE some .PAIN medication and read a book .BEFORE I .SLEEP 1)
    2 (I take some lortab about an hour before I go to bed \, and then I read a book until I start to fall asleep \.) (0 :out)
  1 (you .CAN .CALL me sophie 1)
    2 (You can call me sophie \.) (2 :out)
    2 (I\'m fine with being called sophie \.) (0 :out)
  1 (I .CAN .HEAR you 1)
    2 (Yes \, I am able to hear you just fine \, thank you for asking \.) (100 :out)
    2 (Oh ! Yes \, I can hear you quite well \.) (0 :out)
  1 (my goal is to survive .LONG enough to .BE there for my .FAMILY \.)
    2 (Of course I want to live as long as possible \, but the most important thing to me is being able to be there for my family \. My grandson is going to graduate from middle school soon \.) (2 :out)
    2 (I just want to be able to spend more time with my family \, and to be comfortable \.) (0 :out)
  1 (you .CAN .HELP me by answering all of my questions 1)
    2 (I think what I need the most right now is just someone who can help me understand what\'s happening to me \. All of this feels so sudden and i\'m having trouble wrapping my mind around what it means for my future \.) (100 :out)
    2 (It may sound silly \, but right now I think what I need is a someone patient and knowledgeable who doesn\'t mind answering all of my questions \. I feel like my whole world has been upended and i\'m still trying to understand what it means for me \.) (0 :out)
  ; By default, simply output the gist-clause
  1 (0)
    2 (1) (0 :out)
))