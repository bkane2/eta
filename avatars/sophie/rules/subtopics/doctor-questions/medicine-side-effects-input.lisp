(READRULES '*medicine-side-effects-addiction-input*
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
))


(READRULES '*medicine-side-effects-input*
'(
  1 (0 hair 0)
    2 ((A side effect of the medication is hair loss \.) (Medicine-side-effects)) (0 :gist)
  1 (0 side-effect-neuropathy 0)
    2 ((A side effect of the medication is neuropathy \.) (Medicine-side-effects)) (0 :gist)
  1 (0 side-effect-nausea 0)
    2 ((A side effect of the medication is nausea \.) (Medicine-side-effects)) (0 :gist)
  1 (0 diarrhea 0)
    2 ((A side effect of the medication is diarrhea \.) (Medicine-side-effects)) (0 :gist)
  1 (0 side-effect-fatigue 0)
    2 ((A side effect of the medication is fatigue \.) (Medicine-side-effects)) (0 :gist)
  1 (0 side-effect-appetite 0)
    2 ((A side effect of the medication is loss of appetite \.) (Medicine-side-effects)) (0 :gist)
  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for side effects of a medication \.)) (0 :gist)
))


(READRULES '*medicine-side-effects-question*
'(
))


(READRULES '*medicine-side-effects-reaction*
'(
  1 (Addiction is not a side effect of the medication \.)
    2 (I didn\'t know that\. It\'s good to know that stronger pain medication is an option without risking addiction \.) (0 :out)
  1 (A side effect of the medication be 2 side-effects-significant 2 \.)
    2 (I think I should hold off for now and think about it more \.) (0 :out)
  1 (A side effect of the medication be 2 side-effects-moderate 2 \.)
    2 (I think I should try the medicine and see if I have problems with 8 9 10 \.) (0 :out)
  1 (A side effect of the medication be 2 side-effects-insignificant 2 \.)
    2 (I already have 8 9 10 \, so I think the new medicine is worth a try\.) (0 :out)
  1 (0)
    2 (I see\. Well\, I think it\'s worth giving it a try\.) (0 :out)
))