(READRULES '*test-results-input*
'(
  ; The cancer hasn't yet spread
  1 (0 NEG 2 cancer-increase 0)
    2 ((The test results show that the cancer hasn\'t spread \.) (Test-results)) (0 :gist)
  
  ; There is no cure
  1 (0 NEG 2 cure 0)
    2 ((The test results show that I cannot be cured \.) (Test-results)) (0 :gist)
  1 (0 NEG 2 go away 0)
    2 ((The test results show that I cannot be cured \.) (Test-results)) (0 :gist)
  1 (0 fight 2 rest 4 life 0)
    2 ((The test results show that I cannot be cured \.) (Test-results)) (0 :gist)
  1 (0 lose 1 battle 0)
    2 ((The test results show that I cannot be cured \.) (Test-results)) (0 :gist)

  ; The cancer has spread
  1 (0 spread 0)
    2 ((The test results show that my cancer has spread \.) (Test-results)) (0 :gist)
  1 (0 illness 5 in 3 body-part)
    2 ((The test results show that my cancer has spread \.) (Test-results)) (0 :gist)
  1 (0 tumor 2 in 6 chest 0)
    2 ((The test results show that my cancer has spread \.) (Test-results)) (0 :gist)

  ; You have stage 4 cancer
  1 (0 stage four 0)
    2 ((The test results show that my cancer has spread \.) (Test-results)) (0 :gist)
  1 (0 advanced 1 body-part 1 cancer 0)
    2 ((The test results show that my cancer has spread \.) (Test-results)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for test results \.)) (0 :gist)
))


(READRULES '*test-results-question*
'(
))


(READRULES '*test-results-reaction*
'(
  1 (The test results show that the cancer hasn\'t spread \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (The test results show that I cannot be cured \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (The test results show that my cancer has spread \.)
    2 *ask-about-prognosis* (0 :schema)
  1 (0)
    2 (Oh\, I see\.) (0 :out)
))