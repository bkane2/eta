(READRULES '*general-input*
'(
  ; Generic greeting
  1 (0 nice to meet you 0)
    2 ((It is nice to meet me \.)) (0 :gist)
  ; If asked if anyone is here with you
  1 (0 here anyone-here-with-you 0)
    2 *appointment-question* (0 :subtree)
  1 (0 come anyone-here-with-you 0)
    2 *appointment-question* (0 :subtree)
  1 (0 drive 0)
    2 *appointment-question* (0 :subtree)
  1 (0 child 0)
    2 *appointment-question* (0 :subtree)
  1 (0 married 0)
    2 *appointment-question* (0 :subtree)
  ; If asked to elaborate about pain
  1 (0 pain 0)
    2 *pain-question* (0 :subtree)
  ; If asked about diagnosis details
  1 (0 diagnosis-tests 0)
    2 *diagnosis-details-question* (0 :subtree)
  1 (0 diagnosis-symptom 0)
    2 *diagnosis-details-question* (0 :subtree)
  1 (0 diagnosis-non-symptom 0)
    2 *diagnosis-details-question* (0 :subtree)
  ; If asked about radiation treatment
  1 (0 radiation 0)
    2 *radiation-question* (0 :subtree)
  ; If doctor mentions possibility of chemotherapy
  1 (0 chemotherapy 0)
    2 *chemotherapy-question* (0 :subtree)
  ; If doctor asks something about sleep
  1 (0 sleep 0)
    2 *sleep-question* (0 :subtree)
  ; If doctor asks something about medicine
  1 (0 medicine-gen 0)
    2 *medicine-question* (0 :subtree)
  ;If the doctor asks about your medical history
  1 (0 medical-history 0)
    2 *medical-history-question* (0 :subtree)
  ; If doctor asks something about patient's energy (or mood)
  1 (0 energy 0)
   2 *energy-question* (0 :subtree)
  ; If doctor asks something about prognosis
  1 (0 prognosis 0)
    2 *prognosis-question* (0 :subtree)
  ; If doctor says something about comfort care/hospice/pal
  1 (0 palliative care 0)
    2 *comfort-care-question* (0 :subtree)
  1 (0 hospice 0)
    2 *comfort-care-question* (0 :subtree)

    
  ; Interjections/prompts to continue
  ;; 1 (2 okay 2)
  ;;   2 ((Continue talking \.)) (0 :gist)
  ;; 1 (2 go on 2)
  ;;   2 ((Continue talking \.)) (0 :gist)
  ;; 1 (2 uh huh 2)
  ;;   2 ((Continue talking \.)) (0 :gist)
  ;; 1 (2 sure 2)
  ;;   2 ((Continue talking \.)) (0 :gist)

  1 (0 ?)
    2 ((NIL Question ?)) (0 :gist)
  1 (1 wh_ 2 be 0)
    2 ((NIL Question ?)) (0 :gist)
  1 (1 wh_ aux 0)
    2 ((NIL Question ?)) (0 :gist)
  1 (aux np_ 0)
    2 ((NIL Question ?)) (0 :gist)
  1 (0 aux np_ 1); tag question
    2 ((NIL Question ?)) (0 :gist)
  1 (0 tell me 0); declarative question
    2 ((NIL Question ?)) (0 :gist)
  ;; 1 (0)
  ;;   2 ((NIL Gist)) (0 :gist)
))


(READRULES '*general-reaction*
'(
  1 (It is nice to meet me \.)
    2 (Thank you \, it\'s nice to meet you too \.) (100 :out)
  ; If doctor is just giving an indication to keep talking, react silently and continue
  1 (Continue talking \.)
    2 () (0 :out)
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
