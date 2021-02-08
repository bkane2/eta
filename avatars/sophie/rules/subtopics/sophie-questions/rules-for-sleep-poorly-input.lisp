(MAPC 'ATTACHFEAT
'(
  (sleep sleeping)
  (okay alright well good fine)
  (problem problems issue issues hard difficulty)
  (sleep-prob problem insomnia)
  (lot much)
  (often frequent frequently much)
  (wake waking)
  (day daytime)
  (sleep-medication ambien nyquil lunesta)
  (work working effective help helping)
  (cause causing causes caused triggering triggered triggers trigger provoke provokes provoking provoked)
  (spread spreading metastasized metastatic)
  (sleep-thought thought thoughts head mind brain)
  (ment-health anxiety anxiousness depression anxious depressed mental)
  (recently lately)
))


(READRULES '*sleep-poorly-input*
'(
  
  
  ; What medicine are you taking?
  1 (8 wh_ 1 medicine-gen 0)
    2 (*medicine-question* (what medicine are you taking ?)) (0 :subtree+clause)
  1 (8 wh_ 2 med-take 0)
    2 (*medicine-question* (what medicine are you taking ?)) (0 :subtree+clause)

  ; When you take it does it take care of the pain?
  1 (0 be-aux 3 med-help 3 pain 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 be-aux 3 med-help 1 at acd Documll 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 be-aux 3 med-help 1 little 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 be-aux 1 it 3 do anything 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  
  ; How is your anxiety or depression?
  1 (0 be-aux 3 ment-health 3 recently 0)
    2 (*energy-question* (how is your mental health ?)) (0 :subtree+clause)
  1 (0 how 5 think-gen 0)
    2 (*energy-question* (how is your mental health ?)) (0 :subtree+clause)
  1 (0 how 3 ment-health 5)
    2 (*energy-question* (how is your mental health ?)) (0 :subtree+clause)
  1 (0 wh_ 5 think-gen 0)
    2 (*energy-question* (how is your mental health ?)) (0 :subtree+clause)

  
  ; You may be sleeping poorly because of anxiety/depression.
  1 (0 be-aux 0 because 2 ment-health 0)
    2 ((I am sleeping poorly because of my mental health \.) (Sleeping-poorly)) (0 :gist)
  1 (0 ment-health 3 cause 0)
    2 ((I am sleeping poorly because of my mental health \.) (Sleeping-poorly)) (0 :gist)
  
  1 (0 medicine-gen 1 neg 1 work 0)
    2 ((I am sleeping poorly because the pain medication is no longer working \.) (Sleeping-poorly)) (0 :gist)

  1 (6 side 1 effect 0)
    2 ((I am sleeping poorly because of a side effect from a medication \.) (Sleeping-poorly)) (0 :gist)

  1 (0 illness 2 spread 0)
    2 ((I am sleeping poorly because the cancer has spread \.) (Test-results)) (0 :gist)
  1 (0 illness 2 worse 0)
    2 ((My cancer has gotten worse \.) (Test-results)) (0 :gist)

  1 (0 medicine-gen 0)
    2 *medicine-working-input* (0 :subtree)
  1 (0 something 1 med-better 0)
    2 *medicine-working-input* (0 :subtree)

  1 (0 sleep 2 during 3 day 0)
    2 (*sleep-question* (do you sleep during the day ?)) (0 :subtree+clause)
  1 (0 how 1 often 0 wake)
    2 (*sleep-question* (how often are you waking up at night ?)) (0 :subtree+clause)

  ; What's going through your head/what are you thinking
  1 (0 wh_ 3 sleep-thought 0)
    2 (*sleep-question* (what is on your mind when you try to sleep ?)) (0 :subtree+clause)


  
  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((Nil Gist \: nothing found for why I am sleeping poorly \.)) (0 :gist)
))


(READRULES '*sleep-poorly-question*
'(
))


(READRULES '*sleep-poorly-reaction*
'(
  1 (I am sleeping poorly because of a side effect from a medication \.)
    2 (I see\. If the medicine is going to make me tired no matter what\, I\'d rather at least have the pain controlled\.) (0 :out)
  1 (I am sleeping poorly because the cancer has spread \.)
    2 *ask-if-cancer-worse* (0 :schema)
  1 (I am sleeping poorly because of my mental health \.)
     2 *discuss-depression* (0 :schema)
    
  1 (0)
    2 (I see\.) (0 :out)
))
