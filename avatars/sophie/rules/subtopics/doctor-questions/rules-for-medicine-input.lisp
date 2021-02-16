(READRULES '*medicine-input*
'(

  ;; ; The following needs modification
  ;; 1 (0 sure \, I can arrange that 0)
  ;;   2 ((You will give me more medicine \.) (Stronger-medicine)) (0 :gist)

  ; Possibly too general, might need refining
  1 (0 med-narcotic 0)
    2 ((I should take a narcotic \.) (Medicine-request)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for medicine \.)) (0 :gist)
))


(READRULES '*medicine-question*
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

  ; Does taking the medicine more frequently help?
  1 (0 medicine-taking 3 frequently 5 med-help 0)
    2 ((Does taking medication more frequently help ?) (Medicine-frequency)) (0 :gist)
  1 (0 med-help 5 medicine-taking 3 frequently 0)
    2 ((Does taking medication more frequently help ?) (Medicine-frequency)) (0 :gist)
  1 (0 medicine-taking 5 med-help 5 frequently 0)
    2 ((Does taking medication more frequently help ?) (Medicine-frequency)) (0 :gist)

  ; Are you taking [some med]?
  1 (0 be 2 you 8 med-take 0 medicine-particular 0)
    2 ((Am I taking 8 ?) (Medicine)) (0 :gist)
  1 (0 what medicine 3 you 2 med-take 0)
    2 ((What medicine am I taking ?) (Medicine)) (0 :gist)

  ; Is the pain medication working?
  1 (0 be-aux 3 medicine-taking 3 med-help 3 pain 0)
    2 ((Is the pain medication working at all ?) (Medicine-working)) (0 :gist)
  1 (0 be-aux 0 medicine-taking 3 do anything 0)
    2 ((Is the pain medication working at all ?) (Medicine-working)) (0 :gist)
  1 (0 be-aux 0 medicine-taking 0 med-help 3 at all 0)
    2 ((Is the pain medication working at all ?) (Medicine-working)) (0 :gist)
  1 (0 be-aux 0 medicine-taking 0 med-help 0)
    2 ((Is the pain medication working ?) (Medicine-working)) (0 :gist)
  1 (0 how 0 medicine-taking 0 med-help 0)
    2 ((Is the pain medication working ?) (Medicine-working)) (0 :gist)

  ; Do you want stronger pain medication?
  1 (0 do 1 you 3 want-gen 3 med-better 1 medicine-taking 0)
    2 ((Do I want stronger pain medication ?) (Medicine-request)) (0 :gist)
  1 (0 do 1 you 3 want-gen 3 med-narcotic 0)
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

  1 (0 you 3 med-take 5 med-narcotic 0)
    2 ((I should take a narcotic \.) (Medicine-request)) (0 :gist)

  ; Do you have a history with narcotics?
  1 (0 be-aux 3 med-past 3 med-narcotic 0)
    2 ((What is my history with med-narcotic ?) (Medical-history)) (0 :gist)
  1 (0 be-aux 3 history 3 med-narcotic 0)
    2 ((What is my history with med-narcotic ?) (Medical-history)) (0 :gist)

  ))


(READRULES '*medicine-reaction*
'(
  ;; 1 (0 you will give me more medicine 0)
  ;;   2 (Great\, thank you !) (0 :out)
))
