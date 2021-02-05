(MAPC 'ATTACHFEAT
'(
))


(READRULES '*cancer-worse-input*
'(
  1 (0 POS 0)
    2 ((Your cancer has gotten worse \.) (cancer-worse)) (0 :gist)
  1 (0 I 1 think-gen so 0)
    2 ((Your cancer has gotten worse \.) (cancer-worse)) (0 :gist)
  1 (0 no 0)
    2 ((Your cancer has not gotten worse \.) (cancer-worse)) (0 :gist)
  1 (0 NEG 1 think-gen 0)
    2 ((Your cancer has not gotten worse \.) (cancer-worse)) (0 :gist)
  1 (0 illness 2 NEG 2 worse 0)
    2 ((Your cancer has not gotten worse \.) (cancer-worse)) (0 :gist)
  1 (0 illness 2 worse 0)
    2 ((Your cancer has gotten worse \.) (cancer-worse)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 (NIL Gist \: nothing found for has cancer gotten worse \.)
))


(READRULES '*cancer-worse-verification-input*
'(
  1 (0 NEG 1 know-gen 0)
    2 ((I am not sure whether your cancer has gotten worse \.) (cancer-worse)) (0 :gist)
  1 (0 no 0)
    2 ((I am not sure whether your cancer has gotten worse \.) (cancer-worse)) (0 :gist)
  1 (0 POS 0)
    2 ((Your cancer has not gotten worse \.) (cancer-worse)) (0 :gist)
  1 (0 I 1 think-gen so 0)
    2 ((Your cancer has not gotten worse \.) (cancer-worse)) (0 :gist)
  1 (0 NEG 1 think-gen 0)
    2 ((Your cancer has not gotten worse \.) (cancer-worse)) (0 :gist)
  1 (0 illness 2 NEG 2 worse 0)
    2 ((Your cancer has not gotten worse \.) (cancer-worse)) (0 :gist)
  1 (0 illness 2 worse 0)
    2 ((Your cancer has gotten worse \.) (cancer-worse)) (0 :gist)
))


(READRULES '*cancer-worse-question*
'(
))


(READRULES '*cancer-worse-reaction*
'(
  1 (Your cancer has gotten worse \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (Your cancer has not gotten worse \.)
    2 *verify-cancer-status* (100 :schema)
    2 (Okay\. Well\, that makes me feel a little bit better\.) (0 :out)
  1 (I am not sure whether your cancer has gotten worse \.)
    2 (That\'s not very reassuring\.) (0 :out)
  1 (0)
    2 (You see\.) (0 :out)
))