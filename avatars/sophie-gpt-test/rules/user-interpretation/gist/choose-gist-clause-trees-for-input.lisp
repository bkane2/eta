; NOTE: these rules were copied from the original SOPHIE system; they may need to be adjusted for the new modules.
;
; This is the top-level gist-clause interpretation rule tree, used to select an appropriate choice packet using
; the context of SOPHIE's previous question or statement. If a match fails here, the system falls back to a
; general subtree intended to match generic questions from the user.
;
(READRULES '*gist-clause-trees-for-input*
'(
  ; From current schemas
  ;;; Pain
  1 (:or
    (.BE 1 .REASON 3 .PAIN 3 .MAKE-WORSE 1 ?)
    (why 3 .PAIN 2 .MAKE-WORSE 1 ?)
    (what 2 .CAUSE 2 .PAIN 2 .MAKE-WORSE 1 ?))
    2 (*pain-input*
       *general-input*) (0 :subtrees)
  ;;; Prognosis
  1 (:or
    (what 2 the prognosis 3 ?)
    (what 2 my prognosis ?)
    (what 3 mean for 1 future ?))
    2 (*prognosis-input*
       *general-input*) (0 :subtrees)
  ;;; Options
  1 (what 2 my options for .TREATMENT ?)
    2 (*treatment-option-input*
       *general-input*) (0 :subtrees)

  ; It's assumed that Sophie only answers these questions in the very beginning
  1 (:or
    (3 .NICE to .MEET you 3 \.)
    (you .CAN .CALL me sophie \.)
    (I .CAN .HEAR you \.))
    2 (*pain-input*
       *general-input*) (0 :subtrees)

  ; From previous version
  1 (why 1 I not 1 sleeping well ?)
    2 (*sleep-poorly-input*
       *general-input*) (0 :subtrees)
  1 (how will I .KNOW if my .PAIN medication is working ?)
    2 (*medicine-working-input*
       *general-input*) (0 :subtrees)
  1 (.CAN I .HAVE a stronger .PAIN medication ?)
    2 (*medicine-stronger-request-input*
       *general-input*) (0 :subtrees)
  1 (what .DO my test results mean ?)
    2 (*test-results-input*
       *general-input*) (0 :subtrees)
  1 (why .DO I .HAVE cancer ?)
    2 (*reason-for-cancer-input*
       *general-input*) (0 :subtrees)
  1 (what .SHOULD I .TELL my .FAMILY ?)
    2 (*tell-family-input*
       *general-input*) (0 :subtrees)
  1 (.DO I need .CHEMOTHERAPY ?)
    2 (*chemotherapy-input*
       *general-input*) (0 :subtrees)
  1 (.SHOULD I get comfort .CARE ?)
    2 (*comfort-care-input*
       *general-input*) (0 :subtrees)
  1 (why has my .PAIN been getting worse .RECENTLY ?)
    2 (*pain-input*
       *general-input*) (0 :subtrees)
  1 (my .PAIN has .RECENTLY been getting worse \.)
    2 (*pain-input*
       *general-input*) (0 :subtrees)
  1 (I .BELIEVE my cancer has gotten worse .BECAUSE my .PAIN has also gotten worse \.)
    2 (*pain-input*
       *general-input*) (0 :subtrees)
  1 (I am here .ALONE \.)
    2 (*appointment-input*
       *general-input*) (0 :subtrees)
  1 (I got my diagnosis after visiting a .LUNG doctor \.)
    2 (*diagnosis-details-input*
       *general-input*) (0 :subtrees)
  1 (I .HAVE lost 1 weight \.)
    2 (*diagnosis-details-input*
       *general-input*) (0 :subtrees)
  1 (I had radiation .TREATMENT for .FIVE weeks \.)
    2 (*radiation-input*
       *general-input*) (0 :subtrees)
  1 (I was .FEELING a little better after radiation \.)
    2 (*radiation-input*
       *general-input*) (0 :subtrees)
  1 (.DO you think radiation will .HELP ?)
    2 (*radiation-input-verification-input*
       *general-input*) (0 :subtrees)
  1 (.DO you think .CHEMOTHERAPY will .HELP ?)
    2 (*chemotherapy-input*
       *general-input*) (0 :subtrees)
  1 (what are the side effects of .CHEMOTHERAPY ?)
    2 (*chemotherapy-details-input*
       *general-input*) (0 :subtrees)
  1 (how does .CHEMOTHERAPY .WORK ?)
    2 (*chemotherapy-details-input*
       *general-input*) (0 :subtrees)
  1 (.DO you think .EXPERIMENTAL therapies will .HELP ?)
    2 (*experimental-therapy-input*
       *general-input*) (0 :subtrees)
  1 (I .HAVE not been sleeping well \.)
    2 (*sleep-poorly-input*
       *general-input*) (0 :subtrees)
  1 (I .HAVE been fatigued \.)
    2 (*energy-input*
       *general-input*) (0 :subtrees)
  1 (I .HAVE had .TROUBLE concentrating \.)
    2 (*energy-input*
       *general-input*) (0 :subtrees)
  1 (I feel mildly depressed \.)
    2 (*energy-input*
       *general-input*) (0 :subtrees)
  1 (I feel anxious about my future \.)
    2 (*energy-input*
       *general-input*) (0 :subtrees)
  1 (you .CAN .HELP me by answering all of my questions \.)
    2 (*energy-input*
       *general-input*) (0 :subtrees)
  1 (will an .ANTIDEPRESSANT .HELP me with my .PAIN ?)
    2 (*energy-input*
       *general-input*) (0 :subtrees)
  1 (.SHOULD I .TRY medication .BEFORE I .TRY .THERAPY ?)
    2 (*energy-input*
       *general-input*) (0 :subtrees)
  1 (my future feels out of my control .BECAUSE I .DO not .KNOW how .MUCH time I .HAVE to live \.)
    2 (*energy-input*
       *general-input*) (0 :subtrees)
  1 (I don\'t .HAVE allergies to any .MEDICINE \.)
    2 (*medicine-input*
       *general-input*) (0 :subtrees)
  1 (I am only taking lortab to treat my .PAIN \.)
    2 (*medicine-input*
       *general-input*) (0 :subtrees)
  1 (I am taking cozar to .HELP with blood pressure \.)
    2 (*medicine-input*
       *general-input*) (0 :subtrees)
  1 (taking the lortab more .FREQUENTLY helps \.)
    2 (*medicine-input*
       *general-input*) (0 :subtrees)
  1 (I am taking lortab every .THREE hours \.)
    2 (*medicine-input*
       *general-input*) (0 :subtrees)
  1 (why isn\'t the .PAIN medication working anymore ?)
    2 (*medicine-working-input*
       *general-input*) (0 :subtrees)
  1 (what are the side effects of stronger .PAIN medication ?)
    2 (*medicine-side-effects-input*
       *general-input*) (0 :subtrees)
  1 (.CAN I get addicted to narcotics ?)
    2 (*medicine-side-effects-addiction-input*
       *general-input*) (0 :subtrees)
  1 (I .HAVE a .HISTORY of alcohol abuse but .DO not .DRINK .NOW \.)
    2 (*medical-history-input*
       *general-input*) (0 :subtrees)
  1 (I .HAVE a .HISTORY of alcohol abuse \.)
    2 (*medical-history-input*
       *general-input*) (0 :subtrees)
  1 (I .DO not .DRINK often .NOW \.)
    2 (*medical-history-input*
       *general-input*) (0 :subtrees)
  1 (I .HAVE a .HISTORY of smoking but .QUIT .SIX months ago \.)
    2 (*medical-history-input*
       *general-input*) (0 :subtrees)
  1 (I .HAVE a .HISTORY of smoking \.)
    2 (*medical-history-input*
       *general-input*) (0 :subtrees)
  1 (I .QUIT smoking .SIX months ago \.)
    2 (*medical-history-input*
       *general-input*) (0 :subtrees)
  1 (I .DO not .HAVE a .HISTORY of narcotic abuse \.)
    2 (*medicine-input*
       *general-input*) (0 :subtrees)
  1 (nobody .IN my .FAMILY has a .HISTORY of mental illness \.)
    2 (*medical-history-input*
       *general-input*) (0 :subtrees)
  1 (my .FAMILY does not .HAVE a .HISTORY of mental illness \.)
    2 (*medical-history-input*
       *general-input*) (0 :subtrees)
  1 (my .MOTHER died of complications from her diabetes \.)
    2 (*medicine-input*
       *general-input*) (0 :subtrees)
  1 (my .FATHER died of prostate cancer \.)
    2 (*medicine-input*
       *general-input*) (0 :subtrees)
  1 (I would .LIKE a refill of .MEDICINE \.)
    2 (*medicine-refill-request-input*
       *general-input*) (0 :subtrees)
  1 (has the cancer gotten worse ?)
    2 (*cancer-worse-input*
       *general-input*) (0 :subtrees)
  1 (are you sure the cancer has not gotten worse ?)
    2 (*cancer-worse-verification-input*
       *general-input*) (0 :subtrees)
  1 (what are my .TREATMENT options if I .DO not .DO .CHEMOTHERAPY ?)
    2 (*treatment-option-input*
       *general-input*) (0 :subtrees)
  1 (how does comfort .CARE .WORK ?)
    2 (*comfort-care-input*
       *general-input*) (0 :subtrees)
  1 (are you sure that I .DO not need comfort .CARE ?)
    2 (*comfort-care-verification-input*
       *general-input*) (0 :subtrees)
  1 (will stronger .PAIN medication .HELP me .SLEEP ?)
    2 (*stronger-medicine-help-sleep-input*
       *general-input*) (0 :subtrees)
  1 (I .KNOW that my cancer has gotten worse \, but i\'m not sure how .BAD it is \.)
    2 (*prognosis-input*
       *general-input*) (0 :subtrees)
  1 (.CAN I trust your prognosis ?)
    2 (*prognosis-denial-input*
       *general-input*) (0 :subtrees)
  1 (.CAN I outlive your prognosis if I .HAVE .HEALTHY habits ?)
    2 (*prognosis-bargaining-habits-input*
       *general-input*) (0 :subtrees)
  1 (.CAN I outlive your prognosis if I .QUIT smoking ?)
    2 (*prognosis-bargaining-quit-smoke-input*
       *general-input*) (0 :subtrees)
  1 (.CAN I outlive your prognosis if I am .HEALTHY .NOW ?)
    2 (*prognosis-bargaining-now-input*
       *general-input*) (0 :subtrees)
  1 (.CAN I outlive your prognosis until the graduation of my grandson ?)
  ; (.BE 1 .ANYTHING 5 .IMPROVE 1 prognosis 8 .GRAD-WORDS 1 ?)
    2 (*prognosis-bargaining-graduation-input*
       *general-input*) (0 :subtrees)
  1 (my goal is to survive .LONG enough to .BE there for my .FAMILY \.)
    2 (*prognosis-bargaining-graduation-input*
       *general-input*) (0 :subtrees)
  1 (.SHOULD I get a .SECOND opinion about my prognosis ?)
    2 (*prognosis-input*
       *general-input*) (0 :subtrees)
  1 (I .WANT to .TALK about my prognosis today \.)
    2 (*prognosis-input*
       *general-input*) (0 :subtrees)
  1 (.CAN you rephrase your .QUESTION ?)
    2 (*ask-for-questions-input*
       *general-input*) (0 :subtrees)
  1 (what are your questions ?)
    2 (*ask-for-questions-input*
       *general-input*) (0 :subtrees)
  1 (Goodbye \.)
    2 (*say-bye-input*
       *general-input*) (0 :subtrees)
  1 (0)
    2 (*general-input*) (0 :subtrees)
))