(MAPC 'ATTACHFEAT
  '()
)

(READRULES '*reaction-to-question*
; Here we match any important questions which may branch off into a sub-dialogue, i.e. initiate a sub-schema.
; A separate tree is used for matching any less relevant questions, which prompt Eta to give an answer but then
; return to the central track of the conversation.
;
'(
  ; Questions about pain
  1 (Can you tell me about your pain ?)
    2 *say-pain-worse* (3 :schema)
    2 *say-pain-worse* (3 :schema)
    2 (You did have some pain during swallowing after radiation as well\, but that\'s improved a bit \.) (0 :out)
  1 (How do you rate your pain ?)
    2 *say-pain-worse* (0 :schema)
  1 (Where is the pain located ?)
    2 *say-pain-worse* (0 :schema)
  1 (Does it hurt to 2 ?)
    2 *say-pain-worse* (0 :schema)
  1 (Did your pain come back ?)
    2 *say-pain-worse* (0 :schema)

  ; Questions about how you got your diagnosis
  1 (How did you get your diagnosis ?)
    2 *explain-how-got-diagnosis* (0 :schema)
  1 (What symptoms do you have ?)
    2 *explain-symptoms* (0 :schema)
  1 (Have you changed weight ?)
    2 *mention-lost-weight* (0 :schema)
  1 (How much weight have you lost ?)
    2 *mention-lost-weight* (0 :schema)
  1 (Have you changed appetite ?)
    2 *mention-lost-appetite* (0 :schema)
  1 (Do you have the symptom of 2 ?)
    2 *deny-symptom* (0 :schema) ; might need to be made more specific, but we're assuming that this is
                                 ; a "catch-all" rule for any symptom which isn't captured as another
                                 ; gist-clause listed above
  1 (Do you know what the tests say ?)
    2 *ask-about-test-results* (0 :schema)

  ; Questions about radiation treatment
  1 (Did you get radiation treatment ?)
    2 *mention-radiation-time* (0 :schema)
  1 (Did you get any hair loss or redness during radiation treatment ?)
    2 *discuss-radiation-symptoms* (0 :schema)
  1 (Did the pain respond to radiation treatment ?)
    2 *mention-feeling-better-after-radiation* (0 :schema)

  ; Questions about appointment
  1 (Did you drive here ?)
    2 *explain-drove-today* (0 :schema)
  1 (Is anyone here with you ?)
    2 *explain-here-alone* (0 :schema)

  ; Questions about chemotherapy
  1 (Did your doctor mention chemotherapy ?)
    2 *ask-if-need-chemotherapy* (0 :schema)

  ; Questions about sleep
  1 (Have you been sleeping okay ?)
    2 *explain-not-sleeping-well* (0 :schema)
  1 (How often are you waking up at night ?)
    2 *explain-not-sleeping-well* (0 :schema)
  1 (Do you sleep during the day ?)
    2 *mention-taking-naps* (0 :schema)
  1 (What is on your mind when you try to sleep ?)
    2 *explain-not-sleeping-well* (0 :schema)

  ; Questions about energy
  1 (How is your energy ?)
    2 *mention-fatigue* (0 :schema)
  1 (Have you had trouble concentrating ?)
    2 *mention-trouble-concentrating* (0 :schema)
  1 (how is your mental health ?)
    2 *mention-mild-depression* (0 :schema)

  ; Questions about medicine
  1 (Do you have allergies to any medicine ?)
    2 *deny-allergies* (0 :schema)
  1 (What medicine are you taking ?)
    2 *mention-taking-lortab* (0 :schema)
  1 (Are you taking pain-med ?)
    2 *mention-taking-lortab* (0 :schema)
  1 (How often are you taking medication ?)
    2 *mention-lortab-frequency* (0 :schema)
  1 (Does taking medication more frequently help ?)
    2 *mention-lortab-frequency* (0 :schema)
  1 (Are you taking pain-med-other ?)
    2 *mention-taking-lortab* (0 :schema)
  1 (Are you taking blood-pressure-med ?)
    2 *mention-blood-medication* (0 :schema)
  1 (Are you taking med-narcotic ?)
    2 *mention-taking-lortab* (0 :schema)
  1 (Is the pain medication working at all ?)
    2 *ask-why-pain-medication-not-working* (0 :schema)
  1 (Is the pain medication working ?)
    2 *ask-why-pain-medication-not-working* (0 :schema)
  1 (Do you want stronger pain medication ?)
    2 *ask-about-pain-medication-side-effects* (0 :schema)
  1 (Do you need more medicine ?)
    2 *ask-for-lortab-refill* (0 :schema)

  ; Comfort care
  1 (Have you considered comfort care ?)
    2 *ask-about-comfort-care* (0 :schema)

  ;Questions about medical history
  1 (What is your history with alcohol ?)
    2 *discuss-drinking-habits* (100 :schema)
    2 (At one time\, you suppose you used to have a drink or two maybe three or four days a week \. You have cut back since then though \. 
       Now\, since the cancer diagnosis\, you only have a couple drinks a week \.) (0 :out)
  1 (What is your history with smoking ?)
    2 *discuss-smoking-habits* (100 :schema)
    2 (You have been a heavy smoker since high school\, but you kicked the habit six months ago \.) (0 :out)
  1 (What is your history with med-narcotic ?)
    2 *mention-taking-lortab* (0 :schema)
  1 (Does your family have a history of mental illness ?)
    2 *discuss-history-mental-illness* (100 :schema)
    2 (No\, no one in your family has any history of mental illness \.)  (0 :out)
  1 (How did your parents die ?)
    2 *discuss-parent-deaths* (0 :schema)
                           
  1 (0)
    2 *reaction-to-question-minor* (0 :subtree)
))


(READRULES '*reaction-to-question-minor*
; Here we match any question gist clauses which are considered "minor", i.e. off-topic or otherwise
; not expected to branch off into a further sub-dialogue.
'(
  ; Questions about daughter
  1 (Where does your daughter work ?)
    2 (She works as a school nurse in the county school system\. She\'s very diligent\. They gave her an award last year\, but I\'m blanking on the name of it\.) (0 :out)
  1 (Where does your son work ?)
    2 (He\'s in construction management\, out over in Utica\. He supervised the team that built the new firehouse there last year\.) (0 :out)
  1 (How old is your daughter ?)
    2 (She\'s thirty four\. Turning thirty five in a few months\.) (0 :out)
  1 (How old is your son ?)
    2 (He\'ll be celebrating his fortieth this year\, and is not happy about it\.) (0 :out)
  1 (Do you have any grandchildren ?)
    2 (Yes\, one grandson\. He\'s starting middle school this year and is absolutely thrilled about it\.) (0 :out)
  1 (Do you have any children ?)
    2 (Yes\, you\'re staying with my daughter and her husband here in Rochester\, but you have a son out in Utica as well\.) (0 :out)
  1 (Are you married ?)
    2 (You were for about twenty years\. But as we got older and the kids went off to college\, things just didn\'t work out as well as we thought they would\. We separated about ten years ago and divorced two years later\.) (0 :out)
  1 (How are you doing today ?)
    2 (You\'re fine\, thank me\. And me?) (0 :out)
  ; Questions about family (TODO)
))
