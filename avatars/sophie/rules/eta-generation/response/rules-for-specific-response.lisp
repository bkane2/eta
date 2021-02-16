; The rules defined in this file are used to generate a specific response for a topic, in the context of the
; user's previous gist-clause (the specific rule tree is initially chosen based on the gist-clause of Eta's response).
;
; All trees defined in this file should be named using format *response-tree-<topic>*.


(READRULES '*response-tree-treatment-options*
; (What are my options for treatment 1)
'(
  1 (0 Maintaining good quality of life is a treatment option 0)
    2 (Keeping a high quality of life for the rest of my time is the most important thing to me right now \.
       What\'s the best option for making sure this is possible ?) (0 :out)

  1 (0)
    2 (What are my choices at this point ?) (0 :out)

)) ; END *response-tree-treatment-options*



(READRULES '*response-tree-comfort-care*
; (How does comfort care work 1)
'(
  1 (0 Comfort care is a treatment option 0)
    2 (Comfort care sounds good to me \. What I want is to try to get my life back to normal as much as possible \.
       You know\, spend time with my family\. What do I have to do for that ?) (0 :out)
  1 (0 Have I considered comfort care 0)
    2 (I haven\'t thought about it\, but it sounds like what I really need \. A way to maintain quality of life
       during the time I have left \. Can you tell me about it ?) (0 :out)

)) ; END *response-tree-comfort-care*



(READRULES '*response-tree-pain-medication-not-working*
; (Why isn\'t the pain medication working anymore 1)
'(
  1 (0 Is the pain medication working at all 0)
    2 (The lortab is working a little bit\, but not much \.) (0 :out)
  1 (0 Is the pain medication working 0)
    2 (No\, it\'s not really working anymore \. So I have been taking the pills every three hours instead of every four \.) (0 :out)

  1 (0)
    2 (Could you tell me why the pain medication isn\'t working anymore ?) (0 :out)

)) ; END *response-tree-pain-medication-not-working*



(READRULES '*response-tree-lortab-frequency*
; (I am taking Lortab every three hours 1)
'(
  1 (0 How often am I taking medication 0)
    2 (I am taking two pills of lortab every three hours now for the past couple of weeks\, since this pain has come back \.) (0 :out)
  1 (0 Does taking medication more frequently help 0)
    2 (Taking the lortab more often seems to help a little \. I am already taking it every three hours \.) (0 :out)

)) ; END *response-tree-lortab-frequency*



(READRULES '*response-tree-sleep*
; (I have not been sleeping well 1)
'(
  1 (0 Have I been sleeping okay 0)
    2 (I have been having a bit of trouble \. I keep waking up at night \. Most nights I have to take my pain medication
       before falling back to sleep again \.) (0 :out)
  1 (0 How often am I waking up at night 0)
    2 (I haven\'t really been keeping track \. Maybe about four or five times in a night \.) (0 :out)

  1 (0 What is on my mind when I try to sleep 0)
    2 (When I actually sleep\, I don\'t really have anything on my mind \. When I have trouble sleeping I usually can\'t think
       of anything except for the pain \.) (0 :out)
  1 (0 What happens when I try to sleep 0)
    2 (I usually have trouble staying asleep \. Sometimes I wake up in the middle of the night and notice an ache in my
       back and near my chest \. That\'s when I have to take pain medication to fall back asleep \.) (0 :out)

)) ; END *response-tree-sleep*



(READRULES '*response-tree-test-results*
; (What do my test results mean 1)
'(
  1 (0 Do I know what the tests say 0)
    2 (I don\'t really understand the test results \. Can you explain them ?) (0 :out)

  1 (0)
    2 (Could you explain to me what my test results mean ?) (0 :out)
)) ; END *response-tree-test-results*



(READRULES '*response-tree-weight*
; (I have lost weight 1)
'(
  1 (0 Have I changed weight 0)
    2 (I have lost some weight \.) (0 :out)
  1 (0 How much weight have I lost 0)
    2 (I have lost about twenty five pounds since they started \. I gained seven back in radiation\, but I am still down a bit \.) (0 :out)

)) ; END *response-tree-weight*



(READRULES '*response-tree-pain*
; (My pain has recently been getting worse 1)
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

)) ; END *response-tree-pain*



(READRULES '*response-tree-medication*
; (What are the side effects of stronger pain medication 1)
; (I am only taking Lortab to treat my pain 1)
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

)) ; END *response-tree-medication*



(READRULES '*response-tree-treatment-chemotherapy*
'(
  1 (0 Chemotherapy is a treatment option 0)
    2 (Do you think chemotherapy is really going to help ?) (0 :out)

  1 (0)
    2 (What about chemotherapy ?) (0 :out)

)) ; END *response-tree-treatment-chemotherapy*



(READRULES '*response-tree-chemotherapy-explanation*
; (How does chemotherapy work 1)
'(
  1 (0 A side effect of chemotherapy is 0)
    2 (Okay \. How does chemotherapy usually work ?) (0 :out)

  1 (0)
    2 (How does chemotherapy usually work ?) (0 :out)

)) ; END *response-tree-chemotherapy-explanation*



(READRULES '*response-tree-chemotherapy*
; (How does chemotherapy work 1)
; (Do I need chemotherapy 1)
'(
  1 (0 Did my doctor mention chemotherapy 0)
    2 (My doctor mentioned something about chemotherapy\, but said that I should wait to see how
       things go after the radiation is done \. Why? Do you think I need chemotherapy ?) (0 :out)

  1 (0)
    2 (My previous doctor mentioned something about chemotherapy\, but he said to wait to see how
       things go after the radiation \. Do you think I need chemotherapy ?) (100 :out)
    2 (Thanks\, though I\'m still a bit confused at this point \. Should I get chemotherapy ?) (100 :out)
    2 (Do you think I need chemotherapy ?) (0 :out)

)) ; END *response-tree-chemotherapy*



(READRULES '*response-tree-prognosis*
; (what is 1 prognosis 1)
'(
  1 (0 My cancer has gotten worse 0)
    2 (What does that mean for me ?) (0 :out)
  1 (0 The prognosis is that I cannot be cured 0)
    2 (I feared as much \, though it\'s still pretty upsetting \. How long do you think I have ?) (0 :out)

  1 (0 The prognosis is that my cancer should be treated with chemotherapy 0)
    2 (I want to talk about my options in a minute\, but first I just want to know how bad it really is \.
       How long do you think I have ?) (0 :out)

  1 (0 The prognosis is hard to predict 0)
    2 (My last doctor also just said it would be hard to predict \. I think I am ready to hear though \. Could you
       please just tell me what the worst case looks like ?) (0 :out)

  1 (0 The test results show that the cancer hasn\'t spread 0)
    2 (My previous doctor didn\'t seem very optimistic \. So what do you think this all means for me ?) (0 :out)

  1 (0 The test results show that me cannot be cured 0)
    2 (That\'s distressing \. I was fearing the worst\, but in the back of my mind I didn\'t think it would all
       happen so quickly \. My family will be distraught \. What I am wondering at this point is\, how much time
       do I have left ?) (0 :out)

  1 (0 The test results show that my cancer has spread 0)
    2 (Those are not the words I wanted to hear \. I mean\, I was bracing for the worst\, since I could tell by the
       pain that it\'s bad \. But to hear that the cancer has spread is quite depressing \. What does
       it all mean for me ?) (0 :out)

  1 (0)
    2 (I want you to be honest with me \. How long do you think I have ?) (0 :out)

)) ; END *response-tree-prognosis*



(READRULES '*response-tree-rephrase*
; (can 1 rephrase 1 question 1)
'(
  1 (0)
    2 (I am sorry\, I didn\'t quite understand\. Can you say it again ?) (3 :out)
    2 (Would you mind rephrasing ?) (3 :out)
    2 (Could you repeat that one more time using a different phrasing ?) (0 :out)

)) ; END *response-tree-rephrase*