; This is the top-level gist-clause interpretation rule tree, used to select an appropriate choice packet using
; the context of SOPHIE's previous question or statement. If a match fails here, the system falls back to a
; general subtree intended to match generic questions from the user.
(READRULES '*gist-clause-trees-for-input*
'(
  ; Direct gist clauses from schema
  ; Outdated Sleep/Pain Schemas
  1 (why 1 I not 1 sleeping well ?)
    2 (*sleep-poorly-input*) (0 :subtrees)
  1 (how will I .KNOW if my .PAIN medication is working ?)
    2 (*medicine-working-input*) (0 :subtrees)
  1 (.CAN I .HAVE a stronger .PAIN medication ?)
    2 (*medicine-stronger-request-input*) (0 :subtrees)
  ; Module 1: Test Results, Prognosis, Tell Family
  1 (what .DO my test results mean ?)
    2 (*test-results-input*) (0 :subtrees)
  1 (what is my prognosis ?)
    2 (*prognosis-input*) (0 :subtrees)
  1 (why .DO I .HAVE cancer ?)
    2 (*reason-for-cancer-input*) (0 :subtrees)
  1 (what .SHOULD I .TELL my .FAMILY ?)
    2 (*tell-family-input*) (0 :subtrees)
  ; Module 2: Treatment Options, Chemotherapy, Comfort Care
  1 (what are my options for .TREATMENT ?)
    2 (*treatment-option-input*) (0 :subtrees)
  1 (.DO I need .CHEMOTHERAPY ?)
    2 (*chemotherapy-input*) (0 :subtrees)
  1 (.SHOULD I get comfort .CARE ?)
    2 (*comfort-care-input*) (0 :subtrees)
  ; Gist clauses from potential sub-dialogues
  1 (my .PAIN has .RECENTLY been getting worse \.)
    2 (*pain-input*) (0 :subtrees)
  1 (I .BELIEVE my cancer has gotten worse .BECAUSE my .PAIN has also gotten worse \.)
    2 (*pain-input*) (0 :subtrees)
  1 (I am here .ALONE \.)
    2 (*appointment-input*) (0 :subtrees)
  1 (I got my diagnosis after visiting a .LUNG doctor \.)
    2 (*diagnosis-details-input*) (0 :subtrees)
  1 (I .HAVE lost 1 weight \.)
    2 (*diagnosis-details-input*) (0 :subtrees)
  1 (I had radiation .TREATMENT for .FIVE weeks \.)
    2 (*radiation-input*) (0 :subtrees)
  1 (I was .FEELING a little better after radiation \.)
    2 (*radiation-input*) (0 :subtrees)
  1 (.DO you think radiation will .HELP ?)
    2 (*radiation-input-verification-input*) (0 :subtrees)
  1 (.DO you think .CHEMOTHERAPY will .HELP ?)
    2 (*chemotherapy-input*) (0 :subtrees)
  1 (what are the side effects of .CHEMOTHERAPY ?)
    2 (*chemotherapy-details-input*) (0 :subtrees)
  1 (how does .CHEMOTHERAPY .WORK ?)
    2 (*chemotherapy-details-input*) (0 :subtrees)
  1 (.DO you think .EXPERIMENTAL therapies will .HELP ?)
    2 (*experimental-therapy-input*) (0 :subtrees)
  1 (I .HAVE not been sleeping well \.)
    2 (*sleep-poorly-input*) (0 :subtrees)
  1 (I .HAVE been fatigued \.)
    2 (*energy-input*) (0 :subtrees)
  1 (I .HAVE had .TROUBLE concentrating \.)
    2 (*energy-input*) (0 :subtrees)
  1 (I feel mildly depressed \.)
    2 (*energy-input*) (0 :subtrees)
  1 (I feel anxious about my future \.)
    2 (*energy-input*) (0 :subtrees)
  1 (you .CAN .HELP me by answering all of my questions \.)
    2 (*energy-input*) (0 :subtrees)
  1 (will an .ANTIDEPRESSANT .HELP me with my .PAIN ?)
    2 (*energy-input*) (0 :subtrees)
  1 (.SHOULD I .TRY medication .BEFORE I .TRY .THERAPY ?)
    2 (*energy-input*) (0 :subtrees)
  1 (my future feels out of my control .BECAUSE I .DO not .KNOW how .MUCH time I .HAVE to live \.)
    2 (*energy-input*) (0 :subtrees)
  1 (I don\'t .HAVE allergies to any .MEDICINE \.)
    2 (*medicine-input*) (0 :subtrees)
  1 (I am only taking lortab to treat my .PAIN \.)
    2 (*medicine-input*) (0 :subtrees)
  1 (I am taking cozar to .HELP with blood pressure \.)
    2 (*medicine-input*) (0 :subtrees)
  1 (taking the lortab more .FREQUENTLY helps \.)
    2 (*medicine-input*) (0 :subtrees)
  1 (I am taking lortab every .THREE hours \.)
    2 (*medicine-input*) (0 :subtrees)
  1 (why isn\'t the .PAIN medication working anymore ?)
    2 (*medicine-working-input*) (0 :subtrees)
  1 (what are the side effects of stronger .PAIN medication ?)
    2 (*medicine-side-effects-input*) (0 :subtrees)
  1 (.CAN I get addicted to narcotics ?)
    2 (*medicine-side-effects-addiction-input*) (0 :subtrees)
  1 (I .HAVE a .HISTORY of alcohol abuse but .DO not .DRINK .NOW \.)
    2 (*medical-history-input*) (0 :subtrees)
  1 (I .HAVE a .HISTORY of alcohol abuse \.)
    2 (*medical-history-input*) (0 :subtrees)
  1 (I .DO not .DRINK often .NOW \.)
    2 (*medical-history-input*) (0 :subtrees)
  1 (I .HAVE a .HISTORY of smoking but .QUIT .SIX months ago \.)
    2 (*medical-history-input*) (0 :subtrees)
  1 (I .HAVE a .HISTORY of smoking \.)
    2 (*medical-history-input*) (0 :subtrees)
  1 (I .QUIT smoking .SIX months ago \.)
    2 (*medical-history-input*) (0 :subtrees)
  1 (I .DO not .HAVE a .HISTORY of narcotic abuse \.)
    2 (*medicine-input*) (0 :subtrees)
  1 (nobody .IN my .FAMILY has a .HISTORY of mental illness \.)
    2 (*medical-history-input*) (0 :subtrees)
  1 (my .FAMILY does not .HAVE a .HISTORY of mental illness \.)
    2 (*medical-history-input*) (0 :subtrees)
  1 (my .MOTHER died of complications from her diabetes \.)
    2 (*medicine-input*) (0 :subtrees)
  1 (my .FATHER died of prostate cancer \.)
    2 (*medicine-input*) (0 :subtrees)
  1 (I would .LIKE a refill of .MEDICINE \.)
    2 (*medicine-refill-request-input*) (0 :subtrees)
  1 (has the cancer gotten worse ?)
    2 (*cancer-worse-input*) (0 :subtrees)
  1 (are you sure the cancer has not gotten worse ?)
    2 (*cancer-worse-verification-input*) (0 :subtrees)
  1 (what are my .TREATMENT options if I .DO not .DO .CHEMOTHERAPY ?)
    2 (*treatment-option-input*) (0 :subtrees)
  1 (how does comfort .CARE .WORK ?)
    2 (*comfort-care-input*) (0 :subtrees)
  1 (are you sure that I .DO not need comfort .CARE ?)
    2 (*comfort-care-verification-input*) (0 :subtrees)
  1 (will stronger .PAIN medication .HELP me .SLEEP ?)
    2 (*stronger-medicine-help-sleep-input*) (0 :subtrees)
  1 (I .KNOW that my cancer has gotten worse \, but i\'m not sure how .BAD it is \.)
    2 (*prognosis-input*) (0 :subtrees)
  1 (.CAN I trust your prognosis ?)
    2 (*prognosis-denial-input*) (0 :subtrees)
  1 (.CAN I outlive your prognosis if I .HAVE .HEALTHY habits ?)
    2 (*prognosis-bargaining-habits-input*) (0 :subtrees)
  1 (.CAN I outlive your prognosis if I .QUIT smoking ?)
    2 (*prognosis-bargaining-quit-smoke-input*) (0 :subtrees)
  1 (.CAN I outlive your prognosis if I am .HEALTHY .NOW ?)
    2 (*prognosis-bargaining-now-input*) (0 :subtrees)
  1 (.CAN I outlive your prognosis until the graduation of my grandson ?)
    2 (*prognosis-bargaining-graduation-input*) (0 :subtrees)
  1 (my goal is to survive .LONG enough to .BE there for my .FAMILY \.)
    2 (*prognosis-bargaining-graduation-input*) (0 :subtrees)
  1 (.SHOULD I get a .SECOND opinion about my prognosis ?)
    2 (*prognosis-input*) (0 :subtrees)
  1 (I .WANT to .TALK about my prognosis today \.)
    2 (*prognosis-input*) (0 :subtrees)
  1 (.CAN you rephrase your .QUESTION ?)
    2 (*ask-for-questions-input*) (0 :subtrees)
  1 (what are your questions ?)
    2 (*ask-for-questions-input*) (0 :subtrees)
  ; it's assumed that this question is only ever asked in the very beginning
  1 (you .CAN .CALL me sophie \.)
    2 (*test-results-input*) (0 :subtrees)
  1 (I .CAN .HEAR you \.)
    2 (*test-results-input*) (0 :subtrees)
  1 (0)
    2 (*general-input*) (0 :subtrees)
))