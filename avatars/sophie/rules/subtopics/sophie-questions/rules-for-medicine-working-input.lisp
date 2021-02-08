(MAPC 'ATTACHFEAT
  '(
    (med-take take taking get getting use using)
    (work working help helping treat treating effective)
    (often frequent frequently much)
    (med-time every time times hour hours minute minutes day days week weeks)
    (med-increase maximize maximizing increase increasing upping)
  ))


(READRULES '*medicine-working-input*
'(

  ; What medicine are you taking?
  1 (4 wh_ 1 medicine-gen 0)
    2 (*medicine-question* (what medicine are you taking ?)) (0 :subtree+clause)
  
  ; The Lortab?
  1 (4 medicine-gen 8)
    2 (*medicine-question* (are you taking 2 ?)) (0 :subtree+clause)

  ; When you take it does it take care of the pain?
  1 (0 be-aux 3 med-help 3 pain 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 be-aux 3 med-help 1 at all 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 be-aux 3 med-help 1 little 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)
  1 (0 be-aux 1 it 3 do anything 0)
    2 (*medicine-question* (does your pain medicine help with the pain ?)) (0 :subtree+clause)

  ; You should take morphine
  1 (0 med-narcotic 0)
    2 ((I should take a narcotic \.) (Medicine-request)) (0 :gist)

  ; Do you want something better / stronger pain medication
  1 (0 do 1 you 3 want 3 med-better medicine-taking 0)
    2 (*medicine-question* (do you want stronger pain medication ?)) (0 :subtree+clause)
  1 (0 do 1 want 3 med-better 0)
    2 (*medicine-question* (do you want stronger pain medication ?)) (0 :subtree+clause)

  ; You should take something stronger / better pain medication
  1 (0 you 5 med-take 3 med-better 3 medicine-gen 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 you 5 med-take 1 something 1 med-better 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 you 5 want 3 med-better 2 medicine-gen 0)
    2 ((I should take stronger pain medication \.) (Medicine-request)) (0 :gist)
  1 (0 you 5 want 1 something 1 med-better 0)
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

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for knowing if pain medication working \.)) (0 :gist)
))


(READRULES '*medicine-working-question*
'(
))


(READRULES '*medicine-working-reaction*
'(
  1 (I should take something different \.)
    2 *ask-about-pain-medication-side-effects* (0 :schema)
  1 (I should take med-narcotic \.)
    2 *ask-about-narcotic-addiction* (100 :schema)
    2 (I think having the stronger pain medication would help\.) (0 :out)
  1 (I should take stronger pain medication \.)
    2 *ask-about-pain-medication-side-effects* (100 :schema)
    2 (I think having the stronger pain medication would help\.) (0 :out)
  1 (0)
    2 (I think for now I will wait to see if the lortab starts helping more\.) (0 :out)
))