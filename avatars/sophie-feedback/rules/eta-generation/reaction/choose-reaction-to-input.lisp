(READRULES '*reaction-to-input*
'(
  ;; 1 (An input was found 0)
  ;;   2 (You gave an input \.) (0 :out)

  1 (Suggestion \: 0)
    2 (You could have asked \: 3) (0 :out)

  1 (The doctor asked an open ended question \.)
    2 (Excellent\! You asked an open ended question \!) (0 :out)

))