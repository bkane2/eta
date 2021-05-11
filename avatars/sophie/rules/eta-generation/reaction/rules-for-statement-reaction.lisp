(READRULES '*reaction-to-statement*
; Here we match any non-question statements which the user might ask, and respond to them appropriately.
; If some topic has enough possible gist clauses where it gets messy to put them all here, we can branch off
; to a subtree defined in the rule file for that subtopic (e.g. with *general-reaction*).
; NOTE: questions in declarative form might be tricky, and seem to happen frequently enough in the transcripts.
; Will have to figure out whether to make those questions beforehand through some preprocessing step (You think
; this makes more sense) or deal with them here somehow.
'(

  ; The following might need changing
  1 (You are sorry that my daughter couldn\'t come today \.)
    2 (That\'s okay\. We\'ll have to discuss it with her some other time\.) (0 :out)
  ;; ; Chemotherapy
  ;; 1 (You think me need chemotherapy \.)
  ;;   ;; 2 *discuss-chemotherapy* (0 :schema)
  ;;   2 (*have-subdialogue* ((What would be the side effects of chemotherapy ?)
  ;;                          ((What are the side effects of chemotherapy ?)))) (100 :schema+args)
  ;; 1 (I do not think you need chemotherapy \.)
  ;;   2 (Ah\, okay\.) (0 :out)
  ;; ; Medicine
  ;; 1 (I think you should take med-narcotic \.)
  ;;   2 (*have-subdialogue* ((Could you tell me about some of the side effects of that ?)
  ;;                          ((Can you tell me about the side effects ?)))) (100 :schema+args)

  1 (0 stronger pain medication 0 help me sleep 0)
    2 *medicine-reaction* (0 :subtree)
  1 (0 sleeping poorly 0 \.)
    2 *sleep-poorly-reaction* (0 :subtree)
  1 (0 medication 4 work 0 \.)
    2 *medicine-working-reaction* (0 :subtree)
  1 (0 energy 0 \.)
    2 *energy-reaction* (0 :subtree)
  1 (0 take 3 different \.)
    2 *medicine-working-reaction* (0 :subtree)
  1 (0 stronger 1 medication 0 \.)
    2 *medicine-request-reaction* (0 :subtree)
  1 (0 refill 2 medication 0 \.)
    2 *medicine-request-reaction* (0 :subtree)
  1 (0 med-narcotic 0 \.)
    2 *medicine-request-reaction* (0 :subtree)
  1 (0 test results 0 \.)
    2 *test-results-reaction* (0 :subtree)
  1 (0 prognosis 0 \.)
    2 *prognosis-reaction* (0 :subtree)
  1 (0 treatment option 0 \.)
    2 *treatment-option-reaction* (0 :subtree)
  1 (0 chemotherapy details 0 \.)
    2 *chemotherapy-details-reaction* (0 :subtree)
  1 (0 side effect 0 chemotherapy 0 \.)
    2 *chemotherapy-details-reaction* (0 :subtree)
  1 (0 way 1 to get 2 chemotherapy 0 \.)
    2 *chemotherapy-details-reaction* (0 :subtree)
  1 (0 chemotherapy 0 \.)
    2 *chemotherapy-reaction* (0 :subtree)
  1 (0 comfort care 0 \.)
    2 *comfort-care-reaction* (0 :subtree)
  1 (0 tell 1 family 0 \.)
    2 *tell-family-reaction* (0 :subtree)
  1 (0 family 1 know-gen 0 \.)
    2 *tell-family-reaction* (0 :subtree)
  1 (0 side effect 3 medication 0)
    2 *medicine-side-effects-reaction* (0 :subtree)
  1 (0 cancer 2 gotten worse 0)
    2 *cancer-worse-reaction* (0 :subtree)
  1 (0 radiation 0)
    2 *radiation-reaction* (0 :subtree)
  1 (0 congratulations 0)
    2 *medical-history-reaction* (0 :subtree)
  1 (0 ment-treatment 0)
    2 *energy-reaction* (0 :subtree)
  1 (0 pain 0)
    2 *pain-reaction* (0 :subtree)
  1 (0 cancer-fight 0)
    2 *treatment-goals-reaction* (0 :subtree)
  1 (0 cancer-live 0)
    2 *treatment-goals-reaction* (0 :subtree)
  1 (0 cancer-goals 0)
    2 *treatment-goals-reaction* (0 :subtree)
 
  1 (0)
    2 *general-reaction* (0 :subtree)
))



(READRULES '*general-reaction*
'(
  1 (It is nice to meet me \.)
    2 (Thank you \, it\'s nice to meet you too \.) (100 :out)
  1 (You like my 6 \.)
    2 (Thanks \, I appreciate it \. I think we should stay on topic\, though \.) (0 :out)
  ; If doctor is just giving an indication to keep talking, react silently and continue
  1 (Continue talking \.)
    2 () (0 :out)
  ; Meta-questions about conversation
  1 (Can you ask me some questions ?)
    2 *ask-for-questions* (0 :schema)
  1 (How much information do I want ?)
    2 *ask-for-questions* (0 :schema)
  1 (How do I think this conversation is going ?)
    2 *ask-for-questions* (0 :schema)
  1 (Am I following what you say ?)
    2 *ask-for-questions* (0 :schema)
  1 (How does that sound ?)
    2 (I think what you said makes sense to me \.) (3 :out)
    2 (I think that sounds fine \.) (3 :out)
    2 (That makes sense \.) (0 :out)
  ; If no gist clauses were extracted from user, ask them to repeat the question (Repeats at most 2 times in a row,
  ; otherwise eta will ignore and return to the central conversation)
  1 (0 ?)
    ;; 2 (2 ?); too short to be a question
    ;;   3 () (0 :out)
    2 *ask-for-clarification* (3 :schema)
    2 *ask-for-clarification* (3 :schema)
    2 (Sorry\, I still didn\'t quite understand\. I have some more questions\, maybe we can come back to it\.) (0 :out)
  1 (0)
    2 (I see\.) (8 :out)
    2 (Okay\.) (8 :out)
    2 (Sure\.) (8 :out)
    2 (Uh huh\.) (0 :out)
))



