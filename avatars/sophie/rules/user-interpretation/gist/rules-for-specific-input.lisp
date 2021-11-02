; The rules defined in this file contain context-sensitive responses that might be expected based on the
; question that SOPHIE previously asked. User questions are paraphrased and sent to the corresponding
; question tree (in rules-for-question-input.lisp) using :subtree+clause.
; 
; NOTE: since *gist-clause-trees-for-input* uses the :subtrees directive to choose a single subtree for
; user interpretation, and can therefore not fall back on *general-input* once committed to a specific-input
; subtree, most of the specific-input subtrees should explicitly fall back on *general-input* before defaulting
; to a null clause.
;
; All trees defined in this file should be named using format *<topic-key>-input*.
;
; Current list of topics:
; - cancer-worse
; - cancer-worse-verification
; - medical-history
; - medicine-side-effects
; - medicine-side-effects-addiction
; - appointment
; - chemotherapy-details
; - diagnosis-details
; - energy
; - medicine
; - pain
; - radiation
; - radiation-verification
; - sleep
; - chemotherapy
; - comfort-care
; - comfort-care-verification
; - medicine-refill-request
; - medicine-stronger-request
; - medicine-working
; - prognosis
; - prognosis-denial
; - prognosis-bargaining
; - prognosis-verification
; - sleep-poorly
; - tell-family
; - test-results
; - treatment-option
; - stronger-medicine-help-sleep


(READRULES '*cancer-worse-input*
; (Has the cancer gotten worse ?)
'(
  1 (5 POS 0)
    2 (- 0 NEG sure 0)
      3 ((My cancer has gotten worse \.) (Cancer-worse)) (0 :gist)
    2 ((You are not sure whether my cancer has gotten worse \.) (Cancer-worse)) (0 :gist)
  1 (0 posadv-affirm 0)
    2 (- 0 posadv-affirm NEG 0)
      3 (- 0 NEG posadv-affirm 0)
        4 ((My cancer has not gotten worse \.) (Cancer-worse)) (0 :gist)
    2 ((My cancer has gotten worse \.) (Cancer-worse)) (0 :gist)
  1 (0 I 1 think-gen so 0)
    2 ((My cancer has gotten worse \.) (Cancer-worse)) (0 :gist)
  1 (5 no 0)
    2 ((My cancer has not gotten worse \.) (Cancer-worse)) (0 :gist)
  1 (0 NEG 1 think-gen 0)
    2 ((My cancer has not gotten worse \.) (Cancer-worse)) (0 :gist)
  1 (0 cancer-illness 2 NEG 2 worse 0)
    2 ((My cancer has not gotten worse \.) (Cancer-worse)) (0 :gist)
  1 (0 cancer-illness 2 worse 0)
    2 ((My cancer has gotten worse \.) (Cancer-worse)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for has cancer gotten worse \.)) (0 :gist)

)) ; END *cancer-worse-input*



(READRULES '*cancer-worse-verification-input*
; (Are you sure the cancer has not gotten worse ?)
'(
  1 (0 NEG 1 know-gen 0)
    2 ((You are not sure whether my cancer has gotten worse \.) (Cancer-worse)) (0 :gist)
  1 (5 no 0)
    2 ((You are not sure whether my cancer has gotten worse \.) (Cancer-worse)) (0 :gist)
  1 (5 POS 0)
    2 (- 0 NEG sure 0)
      3 ((My cancer has not gotten worse \.) (Cancer-worse)) (0 :gist)
  1 (0 I 1 think-gen so 0)
    2 ((My cancer has not gotten worse \.) (Cancer-worse)) (0 :gist)
  1 (0 NEG 1 think-gen 0)
    2 ((My cancer has not gotten worse \.) (Cancer-worse)) (0 :gist)
  1 (0 cancer-illness 2 NEG 2 worse 0)
    2 ((My cancer has not gotten worse \.) (Cancer-worse)) (0 :gist)
  1 (0 cancer-illness 2 worse 0)
    2 ((My cancer has gotten worse \.) (Cancer-worse)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for verifying whether my cancer is worse \.)) (0 :gist)

)) ; END *cancer-worse-verification-input*



(READRULES '*medical-history-input*
; (I have a history of alcohol abuse but do not drink now \.)
; (I have a history of alcohol abuse \.)
; (I do not drink often now \.) 
; (I have a history of smoking but quit six months ago \.)
; (I have a history of smoking \.)
; (I quit smoking six months ago \.)
; (Nobody in my family has a history of mental illness \.)
; (My family does not have a history of mental illness \.)
'(
  ; What is your history with drinking?
  1 (0 how 1 frequently 5 drink 0)
    2 ((What is my history with alcohol ?) (Medical-history)) (0 :gist)
  1 (0 do 1 pron 5 drink 0)
    2 ((What is my history with alcohol ?) (Medical-history)) (0 :gist)
  1 (0 AUX-BASE 1 pron 5 drink 0)
    2 ((What is my history with alcohol ?) (Medical-history)) (0 :gist)
  
  ; What is your history with smoking?
  1 (0 AUX-BASE 1 pron 5 smoke 0)
    2 ((What is my history with smoking ?) (Medical-history)) (0 :gist)
  1 (0 do 1 pron 5 smoke 0)
    2 ((What is my history with smoking ?) (Medical-history)) (0 :gist)
  1 (0 how 1 frequently 5 smoke 0)
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

  ; Questions related to symptoms
  1 (0 diagnosis-symptom 0)
    2 *diagnosis-details-input* (0 :subtree)
  1 (0 diagnosis-non-symptom 0)
   2 *diagnosis-details-input* (0 :subtree)
  1 (0 diagnosis-tests 0)
    2 *diagnosis-details-input* (0 :subtree)

  ; Your history with mental health
  1 (0 you 5 experienced 5 ment-health 0)
    2 *energy-input* (0 :subtree)
  
  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for medical history \.)) (0 :gist)

)) ; END *medical-history-input*



(READRULES '*medicine-side-effects-addiction-input*
; (Can I get addicted to narcotics ?)
'(
  1 (0 low 1 risk 0)
    2 ((Addiction is not a side effect of the medication \.) (Medicine-addiction)) (0 :gist)
  1 (3 NEG 0)
    2 ((Addiction is not a side effect of the medication \.) (Medicine-addiction)) (0 :gist)
  1 (0 NEG 2 side-effect-addition 0)
    2 ((Addiction is not a side effect of the medication \.) (Medicine-addiction)) (0 :gist)
  1 (3 POS 0)
    2 ((A side effect of the medication is addiction \.) (Medicine-addiction)) (0 :gist)
  1 (0 high 1 risk 0)
    2 ((A side effect of the medication is addiction \.) (Medicine-addiction)) (0 :gist)
  1 (0 may 1 side-effect-addition 0)
    2 ((A side effect of the medication is addiction \.) (Medicine-addiction)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for whether addiction is a side effect of the medication \.)) (0 :gist)

)) ; END *medicine-side-effects-addiction-input*



(READRULES '*medicine-side-effects-input*
; (What are the side effects of stronger pain medication ?)
'(
  1 (0 hair 0)
    2 ((A side effect of the medication is hair loss \.) (Medicine-side-effects)) (0 :gist)
  1 (0 side-effect-addiction 0)
    2 ((A side effect of the medication is addiction \.) (Medicine-side-effects)) (0 :gist)
  1 (0 side-effect-neuropathy 0)
    2 ((A side effect of the medication is neuropathy \.) (Medicine-side-effects)) (0 :gist)
  1 (0 side-effect-nausea 0)
    2 ((A side effect of the medication is nausea \.) (Medicine-side-effects)) (0 :gist)
  1 (0 diarrhea 0)
    2 ((A side effect of the medication is diarrhea \.) (Medicine-side-effects)) (0 :gist)
  1 (0 side-effect-fatigue 0)
    2 ((A side effect of the medication is fatigue \.) (Medicine-side-effects)) (0 :gist)
  1 (0 less 1 energy 0)
    2 ((A side effect of the medication is fatigue \.) (Medicine-side-effects)) (0 :gist)
  1 (0 side-effect-appetite 0)
    2 ((A side effect of the medication is loss of appetite \.) (Medicine-side-effects)) (0 :gist)


  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for side effects of a medication \.)) (0 :gist)

)) ; END *medicine-side-effects-input*



(READRULES '*appointment-input*
; (I am here alone \.)
'(
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
  1 (0 children 0)
    2 ((Do I have any children ?) (Anyone-here-with-you)) (0 :gist)
  1 (0 child 0)
    2 ((Do I have any children ?) (Anyone-here-with-you)) (0 :gist)
  1 (0 grandchildren 0)
    2 ((Do I have any grandchildren ?) (Anyone-here-with-you)) (0 :gist)
  1 (0 grandchild 0)
    2 ((Do I have any grandchildren ?) (Anyone-here-with-you)) (0 :gist)

  ; Were you ever married?
  1 (0 married 0)
    2 ((Am I married ?) (Anyone-here-with-you)) (0 :gist)

  ; How are you doing today?
  1 (0 wh_ 2 you 3 feeling 0)
    2 ((How am I doing today ?)) (0 :gist)

  ; Expressing sympathy about daughter not being able to make it
  1 (0 that be too bad 0)
    2 ((You are sorry that my daughter couldn\'t come today \.) (Anyone-here-with-you)) (0 :gist)
  1 (0 I be sorry 0)
    2 ((You are sorry that my daughter couldn\'t come today \.) (Anyone-here-with-you)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for question about appointment details \.)) (0 :gist)

)) ; END *appointment-input*



(READRULES '*chemotherapy-details-input*
; (What are the side effects of chemotherapy ?)
; (How does chemotherapy work ?)
'(
  ; Side effects
  1 (0 low blood 0)
    2 ((A side effect of chemotherapy is low blood counts \.) (Chemotherapy-side-effects)) (0 :gist)
  1 (0 hair 0)
    2 ((A side effect of chemotherapy is hair loss \.) (Chemotherapy-side-effects)) (0 :gist)
  1 (0 side-effect-neuropathy 0)
    2 ((A side effect of chemotherapy is neuropathy \.) (Chemotherapy-side-effects)) (0 :gist)
  1 (0 side-effect-nausea 0)
    2 ((A side effect of chemotherapy is nausea \.) (Chemotherapy-side-effects)) (0 :gist)
  1 (0 diarrhea 0)
    2 ((A side effect of chemotherapy is diarrhea \.) (Chemotherapy-side-effects)) (0 :gist)
  1 (0 side-effect-fatigue 0)
    2 ((A side effect of chemotherapy is fatigue \.) (Chemotherapy-side-effects)) (0 :gist)
  1 (0 side-effect-appetite 0)
    2 ((A side effect of chemotherapy is loss of appetite \.) (Chemotherapy-side-effects)) (0 :gist)
  
  ; Different types of chemotherapy
  1 (0 mediport 0)
    2 ((One way to get chemotherapy is by a port \.) (Chemotherapy-details)) (0 :gist)
  1 (0 chemotherapy-IV 0)
    2 ((One way to get chemotherapy is by iv \.) (Chemotherapy-details)) (0 :gist)
  1 (0 under 1 skin 0)
    2 ((One way to get chemotherapy is by iv \.) (Chemotherapy-details)) (0 :gist)
  1 (0 chemotherapy-injection 0)
    2 ((One way to get chemotherapy is by injection \.) (Chemotherapy-details)) (0 :gist)
  1 (0 doublet 0)
    2 ((One way to get chemotherapy is to get two chemotherapies together \.) (Chemotherapy-details)) (0 :gist)
  1 (0 two 2 chemotherapy 0)
    2 ((One way to get chemotherapy is to get two chemotherapies together \.) (Chemotherapy-details)) (0 :gist)

  ; What specifically are you wondering about ?
  1 (0 wh_ 3 be 3 you 3 wondering 0)
    2 ((What chemotherapy details are you asking about ?) (Chemotherapy-details)) (0 :gist)

  ; What do you know/think about chemotherapy?
  1 (0 how 4 you 3 feeling 0)
    2 (*chemotherapy-question* (what do you think about chemotherapy ?)) (0 :subtree+clause)
  1 (0 wh_ 4 you 3 think-gen 0)
    2 (*chemotherapy-question* (what do you think about chemotherapy ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 you 2 understand-gen 0)
    2 (*chemotherapy-question* (do you understand how chemotherapy works ?)) (0 :subtree+clause)

  ; asking if system has any questions
  1 (0 you 2 have 2 question-word 0)
    2 (*chemotherapy-question* (Do you have a question about chemotherapy?)) (0 :subtree+clause)
  1 (0 question-word 2 you 2 have 0)
    2 (*chemotherapy-question* (Do you have a question about chemotherapy?)) (0 :subtree+clause)
  1 (0 anything 1 you 2 want-gen 2 ask-gen 0)
    2 (*chemotherapy-question* (Do you have a question about chemotherapy?)) (0 :subtree+clause)

  1 (0 both 0)
    2 ((A side effect of chemotherapy is hair loss \.) (Chemotherapy-side-effects)) (0 :gist)

  1 (0 comfort-care-word 0)
    2 *comfort-care-input* (0 :subtree)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for chemotherapy details \.)) (0 :gist)

)) ; END *chemotherapy-details-input*



(READRULES '*diagnosis-details-input*
; (I got my diagnosis after visiting a lung doctor \.)
; (I have lost 1 weight \.)
'(
  1 (0 medicine-gen 0)
    2 *medicine-working-input* (0 :subtree)
  1 (0 something 1 med-better 0)
    2 *medicine-working* (0 :subtree)

  1 (1 how much 1)
    2 (*diagnosis-details-question* (how much weight have you lost ?)) (0 :subtree+clause)
  1 (0 how much 0 lose 0)
    2 (*diagnosis-details-question* (how much weight have you lost ?)) (0 :subtree+clause)
  1 (0 do pron 2 lose 3 much 0)
    2 (*diagnosis-details-question* (how much weight have you lost ?)) (0 :subtree+clause)
  1 (0 have pron 2 lose 3 much 0)
    2 (*diagnosis-details-question* (how much weight have you lost ?)) (0 :subtree+clause)
  1 (0 wh_ do 2 lose 0)
    2 (*diagnosis-details-question* (how much weight have you lost ?)) (0 :subtree+clause)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for diagnosis details \.)) (0 :gist)

)) ; END *diagnosis-details-input*



(READRULES '*energy-input*
; (I have been fatigued \.)
; (I have had trouble concentrating \.)
; (I feel mildly depressed \.)
; (Will an antidepressant help me with my pain ?)
; (Should I try medication before I try therapy ?)
'(
  1 (0 AUX-BASE 3 ment-health 3 recently 0)
    2 ((How is my mental health ?) (Energy)) (0 :gist)
  1 (0 how 5 think-gen 0)
    2 ((How is my mental health ?) (Energy)) (0 :gist)
  1 (0 how 3 ment-health 5)
    2 ((How is my mental health ?) (Energy)) (0 :gist)
  1 (0 wh_ 5 think-gen 0)
    2 ((How is my mental health ?) (Energy)) (0 :gist)
  1 (0 do 1 pron 5 ment-health 0 )
    2 ((How is my mental health ?) (Energy)) (0 :gist)
  1 (0 have 1 pron 5 ment-health 0)
    2 ((How is my mental health ?) (Energy)) (0 :gist)

  1 (0 antidepressant 0)
    2 ((I should take an antidepressant \.) (Medicine-request)) (0 :gist)
  1 (0 therapy 0)
    2 ((I should see a therapist \.) (Energy)) (0 :gist)

  1 (0 sorry 0)
    2 ((I am sorry you have been feeling down recently \.) (Energy)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for question about my energy \.)) (0 :gist)

)) ; END *energy-input*



(READRULES '*medicine-input*
; (I don\'t have allergies to any medicine \.)
; (I am only taking Lortab to treat my pain \.)
; (I am taking Cozar to help with blood pressure \.)
; (Taking the Lortab more frequently helps \.)
; (I am taking Lortab every three hours \.)
; (I do not have a history of narcotic abuse \.)
; (My mother died of complications from her diabetes \.)
; (My father died of prostate cancer \.)
'(

  ;; ; The following needs modification
  ;; 1 (0 sure \, I can arrange that 0)
  ;;   2 ((You will give me more medicine \.) (Stronger-medicine)) (0 :gist)

  ; how is that working for you?
  1 (0 how be 3 med-help 0)
    2 (*medicine-question* (how are you feeling on the lortab ?)) (0 :subtree+clause)
  1 (0 how 3 be 1 think-gen 0)
    2 (*medicine-question* (how are you feeling on the lortab ?)) (0 :subtree+clause)

  ; Possibly too general, might need refining
  1 (0 med-narcotic 0)
    2 ((I should take a narcotic \.) (Medicine-request)) (0 :gist)

  1 (0 refill 0)
    2 (*medicine-question* (do you need a refill on medicine ?)) (0 :subtree+clause)

  1 (0 something 3 med-better 0)
    2 (*medicine-question* (have you thought about a stronger pain medication ?)) (0 :subtree+clause)
  1 (0 some thing 3 med-better 0)
    2 (*medicine-question* (have you thought about a stronger pain medication ?)) (0 :subtree+clause)
  1 (0 a 2 med-better 2 medication 0)
    2 (*medicine-question* (have you thought about a stronger pain medication ?)) (0 :subtree+clause)
  1 (0 some 2 med-better 2 medication 0)
    2 (*medicine-question* (have you thought about a stronger pain medication ?)) (0 :subtree+clause)

  ; asking if system has any questions
  1 (0 you 2 have 2 question-word 0)
    2 (*medicine-question* (Do you have a question about your medicine ?)) (0 :subtree+clause)
  1 (0 question-word 2 you 2 have 0)
    2 (*medicine-question* (Do you have a question about your medicine ?)) (0 :subtree+clause)
  1 (0 anything 1 you 2 want-gen 2 ask-gen 0)
    2 (*medicine-question* (Do you have a question about your medicine ?)) (0 :subtree+clause)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for medicine \.)) (0 :gist)

)) ; END *medicine-input*



(READRULES '*pain-input*
; (My pain has recently been getting worse \.)
'(
  ; If doctor inquires for more information
  1 (0 more-info 2 more-info 0)
    2 (*pain-question* (can you tell me about your pain ?)) (0 :subtree+clause)
  1 (0 go on 0)
    2 (*pain-question* (can you tell me about your pain ?)) (0 :subtree+clause)
  1 (0 elaborate 0)
    2 (*pain-question* (can you tell me about your pain ?)) (0 :subtree+clause)
  ; If doctor specifically wants you to rate your pain
  1 (0 how pain-bad 2 pain 0)
    2 (*pain-question* (how do you rate your pain ?)) (0 :subtree+clause)
  1 (0 scale 0)
    2 (*pain-question* (how do you rate your pain ?)) (0 :subtree+clause)
  ; If doctor asks about what lead up to this
  1 (0 what 2 happened 3 before 0)
    2 (*diagnosis-details-question* (what lead to your diagnosis ?)) (0 :subtree+clause)
  1 (0 how do 3 know 0)
    2 (*diagnosis-details-question* (what lead to your diagnosis ?)) (0 :subtree+clause)
  1 (0 how 0 find out 0)
    2 (*diagnosis-details-question* (what lead to your diagnosis ?)) (0 :subtree+clause)
  ; If doctor asks what you're taking for the pain
  1 (0 wh_ 1 medicine-gen 0)
    2 (0 how 4 medicine-gen 2 med-help 0)
      3 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
    2 (*medicine-question* (what are you taking for the pain ?)) (0 :subtree+clause)
  1 (0 wh_ 2 med-take 0)
    2 (*medicine-question* (what medicine are you taking ?)) (0 :subtree+clause)
  ; When you take it does it take care of the pain?
  1 (0 AUX-BASE 3 med-help 3 pain 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 med-help 1 at all 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 med-help 1 little 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 1 it 3 do anything 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)

  1 (0 SELF 2 sorry 0)
    2 ((You are sorry that I am in pain \.)) (0 :gist)

  1 (0 medicine-gen 0)
    2 *medicine-working-input* (0 :subtree)
  1 (0 something 1 med-better 0)
    2 *medicine-working-input* (0 :subtree)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for pain \.)) (0 :gist)

)) ; END *pain-input*



(READRULES '*radiation-verification-input*
; (Do you think radiation will help ?)
'(
  1 (5 POS 0)
    2 (- 0 NEG sure 0)
      3 ((You think I need radiation \.) (Radiation)) (0 :gist)
  1 (0 I 1 think-gen so 0)
    2 ((You think I need radiation \.) (Radiation)) (0 :gist)
  1 (5 no 0)
    2 ((You do not think I need radiation \.) (Radiation)) (0 :gist)
  1 (0 NEG 1 think-gen 0)
    2 ((You do not think I need radiation \.) (Radiation)) (0 :gist)

  ; Doctor mentions chemotherapy or comfort care
  1 (0 chemotherapy 0)
    2 *chemotherapy-input* (0 :subtree)
  1 (0 comfort-care-word 0)
    2 *comfort-care-input* (0 :subtree)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for radiation \.)) (0 :gist)

)) ; END *radiation-verification-input*



(READRULES '*radiation-input*
; (I had radiation treatment for five weeks \.)
; (I was feeling a little better after radiation \.)
'(
  1 (0 do it 1 pain-return 0)
    2 (*general-input* (did the pain return ?)) (0 :subtree+clause)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for radiation \.)) (0 :gist)

)) ; END *radiation-input*



(READRULES '*sleep-input*
'(
  1 (0 sleep 2 during 3 day 0)
    2 (*sleep-question* (do you sleep during the day ?)) (0 :subtree+clause)
  1 (0 how 1 frequently 0 wake)
    2 (*sleep-question* (how often are you waking up at night ?)) (0 :subtree+clause)

  1 (0 ment-health 0)
    2 (*sleep-question* (is your mental health keeping you awake ?)) (0 :subtree+clause)

  1 (0 coffee 0)
    2 (*sleep-question* (is coffee keeping you awake ?)) (0 :subtree+clause)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((Nil Gist \: nothing found for sleeping well \.)) (0 :gist)

)) ; END *sleep-input*



(READRULES '*chemotherapy-input*
; (Do I need chemotherapy ?)
; (Do you think chemotherapy will help ?)
'(
  ; If doctor mentions anything about prognosis
  1 (0 prognosis 0)
    2 *prognosis-input* (0 :subtree)

  ; No, I think you should do comfort care instead
  1 (0 palliative care 0 NEG 1 med-help 0)
    2 ((You do not think I need chemotherapy because I should get comfort care instead \.) (Chemotherapy)) (0 :gist)
  1 (0 hospice 0 NEG 1 med-help 0)
    2 ((You do not think I need chemotherapy because I should get comfort care instead \.) (Chemotherapy)) (0 :gist)
  1 (5 NEG 0 palliative care 0)
    2 ((You do not think I need chemotherapy because I should get comfort care instead \.) (Chemotherapy)) (0 :gist)
  1 (5 NEG 0 hospice 0)
    2 ((You do not think I need chemotherapy because I should get comfort care instead \.) (Chemotherapy)) (0 :gist)
  1 (0 palliative care 4 instead 0)
    2 ((You do not think I need chemotherapy because I should get comfort care instead \.) (Chemotherapy)) (0 :gist)
  1 (0 hospice 4 instead 0)
    2 ((You do not think I need chemotherapy because I should get comfort care instead \.) (Chemotherapy)) (0 :gist)

  ; Doctor mentions comfort care
  1 (0 palliative care 0)
    2 *comfort-care-input* (0 :subtree)
  1 (0 comfort-care-word 0)
    2 *comfort-care-input* (0 :subtree)

  ; Chemotherapy might be an option
  1 (0 chemotherapy 4 be 3 treatment-option 0)
    2 ((You think I might need chemotherapy \.) (Chemotherapy)) (0 :gist)

  ; We should talk to an oncologist
  1 (0 chemotherapy-consult 4 oncologist 0)
    2 ((You think we should talk to my oncologist about chemotherapy \.) (Chemotherapy)) (0 :gist)
  1 (0 information 2 from 2 oncologist 0)
    2 ((You think we should talk to my oncologist about chemotherapy \.) (Chemotherapy)) (0 :gist)

  ; What do you know/think about chemotherapy?
  1 (0 how 4 you 3 feeling 0)
    2 (*chemotherapy-question* (what do you think about chemotherapy ?)) (0 :subtree+clause)
  1 (0 wh_ 4 you 3 think-gen 0)
    2 (*chemotherapy-question* (what do you think about chemotherapy ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 you 2 think-gen 7 chemotherapy 0)
    2 (*chemotherapy-question* (what do you think about chemotherapy ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 you 2 understand-gen 0)
    2 (*chemotherapy-question* (do you understand how chemotherapy works ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 4 want-gen 4 chemotherapy 0)
    2 (*chemotherapy-question* (what do you think about chemotherapy ?)) (0 :subtree+clause)
  1 (0 opinion-gen 2 on 2 chemotherapy 0)
    2 (*chemotherapy-question* (what do you think about chemotherapy ?)) (0 :subtree+clause)
    
  ; asking if system has any questions
  1 (0 you 2 have 2 question-word 0)
    2 (*chemotherapy-question* (Do you have a question about chemotherapy ?)) (0 :subtree+clause)
  1 (0 question-word 2 you 2 have 0)
    2 (*chemotherapy-question* (Do you have a question about chemotherapy ?)) (0 :subtree+clause)
  1 (0 anything 1 you 2 want-gen 2 ask-gen 0)
    2 (*chemotherapy-question* (Do you have a question about chemotherapy ?)) (0 :subtree+clause)

  ; Various yes/no answer possibilities
  1 (5 POS 0)
    2 (- 0 NEG sure 0)
      3 ((You think I need chemotherapy \.) (Chemotherapy)) (0 :gist)
    2 (- 0 POS 8 but 0)
      3 ((You think I need chemotherapy \.) (Chemotherapy)) (0 :gist)
    2 ((You think I might need chemotherapy \.) (Chemotherapy)) (0 :gist)
  1 (0 posadv-affirm 0)
    2 (- 0 posadv-affirm NEG 0)
      3 (- 0 NEG posadv-affirm 0)
        4 ((You think I need chemotherapy \.) (Chemotherapy)) (0 :gist)
    2 (- 0 posadv-affirm 8 but 0)
      3 ((You think I need chemotherapy \.) (Chemotherapy)) (0 :gist)
    2 ((You do not think I need chemotherapy \.) (Chemotherapy)) (0 :gist)
  1 (0 I 1 think-gen so 0)
    2 ((You think I need chemotherapy \.) (Chemotherapy)) (0 :gist)
  1 (0 worth 1 shot 0)
    2 (0 worth 1 shot 8 but 0)
      3 ((You think I might need chemotherapy \.) (Chemotherapy)) (0 :gist)
    2 ((You think I need chemotherapy \.) (Chemotherapy)) (0 :gist)
  1 (5 no 0)
    2 ((You do not think I need chemotherapy \.) (Chemotherapy)) (0 :gist)
  1 (0 NEG 1 think-gen 0)
    2 ((You do not think I need chemotherapy \.) (Chemotherapy)) (0 :gist)
  1 (0 NEG 1 med-help 0)
    2 ((You do not think I need chemotherapy \.) (Chemotherapy)) (0 :gist)
  1 (0 you 4 NEG 2 want-gen 0)
    2 ((You do not think I need chemotherapy \.) (Chemotherapy)) (0 :gist)

  1 (0 cancer-goals 0)
    2 (*treatment-option-question* (what are your treatment goals ?)) (0 :subtree+clause)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for chemotherapy \.)) (0 :gist)

)) ; END *chemotherapy-input*



(READRULES '*comfort-care-input*
; (Should I get comfort care ?)
; (How does comfort care work ?)
'(
  ; If doctor mentions anything about prognosis
  1 (0 prognosis 0)
    2 *prognosis-input* (0 :subtree)

  1 (0 NEG 1 painful 0)
    2 ((Comfort care should alleviate my pain \.) (Comfort-care)) (0 :gist)
  1 (0 pain-alleviate 1 pain 0)
    2 ((Comfort care should alleviate my pain \.) (Comfort-care)) (0 :gist)
  1 (0 make 1 comfortable 0)
    2 ((Comfort care should alleviate my pain \.) (Comfort-care)) (0 :gist)
  1 (0 make-better 2 quality 1 of 1 life 0)
    2 ((Comfort care should alleviate my pain \.) (Comfort-care)) (0 :gist)

  1 (0 comfort-care-word 0 referral 0)
    2 ((I would need a referral to start comfort care \.) (Comfort-care)) (0 :gist)

  ; asking if system has any questions
  1 (0 you 2 have 2 question-word 0)
    2 (*comfort-care-question* (Do you have a question about comfort care ?)) (0 :subtree+clause)
  1 (0 question-word 2 you 2 have 0)
    2 (*comfort-care-question* (Do you have a question about comfort care ?)) (0 :subtree+clause)
  1 (0 anything 1 you 2 want-gen 2 ask-gen 0)
    2 (*comfort-care-question* (Do you have a question about comfort care ?)) (0 :subtree+clause)

  ; What do you know/think about comfort care?
  1 (0 how 4 you 3 feeling 0)
    2 (*comfort-care-question* (what do you think about comfort care ?)) (0 :subtree+clause)
  1 (0 wh_ 4 you 3 think-gen 0)
    2 (*comfort-care-question* (what do you think about comfort care ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 you 2 understand-gen 0)
    2 (*comfort-care-question* (do you understand how comfort care works ?)) (0 :subtree+clause)

  ; Doctor explicitly mentions chemotherapy
  1 (0 chemotherapy 0)
    2 *chemotherapy-input* (0 :subtree)

  ; Comfort care allows me to spend time with my family .
  1 (0 family-pron 2 visit 2 you 0)
    2 ((Comfort care allows me to spend time with my family \.) (Comfort-care)) (0 :gist)
  1 (0 family-pron 2 spend 1 time-words 2 you 0)
    2 ((Comfort care allows me to spend time with my family \.) (Comfort-care)) (0 :gist)
  1 (0 you 2 spend 4 time-words 4 family-pron 0)
    2 ((Comfort care allows me to spend time with my family \.) (Comfort-care)) (0 :gist)

  ; Ways to receive comfort care
  1 (0 place 1 provide 2 comfort-care-word 0)
    2 ((Receiving comfort care in a dedicated facility is an option \.) (Comfort-care)) (0 :gist)
  1 (0 company 0)
    2 ((Receiving comfort care from a specialized service is an option \.) (Comfort-care)) (0 :gist)
  1 (0 home 0)
    2 (- 0 your 1 home 0)
      3 ((Receiving comfort care in a dedicated facility is an option \.) (Comfort-care)) (0 :gist)
    2 ((Receiving comfort care in my own home is an option \.) (Comfort-care)) (0 :gist)
  1 (0 nurse 0)
    2 ((Receiving comfort care from a nurse is an option \.) (Comfort-care)) (0 :gist)

  ; TODO: these rules need to be made a bit more explicit.
  1 (0 palliative care 0)
    2 ((You think I need comfort care \.) (Comfort-care)) (0 :gist)
  1 (0 end 1 life 1 care 0)
    2 ((You think I need comfort care \.) (Comfort-care)) (0 :gist)
  1 (0 hospice 0)
    2 ((You think I need comfort care \.) (Comfort-care)) (0 :gist)
  
  ; Various yes/no possibilities 
  1 (5 POS 0)
    2 (- 0 NEG sure 0)
      3 ((You think I need comfort care \.) (Comfort-care)) (0 :gist)
    2 (- 0 POS 8 but 0)
      3 ((You think I need comfort care \.) (Comfort-care)) (0 :gist)
  1 (0 posadv-affirm 0)
    2 (- 0 posadv-affirm NEG 0)
      3 (- 0 NEG posadv-affirm 0)
        4 ((You think I need comfort care \.) (Comfort-care)) (0 :gist)
    2 (- 0 posadv-affirm 8 but 0)
      3 ((You think I need comfort care \.) (Comfort-care)) (0 :gist)
    2 ((You do not think I need comfort care \.) (Comfort-care)) (0 :gist)
  1 (0 I 1 think-gen so 0)
    2 ((You think I need comfort care \.) (Comfort-care)) (0 :gist)
  1 (5 no 0)
    2 ((You do not think I need comfort care \.) (Comfort-care)) (0 :gist)
  1 (0 NEG 1 think-gen 0)
    2 ((You do not think I need comfort care \.) (Comfort-care)) (0 :gist)


  1 (0 cancer-goals 0)
    2 (*treatment-option-question* (what are your treatment goals ?)) (0 :subtree+clause)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for comfort care \.)) (0 :gist)

)) ; END *comfort-care-input*



(READRULES '*comfort-care-verification-input*
; (Are you sure that I do not need comfort care ?)
'(
  1 (5 POS 0)
    2 ((You do not think I need comfort care \.) (Comfort-care)) (0 :gist)
  1 (0 affirm 0)
    2 ((You do not think I need comfort care \.) (Comfort-care)) (0 :gist)
  1 (0 I 1 think-gen so 0)
    2 ((You do not think I need comfort care \.) (Comfort-care)) (0 :gist)
  1 (5 no 0)
    2 ((You think I need comfort care \.) (Comfort-care)) (0 :gist)
  1 (0 NEG 1 think-gen 0)
    2 ((You think I need comfort care \.) (Comfort-care)) (0 :gist)

  ; What do you know/think about comfort care?
  1 (0 how 4 you 3 feeling 0)
    2 (*comfort-care-question* (what do you think about comfort care ?)) (0 :subtree+clause)
  1 (0 wh_ 4 you 3 think-gen 0)
    2 (*comfort-care-question* (what do you think about comfort care ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 you 2 understand-gen 0)
    2 (*comfort-care-question* (do you understand how comfort care works ?)) (0 :subtree+clause)

  1 (0 cancer-goals 0)
    2 (*treatment-option-question* (what are your treatment goals ?)) (0 :subtree+clause)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for verifying whether I need comfort care \.)) (0 :gist)

)) ; END *comfort-care-verification-input*



(READRULES '*medicine-refill-request-input*
; (I would like a refill of medicine \.)
'(
  ; You should take morphine
  1 (0 med-narcotic 0)
    2 ((I should take a narcotic \.) (Medicine-request)) (0 :gist)

  ; Do you want something better / stronger pain medication
  1 (0 do 1 you 3 want-gen 3 med-better medicine-taking 0)
    2 (*medicine-question* (do you want stronger pain medication ?)) (0 :subtree+clause)
  1 (0 do 1 want-gen 3 med-better 0)
    2 (*medicine-question* (do you want stronger pain medication ?)) (0 :subtree+clause)

  ; You should take something stronger / better pain medication
  1 (0 med-take 3 med-better 3 medicine-gen 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 med-take 1 something 1 med-better 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 want-gen 3 med-better 2 medicine-gen 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 want-gen 1 something 1 med-better 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
 1 (0 try 2 something 1 med-better 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 try 2 med-better 1 medicine-gen 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  
  ; Maximizing your pain medication
  1 (0 med-increase 3 medicine-gen 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 make 1 medicine-gen 2 med-better 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)

  ; You should take something different
  1 (0 something 2 different 0)
    2 ((I should take something different \.) (Medicine-request)) (0 :gist)
  1 (0 different 2 medicine-gen 0)
    2 ((I should take something different \.) (Medicine-request)) (0 :gist)

  ; Yes / No
  1 (5 POS 0)
    2 (- 0 NEG sure 0)
      3 ((I can give you a refill of pain medication \.) (Medicine-request)) (0 :gist)
    2 (- 0 POS 8 but 0)
      3 ((I can give you a refill of pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 posadv-affirm 0)
    2 (- 0 posadv-affirm NEG 0)
      3 (- 0 NEG posadv-affirm 0)
        4 ((I can give you a refill of pain medication \.) (Medicine-request)) (0 :gist)
    2 (- 0 posadv-affirm 8 but 0)
      3 ((I can give you a refill of pain medication \.) (Medicine-request)) (0 :gist)
    2 ((I cannot give you a refill of pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 no 1 problem 0)
    2 ((I can give you a refill of pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 NEG 0)
    2 ((I cannot give you a refill of pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 NEGADV 0)
    2 ((I cannot give you a refill of pain medication \.) (Medicine-request)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for refill of pain medication \.)) (0 :gist)

)) ; END *medicine-refill-request-input*



(READRULES '*medicine-stronger-request-input*
; (Can I have a stronger pain medication ?)
'(
  ; You should take morphine
  1 (0 med-narcotic 0)
    2 ((I should take a narcotic \.) (Medicine-request)) (0 :gist)

  ; Maximizing your pain medication
  1 (0 med-increase 3 medicine-gen 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 make 1 medicine-gen 2 med-better 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 med-better 3 medicine-gen 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 medicine-gen 3 med-better 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 something 3 med-better 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)

  ; You should take something different
  1 (0 something 2 different 0)
    2 ((I should take something different \.) (Medicine-request)) (0 :gist)
  1 (0 different 2 medicine-gen 0)
    2 ((I should take something different \.) (Medicine-request)) (0 :gist)

  ; Yes / No
  1 (5 POS 0)
    2 (- 0 NEG sure 0)
      3 ((I can give you stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 posadv-affirm 0)
    2 (- 0 posadv-affirm NEG 0)
      3 (- 0 NEG posadv-affirm 0)
        4 ((I can give you stronger pain medication \.) (Medicine-request)) (0 :gist)
    2 ((I cannot give you stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 no 1 problem 0)
    2 ((I can give you stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 NEG 0)
    2 ((I cannot give you stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 NEGADV 0)
    2 ((I cannot give you stronger pain medication \.) (Medicine-request)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for stronger pain medication \.)) (0 :gist)
    
)) ; END *medicine-stronger-request-input*



(READRULES '*medicine-working-input*
; (How will I know if my pain medication is working ?)
; (Why isn\'t the pain medication working anymore ?)
'(
  
  ; The Lortab?
  1 (4 medicine-gen 8)
    2 (*medicine-question* (are you taking 2 ?)) (0 :subtree+clause)

  ; When you take it does it take care of the pain?
  1 (0 AUX-BASE 3 med-help 3 pain 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 med-help 1 at all 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 med-help 1 little 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 1 it 3 do anything 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 how 4 medicine-gen 2 med-help 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)

  ; What medicine are you taking?
  1 (4 wh_ 3 medicine-gen 0)
    2 (*medicine-question* (what medicine are you taking ?)) (0 :subtree+clause)
  
  ; You should take morphine
  1 (0 med-narcotic 0)
    2 ((I should take a narcotic \.) (Medicine-request)) (0 :gist)

  ; Do you want something better / stronger pain medication
  1 (0 do 1 you 3 want-gen 3 med-better medicine-taking 0)
    2 (*medicine-question* (do you want stronger pain medication ?)) (0 :subtree+clause)
  1 (0 do 1 want-gen 3 med-better 0)
    2 (*medicine-question* (do you want stronger pain medication ?)) (0 :subtree+clause)

  ; You should take something stronger / better pain medication
  1 (0 med-take 3 med-better 3 medicine-gen 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 med-take 1 something 1 med-better 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 want-gen 3 med-better 2 medicine-gen 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 want-gen 1 something 1 med-better 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 try 2 something 2 med-better 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 try 2 med-better 2 medicine-gen 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  
  ; Maximizing your pain medication
  1 (0 med-increase 3 medicine-gen 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 make 1 medicine-gen 2 med-better 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)

  ; You should take something different
  1 (0 something 2 different 0)
    2 ((I should take something different \.) (Medicine-request)) (0 :gist)
  1 (0 different 2 medicine-gen 0)
    2 ((I should take something different \.) (Medicine-request)) (0 :gist)

  ; It might take a couple days to tell
  1 (0 take 5 med-time-gen 4 med-help 0)
    2 ((I should wait to see if the pain medication works \.) (Medicine-request)) (0 :gist)
  1 (0 take 5 med-time-gen 4 med-notice 0)
    2 ((I should wait to see if the pain medication works \.) (Medicine-request)) (0 :gist)
  1 (0 med-wait 5 med-time-gen 0)
    2 ((I should wait to see if the pain medication works \.) (Medicine-request)) (0 :gist)
  1 (0 might 1 be 4 med-time-gen 0)
    2 ((I should wait to see if the pain medication works \.) (Medicine-request)) (0 :gist)
  1 (0 you 5 feeling 2 better 5 med-time-gen 0)
    2 ((I should wait to see if the pain medication works \.) (Medicine-request)) (0 :gist)
  1 (0 you 5 feeling 2 less 1 pain 5 med-time-gen 0)
    2 ((I should wait to see if the pain medication works \.) (Medicine-request)) (0 :gist)
  1 (0 you 5 improve 5 med-time-gen 0)
    2 ((I should wait to see if the pain medication works \.) (Medicine-request)) (0 :gist)
  1 (0 you 5 pain 3 decrease 5 med-time-gen 0)
    2 ((I should wait to see if the pain medication works \.) (Medicine-request)) (0 :gist)
  1 (0 you 5 pain 3 go away 5 med-time-gen 0)
    2 ((I should wait to see if the pain medication works \.) (Medicine-request)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for knowing if pain medication working \.)) (0 :gist)

)) ; END *medicine-working-input*



(READRULES '*prognosis-verification-input*
'(
)) ; END *prognosis-verification-input*



(READRULES '*prognosis-input*
; (What is my prognosis ?)
'(
  ; Mentions test results explicitly
  1 (0 diagnosis-tests 0)
    2 *test-results-input* (0 :subtree)
  
  ; The prognosis is that I may live for x amount of time.
  1 (0 number-total 2 elapsed-time 0)
    2 ((The prognosis is that I may live for 2 4 \.) (Prognosis)) (0 :gist)
  1 (0 number-vague 2 elapsed-time 0)
    2 ((The prognosis is that I may live for several 4 \.) (Prognosis)) (0 :gist)
  1 (0 elapsed-time-plur ahead 3 you 0)
    2 ((The prognosis is that I may live for several 2 \.) (Prognosis)) (0 :gist)
  1 (0 elapsed-time-plur 1 left 0)
    2 ((The prognosis is that I may live for several 2 \.) (Prognosis)) (0 :gist)
  1 (0 elapsed-time-plur 1 prognosis-more 0)
    2 ((The prognosis is that I may live for several 2 \.) (Prognosis)) (0 :gist)
  1 (0 a 2 elapsed-time 0)
    2 ((The prognosis is that I may live for a 4 \.) (Prognosis)) (0 :gist)

  ; You don't have much long left to live
  1 (0 you 1 NEG 2 have 3 long 2 cancer-live 0)
    2 ((The prognosis is that I do not have long left to live \.) (Prognosis)) (0 :gist)
  1 (0 NEG 8 long 1 time-words 0)
    2 ((The prognosis is that I do not have long left to live \.) (Prognosis)) (0 :gist)
  1 (0 NEG 8 much 1 time-words 0)
    2 ((The prognosis is that I do not have long left to live \.) (Prognosis)) (0 :gist)
  1 (0 you 2 NEG 2 much 1 left 0)
    2 ((The prognosis is that I do not have long left to live \.) (Prognosis)) (0 :gist)
  1 (0 you 2 NEG 2 much 3 cancer-live 0)
    2 ((The prognosis is that I do not have long left to live \.) (Prognosis)) (0 :gist)
  1 (0 you 2 NEG 2 have 1 much 1 time-words 0)
    2 ((The prognosis is that I do not have long left to live \.) (Prognosis)) (0 :gist)
  1 (0 you 2 succumb 4 cancer-illness 0)
    2 ((The prognosis is that I do not have long left to live \.) (Prognosis)) (0 :gist)
  1 (0 MODAL 6 think-gen 2 about 4 end 1 of 1 life 0)
    2 ((The prognosis is that I do not have long left to live \.) (Prognosis)) (0 :gist)

  ; There is no cure
  1 (0 NEG 2 cure 0)
    2 ((The prognosis is that I cannot be cured \.) (Prognosis)) (0 :gist)
  1 (0 NEG 8 curable 0)
    2 ((The prognosis is that I cannot be cured \.) (Prognosis)) (0 :gist)
  1 (0 NEG 2 go away 0)
    2 ((The prognosis is that I cannot be cured \.) (Prognosis)) (0 :gist)
  1 (0 fight 2 rest 4 life 0)
    2 ((The prognosis is that I cannot be cured \.) (Prognosis)) (0 :gist)
  1 (0 lose 1 battle 0)
    2 ((The prognosis is that I cannot be cured \.) (Prognosis)) (0 :gist)
  1 (0 chance 5 recover 3 low 0)
    2 ((The prognosis is that I cannot be cured \.) (Prognosis)) (0 :gist)
  1 (0 you 3 will 4 NEG recover 0)
    2 ((The prognosis is that I cannot be cured \.) (Prognosis)) (0 :gist)
  1 (0 NEG 2 seem 2 good 0)
    2 ((The prognosis is that I cannot be cured \.) (Prognosis)) (0 :gist)

  ; The test results show that the radiation is not working 
  1 (0 radiation-treatment 2 NEG 2 work 0)
    2 ((The test results show that the radiation is not working \.) (Prognosis)) (0 :gist)
  1 (0 radiation-treatment 2 NEG 2 stop 4 cancer-illness 0)
    2 ((The test results show that the radiation is not working \.) (Prognosis)) (0 :gist)

  ; You'll be fine
  1 (0 you 3 prog-future 4 recover 0)
    2 ((The prognosis is that I will survive \.) (Prognosis)) (0 :gist)
  
  ; TODO: fix issue with extracting multiple time gist clauses from this:
  ; Good question. It’s hard to tell. If you were to read a book people would say with treatment people live about up to two years. That being said, we have patients in our practice that live much longer.  And that being said, we have patients in our practice that don’t live that long. And it really depends on the aggressiveness of your disease.  So, back in the day when we didn’t have treatments for lung cancer people would pass away within less than six months. That was the norm in an untreated lung cancer patient. And now we have patients living several years.  And the good part, if there is a silver lining in the treatment of lung cancer, is that there are so many new treatments coming out. And that my hope is that my patients currently being treated for lung
  ; cancer, these things that come out as time goes on. Because the hard part about any of these chemos is they don’t work forever.
  ; So they are smart in the sense that they can kill off cancer cells but the hard part with them is that they don’t work forever
  ; meaning the cells become clever and they find a way around the chemo.  And so when that happens, so say for example we do this
  ; four to six times and then we’re on observation, then we do another scan.  And this would be six months later. And sure enough
  ; we do the CT scan and there’s a new spot.  A new spot on the bone, a new spot on the lung. Then we repeat usually another
  ; type of chemo. So not this one. Because we’ve learned that this one, now those cancer cells figured out a way to get around.
  ; So this is when we use another type of chemo.  We use another type of chemo and then we do an observation again and that cycle
  ; keeps continuing as long as we can.  
  ;
  ;
  ; TODO: pick up on palliative care here?
  ; But in general when cancer starts in the lung and travels to other sites in the body like the bone it’s what
  ; we call Stage 4 or metastatic lung cancer, meaning that the cancer has spread from where it started to another spot.
  ; And when lung cancer does that and it spreads to other places in the body it’s unfortunately not what we would think
  ; of as a curable situation, like Dr. [Name] shared with you.  So the -- when I say that what I mean is that the
  ; treatments that we offer are unlikely to take the cancer away and have it never come back.  Okay?
  ; The goal of the. . . of the treatments is really to try to control and contain the cancer for as long as
  ; possible and in doing so we hope to have. . . to help folks live longer and live better.  Okay.  Have better
  ; control of symptoms that would be attributable to cancer and so forth.  It’s what we call palliative
  ; treatments, palliative meaning to alleviate suffering and symptoms.  
  ;

  1 (0 comfort-care-word 0)
    2 ((The prognosis is that my cancer should be treated with comfort care \.) (Comfort-care)) (0 :gist)
  1 (0 quality 1 life 0)
    2 ((The prognosis is that my cancer should be treated with comfort care \.) (Comfort-care)) (0 :gist)

  ; Mention of chemotherapy
  1 (0 chemotherapy 0)
    2 ((The prognosis is that my cancer should be treated with chemotherapy \.) (Chemotherapy)) (0 :gist)

  ; It's hard to predict
  1 (0 hard 2 to 2 predict 0)
    2 ((The prognosis is hard to predict \.) (Prognosis)) (0 :gist)
  1 (0 bad 1 at 3 guess 0)
    2 ((The prognosis is hard to predict \.) (Prognosis)) (0 :gist)
  1 (0 NEG good 1 at 3 guess 0)
    2 ((The prognosis is hard to predict \.) (Prognosis)) (0 :gist)
  1 (0 difficult 3 answer 0)
    2 ((The prognosis is hard to predict \.) (Prognosis)) (0 :gist)

  ; You should/should not get a second opinion.
  1 (0 second opinion 0)
    2 (0 good idea 0)
      3 (- 0 NEG 1 good idea 0)
        4 (- 0 good idea 1 NEG 0)
          5 ((You should obtain a second opinion about the prognosis \.) (Prognosis)) (0 :gist)
      3 ((You should not obtain a second opinion about the prognosis \.) (Prognosis)) (0 :gist)
    2 (0 beneficial 0)
      3 (- 0 NEG 1 beneficial 0)
        4 ((You should obtain a second opinion about the prognosis \.) (Prognosis)) (0 :gist)
      3 ((You should not obtain a second opinion about the prognosis \.) (Prognosis)) (0 :gist)
    2 (0 should 0)
      3 (- 0 should 1 NEG 0)
        4 (- 0 NEG 1 should 0)
          5 ((You should obtain a second opinion about the prognosis \.) (Prognosis)) (0 :gist)
      3 ((You should not obtain a second opinion about the prognosis \.) (Prognosis)) (0 :gist)
    2 (0 bad 0)
      3 (- 0 NEG 1 bad 0)
        4 (- 0 bad NEG 0)
          5 ((You should not obtain a second opinon about the prognosis \.) (Prognosis)) (0 :gist)
      3 ((You should obtain a second opinion about the prognosis \.) (Prognosis)) (0 :gist)
    2 (0 change 0)
      3 (- 0 NEG 1 change 0)
        4 (- 0 NEGADV 1 change 0)
          4 ((You should obtain a second opinion about the prognosis \.) (Prognosis)) (0 :gist)
      3 ((You should obtain a second opinion about the prognosis \.) (Prognosis)) (0 :gist)
    2 (0 up to you 0)
      3 ((It is up to you whether you obtain a second opinion \.) (Prognosis)) (0 :gist)
    2 (0 what 2 you 1 think-gen 0)
      3 ((It is up you whether you obtain a second opinion \.) (Prognosis)) (0 :gist)
    2 (0 depends on 1 you 0)
      3 ((It is up to you whether you obtain a second opinion \.) (Prognosis)) (0 :gist)

  ; What do you know/think about your prognosis?/What scares you about your prognosis?
  1 (0 how 4 you 3 feeling 0)
    2 (*prognosis-question* (what do you think about your prognosis ?)) (0 :subtree+clause)
  1 (0 wh_ 4 you 3 think-gen 0)
    2 (*prognosis-question* (what do you think about your prognosis ?)) (0 :subtree+clause)
  1 (0 tell 5 fear-words 0)
    2 (*prognosis-question* (What scares you about your prognosis ?)) (0 :subtree+clause)
  1 (0 elaborate 4 fear-words 0)
    2 (*prognosis-question* (What scares you about your prognosis ?)) (0 :subtree+clause)
  1 (0 wh_ 1 make 1 you 3 frightened 0)
    2 (*prognosis-question* (What scares you about your prognosis ?)) (0 :subtree+clause)
  1 (0 wh_ 1 frightens 1 you 0) 
    2 (*prognosis-question* (What scares you about your prognosis ?)) (0 :subtree+clause)
  1 (0 wh_ be 3 frightening 0)
    2 (*prognosis-question* (What scares you about your prognosis ?)) (0 :subtree+clause)
  1 (0 wh_ 1 you 1 think-gen 3 frightening 0)
    2 (*prognosis-question* (What scares you about your prognosis ?)) (0 :subtree+clause)
  1 (0 wh_ be 3 fear-words 0)
    2 (*prognosis-question* (What scares you about your prognosis ?)) (0 :subtree+clause)
  1 (0 wh_ cause you 4 fear-words 0)
    2 (*prognosis-question* (What scares you about your prognosis ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 you 2 understand-gen 0)
    2 (*prognosis-question* (do you understand your prognosis ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 you 2 tell 6 understand-gen 0)
    2 (*prognosis-question* (do you understand your prognosis ?)) (0 :subtree+clause)
  1 (0 tell 4 understand-gen 0)
    2 (*prognosis-question* (do you understand your prognosis ?)) (0 :subtree+clause)

  ; asking if system has any questions
  1 (0 you 2 have 2 question-word 0)
    2 (*prognosis-question* (Do you have a question about your prognosis ?)) (0 :subtree+clause)
  1 (0 question-word 2 you 2 have 0)
    2 (*prognosis-question* (Do you have a question about your prognosis ?)) (0 :subtree+clause)
  1 (0 anything 1 you 2 want-gen 2 ask-gen 0)
    2 (*prognosis-question* (Do you have a question about your prognosis ?)) (0 :subtree+clause)

  ; How much do I want to know about my prognosis ?
  1 (0 how much 3 information 3 AUX 1 you 0)
    2 (*prognosis-question* (How much information do you want about your prognosis ?)) (0 :subtree+clause)
  1 (0 how much 3 information 3 I 3 you 0)
    2 (*prognosis-question* (How much information do you want about your prognosis ?)) (0 :subtree+clause)
  1 (0 how much 3 AUX 3 I 3 want-gen 3 know 0)
    2 (*prognosis-question* (How much information do you want about your prognosis ?)) (0 :subtree+clause)
  1 (0 how much 3 I 3 tell 3 you 0)
    2 (*prognosis-question* (How much information do you want about your prognosis ?)) (0 :subtree+clause)


  1 (0 treatment-option 0)
    2 ((Am I ready to start discussing treatment options ?) (Treatment-options)) (0 :gist)
  
  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for prognosis \.)) (0 :gist)

)) ; END *prognosis-input*

(READRULES '*prognosis-denial-input*
; (Can I trust your prognosis ?)
'(

  ; Your uncle Fred is an unusual case.
  1 (0 uncle 0)
    2 (0 unusual 0)
      3 (- 0 NEG 1 unusual 0)
        4 ((The majority of people have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((The majority of people do not have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 usual 0)
      3 (- 0 NEG 1 usual 0)
        4 ((The majority of people do not have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((The majority of people have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 seldom 0)
      3 (- 0 NEG 1 seldom 0)
        4 ((The majority of people have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((The majority of people do not have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 frequently 0)
      3 (- 0 NEG 4 frequently 0)
        4 ((The majority of people do not have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((The majority of people have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 exception 0)
      3 (- 0 NEG 2 exception 0)
        4 ((The majority of people have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((The majority of people do not have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 like 1 uncle 0)
      3 (0 much 0)
        4 (- 0 NEG 0)
          5 ((The majority of people do not have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
        4 ((The majority of people have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 (0 most 0)
        4 (- 0 NEG 0)
          5 ((The majority of people do not have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
        4 ((The majority of people have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 (0 few 0)
        4 ((The majority of people have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 (0 none 0)
        4 (- 0 NEG 0)
          5 ((The majority of people do not have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
        4 ((The majority of people have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 (0 no 1 one 0)
        4 ((The majority of people have an accurate prognosis \.) (Prognosis-Understanding)) (0 :gist)

  ; More complex ways of saying yes/no
  1 (0 tag-question 0)
    2 (0 you 2 tag-question 0)
      3 (- 0 you 2 tag-question 8 but 0)
        4 ((My understanding of my prognosis is correct \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (- 0 NEG tag-question 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis is correct \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 incorrect 0)
    2 (0 you 2 incorrect 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (- 0 NEG 1 incorrect 0)
      3 (- 0 NEG 1 incorrect 4 but 0)
        4 ((My understanding of my prognosis is correct \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 unusual 0)
    2 (- 0 NEG 1 unusual 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis is correct \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 usual 0)
    2 (- 0 NEG 1 usual 0)
      3 ((My understanding of my prognosis is correct \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 seldom 0)
    2 (- 0 NEG 1 seldom 0)
      3 (- 0 seldom 1 NEG 0)
        4 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis is correct \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 odds 0)
    2 (0 good 1 odds 0)
      3 (- 0 NEG 4 good 1 odds 0)
        4 ((My understanding of my prognosis is correct \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 have 3 odds 0)
      3 (- 0 NEG 4 odds 0)
        4 ((My understanding of my prognosis is correct \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 be 3 odds 0)
      3 (- 0 NEG 4 odds 0)
        4 ((My understanding of my prognosis is correct \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)

  ; My understanding of my prognosis may be correct.
  1 (0 hard 2 to 2 predict 0)
    2 (0 hard 2 to 2 predict 2 but 0 NEG 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 hard 2 to 2 predict 2 but 0 NEGADV 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 hard 2 to 2 predict 2 but 0 unusual 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 hard 2 to 2 predict 2 but 0 I 2 doubt 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis may be correct \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 bad 1 at 3 guess 0)
     2 (0 bad 1 at 3 guess 2 but 0 NEG 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 bad 1 at 3 guess 2 but 0 NEGADV 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 bad 1 at 3 guess 2 but 0 unusual 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 bad 1 at 3 guess 2 but 0 I 2 doubt 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis may be correct \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEG good 1 at 3 guess 0)
     2 (0 NEG good 1 at 3 guess 2 but 0 NEG 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 NEG good 1 at 3 guess 2 but 0 NEGADV 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 NEG good 1 at 3 guess 2 but 0 unusual 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 NEG good 1 at 3 guess 2 but 0 I 2 doubt 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis may be correct \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 difficult 3 answer 0)
    2 (0 difficult 3 answer 2 but 0 NEG 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 difficult 3 answer 2 but 0 NEGADV 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 difficult 3 answer 2 but 0 unusual 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 difficult 3 answer 2 but 0 I 2 doubt 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis may be correct \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 might 3 tag-question 0)
    2 (0 might 3 tag-question 2 but 0 NEG 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 might 3 tag-question 2 but 0 NEGADV 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 might 3 tag-question 2 but 0 unusual 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 might 3 tag-question 2 but 0 I 2 doubt 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis may be correct \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 maybe 3 tag-question 0)
    2 (0 maybe 3 tag-question 2 but 0 NEG 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 maybe 3 tag-question 2 but 0 NEGADV 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 maybe 3 tag-question 2 but 0 unusual 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 maybe 3 tag-question 2 but 0 I 2 doubt 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis may be correct \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 never 1 know 0)
    2 (0 never 1 know 2 but 0 NEG 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 never 1 know 2 but 0 NEGADV 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 never 1 know 2 but 0 unusual 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 never 1 know 2 but 0 I 2 doubt 0)
      3 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis may be correct \.) (Prognosis-Understanding)) (0 :gist)
  
  ; You may/may not have more time. (Your understanding of yor prognosis-- based on Uncle Fred --is correct/incorrect.)
  1 (0 diagnosis-more 1 time 0)
    2 (- 0 NEG 2 diagnosis-more 0)
      3 ((My understanding of my prognosis is correct \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 cancer-live 2 prognosis-more 0)
    2 (- 0 NEG 4 prognosis-more 0)
      3 ((My understanding of my prognosis is correct \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    
  ; Yes / No
  1 (0 POS 0)
    2 (- 0 NEG 1 sure 0)
      3 (- 0 POS 10 but 0)
        4 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis may be correct \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 posadv-affirm 0)
    2 (- 0 posadv-affirm 1 NEG 0)
      3 (- 0 NEG 1 posadv-affirm 0)
        4 (- 0 posadv-affirm 8 but 0)
          5 ((My understanding of my prognosis is incorrect \.) (Prognosis-Understanding)) (0 :gist)    
    2 ((My understanding of my prognosis may be correct \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEG 0)
    2 (- 0 NEG 10 but 0)
      3 ((My understanding of my prognosis may be correct \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis is correct \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEGADV 0)
    2 (- 0 NEGADV 4 but 0)
      3 ((My understanding of my prognosis may be correct \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My understanding of my prognosis is correct \.) (Prognosis-Understanding)) (0 :gist)
  
  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for denial of prognosis \.)) (0 :gist)

)) ; END *prognosis-denial-input*


(READRULES '*prognosis-bargaining-habits-input*
'(
  ; Can I outlive your prognosis if I have healthy habits?

  ; Focus on spending time with family
  1 (0 spend 4 time-words 6 child 0)
    2 ((I should spend the time predicted by my prognosis with my family \.) (Prognosis-Understanding)) (0 :gist)

  ; More complex ways of saying yes/no
  1 (0 odds 0)
    2 (0 good 1 odds 0)
      3 (- 0 NEG 5 good 1 odds 0)
        4 ((Healthy habits will help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 have 3 odds 0)
      3 (- 0 NEG 6 odds 0)
        4 ((Healthy habits will help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 be 3 odds 0)
      3 (- 0 NEG 6 odds 0)
        4 ((Healthy habits will help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 make-better 3 odds 0)
      3 (- 0 NEG 6 odds 0)
        4 ((Healthy habits will help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
 
  1 (0 worth 2 shot 0)
    2 (0 worth 2 shot 2 but 0)
      3 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 not hurt 0)
    2 (0 not hurt 2 but 0)
      3 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
 
  1 (0 tag-question 0)
    2 (- 0 NEG 1 tag-question 0)
      3 (- 0 tag-question 8 but 0)
        4 ((Healthy habits will help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 incorrect 0)
    2 (- 0 NEG 1 incorrect 0)
      3 (- 0 incorrect 8 but 0)
        4 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
     ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 unusual 0)
    2 (- 0 NEG 1 unusual 0)
      3 (- 0 unusual 8 but 0)
        4 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Healthy habits will help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 seldom 0)
    2 (- 0 NEG 1 seldom 0)
      3 (- 0 seldom NEG 0)
        4 (- 0 seldom 8 but 0)
          5 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 usual 0)
    2 (- 0 NEG 1 usual 0)
      3 (- 0 usual 4 but 0)
        4 ((Healthy habits will help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    
  ; I may outlive your prognosis.
  1 (0 hard 2 to 2 predict 0)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 bad 1 at 3 guess 0)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEG good 1 at 3 guess 0)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 difficult 3 predict 0)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 might 3 tag-question 0)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 maybe 0)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)      

  ; Healthy habits will/will not be beneficial/change the prognosis.
  1 (0 make-better 0)
    2 (- 0 NEG 1 make-better 0)
      3 (- 0 make-better 4 but 0)
        4 (- 0 NEGADV 1 make-better 0)
          5 (- 0 doubt 4 make-better 0)
            6 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 make-worse 0)
    2 (- 0 NEG 1 make-worse 0)
      3 (- 0 NEGADV 1 make-worse 0)
        4 (- 0 doubt 4 make-worse 0)
          5 (- 0 make-worse 4 but 0)
            6 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
     2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEG 2 make-change-words 4 difference 0)
    2 (- 0 NEG 2 make-change-words 4 difference 5 but 0)
      3 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEGADV 2 make-change-words 4 difference 0)
    2 (- 0 NEGADV 2 make-change-words 4 difference 5 but 0)
      3 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 doubt 4 make-change-words 4 difference 0)
    2 (- 0 doubt 4 make-change-words 4 difference 5 but 0)
      3 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 beneficial 0)
    2 (- 0 NEG 1 beneficial 0)
      3 (- 0 NEGADV 1 beneficial 0)
        4 (- 0 beneficial 8 but 0)
          5 (- 0 doubt 4 beneficial 0)
      3 ((Healthy habits will help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  
  ; Most people do/do not outlive their prognosis. 
  ; TODO: Expand?
  1 (0 person-pl 0)
    2 (0 most 1 person-pl 0)
      3 (0 NEG 0)
        4 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((Healthy habits will help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 much 1 person-pl 0)
      3 (0 NEG 0)
        4 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((Healthy habits will help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 few 1 person-pl 0)
      3 (0 NEG 0)
        4 ((Healthy habits will help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)

  ; Yes / No
  1 (0 POS 0)
    2 (- 0 NEG 1 sure 0)
      3 (- 0 POS 8 but 0)
        4 ((Healthy habits will help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 posadv-affirm 0)
    2 (- 0 posadv-affirm 1 NEG 0)
      3 (- 0 NEG 1 posadv-affirm 0)
        4 (- 0 posadv-affirm 8 but 0)
          5 ((Healthy habits will help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEG 0)
    2 (- 0 NEG 8 but 0)
      3 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Healthy habits may help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEGADV 0)
    2 ((Healthy habits will not help me outlive my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  
  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for habits related bargaining of prognosis \.)) (0 :gist)
)) ; END *prognosis-bargaining-habits-input*

(READRULES '*prognosis-bargaining-quit-smoke-input*
'(
  ; I may outlive your prognosis.
  1 (0 hard 2 to 2 predict 0)
    2 ((Quitting smoking might make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 bad 1 at 3 guess 0)
    2 ((Quitting smoking might make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEG good 1 at 3 guess 0)
    2 ((Quitting smoking might make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 difficult 3 answer 0)
    2 ((Quitting smoking might make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 might 0)
    2 ((Quitting smoking might make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 maybe 0)
    2 ((Quitting smoking might make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)  

  ; More complex ways of saying yes/no
  1 (0 tag-question 0)
    2 (- 0 NEG tag-question 0)
      3 ((Quitting smoking will make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking will not make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 incorrect 0)
    2 (- 0 NEG incorrect 0)
      3 ((Quitting smoking will not make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking will make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 unusual 0)
    2 (- 0 NEG unusual 0)
      3 ((Quitting smoking will not make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking will make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 seldom 0)
    2 (- 0 NEG seldom 0)
      3 (- 0 seldom NEG 0)
        4 ((Quitting smoking will not make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking will make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 usual 0)
    2 (- 0 NEG usual 0)
      3 ((Quitting smoking will make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking will not make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 odds 0)
    2 (0 good 1 odds 0)
      3 (- 0 NEG 1 good 1 odds 0)
        4 ((Quitting smoking will make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
      3 ((Quitting smoking will not make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 have 3 odds 0)
      3 (- 0 NEG 4 odds 0)
        4 ((Quitting smoking will make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
      3 ((Quitting smoking will not make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 be 3 odds 0)
      3 (- 0 NEG 4 odds 0)
        4 ((Quitting smoking will make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
      3 ((Quitting smoking will not make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 make-better 3 odds 0)
      3 (- 0 NEG 6 odds 0)
        4 ((Quitting smoking will make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
      3 ((Quitting smoking will not make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 worth 2 shot 0)
    2 (0 worth 2 shot 2 but 0 NEG 0)
      3 ((Quitting smoking will not make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking might make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 not hurt 0)
    2 (0 not 2 hurt 2 but 0 NEG 0)
      3 ((Quitting smoking will not make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking might make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)

  ; Quitting smoking won't change your prognosis
  1 (0 make-better 0)
    2 (- 0 NEG 1 make-better 0)
      3 (- 0 make-better 4 but 0)
        4 (- 0 doubt 4 make-better 0)
          5 (- 0 NEGADV 1 make-better 0)
            6 ((Quitting smoking will make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking might make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 make-worse 0)
    2 (- 0 NEG 4 make-worse 0)
      3 (- 0 NEGADV 1 make-worse 0)
        4 (- 0 doubt 4 make-worse 0)
          5 (- 0 make-worse 4 but 0)
            6 ((Quitting smoking will not make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking might make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEG 2 make-change-words 4 difference 0)
    2 (- 0 NEG 2 make-change-words 4 difference 5 but 0)
      3 ((Quitting smoking will not make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking might make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEGADV 2 make-change-words 4 difference 0)
    2 (- 0 NEGADV 2 make-change-words 4 difference 5 but 0)
      3 ((Quitting smoking will not make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking might make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 doubt 4 make-change-words 4 difference 0)
    2 (- 0 doubt 4 make-change-words 4 difference 5 but 0)
      3 ((Quitting smoking will not make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking might make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 beneficial 0)
    2 (- 0 NEG 1 beneficial 0)
      3 (- 0 NEGADV 1 beneficial 0)
        4 (- 0 beneficial 8 but 0)
          5 (- 0 doubt 4 beneficial 0)
            6 ((Quitting smoking will make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking might make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
  
  ; Most people do/do not outlive their prognosis.
  1 (0 person-pl 0)
    2 (0 most 1 person-pl 0)
      3 (0 NEG 0)
        4 ((Quitting smoking will not make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
      3 ((Quitting smoking will make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 much 1 person-pl 0)
      3 (0 NEG 0)
        4 ((Quitting smoking will not make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
      3 ((Quitting smoking will make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 few 1 person-pl 0)
      3 (0 NEG 0)
        4((Quitting smoking will make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
      3 ((Quitting smoking will not make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)

  ; Yes / No
  1 (0 POS 0)
    2 (- 0 NEG 1 sure 0)
      3 (- 0 POS 8 but 0)
        4 ((Quitting smoking will make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking might make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 posadv-affirm 0)
    2 (- 0 posadv-affirm 1 NEG 0)
      3 (- 0 NEG 1 posadv-affirm 0)
        4 (- 0 posadv-affirm 8 but 0)
          5 ((Quitting smoking might make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking will not make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEG 0)
    2 (- 0 NEG 1 bad 0)
      3 (- 0 NEG 8 but 0)
        4 ((Quitting smoking will not make my prognosis better \.) (Prognosis-Understanding)) (0 :gist)
    2 ((Quitting smoking might make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEGADV 0)
    2 ((Quitting smoking will not make my prognosis better  \.) (Prognosis-Understanding)) (0 :gist)
  
  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for smoking related bargaining of prognosis \.)) (0 :gist)
)) ; END *prognosis-bargaining-quit-smoke-input*

(READRULES '*prognosis-bargaining-now-input*
'(
  ; Can I outlive your prognosis if I am healthy now? 

  ; Focus on spending time with family
  1 (0 spend 4 time-words 6 child 0)
    2 ((I should spend the time predicted by my prognosis with my family \.) (Prognosis-Understanding)) (0 :gist)

  ; How you feel right now does not predict your future
  1 (0 wh_ 3 feeling 0)
    2 (0 change 0)
      3 (- 0 change 2 odds 0)
        4 (- 0 change 2 prognosis 0)
          5 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 NEG 0)
      3 (0 NEG 1 predict 0)
        4 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 (0 NEG 3 predictor 0)
        4 (- 0 bad predictor 0)
          5 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
        4 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 (0 NEG 2 change 0)
        4 (0 change 2 odds 0)
          5 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
        4 (0 change 2 prognosis 0)
          5 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
        4 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 worse 0)
      3 (- 0 NEG 3 worse 0)
        4 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 beneficial 0)
      3 (0 NEG 3 beneficial 0)
        4 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 (0 beneficial 6 but 0)
        4 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)

  
  ; Being healthy now won't improve your prognosis
  1 (0 healthy 0)
    2 (0 change 0)
      3 (- 0 change 2 odds 0)
        4 (- 0 change 2 prognosis 0)
          5 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 NEG 0)
      3 (0 NEG 1 predict 0)
        4 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 (0 NEG 3 predictor 0)
        4 (- 0 bad predictor 0)
          5 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
        4 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 (0 NEG 2 change 0)
        4 (- 0 change 2 odds 0)
          5 (- 0 change 2 prognosis 0)
            6 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
        4 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 worse 0)
      3 (- 0 NEG 3 worse 0)
        4 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
   2 (0 good 2 predictor 0)
      3 (- 0 NEG 1 good 2 predictor 0)
        4 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 make-better 0)
      3 (- 0 NEG 1 make-better 0)
        4 (- 0 NEG 1 make-better 4 but 0)
          5 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
        4 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 (- 0 make-better 8 but 0)
         4 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 beneficial 0)
      3 (- 0 NEG 1 beneficial 0)
        4 (- 0 beneficial 8 but 0)
          5 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    
  ; More complex ways of saying yes/no
  1 (0 tag-question 0)
    2 (- 0 NEG 1 tag-question 0)
      3 (- 0 NEG 1 tag-question 4 but 0)
        4 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now may change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (- 0 tag-question 8 but 0)
      3 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 incorrect 0)
    2 (- 0 NEG 1 incorrect 0)
      3 (- 0 incorrect 4 but 0)
        4 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now may change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 unusual 0)
    2 (- 0 NEG 1 unusual 0)
      3 (- 0 unusual 4 but 0)
        4 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now may change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 seldom 0)
    2 (- 0 NEG 1 seldom 0)
      3 (- 0 seldom NEG 0)
        4 (- 0 seldom 8 but 0)
          5 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
        4 ((My health right now may change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 usual 0)
    2 (- 0 NEG 1 usual 0)
      3 (- 0 usual 4 but 0)
        4 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now may change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
   2 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)

  1 (0 odds 0)
    2 (0 good 1 odds 0)
      3 (- 0 NEG 1 good 1 odds 0)
        4 ((My health right now may change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 have 3 odds 0)
      3 (- 0 NEG 4 odds 0)
        4 ((My health right now may change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 be 3 odds 0)
      3 (- 0 NEG 4 odds 0)
        4 ((My health right now may change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)

  ; I may outlive your prognosis.
  1 (0 hard 2 to 2 predict 0)
    2 ((My health right now may change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 bad 1 at 3 guess 0)
    2 ((My health right now may change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEG good 1 at 3 guess 0)
    2 ((My health right now may change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 difficult 3 answer 0)
    2 ((My health right now may change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 might 3 tag-question 0)
    2 ((My health right now may change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 maybe 0)
    2 ((My health right now may change my prognosis \.) (Prognosis-Understanding)) (0 :gist)      

  ; Most people do/do not outlive their prognosis.
  1 (0 person-pl 0)
    2 (0 most 1 person-pl 0)
      3 (0 NEG 0)
        4 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 much 1 person-pl 0)
      3 (0 NEG 0)
        4 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 few 1 person-pl 0)
      3 (0 NEG 0)
        4 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)

  ; Yes / No
  1 (0 POS 0)
    2 (- 0 NEG 1 sure 0)
      3 (- 0 POS 8 but 0)
        4 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My health right now may improve my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 posadv-affirm 0)
    2 (- 0 posadv-affirm 1 NEG 0)
      3 (- 0 NEG 1 posadv-affirm 0)
        4 (- 0 posadv-affirm 8 but 0)
          5 ((My health right now improves my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My health right now may improve my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEG 0)
    2 (- 0 NEG 8 but 0)
      3 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My health right now may improve my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEGADV 0)
    2 ((My health right now does not change my prognosis \.) (Prognosis-Understanding)) (0 :gist)
  
  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for health now related bargaining of prognosis \.)) (0 :gist)
)) ; END *prognosis-bargaining-now-input*


(READRULES '*prognosis-bargaining-graduation-input*
; (Can I outlive my prognosis until the graduation of my grandson ?) 
'(
  
  ; You do/do not have a lot of time left
  ; You should focus on spending time on your family
  ; --> (My prognosis is that I might live to attend the graduation of my grandson \.)
  1 (0 time 0)
    2 (0 much 1 time 0)
      3 (- 0 NEG 1 much 1 time 0)
        4 (- 0 much 1 time 1 left 0)
          5 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My prognosis is that I will not live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 long 1 time 0)
      3 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 time 4 now 0)
      3 ((I should spend the time predicted by my prognosis with my family \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 now 1 time 0)
      3 ((I should spend the time predicted by my prognosis with my family \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 time 3 child 0)
      3 ((I should spend the time predicted by my prognosis with my family \.) (Prognosis-Understanding)) (0 :gist)
   
  ; More complex ways of saying yes/no
  1 (0 tag-question 0)
    2 (0 NEG tag-question 0)
      3 (0 NEG 1 tag-question 4 but 0)
        4 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My prognosis is that I will not live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 tag-question 2 but 0)
      3 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My prognosis is that I will live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 incorrect 0)
    2 (- 0 NEG incorrect 0)
      3 ((My prognosis is that I will not live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My prognosis is that I will live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 unusual 0)
    2 (- 0 NEG unusual 0)
      3 ((My prognosis is that I will not live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 unusual 4 but 0)
      3 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My prognosis is that I will live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 seldom 0)
    2 (- 0 NEG seldom 0)
      3 (- 0 seldom NEG 0)
        4 ((My prognosis is that I will not live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 seldom 8 but 0)
      3 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My prognosis is that I will live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 usual 0)
    2 (- 0 NEG usual 0)
      3 ((My prognosis is that I will live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 usual 8 but 0)
      3 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My prognosis is that I will not live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 odds 0)
    2 (0 good 1 odds 0)
      3 (- 0 NEG 1 good 1 odds 0)
        4 (- 0 NEG 1 good 1 odds 4 but 0)
          5 ((My prognosis is that I will live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
        4 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My prognosis is that I will not live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 have 3 odds 0)
      3 (- 0 NEG 4 odds 0)
        4 (- 0 NEG 4 odds 4 but 0)
          5 ((My prognosis is that I will live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
        4 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My prognosis is that I will not live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 be 3 odds 0)
      3 (- 0 NEG 4 odds 0)
        4 (- 0 NEG 4 odds 4 but 0)
          5 ((My prognosis is that I will live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
        4 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My prognosis is that I will not live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 worth 2 shot 0)
    2 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  
  ; I may outlive your prognosis.
  1 (0 hard 2 to 2 predict 0)
    2 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 bad 1 at 3 guess 0)
    2 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEG good 1 at 3 guess 0)
    2 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 difficult 3 answer 0)
    2 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 might 0)
    2 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 maybe 0)
    2 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)      
  1 (0 try 0)
    2 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
   

  ; Most people do/do not outlive their prognosis.
  1 (0 person-pl 0)
    2 (0 most 1 person-pl 0)
      3 (0 NEG 0)
        4 ((My prognosis is that I will not live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My prognosis is that I will live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 much 1 person-pl 0)
      3 (0 NEG 0)
        4 ((My prognosis is that I will not live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My prognosis is that I will live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 (0 few 1 person-pl 0)
      3 (0 NEG 0)
        4 ((My prognosis is that I will live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
      3 ((My prognosis is that I will not live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)

  ; Yes / No
  1 (0 POS 0)
    2 (- 0 NEG 1 sure 0)
      3 (- 0 POS 8 but 0)
        4 ((My prognosis is that I will live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 posadv-affirm 0)
    2 (- 0 posadv-affirm 1 NEG 0)
      3 (- 0 NEG 1 posadv-affirm 0)
        4 (- 0 posadv-affirm 8 but 0)
          5 ((My prognosis is that I will live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My prognosis is that I will not live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEG 0)
    2 (- 0 NEG 8 but 0)
      3 ((My prognosis is that I will not live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
    2 ((My prognosis is that I might live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  1 (0 NEGADV 0)
    2 ((My prognosis is that I will not live to attend the graduation of my grandson \.) (Prognosis-Understanding)) (0 :gist)
  
  
  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for bargaining of prognosis \.)) (0 :gist)

)) ; END *prognosis-bargaining-graduation-input*

(READRULES 'experimental-therapy-input*
; (Do you think experimental therapies will help ?)
'(

  ; Experimental treatments will/will not/might make my prognosis better .
  1 (0 NEG 0)
    2 (- 0 NEG 8 but 0)
      3 ((Experimental treatments will not make my prognosis better \.) (Experimental-Treatment)) (0 :gist)
    2 ((Experimental treatments might make my prognosis better  \.) (Experimental-Treatment)) (0 :gist)
  1 (0 NEGADV 0)
    2 ((Experimental treatments will not make my prognosis better  \.) (Experimental-Treatment)) (0 :gist)
  1 (0 POS 0)
    2 (- 0 NEG 1 sure 0)
      3 ((Experimental treatments will make my prognosis better \.) (Experimental-Treatment)) (0 :gist)
    2 (- 0 POS 1 but 0)
      3 ((Experimental treatments will make my prognosis better \.) (Experimental-Treatment)) (0 :gist)
    2 ((Experimental treatments might make my prognosis better  \.) (Experimental-Treatment)) (0 :gist)
  1 (0 posadv-affirm 0)
    2 (- 0 posadv-affirm NEG 0)
      3 (- 0 NEG posadv-affirm 0)
        4 ((Experimental treatments will make my prognosis better  \.) (Experimental-Treatment)) (0 :gist)
    2 (- 0 posadv-affirm 1 but 0)
      3 ((Experimental treatments will make my prognosis better \.) (Experimental-Treatment)) (0 :gist)
    2 ((Experimental treatments will not make my prognosis better  \.) (Experimental-Treatment)) (0 :gist)
  1 (0 might 0)
    2 ((Experimental treatments might make my prognosis better  \.) (Experimental-Treatment)) (0 :gist)
  1 (0 maybe 0) 
    2 ((Experimental treatments might make my prognosis better  \.) (Experimental-Treatment)) (0 :gist)
  1 (0 make-better 2 odds 0)
    2 ((Experimental treatments might make my prognosis better  \.) (Experimental-Treatment)) (0 :gist)
  1 (0 try 0)
    2 (- 0 NEG try 0)
      3 ((Experimental treatments might make my prognosis better  \.) (Experimental-Treatment)) (0 :gist)
    2 ((Experimental treatments might make my prognosis better  \.) (Experimental-Treatment)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for experimental treatments \.)) (0 :gist)

)) ; END *experimental-therapy-input*

(READRULES '*sleep-poorly-input*
; (Why 1 I not 1 sleeping well ?)
; (I have not been sleeping well \.)
'(
  ; What medicine are you taking?
  1 (8 wh_ 1 medicine-gen 0)
    2 (*medicine-question* (what medicine are you taking ?)) (0 :subtree+clause)
  1 (8 wh_ 2 med-take 0)
    2 (*medicine-question* (what medicine are you taking ?)) (0 :subtree+clause)

  ; When you take it does it take care of the pain?
  1 (0 AUX-BASE 3 med-help 3 pain 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 med-help 1 at acd Documll 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 med-help 1 little 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 1 it 3 do anything 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  
  1 (0 coffee 0)
    2 (*sleep-question* (is coffee keeping you awake ?)) (0 :subtree+clause)

  ; How is your anxiety or depression?
  1 (0 be 3 ment-health 3 recently 0)
    2 (*sleep-question* (is your mental health keeping you awake ?)) (0 :subtree+clause)
  1 (0 how 3 be 3 think-gen 0)
    2 (*sleep-question* (is your mental health keeping you awake ?)) (0 :subtree+clause)
  1 (0 how 3 ment-health 5)
    2 (*sleep-question* (is your mental health keeping you awake ?)) (0 :subtree+clause)
  1 (0 wh_ 3 be 3 think-gen 0)
    2 (*sleep-question* (is your mental health keeping you awake ?)) (0 :subtree+clause)
  1 (0 wh_ 5 think-gen 5 mind 0)
    2 (*sleep-question* (is your mental health keeping you awake ?)) (0 :subtree+clause)
  1 (0 AUX 2 you 6 ment-health 0)
    2 (*sleep-question* (is your mental health keeping you awake ?)) (0 :subtree+clause)
  1 (0 AUX 2 possible 2 you 6 ment-health 0)
    2 (*sleep-question* (is your mental health keeping you awake ?)) (0 :subtree+clause)

  ; You may be sleeping poorly because of anxiety/depression.
  1 (0 AUX 0 because 2 ment-health 0)
    2 ((I am sleeping poorly because of my mental health \.) (Sleeping-poorly)) (0 :gist)
  1 (0 ment-health 3 cause 0)
    2 ((I am sleeping poorly because of my mental health \.) (Sleeping-poorly)) (0 :gist)
  
  ; How/Where is your pain?
  1 (0 wh_ 5 pain 0)
    2 (- 0 pain-bad 2 pain 0)
      3 (*pain-question* (can you tell me about your pain ?)) (0 :subtree+clause)
    2 (*pain-question* (how bad is your pain ?)) (0 :subtree+clause)

  ; You may be sleeping poorly because of pain.
  1 (0 medicine-gen 1 neg 1 work 0)
    2 ((I am sleeping poorly because the pain medication is no longer working \.) (Sleeping-poorly)) (0 :gist)
  1 (0 AUX 0 because 2 pain 0)
    2 ((I am sleeping poorly because of my pain \.) (Sleeping-poorly)) (0 :gist)
  1 (0 AUX 1 pain 0)
    2 ((I am sleeping poorly because of my pain \.) (Sleeping-poorly)) (0 :gist)
  1 (0 pain 3 cause 0)
    2 ((I am sleeping poorly because of my pain \.) (Sleeping-poorly)) (0 :gist)

  ; You may be sleeping poorly because of a side effect.
  1 (6 side 1 effect 0)
    2 ((I am sleeping poorly because of a side effect from a medication \.) (Sleeping-poorly)) (0 :gist)

  ; You may be sleeping poorly because your cancer has gotten worse.
  1 (0 cancer-illness 2 spread 0)
    2 ((I am sleeping poorly because the cancer has spread \.) (Test-results)) (0 :gist)
  1 (0 cancer-illness 2 worse 0)
    2 ((My cancer has gotten worse \.) (Test-results)) (0 :gist)

  ; A stronger pain medication might help.
  1 (0 med-better 3 med-help 0)
    2 ((A stronger pain medication will help me sleep \.) (Medicine-request)) (0 :gist)
  1 (0 something 3 med-better 0)
    2 ((A stronger pain medication will help me sleep \.) (Medicine-request)) (0 :gist)
  1 (0 medicine-gen 3 med-better 0)
    2 ((A stronger pain medication will help me sleep \.) (Medicine-request)) (0 :gist)

  ; You might need some better medication.
  1 (0 medicine-gen 0)
    2 *medicine-working-input* (0 :subtree)

  ; Do you sleep during the day?
  1 (0 sleep 2 during 3 day 0)
    2 (*sleep-question* (do you sleep during the day ?)) (0 :subtree+clause)

  ; How frequently are you waking?
  1 (0 how 1 frequently 0 wake)
    2 (*sleep-question* (how often are you waking up at night ?)) (0 :subtree+clause)

  ; What's going through your head/what are you thinking
  1 (0 wh_ 3 sleep-thought 0)
    2 (*sleep-question* (what is on your mind when you try to sleep ?)) (0 :subtree+clause)

  ; Can you tell me more
  1 (0 aux 1 you 1 tell 5 more 0)
    2 (- 0 about 2 pain 0)
      3 (*sleep-question* (what happens when you try to sleep ?)) (0 :subtree+clause)
    2 (*pain-question* (can you tell me about your pain ?)) (0 :subtree+clause)
  1 (0 aux 1 you be able 1 tell 5 more 0)
    2 (- 0 about 2 pain 0)
      3 (*sleep-question* (what happens when you try to sleep ?)) (0 :subtree+clause)
    2 (*pain-question* (can you tell me about your pain ?)) (0 :subtree+clause)
  1 (0 aux 1 you 1 elaborate 0)
    2 (- 0 about 2 pain 0)
      3 (*sleep-question* (what happens when you try to sleep ?)) (0 :subtree+clause)
    2 (*pain-question* (can you tell me about your pain ?)) (0 :subtree+clause)

  1 (0 sorry 0)
    2 ((You are sorry that I am sleeping poorly \.) (Sleeping-poorly)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((Nil Gist \: nothing found for why I am sleeping poorly \.)) (0 :gist)

)) ; END *sleep-poorly-input*



(READRULES '*tell-family-input*
; (What should I tell my family ?)
'(
  
  ; How much do you want your family to know about your cancer?
  1 (0 want-gen 3 family-pron 2 know-gen 0)
    2 (*tell-family-question* (how much do you want your family to know about the prognosis ?)) (0 :subtree+clause)
  1 (0 want-gen 3 tell 2 family-pron 0)
    2 (*tell-family-question* (how much do you want your family to know about the prognosis ?)) (0 :subtree+clause)

  ; Do you want me to be present when you tell your family about the cancer?
  1 (0 want-gen 4 available 0)
    2 (*tell-family-question* (do you want me to be present when you tell your family about the prognosis ?)) (0 :subtree+clause)
  1 (0 want-gen 4 with 0)
    2 (*tell-family-question* (do you want me to be present when you tell your family about the prognosis ?)) (0 :subtree+clause)
  1 (0 want-gen 6 appointment 0)
    2 (*tell-family-question* (do you want me to be present when you tell your family about the prognosis ?)) (0 :subtree+clause)
  1 (0 make 4 appointment 0)
    2 (*tell-family-question* (do you want me to be present when you tell your family about the prognosis ?)) (0 :subtree+clause)

  ; How much does your family know about your cancer?
  1 (0 AUX-BASE 3 family-pron 2 know-gen 0)
    2 (*tell-family-question* (do your family know about your cancer ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 family-pron 3 tell 0)
    2 (*tell-family-question* (do your family know about your cancer ?)) (0 :subtree+clause)
  1 (0 wh_ 3 AUX-BASE 3 family-pron 2 know-gen 0)
    2 (*tell-family-question* (do your family know about your cancer ?)) (0 :subtree+clause)
  1 (0 wh_ 3 AUX-BASE 3 family-pron 3 tell 0)
    2 (*tell-family-question* (do your family know about your cancer ?)) (0 :subtree+clause)

  ; I should tell my family the full truth about my cancer.
  1 (0 AUX 1 honest 0)
    2 ((I should tell my family the full truth about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 being 1 honest 0)
    2 ((I should tell my family the full truth about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 tell 1 family-pron 2 fact 0)
    2 ((I should tell my family the full truth about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 give 1 family-pron 2 fact 0)
    2 ((I should tell my family the full truth about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 tell 1 family-pron 2 everything 0)
    2 ((I should tell my family the full truth about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 give 1 family-pron 2 everything 0)
    2 ((I should tell my family the full truth about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 family-pron 2 got 2 know-gen 0)
    2 ((I should tell my family the full truth about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 family-pron 2 should 2 know-gen 0)
    2 ((I should tell my family the full truth about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 family-pron 2 want-gen 2 know-gen 0)
    2 ((I should tell my family the full truth about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 brace 1 family-pron 4 worst 0)
    2 ((I should tell my family the full truth about my cancer \.) (Tell-family)) (0 :gist)

  ; I should reassure my family about my prognosis.
  1 (0 reassure 4 family-pron 0)
    2 ((I should reassure my family about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 let 1 family-pron 1 know-gen 4 love 0)
    2 ((I should reassure my family about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 tell 1 family-pron 4 love 0)
    2 ((I should reassure my family about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 tell 4 love 2 family-pron 0)
    2 ((I should reassure my family about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 AUX 1 gentle 0)
    2 ((I should reassure my family about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 put 4 in 1 their 1 position 0)
    2 ((I should reassure my family about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 thought 3 from 3 their 3 perspective 0)
    2 ((I should reassure my family about my cancer \.) (Tell-family)) (0 :gist)
  1 (0 soften 1 blow 0)
    2 (- 0 NEG 2 soften 1 blow 0)
      3 ((I should reassure my family about the cancer \.) (Tell-family)) (0 :gist)
    2 ((I tell my family the full truth about my cancer \.) (Tell-family)) (0 :gist)

  ; Who in my family do I want to tell about the prognosis?
  1 (0 who 3 be 3 tell 0)
    2 (*tell-family-question* (Who in my family do I want to tell about the prognosis ?)) (0 :subtree+clause)
  1 (0 who 2 AUX-BASE 4 want-gen 2 tell 0)
    2 (*tell-family-question* (Who in my family do I want to tell about the prognosis ?)) (0 :subtree+clause)
  1 (0 who 6 want-gen 3 tell 0)
    2 (*tell-family-question* (Who in my family do I want to tell about the prognosis ?)) (0 :subtree+clause)


  1 (0 doctor-pron 4 be 4 available 0)
    2 ((You will be available to help me and my family during my cancer treatment \.) (Treatment-option)) (0 :gist)
  1 (0 you 4 NEG 2 be 2 alone 0)
    2 ((You will be available to help me and my family during my cancer treatment \.) (Treatment-option)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for tell family \.)) (0 :gist)

)) ; END *tell-family-input*



(READRULES '*test-results-input*
; (What do my test results mean ?)
'(

  ; You don't have much long left to live
  1 (0 you 1 NEG 2 have 3 long 2 cancer-live 0)
    2 ((The prognosis is that I do not have long left to live \.) (Prognosis)) (0 :gist)

  ; The cancer hasn't yet spread
  1 (0 NEG 2 cancer-increase 0)
    2 ((The test results show that the cancer hasn\'t spread \.) (Test-results)) (0 :gist)
  
  ; I don't know
  1 (0 NEG 1 sure 0)
    2 ((You are not sure what my test results mean \.)) (0 :gist)
  1 (0 NEG 1 know 0)
    2 ((You are not sure what my test results mean \.)) (0 :gist)
  
  ; The test results do not appear conclusive .
  1 (0 difficult 2 to 2 predict 0)
    2 ((The test results do not appear conclusive \.)) (0 :gist)
  1 (0 maybe 0)
    2 ((The test results do not appear conclusive \.)) (0 :gist)

  ; There is no cure
  1 (0 NEG 2 cure 0)
    2 ((The test results show that I cannot be cured \.) (Test-results)) (0 :gist)
  1 (0 cannot 2 cure 0)
    2 ((The test results show that I cannot be cured \.) (Test-results)) (0 :gist)
  1 (0 NEG 2 go away 0)
    2 ((The test results show that I cannot be cured \.) (Test-results)) (0 :gist)
  1 (0 fight 2 rest 4 life 0)
    2 ((The test results show that I cannot be cured \.) (Test-results)) (0 :gist)
  1 (0 lose 1 battle 0)
    2 ((The test results show that I cannot be cured \.) (Test-results)) (0 :gist)

  ; The cancer has spread
  1 (0 cancer-increase 0)
    2 ((The test results show that my cancer has spread \.) (Test-results)) (0 :gist)
  1 (0 cancer-illness 5 in 3 body-part)
    2 ((The test results show that my cancer has spread \.) (Test-results)) (0 :gist)
  1 (0 tumor 2 in 6 chest 0)
    2 ((The test results show that my cancer has spread \.) (Test-results)) (0 :gist)
  1 (0 cancer-illness 5 worse 0) 
    2 ((The test results show that my cancer has spread \.) (Test-results)) (0 :gist)
  1 (0 cancer-illness 4 become 2 worse 0)
    2 ((The test results show that my cancer has spread \.) (Test-results)) (0 :gist)
  1 (0 move 4 into 1 body-part 0)
    2 ((The test results show that my cancer has spread \.) (Test-results)) (0 :gist)
  
  ; The radiation doesn't seem to be helping
  1 (0 radiation 2 NEG 3 radiation-help 0)
    2 ((The test results show that the radiation is not working \.) (Test-results)) (0 :gist)
  1 (0 radiation 2 NEG 4 stop 2 cancer-illness 2 cancer-increase 0)
    2 ((The test results show that the radiation is not working \.) (Test-results)) (0 :gist)

  ; You have stage 4 cancer
  1 (0 stage four 0)
    2 ((The test results show that my cancer has spread \.) (Test-results)) (0 :gist)
  1 (0 advanced 1 body-part 1 cancer 0)
    2 ((The test results show that my cancer has spread \.) (Test-results)) (0 :gist)

  ; I don't know which test results you mean
  1 (0 NEG 1 know 2 wh_ 1 test 0)
    2 ((What test results am I referring to ?) (Test-results)) (0 :gist)
  1 (0 be 1 you 2 ask-gen 2 about 2 diagnosis-tests 0)
    2 ((What test results am I referring to ?) (Test-results)) (0 :gist)

  ; Doctor still wants to talk about pain or sleep
  1 (0 pain 0)
    2 ((Can I tell you about my pain instead of test results ?) (Pain-description)) (0 :gist)
  1 (0 sleep 0)
    2 ((Can I tell you about my sleep instead of test results ?) (Sleep)) (0 :gist)

  ; How do you feel about your test results?
  1 (0 you 2 think-gen 0)
    2 (*test-results-question* (how do you feel about your test results ?)) (0 :subtree+clause)

  ; asking if system has any questions
  1 (0 you 2 have 2 question-word 0)
    2 (*test-results-question* (Do you have a question about your test results ?)) (0 :subtree+clause)
  1 (0 question-word 2 you 2 have 0)
    2 (*test-results-question* (Do you have a question about your test results ?)) (0 :subtree+clause)
  1 (0 anything 1 you 2 want-gen 2 ask-gen 0)
    2 (*test-results-question* (Do you have a question about your test results ?)) (0 :subtree+clause)

  ; How much do you want to know about your test results?
  1 (0 how much 3 information 3 AUX 1 you 0)
    2 (*test-results-question* (How much information do you want about your test results ?)) (0 :subtree+clause)
  1 (0 how much 3 information 3 I 3 you 0)
    2 (*test-results-question* (How much information do you want about your test results ?)) (0 :subtree+clause)
  1 (0 how much 3 AUX 3 I 3 want-gen 3 know 0)
    2 (*test-results-question* (How much information do you want about your test results ?)) (0 :subtree+clause)
  1 (0 how much 3 I 3 tell 3 you 0)
    2 (*test-results-question* (How much information do you want about your test results ?)) (0 :subtree+clause)

  ; If the doctor gets ahead of themself and starts mentioning treatment options.
  1 (0 treatment-options 0)
    2 ((Am I ready to start discussing treatment options ?) (Treatment-options)) (0 :gist)
  1 (0 comfort-care-word 0)
    2 ((Am I ready to start discussing treatment options ?) (Treatment-options)) (0 :gist)
  1 (0 chemotherapy 0)
    2 ((Am I ready to start discussing treatment options ?) (Treatment-options)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for test results \.)) (0 :gist)
    
)) ; END *test-results-input*



(READRULES '*treatment-option-input*
; (What are my options for treatment ?)
; (What are my treatment options if I do not do chemotherapy ?)
'(
  ; How much do you know about comfort care?
  ; Comfort care is an option
  1 (0 comfort-care-word 0)
    2 (0 AUX-BASE 2 know-gen 3 comfort-care-word 0)
      3 (*comfort-care-question* (do you understand how comfort care works ?)) (0 :subtree+clause)
    2 (0 be 2 know 3 comfort-care-word 0)
      3 (*comfort-care-question* (do you understand how comfort care works ?)) (0 :subtree+clause)
    2 (0 AUX-BASE 2 heard 3 comfort-care-word 0)
      3 (*comfort-care-question* (do you understand how comfort care works ?)) (0 :subtree+clause)
    2 (0 wh_ 4 know-gen 3 comfort-care-word 0)
      3 (*comfort-care-question* (do you understand how comfort care works ?)) (0 :subtree+clause)
    2 (0 wh_ 3 heard 3 comfort-care-word 0)
      3 (*comfort-care-question* (do you understand how comfort care works ?)) (0 :subtree+clause)
    2 (0 AUX-BASE 3 mention 1 comfort-care-word 0)
      3 (*comfort-care-question* (do you understand how comfort care works ?)) (0 :subtree+clause)
    2 (0 AUX-BASE 3 tell 3 comfort-care-word 0)
      3 (*comfort-care-question* (do you understand how comfort care works ?)) (0 :subtree+clause) 
    2 ((Comfort care is a treatment option \.) (Comfort-care)) (0 :gist)

  ; Chemotherapy is an option
  1 (0 med-chemotherapy 0)
    2 ((Chemotherapy is a treatment option \.) (Chemotherapy)) (0 :gist)
  1 (0 chemotherapy 0)
    2 ((Chemotherapy is a treatment option \.) (Chemotherapy)) (0 :gist)

  ; Radiation/surgery is an option
  1 (0 radiation 0)
    2 ((Radiation is a treatment option \.) (Radiation)) (0 :gist)
  1 (0 surgery 0)
    2 ((Surgery is a treatment option \.) (Surgery)) (0 :gist)

  ; Maintaining a good quality of life is an option
  1 (0 quality 2 life 0)
    2 ((Maintaining good quality of life is a treatment option \.) (Comfort-care)) (0 :gist)

  ; Depends on what your goals are
  1 (0 wh_ 2 your 5 cancer-goals 0)
    2 (*treatment-goals-question* (what are your treatment goals ?)) (0 :subtree+clause)
  1 (0 wh_ 3 cancer-goals 2 you 2 have 0)
    2 (*treatment-goals-question* (what are your treatment goals ?)) (0 :subtree+clause)
  1 (0 wh_ 2 be 3 important 3 you 0)
    2 (*treatment-goals-question* (what are your treatment goals ?)) (0 :subtree+clause)
  1 (0 depend 7 your 2 cancer-goals 0)
    2 (*treatment-goals-question* (what are your treatment goals ?)) (0 :subtree+clause)
  1 (0 depend 7 cancer-goals 2 you 0)
    2 (*treatment-goals-question* (what are your treatment goals ?)) (0 :subtree+clause)

  ; We need to get another study
  1 (0 diagnosis-more 3 diagnosis-tests 0)
    2 ((You need more tests before talking about treatment options \.) (Treatment-options)) (0 :gist)

  ; Prognosis related questions
  1 (0 you 2 think-gen 6 prognosis 0)
    2 (*prognosis-question* (How do you feel about your prognosis ?)) (0 :subtree+clause)
  1 (0 you 2 feeling 6 prognosis 0)
    2 (*prognosis-question* (How do you feel about your prognosis ?)) (0 :subtree+clause)
  1 (0 question-word 4 prognosis 0)
    2 (*prognosis-question* (Do you have any questions about your prognosis ?)) (0 :subtree+clause)
  1 (0 ask-gen 4 prognosis 0)
    2 (*prognosis-question* (Do you have any questions about your prognosis ?)) (0 :subtree+clause)
  1 (0 wh_ 4 be 4 prognosis 0)
    2 (*prognosis-question* (What is your prognosis ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 4 tell 6 prognosis 0)
    2 (*prognosis-question* (What is your prognosis ?)) (0 :subtree+clause)
  1 (0 MODAL 4 know-gen 6 prognosis 0)
    2 (*prognosis-question* (What is your prognosis ?)) (0 :subtree+clause)
  1 (0 MODAL 4 more-info 6 prognosis 0)
    2 (*prognosis-question* (What is your prognosis ?)) (0 :subtree+clause)

  ; What do you know/think about your options?
  1 (0 how 4 you 3 feeling 0)
    2 (*treatment-option-question* (what do you think about the treatment options ?)) (0 :subtree+clause)
  1 (0 wh_ 4 you 3 think-gen 0)
    2 (*treatment-option-question* (what do you think about the treatment options ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 you 2 understand-gen 0)
    2 (*treatment-option-question* (do you understand your treatment options ?)) (0 :subtree+clause)

  ; asking if system has any questions
  1 (0 you 2 have 2 question-word 0)
    2 (*treatment-option-question* (Do you have a question about your treatment options ?)) (0 :subtree+clause)
  1 (0 question-word 2 you 2 have 0)
    2 (*treatment-option-question* (Do you have a question about your treatment options ?)) (0 :subtree+clause)
  1 (0 anything 1 you 2 want-gen 2 ask-gen 0)
    2 (*treatment-option-question* (Do you have a question about your treatment options ?)) (0 :subtree+clause)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for treatment option \.)) (0 :gist)
    
)) ; END *treatment-option-input*



(READRULES '*stronger-medicine-help-sleep-input*
; (Will stronger pain medication help me sleep ?)
'(
  ; What medicine are you taking?
  1 (8 wh_ 1 medicine-gen 0)
    2 (*medicine-question* (what medicine are you taking ?)) (0 :subtree+clause)
  1 (8 wh_ 2 med-take 0)
    2 (*medicine-question* (what medicine are you taking ?)) (0 :subtree+clause)

  ; When you take it does it take care of the pain?
  1 (0 AUX-BASE 3 med-help 3 pain 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 med-help 1 at all 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 3 med-help 1 little 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 AUX-BASE 1 it 3 do anything 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)

  ; Can you tell me more
  1 (0 aux 1 you 1 tell 5 more 0)
    2 (- 0 medicine-gen 0)
      3 (*sleep-question* (what happens when you try to sleep ?)) (0 :subtree+clause)
  1 (0 aux 1 you be able 1 tell 5 more 0)
    2 (- 0 medicine-gen 0)
      3 (*sleep-question* (what happens when you try to sleep ?)) (0 :subtree+clause)

  ; You should take something stronger / better pain medication
  1 (0 med-take 3 med-better 3 medicine-gen 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 med-take 1 something 1 med-better 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 want-gen 3 med-better 2 medicine-gen 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 want-gen 1 something 1 med-better 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 try 2 something 2 med-better 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 try 2 med-better 2 medicine-gen 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)

  ; Yes / No
  1 (5 POS 0)
    2 (- 0 NEG 1 sure 0)
      3 ((A stronger pain medication will help me sleep \.) (Medicine-request)) (0 :gist)
    2 (- 0 POS 8 but 0)
      3 ((A stronger pain medication will help me sleep \.) (Medicine-request)) (0 :gist)
    2 ((A stronger pain medication will not help me sleep \.) (Medicine-request)) (0 :gist)
  1 (0 posadv-affirm 0)
    2 (- 0 posadv-affirm NEG 0)
      3 (- 0 NEG posadv-affirm 0)
        4 ((A stronger pain medication will help me sleep \.) (Medicine-request)) (0 :gist)
    2 (- 0 posadv-affirm 8 but 0)
      3 ((A stronger pain medication will help me sleep \.) (Medicine-request)) (0 :gist)
    2 ((A stronger pain medication will not help me sleep \.) (Medicine-request)) (0 :gist)
  1 (0 NEG 0)
    2 (- 0 NEG 8 but 0)
      3 ((A stronger pain medication will not help me sleep \.) (Medicine-request)) (0 :gist)
    2 ((A stronger pain medication will help me sleep \.) (Medicine-request)) (0 :gist)
  1 (0 NEGADV 0)
    2 ((A stronger pain medication will not help me sleep \.) (Medicine-request)) (0 :gist)

  ; How do you feel on your medication?
  1 (0 AUX-BASE 3 you 4 think-gen 0)
    2 (*medicine-question* (How are you feeling on the medicine ?)) (0 :subtree+clause)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for will stronger pain medication help me sleep \.)) (0 :gist)

)) ; END *stronger-medicine-help-sleep-input*

(READRULES '*reason-for-cancer-input*
'(
  ; You wish that I do not have cancer \.
  1 (0 doctor-pron 4 wish 4 be 1 different 0)
    2 ((You wish that I do not have cancer \.) (Reason-for-cancer)) (0 :gist)
  1 (0 doctor-pron 4 wish 4 you 2 not 4 cancer-illness 0)
    2 ((You wish that I do not have cancer \.) (Reason-for-cancer)) (0 :gist)
  1 (0 doctor-pron 4 wish 4 be 2 no 4 cancer-illness 0)
    2 ((You wish that I do not have cancer \.) (Reason-for-cancer)) (0 :gist)
  1 (0 doctor-pron 4 wish 2 you 4 not 4 deal 2 with 0)
    2 ((You wish that I do not have cancer \.) (Reason-for-cancer)) (0 :gist)
  1 (0 doctor-pron 4 wish 2 you 4 not 4 face 0)
    2 ((You wish that I do not have cancer \.) (Reason-for-cancer)) (0 :gist)
  1 (0 doctor-pron 4 wish 2 you 4 not 2 sick 0)
    2 ((You wish that I do not have cancer \.) (Reason-for-cancer)) (0 :gist)

  ; My cancer is caused by my smoking \.
  1 (0 smoke 4 give 4 cancer-illness 0)
    2 ((My cancer is the result of my smoking \.) (Reason-for-cancer)) (0 :gist)
  1 (0 smoke 4 cause 4 cancer-illness 0)
    2 ((My cancer is the result of my smoking \.) (Reason-for-cancer)) (0 :gist)
  1 (0 smoke 4 reason 2 for 4 cancer-illness 0)
    2 ((My cancer is the result of my smoking \.) (Reason-for-cancer)) (0 :gist)
  1 (0 cancer-illness 4 result 2 of 4 cancer-illness 0)
    2 ((My cancer is the result of my smoking \.) (Reason-for-cancer)) (0 :gist)
  1 (0 cancer-illness 4 because 4 you 4 smoke 0)
    2 ((My cancer is the result of my smoking \.) (Reason-for-cancer)) (0 :gist)
  1 (0 cancer-illness 4 cause 2 by 4 smoke 0)
    2 ((My cancer is the result of my smoking \.) (Reason-for-cancer)) (0 :gist)
  1 (0 smoke 4 hurt-words 4 you 0)
    2 ((My cancer is the result of my smoking \.) (Reason-for-cancer)) (0 :gist)
  1 (0 smoke 4 hurt-words 4 lungs 0)
    2 ((My cancer is the result of my smoking \.) (Reason-for-cancer)) (0 :gist)

  ; You are sorry that I have cancer \.
  1 (0 sorry 0)
    2 ((You are sorry that I have cancer \.) (Reason-for-cancer)) (0 :gist)

  ; My cancer is caused by a mutation that spread through my cells \.
  1 (0 mutation 2 in 2 body 0)
    2 ((My cancer is caused by a mutation that spread through my cells \.) (Reason-for-cancer)) (0 :gist)
  1 (0 mutation 6 spread 0)
    2 ((My cancer is caused by a mutation that spread through my cells \.) (Reason-for-cancer)) (0 :gist)
  1 (0 tumor 4 cancer-increase 0)
    2 ((My cancer is caused by a mutation that spread through my cells \.) (Reason-for-cancer)) (0 :gist)

  ; The cause of my cancer is unclear.
  1 (0 be 4 complicated 0)
    2 ((The cause of my cancer is unclear \.) (Reason-for-cancer)) (0 :gist)
  1 (0 be 4 NEG 2 obvious 0)
    2 ((The cause of my cancer is unclear \.) (Reason-for-cancer)) (0 :gist)
  1 (0 be 4 difficult 3 understand-gen 0)
    2 ((The cause of my cancer is unclear \.) (Reason-for-cancer)) (0 :gist)
  1 (0 NEG 4 know-gen 0)
    2 ((The cause of my cancer is unclear \.) (Reason-for-cancer)) (0 :gist)
  1 (0 NEGADV 4 know-gen 0)
    2 ((The cause of my cancer is unclear \.) (Reason-for-cancer)) (0 :gist)

  ; Cancer can affect anyone.
  1 (0 can 2 happen 4 anyone 0)
    2 ((Cancer can affect anyone \.) (Reason-for-cancer)) (0 :gist)
  1 (0 can 2 happen 4 any 0)
    2 ((Cancer can affect anyone \.) (Reason-for-cancer)) (0 :gist)
  1 (0 much 2 people-pl 2 ask-gen 4 same thing 0)
    2 ((Cancer can affect anyone \.) (Reason-for-cancer)) (0 :gist)
  1 (0 you 2 NEG 4 alone 4 ask-gen 0)
    2 ((Cancer can affect anyone \.) (Reason-for-cancer)) (0 :gist) 
  1 (0 no 1 rhyme 1 or 1 reason 0)
    2 ((Cancer can affect anyone \.) (Reason-for-cancer)) (0 :gist)
  1 (0 NEG 4 similarity 2 between 2 people-pl 6 cancer-illness 0)
    2 ((Cancer can affect anyone \.) (Reason-for-cancer)) (0 :gist)
  1 (0 people-pl 6 cancer-illness 4 NEG 2 similar 0)
    2 ((Cancer can affect anyone \.) (Reason-for-cancer)) (0 :gist)
  
  ; Cancer can affect the human body suddenly.
  1 (0 can 2 sneak 1 up 0)  
    2 ((Cancer can affect the human body suddenly \.) (Reason-for-cancer)) (0 :gist)
  1 (0 happen 4 sudden 0)
    2 ((Cancer can affect the human body suddenly \.) (Reason-for-cancer)) (0 :gist)
  1 (0 happen 4 without 2 warning 0)
    2 ((Cancer can affect the human body suddenly \.) (Reason-for-cancer)) (0 :gist)
  1 (0 cancer-increase 4 sudden 0)
    2 ((Cancer can affect the human body suddenly \.) (Reason-for-cancer)) (0 :gist)

)) ; END *reason-for-cancer-input*