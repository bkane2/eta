(READRULES '*reaction-to-question-specific-session*
; This tree can be used to define reactions to questions specific to a particular module/session. Here the rule
; tree is empty, but it can be overridden in day1/rules to add specific rules.
;
'(

)) ; END *reaction-to-question-specific-session*


(READRULES '*reaction-to-question*
; Here we match any important questions which may branch off into a sub-dialogue, i.e. initiate a sub-schema.
; A separate tree is used for matching any less relevant questions, which prompt Eta to give an answer but then
; return to the central track of the conversation.
;
'(
  ; Preempt any reactions specific to a particular module
  1 (0)
    2 *reaction-to-question-specific-session* (0 :subtree)

  ; Questions about pain
  1 (Can I tell you about my pain ?)
    2 *say-pain-worse* (3 :schema)
    2 *say-pain-worse* (3 :schema)
    2 (I did have some pain during swallowing after radiation as well\, but that\'s improved a bit \.) (0 :out)
  1 (How do I rate my pain ?)
    2 *say-pain-worse* (0 :schema)
  1 (Where is the pain located ?)
    2 *say-pain-worse* (0 :schema)
  1 (Does it hurt to 2 ?)
    2 *say-pain-worse* (0 :schema)
  1 (Did my pain come back ?)
    2 *say-pain-worse* (0 :schema)
  1 (Has the pain become worse ?)
    2 *say-pain-worse* (0 :schema)
  1 (Do you have the pain frequently ?)
    2 *say-pain-worse* (0 :schema)
  1 (Can I tell you about my pain instead of test results ?)
    2 *say-pain-worse* (100 :schema)
    2 *ask-about-test-results* (0 :schema)

  ; Questions about how you got your diagnosis
  1 (How did I get my diagnosis ?)
    2 *explain-how-got-diagnosis* (0 :schema)
  1 (What symptoms do I have ?)
    2 *explain-symptoms* (0 :schema)
  1 (Have I changed weight ?)
    2 *mention-lost-weight* (0 :schema)
  1 (How much weight have I lost ?)
    2 *mention-lost-weight* (0 :schema)
  1 (Have I changed appetite ?)
    2 *mention-lost-appetite* (0 :schema)
  1 (Do I have the symptom of 2 ?)
    2 *deny-symptom* (0 :schema) ; might need to be made more specific, but we're assuming that this is
                                 ; a "catch-all" rule for any symptom which isn't captured as another
                                 ; gist-clause listed above
  1 (What test results am I referring to ?)
    2 *ask-about-test-results* (0 :schema)
  1 (Do I know what the tests say ?)
    2 *ask-about-test-results* (0 :schema)
  1 (How do I feel about my test results ?)
    2 *ask-about-test-results* (0 :schema)
  1 (Do I have a question about my test results ?)
    2 *ask-about-test-results* (0 :schema)
  1 (How much information do I want about my test results ?)
    2 *ask-about-test-results* (0 :schema)
  1 (Do I want my family to be present when you tell me about the test results ?)
    2 *ask-about-test-results* (0 :schema)

  ; Questions about radiation treatment
  1 (Did I get radiation treatment ?)
    2 *mention-radiation-time* (0 :schema)
  1 (Did I get any hair loss or redness during radiation treatment ?)
    2 *discuss-radiation-symptoms* (0 :schema)
  1 (Did the pain respond to radiation treatment ?)
    2 *mention-feeling-better-after-radiation* (0 :schema)

  ; Questions about appointment
  1 (Did I drive here ?)
    2 *explain-drove-today* (0 :schema)
  1 (Is anyone here with me ?)
    2 *explain-here-alone* (0 :schema)

  ; Questions about chemotherapy
  1 (Did my doctor mention chemotherapy ?)
    2 *ask-if-need-chemotherapy* (0 :schema)
  1 (What chemotherapy details are you asking about ?)
    2 *ask-how-chemotherapy-works* (0 :schema)
  1 (Do I understand how chemotherapy works ?)
    2 *ask-how-chemotherapy-works* (0 :schema)
  1 (Do I have a question about chemotherapy ?)
    2 *ask-about-chemotherapy-side-effects* (0 :schema)
  1 (What are my feelings about chemotherapy ?)
    2 *ask-if-need-chemotherapy* (0 :schema)

  ; Questions about sleep
  1 (Have I been sleeping okay ?)
    2 *explain-not-sleeping-well* (0 :schema)
  1 (How often am I waking up at night ?)
    2 *explain-not-sleeping-well* (0 :schema)
  1 (Do I sleep during the day ?)
    2 *mention-taking-naps* (0 :schema)
  1 (What is on my mind when I try to sleep ?)
    2 *explain-not-sleeping-well* (0 :schema)
  1 (What happens when I try to sleep ?)
    2 *explain-not-sleeping-well* (0 :schema)
  1 (What is my sleep routine ?)
    2 *discuss-sleep-routine* (0 :schema)
  1 (Is your mental health keeping you awake ?)
    2 *explain-not-sleeping-well* (0 :schema)
  1 (Is coffee keeping you awake ?)
    2 *explain-not-sleeping-well* (0 :schema)
  1 (Can I tell you about my sleep instead of test results ?)
    2 *explain-not-sleeping-well* (100 :schema)
    2 *ask-about-test-results* (0 :schema)

  ; Questions about energy
  1 (How is my energy ?)
    2 *mention-fatigue* (0 :schema)
  1 (Have I had trouble concentrating ?)
    2 *mention-trouble-concentrating* (0 :schema)
  1 (How is my mental health ?)
    2 *mention-mild-depression* (0 :schema)
  1 (Is something harming your mental health ?)
    2 *mention-anxiety* (0 :schema)

  ; Questions about medicine
  1 (Do I have allergies to any medicine ?)
    2 *deny-allergies* (0 :schema)
  1 (What medicine am I taking ?)
    2 *mention-taking-lortab* (0 :schema)
  1 (How were you prescribed your current pain medication ?)
    2 *mention-taking-lortab* (0 :schema)
  1 (What dosage of pain medication am I taking ?)
    2 *mention-taking-lortab* (0 :schema)
  1 (Am I taking pain-med ?)
    2 *mention-taking-lortab* (0 :schema)
  1 (How often am I taking medication ?)
    2 *mention-lortab-frequency* (0 :schema)
  1 (Does taking medication more frequently help ?)
    2 *mention-lortab-frequency* (0 :schema)
  1 (Am I taking pain-med-other ?)
    2 *mention-taking-lortab* (0 :schema)
  1 (Am I taking blood-pressure-med ?)
    2 *mention-blood-medication* (0 :schema)
  1 (Am I taking med-narcotic ?)
    2 *mention-taking-lortab* (0 :schema)
  1 (Is the pain medication working at all ?)
    2 *ask-why-pain-medication-not-working* (0 :schema)
  1 (Is the pain medication working ?)
    2 *ask-why-pain-medication-not-working* (0 :schema)
  1 (How is the pain medication working ?)
    2 *ask-why-pain-medication-not-working* (0 :schema)
  1 (Do I want stronger pain medication ?)
    2 *ask-about-pain-medication-side-effects* (0 :schema)
  1 (Do I need more medicine ?)
    2 *ask-for-lortab-refill* (0 :schema)
  1 (Do I have a question about my medicine ?)
    2 *ask-why-pain-medication-not-working* (0 :schema)

  ; Comfort care
  1 (Have I considered comfort care ?)
    2 *ask-how-comfort-care-works* (0 :schema)
  1 (Do I understand how comfort care works ?)
    2 *ask-how-comfort-care-works* (0 :schema)
  1 (Do I have a question about comfort care ?)
    2 *ask-how-comfort-care-works* (0 :schema)

  ; Questions about medical history
  1 (What is my history with alcohol ?)
    2 *discuss-drinking-habits* (100 :schema)
    2 (At one time\, I suppose I used to have a drink or two maybe three or four days a week \. I have cut back since then though \. 
       now\, since the cancer diagnosis\, I only have a couple drinks a week \.) (0 :out)
  1 (What is my history with smoking ?)
    2 *discuss-smoking-habits* (100 :schema)
    2 (I have been a heavy smoker since high school\, but I kicked the habit six months ago \.) (0 :out)
  1 (What is my history with med-narcotic ?)
    2 *mention-taking-lortab* (0 :schema)
  1 (Does my family have a history of mental illness ?)
    2 *discuss-history-mental-illness* (100 :schema)
    2 (No\, no one in my family has any history of mental illness \.) (0 :out)
  1 (How did my parents die ?)
    2 *discuss-parent-deaths* (0 :schema)

  ; Questions about talking with family
  1 (Do my family know about my cancer ?)
    2 *ask-what-to-tell-family* (100 :schema)
    2 (My family knows that I have cancer already\, but not much else \.) (0 :out)
  1 (Do I want you to be present when I tell my family about the prognosis ?)
    2 *ask-what-to-tell-family* (100 :schema)
    2 (I can\'t tell you how much I appreciate the offer\, but I think I should break the news to them myself \.) (0 :out)
  1 (How much do I want my family to know about the prognosis ?)
    2 *ask-what-to-tell-family* (100 :schema)
    2 (Now that I think about it more\, my son and daughter both should probably know as much as I do about the prognosis\, since I may need their help as the cancer progresses\.
       My grandson\, though\, he\'s only in middle school\, and I\'d like to protect him for as long as I can\.) (0 :out)
  1 (Who in my family do I want to tell about the prognosis ?)
    2 *ask-what-to-tell-family* (100 :schema)
    2  (I\'d have to tell my son\, and certainly my daughter \. I\'m currently staying with both her and my grandson here in Rochester \, and I imagine I\'ll probably lean on her a lot more as the cancer progresses \.) (0 :out)

  ; Questions about treatment options
  1 (What do I understand about my treatment options ?)
    2 *ask-about-treatment-options* (0 :schema)
  1 (Do I have a question about my treatment options ?)
    2 *ask-about-will-experimental-therapies-help* (0 :schema)
  1 (What are my treatment goals ?)
    2 *ask-about-treatment-options* (0 :schema)
    2 *ask-how-comfort-care-works* (0 :schema)
  1 (What is the prognosis that was given to me previously ?)
    2 *ask-about-treatment-options* (0 :schema)
    2 (I was told I probably wouldn\'t have a long time left\, maybe two or three years at best\.) (0 :out)
  1 (Am I ready to start discussing treatment options ?)
    2 *ask-about-prognosis* (0 :schema)
  1 (How much information do I want about my prognosis ?)
    2 *ask-about-prognosis* (0 :schema)

  ; Questions about prognosis
  ; TODO: should instantiate a schema where SOPHIE explains her (possibly incorrect) knowledge of
  ; her prognosis; e.g., "I know you said two to three months, but I feel pretty good now"
  1 (Do I understand my prognosis ?)
    2 *ask-about-prognosis* (0 :schema) 
    2 *ask-if-can-trust-prognosis* (0 :schema)
  1 (How do I feel about my prognosis ?)
    2 *ask-about-prognosis* (0 :schema)
  1 (What scares me about my prognosis ?)
    2 *ask-about-prognosis* (0 :schema)
  1 (Do I have a question about my prognosis ?)
    2 *ask-for-second-opinion* (0 :schema)

  ; Open-ended questions 
  1 (What do I understand ?)
    2 *explain-understanding-of-condition* (0 :schema)
  1 (How am I feeling about my condition ?)
    2 *explain-understanding-of-condition* (0 :schema)
  1 (What scares me about my condition ?)
    2 *explain-understanding-of-condition* (0 :schema)  
  1 (What is the most important thing for my future ?)
    2 *explain-future-goals* (0 :schema)
  1 (Was I nervous for this appointment ?)
    2 *mention-anxiety* (0 :schema)
  1 (Can you call me Sophie ?)
    2 *confirm-name* (0 :schema)
  
  1 (0)
    2 *reaction-to-question-minor* (0 :subtree)
))


(READRULES '*reaction-to-question-minor*
; Here we match any question gist clauses which are considered "minor", i.e. off-topic or otherwise
; not expected to branch off into a further sub-dialogue.
'(
  ; Questions about daughter
  1 (Where does my daughter work ?)
    2 (She works as a nurse in the county school system\. She\'s very diligent\. They gave her an award last year\, but I\'m blanking on the name of it\.) (0 :out)
  1 (Where does my son work ?)
    2 (He\'s in construction management\, out over in Utica\. He supervised the team that built the new firehouse there last year\.) (0 :out)
  1 (How old is my daughter ?)
    2 (She\'s thirty four\. Turning thirty five in a few months\.) (0 :out)
  1 (How old is my son ?)
    2 (He\'ll be celebrating his fortieth this year\, and is not happy about it\.) (0 :out)
  1 (Do I have any grandchildren ?)
    2 (Yes\, one grandson\. He\'s starting middle school this year and is absolutely thrilled about it\.) (0 :out)
  1 (Do I have any children ?)
    2 (Yes\, I\'m staying with my daughter and her husband here in rochester\, but I have a son out in Utica as well\.) (0 :out)
  1 (Do I live alone ?)
    2 (I live with my daughter and her husband while I\'m here in Rochester \.) (0 :out)
  1 (Am I married ?)
    2 (I was for about twenty years\. But as we got older and the kids went off to college\, things just didn\'t work out as well as we thought they would\. We separated about ten years ago and divorced two years later\.) (0 :out)
  1 (How am I doing today ?)
    2 ([HAPPY] I\'m fine\, thank you\.) (0 :out)
  ; Questions about family (Todo)
))