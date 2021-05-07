; Transduction tree for inferring additional facts from the gist-clause interpretations of user input
;
; Questions asked by SOPHIE:
; (Will an antidepressant help with my pain ?)
; (What are the side effects of chemotherapy ?)
; (Should I get comfort care ?)
; (How will I know if my pain medication is working ?)
; (Should I try medication before I try therapy ?)
; (Can I get addicted to narcotics ?)
; (What are the side effects of stronger pain medication ?)
; (Why have I not been sleeping well ?)
; (What is my prognosis ?)
; (What do my test results mean ?)
; (What are my options for treatment ?)
; (What are my treatment options if I do not do chemotherapy ?)
; (Do you think chemotherapy will help ?)
; (Do you think radiation will help ?)
; (I would like a refill of medicine \.)
; (Can I have a stronger pain medication ?)
; (How does chemotherapy work ?)
; (How does comfort care work ?)
; (Has the cancer gotten worse ?)
; (Do I need chemotherapy ?)
; (Will stronger pain medication help me sleep ?)
; (What should I tell my family ?)
; (Why isn\'t the pain medication working anymore ?)
; (Are you sure that I do not need comfort care ?)
; (Are you sure the cancer has not gotten worse ?)
;
; 2 (^me know.v (ans-to ')) (0 :ulf)
;

(READRULES '*clause-inference-tree*
'(
  1 (0 My cancer 2 gotten worse 0)
    2 (^me know.v (ans-to '(Has the cancer gotten worse ?))) (0 :ulf)

  1 (0 A side effect of the medication is 0)
    2 (0 A side effect of the medication be 2 side-effects-significant 2 \. 0)
      3 (^me know.v (ans-to '(Can I have a stronger pain medication ?))) (0 :ulf)
    2 (^me know.v (ans-to '(What are the side effects of stronger pain medication ?))) (0 :ulf)

  1 (0 A side effect of chemotherapy is 0)
    2 (^me know.v (ans-to '(What are the side effects of chemotherapy ?))) (0 :ulf)

  1 (0 One way to get chemotherapy is 0)
    2 (^me know.v (ans-to '(How does chemotherapy work ?))) (0 :ulf)

  1 (0 I should take an antidepressant 0)
    2 (^me know.v (ans-to '(Will an antidepressant help with my pain ?))) (0 :ulf)

  1 (0 I should see a therapist 0)
    2 (^me know.v (ans-to '(Should I try medication before I try therapy ?))) (0 :ulf)

  1 (0 I should take a narcotic 0)
    2 (^me know.v (ans-to '(Can I have a stronger pain medication ?))) (0 :ulf)

  1 (0 You 3 think I need radiation 0)
    2 (^me know.v (ans-to '(Do you think radiation will help ?))) (0 :ulf)

  1 (0 You 3 think I 1 need chemotherapy 0)
    ; TODO: this should infer answer to comfort care as well, rather than just chemotherapy
    2 (0 You do not think I need chemotherapy because I should get comfort care instead 0)
      3 (^me know.v (ans-to '(Do I need chemotherapy ?))) (0 :ulf)
    2 (^me know.v (ans-to '(Do I need chemotherapy ?))) (0 :ulf)

  1 (0 You think we should talk to my oncologist about chemotherapy 0)
    2 (^me know.v (ans-to '(Do I need chemotherapy ?))) (0 :ulf)

  1 (0 You 3 think I need comfort care 0)
    2 (^me know.v (ans-to '(Should I get comfort care ?))) (0 :ulf)

  1 (0 I should take stronger pain medication 0)
    2 (^me know.v (ans-to '(Can I have a stronger pain medication ?))) (0 :ulf)

  1 (0 I should take something different 0)
    2 (^me know.v (ans-to '(Can I have a stronger pain medication ?))) (0 :ulf)
  
  1 (0 I should wait to see if the pain medication works 0)
    2 (^me know.v (ans-to '(Can I have a stronger pain medication ?))) (0 :ulf)

  1 (0 I 2 give you a refill of pain medication 0)
    2 (^me know.v (ans-to '(I would like a refill of medicine \.))) (0 :ulf)

  1 (0 I 2 give you stronger pain medication 0)
    2 (^me know.v (ans-to '(Can I have a stronger pain medication ?))) (0 :ulf)

  1 (0 The prognosis is that 0)
    2 (- 0 cancer 1 be treated 0)
      3 (- 0 may live 1 number-vague elapsed-time 0)
        4 (- 0 cannot 1 cure 0)
          5 (- 0 hard 1 predict 0)
            6 (^me know.v (ans-to '(What is my prognosis ?))) (0 :ulf)

  1 (0 I 1 sleeping poorly because 0)
    2 (^me know.v (ans-to '(Why have I not been sleeping well ?))) (0 :ulf)

  1 (0 The test results show that 0)
    2 (^me know.v (ans-to '(What do my test results mean ?))) (0 :ulf)

  1 (0 is a treatment option 0)
    2 (^me know.v (ans-to '(What are my options for treatment ?))) (0 :ulf)

  1 (0 A stronger pain medication 3 help me sleep 0)
    2 (^me know.v (ans-to '(Will stronger pain medication help me sleep ?))) (0 :ulf)

))