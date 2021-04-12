; This rule tree is called in the case where no specific-input pattern is matched;
; this will first try to branch to a topical question-input tree based on generic keywords,
; and if that fails, the system will try to match general question forms, with the aim of
; allowing the system to ask for a clarification.

(READRULES '*general-input*
'(
  ; Generic remarks
  1 (0 nice to meet you 0)
    2 ((It is nice to meet me \.)) (0 :gist)
  1 (0 I 1 appreciate 2 avatar-items 0)
    2 ((You like my 6 \.)) (0 :gist)
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
  1 (0 live 3 alone 0)
    2 *appointment-question* (0 :subtree)
  ; If asked if family know about cancer
  1 (0 family 2 know-gen 0)
    2 *tell-family-question* (0 :subtree)
  1 (0 family 3 tell 0)
    2 *tell-family-question* (0 :subtree)
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
  ; If the doctor asks about your medical history
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
  ; If asked about general treatment goals/priorities
  1 (0 cancer-fight 0)
    2 *treatment-goals-question* (0 :subtree)
  1 (0 cancer-live 0)
    2 *treatment-goals-question* (0 :subtree)
  1 (0 cancer-goals 0)
    2 *treatment-goals-question* (0 :subtree)

    
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
  1 (0 tag-question); tag question
    2 ((NIL Question ?)) (0 :gist)
  1 (0 tell me 0); declarative question
    2 ((NIL Question ?)) (0 :gist)
  ;; 1 (0)
  ;;   2 ((NIL Gist)) (0 :gist)
))
