(MAPC 'ATTACHFEAT
'(
  (meet meeting)
  (come came)
  (anyone-here-with-you here with alone by)
  (pain hurt hurting)
  (energy mood concentrate concentration concentrating depression depressed)
  (medicine pain-med pain-med-other blood-pressure-med med-narcotic drug drugs pill pills)
  (pain-med lortab vicodin norco)
  (pain-med-other ibuprofen aleve)
  (med-narcotic narcotic oxycodone morphine)
  (blood-pressure-med cozar)
  (drive drove driving)
  (diagnosis-symptom symptom symptoms weight skinny skinnier appetite eating)
  (diagnosis-non-symptom headache headaches chill chills fever fevers nausea eyesight eyes)
))


(READRULES '*general-input*
'(
  ; Generic greeting
  1 (0 nice to meet you 0)
    2 ((It is nice to meet you \.)) (0 :gist)
  ; If asked if anyone is here with you
  1 (0 here anyone-here-with-you 0)
    2 *appointment-question* (0 :subtree)
  1 (0 come anyone-here-with-you 0)
    2 *appointment-question* (0 :subtree)
  1 (0 drive 0)
    2 *appointment-question* (0 :subtree)
  ; If asked to elaborate about pain
  1 (0 pain 0)
    2 *pain-question* (0 :subtree)
  ; If asked about diagnosis details
  1 (0 diagnosis 0)
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
  ; If doctor asks something about patient's energy (or mood)
  1 (0 energy 0)
    2 *energy-question* (0 :subtree)

  ; The following two will need modification
  1 (0 medicine 0)
    2 *medicine-question* (0 :subtree)
  1 (0 prognosis 0)
    2 *prognosis-question* (0 :subtree)
    
  ; Interjections/prompts to continue
  1 (2 okay 2)
    2 ((Continue talking \.)) (0 :gist)
  1 (2 go on 2)
    2 ((Continue talking \.)) (0 :gist)
  1 (2 uh huh 2)
    2 ((Continue talking \.)) (0 :gist)
  1 (2 sure 2)
    2 ((Continue talking \.)) (0 :gist)

  1 (0 ?)
    2 ((NIL Question ?)) (0 :gist)
  1 (wh_ 0)
    2 ((NIL Question ?)) (0 :gist)
  1 (aux np_ 0)
    2 ((NIL Question ?)) (0 :gist)
  1 (0 aux np_ 1); tag question
    2 ((NIL Question ?)) (0 :gist)
  ;; 1 (0)
  ;;   2 ((NIL Gist)) (0 :gist)
))


(READRULES '*general-reaction*
'(
  1 (It is nice to meet you \.)
    2 (Thank me\, it\'s nice to meet me too \.) (100 :out)
  ; If doctor is just giving an indication to keep talking, react silently and continue
  1 (Continue talking \.)
    2 () (0 :out)
  ; If no gist clauses were extracted from user, ask them to repeat the question (repeats at most 2 times in a row,
  ; otherwise Eta will ignore and return to the central conversation)
  1 (0 ?)
    2 (*have-subdialogue* ((I\'m sorry\, I didn\'t quite understand\. Can you say it again ?) nil)) (3 :schema+args)
    2 (*have-subdialogue* ((Would you mind rephrasing ?) nil)) (3 :schema+args)
    2 (Sorry\, you still didn\'t quite understand\. You have some more questions\, maybe we can come back to it\.) (0 :out)
  1 (0)
    2 (You see\.) (8 :out)
    2 (Okay\.) (8 :out)
    2 (Sure\.) (8 :out)
    2 (Uh huh\.) (0 :out)
))
