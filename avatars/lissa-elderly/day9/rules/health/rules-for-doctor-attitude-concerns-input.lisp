;;  Do you think your doctor takes your concerns seriously?  
;;	(0 I do not think my doctor takes my concerns seriously 0)
;;	(0 I think my doctor takes my concerns seriously 0)
;;	doctor-attitude-concerns
;;	(Do you think your doctor takes your concerns seriously ?) 
;;	(3 Do you think 2 doctor takes 3 concerns seriously 3)


;; MEETING WITH KIM NOTES (8/8/2017)

;; Yes
;; Response: "Can you give me an example?"

;; Yes, the person takes their concerns seriously
;; The doctor is very helpful

;; No, they don't listen
;; None of the suggestions the doctor gives are helpful
;; Response: "That sounds like a tough situation"
  
(MAPC 'ATTACHFEAT
'(
  (alt-suggestions suggestions suggestion recommendations recommendation advice)
))
  

(READRULES '*doctor-attitude-concerns-input*
'(
  ; Questions
  1 (0 what 2 you 0 ?)
      2 (Do I think my doctor takes my concerns seriously ?) (0 :gist)
  1 (0 how 2 you 0 ?)
      2 (Do I think my doctor takes my concerns seriously ?) (0 :gist)
  1 (0 do 1 you 1 have 2 doctor 0 ?)
      2 (Do I have a doctor ?) (0 :gist)

  ; Specific answers
  1 (0 POS 5 concerns 2 seriously 0)
    2 ((You think your doctor takes your concerns seriously \.) (Doctor-attitude-concerns)) (0 :gist)
  1 (0 is VERY 2 HELPFUL 0)
    2 ((You think your doctor takes your concerns seriously \.) (Doctor-attitude-concerns)) (0 :gist)
  1 (0 NEG 1 listen 0)
    2 ((You do not think your doctor takes your concerns seriously \.) (Doctor-attitude-concerns)) (0 :gist)
  1 (0 NEG 1 HELPFUL 0)
    2 ((You do not think your doctor takes your concerns seriously \.) (Doctor-attitude-concerns)) (0 :gist)
  1 (0 none 2 alt-suggestions 5 HELPFUL 0)
    2 ((You do not think your doctor takes your concerns seriously \.) (Doctor-attitude-concerns)) (0 :gist)

  1 (0)
    2 ((NIL gist \: Nothing found for if you think your doctor takes your concerns seriously \.) (Doctor-attitude-concerns)) (0 :gist)
))


(READRULES '*reaction-to-doctor-attitude-concerns-input*
'(
  1 (0 you think your doctor takes your concerns seriously 0)
    2 (It sounds nice that your doctor is helpful\, it\'s so fortunate to have a place where you can be honest about your concerns\.) (100 :out)
  1 (0 you do not think your doctor takes your concerns seriously 0)
    2 (That sounds like a tough situation if you cannot trust your doctor\. Hopefully you can find someone who does take your concerns seriously\.) (100 :out)

  1 (0 NIL gist 0)
    2 (Finding a good doctor who listens to you and helps you is very important\.) (100 :out)
))
