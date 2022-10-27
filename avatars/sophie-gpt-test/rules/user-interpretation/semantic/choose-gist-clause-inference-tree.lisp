; Transduction tree for inferring additional facts from the gist-clause interpretations of user input
;
(READRULES '*clause-inference-tree*
'(
  ; Empathetic responses
  1 (0 you 2 sorry 0)
    2 (^you be.v empathetic.a) (0 :ulf)
  1 (0 you recognize how hard receiving the test results is for me 0)
    2 (^you be.v empathetic.a) (0 :ulf)
  1 (0 you are sorry that I have cancer 0)
    2 (^you be.v empathetic.a) (0 :ulf)

  ; Explicit responses
  1 (0 the prognosis is that I may live for 0)
    2 (^you be.v explicit.a) (0 :ulf)

  ; Empowering responses
  1 (0 do I want to try to fight the cancer 0)
    2 (^you be.v empowering.a) (0 :ulf)
  1 (0 what are my treatment goals 0)
    2 (^you be.v empowering.a) (0 :ulf)
  1 (0 what scares me about my condition 0)
    2 (^you be.v empowering.a) (0 :ulf)
  1 (0 what is the most important thing for my future 0)
    2 (^you be.v empowering.a) (0 :ulf)
  1 (0 what would help me manage my condition 0)
    2 (^you be.v empowering.a) (0 :ulf)

  ; Goodbye responses
  1 (0 goodbye 0)
    2 ((the.d conversation.n) be.v over.a) (0 :ulf)
))