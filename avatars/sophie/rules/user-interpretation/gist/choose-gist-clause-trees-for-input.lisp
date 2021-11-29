; This is the top-level gist-clause interpretation rule tree, used to select an appropriate choice packet using
; the context of SOPHIE's previous question or statement. If a match fails here, the system falls back to a
; general subtree intended to match generic questions from the user.

(READRULES '*gist-clause-trees-for-input*
'(
   ; Direct gist clauses from schema
   
   ; Outdated Sleep/Pain Schemas
   1 (Why 1 I not 1 sleeping well ?)
      2 (*sleep-poorly-input*) (0 :subtrees)
   1 (How will I know if my pain medication is working ?)
      2 (*medicine-working-input*) (0 :subtrees)
   1 (Can I have a stronger pain medication ?)
      2 (*medicine-stronger-request-input*) (0 :subtrees)

   ; Module 1: Test Results, Prognosis, Tell Family
   1 (What do my test results mean ?)
      2 (*test-results-input*) (0 :subtrees)
   1 (What is my prognosis ?)
      2 (*prognosis-input*) (0 :subtrees)
   1 (Why do I have cancer ?)
      2 (*reason-for-cancer-input*) (0 :subtrees)
   1 (What should I tell my family ?)
      2 (*tell-family-input*) (0 :subtrees)

   ; Module 2: Treatment Options, Chemotherapy, Comfort Care
   1 (What are my options for treatment ?)
      2 (*treatment-option-input*) (0 :subtrees)
   1 (Do I need chemotherapy ?)
      2 (*chemotherapy-input*) (0 :subtrees)
   1 (Should I get comfort care ?)
      2 (*comfort-care-input*) (0 :subtrees)

   ; Gist clauses from potential sub-dialogues
   1 (My pain has recently been getting worse \.)
      2 (*pain-input*) (0 :subtrees)
   1 (I am here alone \.)
      2 (*appointment-input*) (0 :subtrees)
   1 (I got my diagnosis after visiting a lung doctor \.)
      2 (*diagnosis-details-input*) (0 :subtrees)
   1 (I have lost 1 weight \.)
      2 (*diagnosis-details-input*) (0 :subtrees)
   1 (I had radiation treatment for five weeks \.)
      2 (*radiation-input*) (0 :subtrees)
   1 (I was feeling a little better after radiation \.)
      2 (*radiation-input*) (0 :subtrees)
   1 (Do you think radiation will help ?)
      2 (*radiation-input-verification-input*) (0 :subtrees)
   1 (Do you think chemotherapy will help ?)
      2 (*chemotherapy-input*) (0 :subtrees)
   1 (What are the side effects of chemotherapy ?)
      2 (*chemotherapy-details-input*) (0 :subtrees)
   1 (How does chemotherapy work ?)
      2 (*chemotherapy-details-input*) (0 :subtrees)
   1 (Do you think experimental therapies will help ?)
      2 (*experimental-therapy-input*) (0 :subtrees)
   1 (I have not been sleeping well \.)
      2 (*sleep-poorly-input*) (0 :subtrees)
   1 (I have been fatigued \.)
      2 (*energy-input*) (0 :subtrees)
   1 (I have had trouble concentrating \.)
      2 (*energy-input*) (0 :subtrees)
   1 (I feel mildly depressed \.)
      2 (*energy-input*) (0 :subtrees)
   1 (I feel anxious about my future \.)
      2 (*energy-input*) (0 :subtrees)
   1 (Will an antidepressant help me with my pain ?)
      2 (*energy-input*) (0 :subtrees)
   1 (Should I try medication before I try therapy ?)
      2 (*energy-input*) (0 :subtrees)
   1 (I don\'t have allergies to any medicine \.)
      2 (*medicine-input*) (0 :subtrees)
   1 (I am only taking Lortab to treat my pain \.)
      2 (*medicine-input*) (0 :subtrees)
   1 (I am taking Cozar to help with blood pressure \.)
      2 (*medicine-input*) (0 :subtrees)
   1 (Taking the Lortab more frequently helps \.)
      2 (*medicine-input*) (0 :subtrees)
   1 (I am taking Lortab every three hours \.)
      2 (*medicine-input*) (0 :subtrees)
   1 (Why isn\'t the pain medication working anymore ?)
      2 (*medicine-working-input*) (0 :subtrees)
   1 (What are the side effects of stronger pain medication ?)
      2 (*medicine-side-effects-input*) (0 :subtrees)
   1 (Can I get addicted to narcotics ?)
      2 (*medicine-side-effects-addiction-input*) (0 :subtrees)
   1 (I have a history of alcohol abuse but do not drink now \.)
      2 (*medical-history-input*) (0 :subtrees)
   1 (I have a history of alcohol abuse \.)
      2 (*medical-history-input*) (0 :subtrees)
   1 (I do not drink often now \.) 
      2 (*medical-history-input*) (0 :subtrees)
   1 (I have a history of smoking but quit six months ago \.)
      2 (*medical-history-input*) (0 :subtrees)
   1 (I have a history of smoking \.)
      2 (*medical-history-input*) (0 :subtrees)
   1 (I quit smoking six months ago \.)
      2 (*medical-history-input*) (0 :subtrees)
   1 (I do not have a history of narcotic abuse \.)
      2 (*medicine-input*) (0 :subtrees)
   1 (Nobody in my family has a history of mental illness \.)
      2 (*medical-history-input*) (0 :subtrees)
   1 (My family does not have a history of mental illness \.)
      2 (*medical-history-input*) (0 :subtrees)
   1 (My mother died of complications from her diabetes \.)
      2 (*medicine-input*) (0 :subtrees)
   1 (My father died of prostate cancer \.)
      2 (*medicine-input*) (0 :subtrees)
   1 (I would like a refill of medicine \.)
      2 (*medicine-refill-request-input*) (0 :subtrees)
   1 (Has the cancer gotten worse ?)
      2 (*cancer-worse-input*) (0 :subtrees)
   1 (Are you sure the cancer has not gotten worse ?)
      2 (*cancer-worse-verification-input*) (0 :subtrees)
   1 (What are my treatment options if I do not do chemotherapy ?)
      2 (*treatment-option-input*) (0 :subtrees)
   1 (How does comfort care work ?)
      2 (*comfort-care-input*) (0 :subtrees)
   1 (Are you sure that I do not need comfort care ?)
      2 (*comfort-care-verification-input*) (0 :subtrees)
   1 (Will stronger pain medication help me sleep ?)
      2 (*stronger-medicine-help-sleep-input*) (0 :subtrees)
   1 (I know that my cancer has gotten worse\, but I\'m not sure how bad it is \.)
      2 (*prognosis-input*) (0 :subtrees)
   1 (Can I trust your prognosis ?)
      2 (*prognosis-denial-input*) (0 :subtrees)
   1 (Can I outlive your prognosis if I have healthy habits ?)
      2 (*prognosis-bargaining-habits-input*) (0 :subtrees)
   1 (Can I outlive your prognosis if I quit smoking ?)
      2 (*prognosis-bargaining-quit-smoke-input*) (0 :subtrees)
   1 (Can I outlive your prognosis if I am healthy now ?)
      2 (*prognosis-bargaining-now-input*) (0 :subtrees)
   1 (Can I outlive your prognosis until the graduation of my grandson ?)
      2 (*prognosis-bargaining-graduation-input*) (0 :subtrees)
   1 (My goal is to survive long enough to be there for my family \.)
      2 (*prognosis-bargaining-graduation-input*) (0 :subtrees)
   1 (Should I get a second opinion about my prognosis ?)
      2 (*prognosis-input*) (0 :subtrees)   
   1 (I want to talk about my prognosis today \.)
      2 (*prognosis-input*) (0 :subtrees)
   1 (What are your questions ?)
      2 (*ask-for-questions-input*) (0 :subtrees)
   ; it's assumed that this question is only ever asked in the very beginning
   1 (You can call me Sophie \.) 
      2 (*test-results-input*) (0 :subtrees)
   
   1 (0)
      2 (*general-input*) (0 :subtrees)
))
