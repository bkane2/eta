; The rules defined in this file are checked if no specific-input rules (in the context of SOPHIE's question)
; are previously matched. As such, these rules generally check general questions from the user.
;
; NOTE: some specific-input rules might redirect here using a :subtree+clause directive, if an equivalent
; question is asked by the user in the context of SOPHIE's question, in which case context will first be added
; to the clause provided to these trees.
;
; All trees defined in this file should be named using format *<topic-key>-question*.
;
; Current list of topics:
; - cancer-worse
; - medical-history
; - medicine-side-effects
; - appointment
; - chemotherapy-details
; - diagnosis-details
; - energy
; - medicine
; - pain
; - radiation
; - sleep
; - chemotherapy
; - comfort-care
; - medicine-request
; - medicine-working
; - prognosis
; - sleep-poorly
; - tell-family
; - test-results
; - treatment-option
; - treatment-goals
; - open-ended-question


(READRULES '*cancer-worse-question*
'(
)) ; END *cancer-worse-question*



(READRULES '*medical-history-question*
; (0 medical-history 0)
'(
  ; How often do you drink?
  1 (0 how 1 frequently 5 drink 0)
    2 ((What is my history with alcohol ?) (Medical-history)) (0 :gist)
  1 (0 do 1 pron 5 drink 0)
    2 ((What is my history with alcohol ?) (Medical-history)) (0 :gist)
  1 (0 AUX-BASE 1 pron 5 drink 0)
    2 ((What is my history with alcohol ?) (Medical-history)) (0 :gist)
   
   ; How often do you smoke?
  1 (0 how 1 frequently 5 smoke 0)
    2 ((What is my history with smoking ?) (Medical-history)) (0 :gist)
  1 (0 do 1 pron 5 smoke 0)
    2 ((What is my history with smoking ?) (Medical-history)) (0 :gist)
  1 (0 AUX-BASE 1 pron 5 smoke 0)
    2 ((What is my history with smoking ?) (Medical-history)) (0 :gist)
  
  ; What is your family's history with mental health ?
  1 (0 AUX-BASE 1 family 5 history 5 ment-health 0)
    2 ((Does my family have a history of mental illness ?) (Medical-history)) (0 :gist)
  1 (0 have 8 family 3 experienced 5 ment-health 0)
    2 ((Does my family have a history of mental illness ?) (Medical-history)) (0 :gist)
  1 (0 history 3 ment-health 0)
    2 ((Does my family have a history of mental illness ?) (Medical-history)) (0 :gist)
  1 (0 family 1 AUX-BASE 5 history 5 ment-health 0)
    2 ((Does my family have a history of mental illness ?) (Medical-history)) (0 :gist)
    
  ; Are your parents still alive?
  1 (0 AUX-BASE 1 parent 3 alive 0)
    2 ((How did my parents die ?) (Medical-history)) (0 :gist)
  1 (0 AUX-BASE 1 parent 3 die 0)
    2 ((How did my parents die ?) (Medical-history)) (0 :gist)
  1 (0 wh_ 2 AUX-BASE 3 parent 3 die 0)
    2 ((How did my parents die ?) (Medical-history)) (0 :gist)
   
  ; Have you ever taken any other drugs?
  1 (0 AUX-BASE 1 pron 3 recreational 0)
    2 ((Have I ever taken any other drugs ?) (Medical-history)) (0 :gist)
  1 (0 pron 1 AUX-BASE 3 recreational 0)
    2 ((Have I ever taken any other drugs ?) (Medical-history)) (0 :gist)
  1 (0 pron 3 history 3 recreational 0)
    2 ((Have I ever taken any other drugs ?) (Medical-history)) (0 :gist)

)) ; END *medical-history-question*



(READRULES '*medicine-side-effects-question*
'(
)) ; END *medicine-side-effects-question*



(READRULES '*appointment-question*
; (0 here anyone-here-with-you 0)
; (0 come anyone-here-with-you 0)
; (0 drive 0)
; (0 child 0)
; (0 married 0)
'(
  ; Did you drive here?
  1 (0 drive 0)
    2 ((Did I drive here ?)) (0 :gist)

  ; Is anyone here with you?
  1 (0 be you here 1 with 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 anyone be here 1 with you 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 who be here 1 with you 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 did you come with 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 be 1 here 1 with you 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 be you here alone 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 did you come by yourself 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 who came with you 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 come here with 0)
    2 ((Is anyone here with me ?)) (0 :gist)

  ; Asking about where your daughter works
  1 (0 where does 3 work 0)
    2 (0 she 0)
      3 ((Where does my daughter work ?) (Anyone-here-with-you)) (0 :gist)
    2 (0 your daughter 0)
      3 ((Where does my daughter work ?) (Anyone-here-with-you)) (0 :gist)
    2 (0 he 0)
      3 ((Where does my son work ?) (Anyone-here-with-you)) (0 :gist)
    2 (0 your son 0)
      3 ((Where does my son work ?) (Anyone-here-with-you)) (0 :gist)
  1 (0 how old be 0)
    2 (0 she 0)
      3 ((How old is my daughter ?)) (0 :gist)
    2 (0 your daughter 0)
      3 ((How old is my daughter ?)) (0 :gist)
    2 (0 he 0)
      3 ((How old is my son ?)) (0 :gist)
    2 (0 your son 0)
      3 ((How old is my son ?)) (0 :gist)

  ; Do you have grandchildren or children?
  1 (0 grandchildren 0)
    2 ((Do I have any grandchildren ?) (Anyone-here-with-you)) (0 :gist)
  1 (0 grandchild 0)
    2 ((Do I have any grandchildren ?) (Anyone-here-with-you)) (0 :gist)
  1 (0 children 0)
    2 ((Do I have any children ?) (Anyone-here-with-you)) (0 :gist)
  1 (0 child 0)
    2 ((Do I have any children ?) (Anyone-here-with-you)) (0 :gist)
  ; Were you ever married?
  1 (0 married 0)
    2 ((Am I married ?) (Anyone-here-with-you)) (0 :gist)
  ; How are you doing today?
  1 (0 wh_ 2 you 3 feeling 0)
    2 ((How am I doing today ?)) (0 :gist)

  ; Do you live alone?
  1 (0 aux 1 you 2 live 2 alone 0)
    2 ((Do I live alone ?)) (0 :gist)

  ;; 1 (0)
  ;;   2 ((NIL Gist)) (0 :gist)

)) ; END *appointment-question*



(READRULES '*chemotherapy-details-question*
'(
)) ; END *chemotherapy-details-question*



(READRULES '*diagnosis-details-question*
; (0 diagnosis-tests 0)
; (0 diagnosis-symptom 0)
; (0 diagnosis-non-symptom 0)
'(
  ; How much weight have you lost?
  1 (0 how much symptom-weight 0 lose 0)
    2 ((How much weight have I lost ?) (Weight-loss)) (0 :gist)
  1 (0 do pron 2 lose 3 much 0 symptom-weight 0)
    2 ((How much weight have I lost ?) (Weight-loss)) (0 :gist)
  1 (0 have pron 2 lose 3 much 0 symptom-weight 0)
    2 ((How much weight have I lost ?) (Weight-loss)) (0 :gist)

  ; What symptoms do you have?
  1 (0 wh_ 1 symptom 0)
    2 ((What symptoms do I have ?) (Symptoms)) (0 :gist)
  1 (0 do pron 3 symptom 0)
    2 ((What symptoms do I have ?) (Symptoms)) (0 :gist)
  1 (0 more-info 4 symptom 0)
    2 ((What symptoms do I have ?) (Symptoms)) (0 :gist)
  1 (0 have pron 5 diagnosis-symptom 0)
    2 (0 symptom-weight 0)
      3 ((Have I changed weight ?) (Symptoms)) (0 :gist)
    2 (0 symptom-appetite 0)
      3 ((Have I changed appetite ?) (Symptoms)) (0 :gist)

  ; Do you have [non-symptom]?
  1 (1 do 0 diagnosis-non-symptom 0)
    2 ((Do I have the symptom of 4 ?) (Symptoms)) (0 :gist)
  1 (1 have 0 diagnosis-non-symptom 0)
    2 ((Do I have the symptom of 4 ?) (Symptoms)) (0 :gist)
  1 (0 any diagnosis-non-symptom 0)
    2 ((Do I have the symptom of 3 ?) (Symptoms)) (0 :gist)

  ; Do you understand your test results?
  1 (8 wh_ diagnosis-tests diagnosis-tests 6)
    2 ((What test results am I referring to ?) (Test-results)) (0 :gist)
  1 (8 wh_ diagnosis-tests 6)
    2 ((What test results am I referring to ?) (Test-results)) (0 :gist)
  1 (8 AUX-BASE 2 you understand-gen 3 diagnosis-tests 0)
    2 ((Do I know what the tests say ?) (Test-results)) (0 :gist)

  ; You had tests recently, right?
  1 (0 you 3 diagnosis-tests 3 recently 0)
    2 ((What test results am I referring to ?) (Test-results)) (0 :gist)

  ; How did you get your diagnosis?
  1 (0 what 2 bring you 0)
    2 ((How did I get my diagnosis ?) (Diagnosis-details)) (0 :gist)
  1 (0 what 1 before 1 to 2 diagnosis 0)
    2 ((How did I get my diagnosis ?) (Diagnosis-details)) (0 :gist)
  1 (0 what 2 before 0 diagnosis 0)
    2 ((How did I get my diagnosis ?) (Diagnosis-details)) (0 :gist)
  1 (0 how do 3 know 0 diagnosis 0)
    2 ((How did I get my diagnosis ?) (Diagnosis-details)) (0 :gist)
  1 (0 how 0 find out 0 diagnosis 0)
    2 ((How did I get my diagnosis ?) (Diagnosis-details)) (0 :gist)

)) ; END *diagnosis-details-question*



(READRULES '*energy-question*
; (0 energy 0)
'(
  1 (0 AUX-BASE 2 you 2 ment-health 2 about 0)
    2 ((Is something harming your mental health ?) (Energy)) (0 :gist)
  1 (0 AUX-BASE 5 ment-health 5)
    2 ((How is my mental health ?) (Energy)) (0 :gist)
  1 (0 trouble 1 concentrate 0)
    2 ((Have I had trouble concentrating ?) (Energy)) (0 :gist)
  1 (0 you 1 have 1 energy 0)
    2 ((How is my energy ?) (Energy)) (0 :gist)
  1 (0 trouble 1 energy 0)
    2 ((How is my energy ?) (Energy)) (0 :gist)
  1 (0 med-take 5 antidepressant)
    2 ((I should take an antidepressant \.) (Medicine-request)) (0 :gist)
  1 (0 therapy 0)
    2 ((I should see a therapist \.) (Energy)) (0 :gist)

  ;; 1 (0)
  ;;   2 ((NIL Gist)) (0 :gist)

)) ; END *energy-question*



(READRULES '*medicine-question*
; (0 medicine-gen 0)
'(
  ; Do you have allergies?
  1 (0 have 0 allergies 0)
    2 ((Do I have allergies to any medicine ?) (Medicine-allergies)) (0 :gist)

  ; How often are you taking medication?
  1 (0 how 1 frequently 3 med-take 0)
    2 ((How often am I taking medication ?) (Medicine-frequency)) (0 :gist)
  1 (0 be 0 med-take 2 frequently 0)
    2 ((How often am I taking medication ?) (Medicine-frequency)) (0 :gist)
  1 (0 be 0 med-take 2 med-time 0)
    2 ((How often am I taking medication ?) (Medicine-frequency)) (0 :gist)

  ; How are you on the [medication]?
  1 (0 how 1 be you 2 feeling 2 med-take 2 medicine-taking 0)
    2 ((How is the pain medication working ?) (Medicine-working)) (0 :gist)
  1 (0 how 1 be you 2 feeling 2 recently 0)
    2 ((How is the pain medication working ?) (Medicine-working)) (0 :gist)
  1 (0 AUX-BASE 1 you 3 think-gen 3 medicine-taking 3 med-help 0)
    2 ((How is the pain medication working ?) (Medicine-working)) (0 :gist)

  ; Does taking the medicine more frequently help?
  1 (0 medicine-taking 3 frequently 5 med-help 0)
    2 ((Does taking medication more frequently help ?) (Medicine-frequency)) (0 :gist)
  1 (0 med-help 5 medicine-taking 3 frequently 0)
    2 ((Does taking medication more frequently help ?) (Medicine-frequency)) (0 :gist)
  1 (0 medicine-taking 5 med-help 5 frequently 0)
    2 ((Does taking medication more frequently help ?) (Medicine-frequency)) (0 :gist)

  ; What is your dosage?
  1 (0 wh_ 3 dose 0)
    2 ((What dosage of pain medication am I taking ?) (Medicine)) (0 :gist)
  1 (0 how 1 med-dosage 3 be 3 med-take 0)
    2 ((What dosage of pain medication am I taking ?) (Medicine)) (0 :gist)

  ; Are you taking [some med]?
  1 (0 be 2 you 8 med-take 0 medicine-particular 0)
    2 ((Am I taking 8 ?) (Medicine)) (0 :gist)
  1 (0 what medicine 3 you 2 med-take 0)
    2 ((What medicine am I taking ?) (Medicine)) (0 :gist)
  1 (0 what other medicine 3 you 2 med-take 0)
    2 ((What medicine am I taking ?) (Medicine)) (0 :gist)

  ; How have you tried the new pain medication already? 
  1 (0 how 1 have 1 you 5 medicine-taking 0)
    2 ((How were you prescribed your current pain medication ?) (Medicine-working)) (0 :gist)

  ; Is the pain medication working?
  1 (0 AUX-BASE 3 medicine-taking 3 med-help 3 pain 0)
    2 ((Is the pain medication working at all ?) (Medicine-working)) (0 :gist)
  1 (0 AUX-BASE 0 medicine-taking 3 do anything 0)
    2 ((Is the pain medication working at all ?) (Medicine-working)) (0 :gist)
  1 (0 AUX-BASE 0 medicine-taking 0 med-help 3 at all 0)
    2 ((Is the pain medication working at all ?) (Medicine-working)) (0 :gist)
  1 (0 AUX-BASE 0 medicine-taking 0 med-help 0)
    2 ((Is the pain medication working ?) (Medicine-working)) (0 :gist)
  1 (0 how 0 medicine-taking 0 med-help 0)
    2 ((How is the pain medication working ?) (Medicine-working)) (0 :gist)

  ; Do you want stronger pain medication?
  1 (0 AUX-BASE 1 you 3 want-gen 3 med-better 1 medicine-taking 0)
    2 ((Do I want stronger pain medication ?) (Medicine-request)) (0 :gist)
  1 (0 AUX-BASE 1 you 3 want-gen 3 med-narcotic 0)
    2 ((Do I want stronger pain medication ?) (Medicine-request)) (0 :gist)
  1 (0 AUX-BASE 1 you 3 think-gen 5 med-better 1 medicine-taking 0)
    2 ((Do I want stronger pain medication ?) (Medicine-request)) (0 :gist)
  1 (0 AUX-BASE 1 you 3 think-gen 5 med-narcotic 0)
    2 ((Do I want stronger pain medication ?) (Medicine-request)) (0 :gist)
  1 (0 wh_ 5 think-gen 5 med-take 1 med-better 1 medicine-taking 0)
    2 ((Do I want stronger pain medication ?) (Medicine-request)) (0 :gist)
  1 (0 wh_ 5 think-gen 5 med-take 1 med-narcotic 0)
    2 ((Do I want stronger pain medication ?) (Medicine-request)) (0 :gist)
  1 (0 how 3 you 5 think-gen 5 med-take 1 med-better 1 medicine-taking 0)
    2 ((Do I want stronger pain medication ?) (Medicine-request)) (0 :gist)
  1 (0 how 3 you 5 think-gen 5 med-take 1 med-narcotic)
    2 ((Do I want stronger pain medication ?) (Medicine-request)) (0 :gist)
  
  ; Do you need more medicine?
  1 (0 do 1 you 3 want-gen 2 medicine-taking 0)
    2 ((Do I need more medicine ?) (Medicine-refill)) (0 :gist)
  1 (0 how are you 1 medicine-taking 0); e.g., how are you on medicine?
    2 ((Do I need more medicine ?) (Medicine-refill)) (0 :gist)
  1 (0 do 1 you 3 want-gen 2 refill 3 medicine-taking 0)
    2 ((Do I need more medicine ?) (Medicine-refill)) (0 :gist)

  ; You should take a narcotic.
  1 (0 you 3 med-take 5 med-narcotic 0)
    2 ((I should take a narcotic \.) (Medicine-request)) (0 :gist)

  ; How are you feeling after taking the medication?
  1 (0 wh_ 1 you 3 feeling 4 medication 0)
    2 ((How is the pain medication working ?) (Medicine-working)) (0 :gist)

  ; Do you have a history with narcotics?
  1 (0 AUX-BASE 3 med-past 3 med-narcotic 0)
    2 ((What is my history with med-narcotic ?) (Medical-history)) (0 :gist)
  1 (0 AUX-BASE 3 history 3 med-narcotic 0)
    2 ((What is my history with med-narcotic ?) (Medical-history)) (0 :gist)

  ; asking if system has any questions
  1 (0 you 2 have 2 question-word 0)
    2 ((Do I have a question about my medicine ?) (Medicine)) (0 :gist)
  1 (0 question-word 2 you 2 have 0)
    2 ((Do I have a question about my medicine ?) (Medicine)) (0 :gist)
  1 (0 anything 1 you 2 want-gen 2 ask-gen 0)
    2 ((Do I have a question about my medicine ?) (Medicine)) (0 :gist)

)) ; END *medicine-question*



(READRULES '*pain-question*
; (0 pain 0)
'(
  ; Did the pain come back?
  1 (0 do 1 pain 1 pain-return 0)
    2 ((Did my pain come back ?) (Pain-return)) (0 :gist)

  ; How do you rate your pain?
  1 (0 scale 0)
    2 ((How do I rate my pain ?) (Pain-description)) (0 :gist)
  1 (0 how pain-bad 0)
    2 ((How do I rate my pain ?) (Pain-description)) (0 :gist)

  ; Can you tell me about your pain?
  1 (0 how be 2 pain 0)
    2 (- 0 medicine-gen 0)
      3 ((Can I tell you about my pain ?) (Pain-description)) (0 :gist)
    2 (*medicine-question* (what medication are you taking ?)) (0 :subtree+clause)
  1 (0 more-info 1 about 2 pain 0)
    2 (- 0 medicine-gen 0)
      3 ((Can I tell you about my pain ?) (Pain-description)) (0 :gist)
    2 (*medicine-question* (what medication are you taking ?)) (0 :subtree+clause)
  1 (0 can 2 you 2 describe 2 pain 0)
    2 (- 0 medicine-gen 0)
      3 ((Can I tell you about my pain ?) (Pain-description)) (0 :gist)
    2 (*medicine-question* (what medication are you taking ?)) (0 :subtree+clause)
  1 (0 what 2 medicine-gen 0)
    2 (- 0 dose 0)
      3 (*medicine-question* (what medication are you taking ?)) (0 :subtree+clause)
  1 (0 med-better 1 medicine-taking 0)
    2 (*medicine-question* (do you want a stronger pain medication ?)) (0 :subtree+clause)
  1 (0 medicine-taking 0 med-help 0)
    2 (*medicine-question* (is your pain medication working ?)) (0 :subtree+clause)
  1 (0 what pain 1 be you 0)
    2 (- 0 medicine-gen 0)
      3 ((Can I tell you about my pain ?) (Pain-description)) (0 :gist)
    2 (*medicine-question* (what medication are you taking ?)) (0 :subtree+clause)

  ; Where does it hurt?
  1 (0 where it 3 pain 0)
    2 ((Where is the pain located ?) (Pain-description)) (0 :gist)
  1 (0 where do 3 pain 0)
    2 ((Where is the pain located ?) (Pain-description)) (0 :gist)
  1 (0 where be 3 pain 0)
    2 ((Where is the pain located ?) (Pain-description)) (0 :gist)
  1 (0 what part 3 pain 0)
    2 ((Where is the pain located ?) (Pain-description)) (0 :gist)

  ; Does it hurt to [...]
  1 (0 do 2 pain to 0)
    2 (0 breath 0)
      3 ((Does it hurt to breath ?) (Pain-description)) (0 :gist)
    2 (0)
      3 ((Does it hurt to do anything ?) (Pain-description)) (0 :gist)

  ; Is the pain worse?
  1 (0 AUX-BASE 3 pain 3 worse 0)
    2 ((Has the pain become worse ?) (Pain-description)) (0 :gist)

  ; Do you have the pain frequently?
  1 (0 AUX-BASE 3 pain 3 frequently 0)
    2 ((Do you have the pain frequently ?) (Pain-description)) (0 :gist)
  1 (0 AUX-BASE 3 pain 3 all 1 time 0)
    2 ((Do you have the pain frequently ?) (Pain-description)) (0 :gist)

)) ; END *pain-question*



(READRULES '*radiation-question*
; (0 radiation 0)
'(
  ; Did the pain respond to [...]?
  1 (0 respond 1 to 1 radiation 0)
    2 ((Did the pain respond to radiation treatment ?) (Radiation-treatment)) (0 :gist)
  1 (0 do 2 radiation 5 radiation-help 0)
    2 ((Did the pain respond to radiation treatment ?) (Radiation-treatment)) (0 :gist)

  ; Did you get [...]?
  1 (0 redness 0)
    2 ((Did I get any hair loss or redness during radiation treatment ?) (Radiation-treatment)) (0 :gist)
  1 (0 hair loss 0)
    2 ((Did I get any hair loss or redness during radiation treatment ?) (Radiation-treatment)) (0 :gist)
  1 (0 do you 3 radiation 0)
    2 ((Did I get radiation treatment ?) (Radiation-treatment)) (0 :gist)
  1 (0 radiation treatment 0)
    2 ((Did I get radiation treatment ?) (Radiation-treatment)) (0 :gist)

)) ; END *radiation-question*



(READRULES '*sleep-question*
; (0 sleep 0)
'(
  ; What's going through your head while you're sleeping?
  1 (0 wh_ 5 sleep-thought 5 sleep 0)
    2 ((What is on my mind when I try to sleep ?) (Sleep)) (0 :gist)

  ; Have you been sleeping okay?
  1 (0 be you 2 sleep 1 okay 0)
    2 ((Have I been sleeping okay ?) (Sleep)) (0 :gist)
  1 (0 have you 2 sleep 1 okay 0)
    2 ((Have I been sleeping okay ?) (Sleep)) (0 :gist)
  1 (0 you 3 trouble sleep 0)
    2 ((Have I been sleeping okay ?) (Sleep)) (0 :gist)
  1 (0 you 2 sleep 1 much 0)
    2 ((Have I been sleeping okay ?) (Sleep)) (0 :gist)

  ; How often are you waking up at night?
  1 (0 how frequently 0)
    2 ((How often am I waking up at night ?) (Waking-frequency)) (0 :gist)

  ; Do you sleep during the day?
  1 (0 sleep 2 during 3 day 0)
    2 ((Do I sleep during the day ?) (Sleep)) (0 :gist)

  ; What happens when you try to sleep?
  1 (0 wh_ 2 happen 4 sleep 0)
    2 ((What happens when I try to sleep ?) (Sleep)) (0 :gist)
  1 (0 wh_ 2 you 1 med-notice 4 sleep 0)
    2 ((What happens when I try to sleep ?) (Sleep)) (0 :gist)

  ; What do you do before bed?
  1 (0 wh_ 2 you 2 before 3 sleep 0)
    2 ((What is my sleep routine ?) (Sleep)) (0 :gist)
  1 (0 wh_ 2 your 1 sleep routine 0)
    2 ((What is my sleep routine ?) (Sleep)) (0 :gist)
  1 (0 wh_ 2 sleep routine 2 you 1 have 0)
    2 ((What is my sleep routine ?) (Sleep)) (0 :gist)

  ; Is worrying keeping you up at night?
  1 (0 be 3 ment-health 4 you 2 sleep-awake 0)
    2 ((Is your mental health keeping you awake ?) (Sleep)) (0 :gist)
  1 (0 your 2 ment-health 4 you 2 sleep-awake 0)
    2 ((Is your mental health keeping you awake ?) (Sleep)) (0 :gist)

  ; Is coffee keeping you up at night?
  1 (0 be 3 coffee 4 you 2 sleep-awake 0)
    2 ((Is coffee keeping you awake ?) (Sleep)) (0 :gist)
  1 (0 coffee 4 cause 2 you 2 sleep-awake 0)
    2 ((Is coffee keeping you awake ?) (Sleep)) (0 :gist)
  1 (0 sleep-awake 4 because 4 coffee 0)
    2 ((Is coffee keeping you awake ?) (Sleep)) (0 :gist)
  1 (0 sleep-awake 4 cause 4 coffee)
    2 ((Is coffee keeping you awake ?) (Sleep)) (0 :gist)
  1 (0 AUX-BASE 3 frequently 6 coffee 0)
    2 ((Is coffee keeping you awake ?) (Sleep)) (0 :gist)
  
)) ; END *sleep-question*



(READRULES '*chemotherapy-question*
; (0 chemotherapy 0)
'(
  ; Did your doctor mention chemotherapy?
  1 (0 did 4 tell 4 you 4 need chemotherapy 0)
    2 ((Did my doctor mention chemotherapy ?) (Chemotherapy)) (0 :gist)
  1 (0 did 8 you 4 about chemotherapy 0)
    2 ((Did my doctor mention chemotherapy ?) (Chemotherapy)) (0 :gist)
  1 (0 mention 3 chemotherapy 0)
    2 ((Did my doctor mention chemotherapy ?) (Chemotherapy)) (0 :gist)

  ; What do you think about chemotherapy?
  1 (0 wh_ 4 think-gen 4 chemotherapy 0)
    2 ((What are my feelings about chemotherapy ?) (Chemotherapy)) (0 :gist)
  1 (0 AUX-BASE 4 want-gen 4 chemotherapy 0)
    2 ((What are my feelings about chemotherapy ?) (Chemotherapy)) (0 :gist)
  1 (0 opinion-gen 2 on 2 chemotherapy 0)
    2 ((What are my feelings about chemotherapy ?) (Chemotherapy)) (0 :gist)

  1 (0 AUX-BASE 3 you 2 understand-gen 4 chemotherapy 0)
    2 ((Do I understand how chemotherapy works ?) (Chemotherapy)) (0 :gist)

  ; asking if system has any questions
  1 (0 you 2 have 2 question-word 0)
    2 ((Do I have a question about chemotherapy ?) (Chemotherapy)) (0 :gist)
  1 (0 question-word 2 you 2 have 0)
    2 ((Do I have a question about chemotherapy ?) (Chemotherapy)) (0 :gist)
  1 (0 anything 1 you 2 want-gen 2 ask-gen 0)
    2 ((Do I have a question about chemotherapy ?) (Chemotherapy)) (0 :gist)

)) ; END *chemotherapy-question*



(READRULES '*comfort-care-question*
; (0 palliative care 0)
; (0 hospice 0)
'(

  ; Do I understand how comfort care works ?
  1 (0 AUX-BASE 2 know-gen 3 comfort-care-word 0)
    2 ((Do I understand how comfort care works ?) (Comfort-care)) (0 :gist)
  1 (0 be 2 know 3 comfort-care-word 0)
    2 ((Do I understand how comfort care works ?) (Comfort-care)) (0 :gist)
  1 (0 AUX-BASE 2 heard 3 comfort-care-word )
    2 ((Do I understand how comfort care works ?) (Comfort-care)) (0 :gist)
  1 (0 wh_ 4 know-gen 3 comfort-care-word 0)
    2 ((Do I understand how comfort care works ?) (Comfort-care)) (0 :gist)
  1 (0 wh_ 3 heard 3 comfort-care-word 0)
    2 ((Do I understand how comfort care works ?) (Comfort-care)) (0 :gist)
  1 (0 AUX-BASE 4 mention 4 comfort-care-word 0)
    2 ((Do I understand how comfort care works ?) (Comfort-care)) (0 :gist)
  1 (0 AUX-BASE 3 tell 3 comfort-care-word 0)
    2 ((Do I understand how comfort care works ?) (Comfort-care)) (0 :gist) 
  
  1 (0 AUX-BASE 3 you 2 understand-gen 6 comfort-care-word 0)
    2 ((Do I understand how comfort care works ?) (Comfort-care)) (0 :gist)

  ; Have you considered comfort care?
  1 (1 AUX-BASE pron 4 thought 4 comfort-care-word 0)
    2 ((Have I considered comfort care ?) (Comfort-care)) (0 :gist)
  1 (1 AUX-BASE 4 you 1 feeling 4 comfort-care-word 0)
    2 ((Have I considered comfort care ?) (Comfort-care)) (0 :gist)


  ; asking if system has any questions
  1 (0 you 2 have 2 question-word 0)
    2 ((Do I have a question about comfort care ?) (Comfort-care)) (0 :gist)
  1 (0 question-word 2 you 2 have 0)
    2 ((Do I have a question about comfort care ?) (Comfort-care)) (0 :gist)
  1 (0 anything 1 you 2 want-gen 2 ask-gen 0)
    2 ((Do I have a question about comfort care ?) (Comfort-care)) (0 :gist)

)) ; END *comfort-care-question*



(READRULES '*medicine-request-question*
'(
)) ; END *medicine-request-question*



(READRULES '*medicine-working-question*
'(
)) ; END *medicine-working-question*



(READRULES '*prognosis-question*
; (0 prognosis 0)
'(
  1 (0 AUX-BASE 3 you 2 think-gen 6 prognosis 0)
    2 ((How do I feel about my prognosis ?) (Prognosis)) (0 :gist)
  1 (0 AUX-BASE 3 you 2 feeling 6 prognosis 0)
    2 ((How do I feel about my prognosis ?) (Prognosis)) (0 :gist)
  1 (0 tell 1 me 7 fear-words 0)
    2 ((What scares me about my prognosis ?) (Prognosis)) (0 :gist)
  1 (0 elaborate 4 fear-words 0)
    2 ((What scares me about my prognosis ?) (Prognosis)) (0 :gist)
  1 (0 wh_ 1 make 1 you 3 frightened 0)
    2 ((What scares me about my prognosis ?) (Prognosis)) (0 :gist)
  1 (0 wh_ 1 frightens 1 you 0) 
    2 ((What scares me about my prognosis ?) (Prognosis)) (0 :gist)
  1 (0 wh_ be 3 frightening 0)
    2 ((What scares me about my prognosis ?) (Prognosis)) (0 :gist)
  1 (0 wh_ 1 you 1 think-gen 3 frightening 0)
    2 ((What scares me about my prognosis ?) (Prognosis)) (0 :gist)
  1 (0 wh_ be 3 fear-words 0)
    2 ((What scares me about my prognosis ?) (Prognosis)) (0 :gist)
  1 (0 wh_ cause you 4 fear-words 0)
    2 ((What scares me about my prognosis ?) (Prognosis)) (0 :gist)
  1 (0 AUX-BASE 3 you 2 understand-gen 6 prognosis 0)
    2 ((Do I understand my prognosis ?) (Prognosis)) (0 :gist)
  1 (0 AUX-BASE 3 you 2 tell 6 prognosis 0)
    2 ((Do I understand my prognosis ?) (Prognosis)) (0 :gist)
  1 (0 tell 4 understand-gen 6 prognosis 0)
    2 ((Do I understand my prognosis ?) (Prognosis)) (0 :gist)

  ; asking if system has any questions
  1 (0 you 2 have 2 question-word 0)
    2 ((Do I have a question about my prognosis ?)) (0 :gist)
  1 (0 question-word 2 you 2 have 0)
    2 ((Do I have a question about my prognosis ?)) (0 :gist)
  1 (0 anything 1 you 2 want-gen 2 ask-gen 0)
    2 ((Do I have a question about my prognosis ?)) (0 :gist)

  ; How much do I want to know about my prognosis ?
  1 (0 how much 3 information 3 AUX 1 you 0)
    2 ((How much information do I want about my prognosis ?)) (0 :gist)
  1 (0 how much 3 information 3 I 3 you 0)
    2 ((How much information do I want about my prognosis ?)) (0 :gist)
  1 (0 how much 3 AUX 3 I 3 want-gen 3 know 0)
    2 ((How much information do I want about my prognosis ?)) (0 :gist)
  1 (0 how much 3 I 3 tell 3 you 0)
    2 ((How much information do I want about my prognosis ?)) (0 :gist)

  ; What is the prognosis that was given to me previously ?
  1 (0 wh_ 4 be 4 prognosis 0)
    2 ((What is the prognosis that was given to me previously ?) (Prognosis)) (0 :gist)
  1 (0 tell 4 wh_ 4 prognosis 4 be 0)
    2 ((What is the prognosis that was given to me previously ?) (Prognosis)) (0 :gist)
  1 (0 AUX-BASE 4 know-gen 4 prognosis 0)
    2 ((What is the prognosis that was given to me previously ?) (Prognosis)) (0 :gist)
  1 (0 MODAL 4 tell 4 prognosis 0)
    2 ((What is the prognosis that was given to me previously ?) (Prognosis)) (0 :gist)
  1 (0 NEG 2 prognosis-notification-words 4 prognosis 0)
    2 ((What is the prognosis that was given to me previously ?) (Prognosis)) (0 :gist)

)) ; END *prognosis-question*


(READRULES '*sleep-poorly-question*
'(
)) ; END *sleep-poorly-question*



(READRULES '*tell-family-question*
; (0 family 2 know-gen 0)
; (0 family 3 tell 0)
'(
  ; Do your family know about your cancer / Have your family been told about your cancer ?
  1 (0 AUX-BASE 3 family-pron 2 know-gen 5 cancer-illness 0)
    2 ((Do my family know about my cancer ?) (Tell-family)) (0 :gist)
  1 (0 AUX-BASE 3 family-pron 3 tell 5 cancer-illness 0)
    2 ((Do my family know about my cancer ?) (Tell-family)) (0 :gist)
  1 (0 wh_ 3 AUX-BASE 3 family-pron 2 know-gen 5 cancer-illness 0)
    2 ((Do my family know about my cancer ?) (Tell-family)) (0 :gist)
  1 (0 wh_ 3 AUX-BASE 3 family-pron 3 tell 5 cancer-illness 0)
    2 ((Do my family know about my cancer ?) (Tell-family)) (0 :gist)

  ; How much do I want my family to know about the prognosis ?
  1 (0 wh_ 4 do 2 want-gen 2 family-pron 2 know-gen 0)
    2 ((How much do I want my family to know about the prognosis ?) (Tell-family)) (0 :gist)
  1 (0 how 1 much 2 do 2 want-gen 2 family-pron 2 know-gen 0)
    2 ((How much do I want my family to know about the prognosis ?) (Tell-family)) (0 :gist)
  1 (0 wh_ 4 do 2 want-gen 2 tell 2 family-pron 0)
    2 ((How much do I want my family to know about the prognosis ?) (Tell-family)) (0 :gist)
  1 (0 how 1 much 2 do 2 want-gen 2 tell 2 family-pron 0)
    2 ((How much do I want my family to know about the prognosis ?) (Tell-family)) (0 :gist)

  ; Do I want you to be present when I tell my family about the prognosis ?
  1 (0 want-gen 4 available 0)
    2 ((Do I want you to be present when I tell my family about the prognosis ?) (Tell-family)) (0 :gist)
  1 (0 want-gen 4 with 0)
    2 ((Do I want you to be present when I tell my family about the prognosis ?) (Tell-family)) (0 :gist)
  1 (0 want-gen 4 joint 2 appointment 0)
    2 ((Do I want you to be present when I tell my family about the prognosis ?) (Tell-family)) (0 :gist)
  1 (0 want-gen 4 in 1 person 2 appointment 0)
    2 ((Do I want you to be present when I tell my family about the prognosis ?) (Tell-family)) (0 :gist)
  1 (0 want-gen 4 appointment 2 with 2 family 0)
    2 ((Do I want you to be present when I tell my family about the prognosis ?) (Tell-family)) (0 :gist)
  1 (0 want-gen 4 appointment 2 together 0)
    2 ((Do I want you to be present when I tell my family about the prognosis ?) (Tell-family)) (0 :gist)
  1 (0 make 2 appointment 0)
    2 ((Do I want you to be present when I tell my family about the prognosis ?) (Tell-family)) (0 :gist)

  ; Who in my family do I want to tell about the prognosis ?
  1 (0 who 3 be 3 tell 0)
    2 ((Who in my family do I want to tell about the prognosis ?) (Tell-family)) (0 :gist)
  1 (0 who 2 AUX-BASE 4 want-gen 2 tell 0)
    2 ((Who in my family do I want to tell about the prognosis ?) (Tell-family)) (0 :gist)
  1 (0 who 6 want-gen 3 tell 0)
    2 ((Who in my family do I want to tell about the prognosis ?) (Tell-family)) (0 :gist)

  ; How much do I want to know about my test results ?
  1 (0 how much 3 information 3 AUX 1 you 0)
    2 ((How much information do you want about your test results ?)) (0 :gist)
  1 (0 how much 3 information 3 I 3 you 0)
    2 ((How much information do you want about your test results ?)) (0 :gist)
  1 (0 how much 3 AUX 3 I 3 want-gen 3 know 0)
    2 ((How much information do you want about your test results ?)) (0 :gist)
  1 (0 how much 3 I 3 tell 3 you 0)
    2 ((How much information do you want about your test results ?)) (0 :gist)

  ; You will help me and my family through the treatment process \.
  1 (0 doctor-pron 4 be 2 available 2 you 4 care 0)
    2 (You will help me and my family through the treatment process \.) (0 :gist)
  1 (0 doctor-pron 4 be 2 available 2 you 4 difficult 1 time 0)
    2 (You will help me and my family through the treatment process \.) (0 :gist)
  1 (0 doctor-pron 4 be 2 available 2 family-pron 0)
    2 (You will help me and my family through the treatment process \.) (0 :gist)
  1 (0 doctor-pron 4 be 2 available 2 help 0)
    2 (You will help me and my family through the treatment process \.) (0 :gist)
  1 (0 doctor-pron 4 med-help 6 family 0)
    2 (You will help me and my family through the treatment process \.) (0 :gist)
  1 (0 doctor-pron 4 be 2 available 2 every 1 step 2 way 0)
    2 (You will help me and my family through the treatment process \.) (0 :gist)

  ; I should plan to spend my remaining time with my family after I tell them about the prognosis \.
  1 (0 make 2 time 4 family-pron 0)
    2 (I should plan to spend my remaining time with my family after I tell them about the prognosis \.) (0 :gist)
  1 (0 give 4 family-pron 4 visit 2 you 0)
    2 (I should plan to spend my remaining time with my family after I tell them about the prognosis \.) (0 :gist)
  1 (0 spend 4 time 4 family-pron 0)
    2 (I should plan to spend my remaining time with my family after I tell them about the prognosis \.) (0 :gist)
  1 (0 family 2 spend 2 time 4 you 0)
    2 (I should plan to spend my remaining time with my family after I tell them about the prognosis \.) (0 :gist)
  1 (0 make 2 most 4 time 4 with 2 family-pron 0)
    2 (I should plan to spend my remaining time with my family after I tell them about the prognosis \.) (0 :gist)


)) ; END *tell-family-question*



(READRULES '*test-results-question*
'(
  1 (0 you 2 think-gen 4 diagnostic-tests 0) 
    2 ((How do I feel about my test results ?) (Test-Results)) (0 :gist)

    ; asking if system has any questions
  1 (0 you 2 have 2 question-word 0)
    2 ((Do I have a question about my test results ?)) (0 :gist)
  1 (0 question-word 2 you 2 have 0)
    2 ((Do I have a question about my test results ?)) (0 :gist)
  1 (0 anything 1 you 2 want-gen 2 ask-gen 0)
    2 ((Do I have a question about my test results ?)) (0 :gist)

)) ; END *test-results-question*



(READRULES '*treatment-option-question*
; (0 treatment-option 0)
'(
  1 (0 how 4 think-gen 4 treatment-option 0)
    2 ((What are my treatment goals ?) (Treatment-options)) (0 :gist)
  1 (0 wh_ 4 you 3 think-gen 6 treatment-option 0)
    2 ((What are my treatment goals ?) (Treatment-options)) (0 :gist)
  1 (0 AUX-BASE 3 you 2 understand-gen 6 treatment-option 0)
    2 ((What do I understand about my treatment options ?) (Treatment-option)) (0 :gist)

  ; asking if system has any questions
  1 (0 you 2 have 2 question-word 0)
    2 ((Do I have a question about my treatment options?)) (0 :gist)
  1 (0 question-word 2 you 2 have 0)
    2 ((Do I have a question about my treatment options?)) (0 :gist)
  1 (0 anything 1 you 2 want-gen 2 ask-gen 0)
    2 ((Do I have a question about my treatment options?)) (0 :gist)

)) ; END *treatment-option-question*



(READRULES '*treatment-goals-question*
; (0 cancer-fight 0)
; (0 cancer-live 0)
; (0 cancer-goals 0)
'(
  ; Do you want to try to fight the cancer ?
  1 (0 you 2 have 2 cancer-fight 0)
    2 ((Do I want to try to fight the cancer ?) (Treatment-options)) (0 :gist)
  1 (0 you 2 want 3 cancer-fight 0)
    2 ((Do I want to try to fight the cancer ?) (Treatment-options)) (0 :gist)
  1 (0 you 2 want 3 cancer-live 0)
    2 ((Do I want to try to fight the cancer ?) (Treatment-options)) (0 :gist)

  ; What are your goals ?
  1 (0 wh_ 2 be 3 your 3 cancer-goals 0)
    2 ((What are my treatment goals ?) (Treatment-options)) (0 :gist)
  1 (0 wh_ 3 cancer-goals 3 AUX-BASE 1 you 0)
    2 ((What are my treatment goals ?) (Treatment-options)) (0 :gist)
  1 (0 wh_ 3 be 3 important 2 you 0)
    2 ((What are my treatment goals ?) (Treatment-options)) (0 :gist)
  1 (0 wh_ 3 AUX-BASE 2 you 3 cancer-goals 0)
    2 ((What are my treatment goals ?) (Treatment-options)) (0 :gist)

)) ; END *treatment-goals-question*



(READRULES '*open-ended-question*
'(
  ; signalling a question
  1 (0 I 3 ask 1 you 4 question 0)
    2 ((Can you ask me some questions ?)) (0 :gist)
  1 (0 can I 3 make 1 sure 3 I understand 0)
    2 ((Can you ask me some questions ?)) (0 :gist)

  ; asking if system has any questions
  1 (0 you 2 have 2 question-word 0)
    2 ((Do I have a question ?)) (0 :gist)
  1 (0 question-word 2 you 2 have 0)
    2 ((Do I have a question ?)) (0 :gist)
  1 (0 anything 1 you 2 want-gen 2 ask-gen 0)
    2 ((Do I have a question ?)) (0 :gist)

  ; checking the system's understanding
  1 (0 tell 0 what 1 you 1 understand-gen 0)
    2 ((What do I understand ?)) (0 :gist)
  1 (0 do 1 you 1 understand-gen 0)
    2 ((What do I understand ?)) (0 :gist)
  1 (0 wh_ do 1 you 1 understand-gen 0)
    2 ((What do I understand ?)) (0 :gist)

  ; asking for system's preferences for information
  1 (0 how much 3 information 3 AUX 1 you 0)
    2 ((How much information do I want ?)) (0 :gist)
  1 (0 how much 3 information 3 I 3 you 0)
    2 ((How much information do I want ?)) (0 :gist)

  ; questions about system's feelings
  1 (0 how 1 you 3 feeling 0)
    2 ((How am I feeling about my condition ?)) (0 :gist)
  1 (0 tell 5 fear-words 0)
    2 ((What scares me about my condition ?)) (0 :gist)
  1 (0 elaborate 4 fear-words 0)
    2 ((What scares me about my condition ?)) (0 :gist)
  1 (0 wh_ 1 make 1 you 3 frightened 0)
    2 ((What scares me about my condition ?)) (0 :gist)
  1 (0 wh_ 1 frightens 1 you 0) 
    2 ((What scares me about my condition ?)) (0 :gist)
  1 (0 wh_ be 3 frightening 0)
    2 ((What scares me about my condition ?)) (0 :gist)
  1 (0 wh_ 1 you 1 think-gen 3 frightening 0)
    2 ((What scares me about my condition ?)) (0 :gist)
  1 (0 wh_ be 3 fear-words 0)
    2 ((What scares me about my condition ?)) (0 :gist)
  1 (0 wh_ cause you 4 fear-words 0)
    2 ((What scares me about my condition ?)) (0 :gist)
  1 (0 be 1 you 1 frightened 5 appointment 0)
    2 ((Was I nervous for this appointment ?)) (0 :gist)  
  1 (0 be 3 appointment 1 frightening 0)
    2 ((Was I nervous for this appointment ?)) (0 :gist)
  1 (0 AUX 3 appointment 1 frighten 1 you 0)
    2 ((Was I nervous for this appointment ?)) (0 :gist)

  ; meta-questions about conversation
  1 (0 how 4 conversation 3 going 0)
    2 ((How do I think this conversation is going ?)) (0 :gist)
  1 (0 AUX-BASE 3 you 2 understand-gen 0)
    2 ((Am I following what you say ?)) (0 :gist)
  1 (0 how 1 AUX-BASE 1 that sound 0)
    2 ((How does that sound ?)) (0 :gist)
))