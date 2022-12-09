(READRULES '*paraphrase-prompt-examples-tree*
;`````````````````````````````````````````````````
; A tree for selecting relevant GPT3 prompt examples based on the gist-clause to paraphrase.
; 
; A prompt-examples directive consists of several tuples, each consisting of a context gist-clause,
; a response gist-clause, and a surface form version of the response gist-clause.
;
; Currently, only a single set of prompt-examples are used, but in the future different sets could
; be created tailored for different Eta gist-cluses in order to improve performance.
;
'(
  1 (0)
    2 (
        ; 1
        ((It\'s nice to meet you \.)
         (My pain medication is not working anymore \.)
         (I was hoping you\'d be able to help me with my pain today \. My medicine just isn\'t working anymore \. I haven\'t been able to get much sleep \.))
        ; 2
        ((What are you taking for the pain ?)
         (I\'m taking Lortab \.)
         (I\'m just taking the Lortab at the moment\, but it\'s really not working anymore \. I already have to take an extra pill each day \.))
        ; 3
        ((I am sorry that you are in pain \.)
         (What is my prognosis ?)
         (I\'m just worried about what this all means for me \. I want to be able to be there for my children and grandchildren \. What do you think this means for me in the future ?))
      )
      (0 :prompt-examples)
))



(READRULES '*gist-prompt-examples-tree*
;`````````````````````````````````````````````````
; A tree for selecting relevant GPT3 prompt examples for gist clause interpretation, based on the
; context gist clause.
; 
; A prompt-examples directive consists of several tuples, each consisting of a context gist clause,
; a response utterance, and the rephrased gist clause for the response.
;
; Currently, only a single set of prompt-examples are used, but in the future different sets could
; be created tailored for different contexts in order to improve performance.
;
'(
  1 (0)
    2 (
        ; 1 - statement
        ((What is my prognosis ?)
         (Unfortunately\, Sophie\, not long \. I took a look at your test results\, and it seems like the cancer has spread \. Likely\, we\'re talking about a matter of
            months at this point \. Maybe up to a year \.)
         (Your prognosis is that you will likely live for some months to a year \.))
        ; 2 - statement
        ((What are my treatment options ?)
         (That depends on what your goals are\, Sophie \. If you want to try to prolong your life\, we can try putting you on aggressive chemotherapy\, but typically that
            has a lot of side effects \. It could make you very sick \. The other option would be palliative care or hospice\, where we try to treat your pain and make sure
            you\'re able to spend valuable time with your family in the time you have left \.)
         (Your treatment options are aggressive chemotherapy or palliative care \.))
        ; 3 - statement
        ((What do my test results show ?)
         (Unfortunately\, it seems like you\'re not going to make it \.)
         (Your test results indicate a poor prognosis \.))
        ; 4 - none
        ((What is my prognosis ?)
         (Unfortunately Sophie)
         nil)
        ; 5 - none
        ((What are my treatment options ?)
         (Goo goo ga joob \.)
         nil)
        ; 6 - question
        ((Your treatment options are aggressive chemotherapy or palliative care \.)
         (I don\'t really know much about either of those \. What would you recommend ?)
         (Which treatment option do you recommend ?))
        ; 7 - question
        ((What are my treatment options ?)
         (What\'s most important to you\, Sophie ?)
         (What are your treatment goals ?))
        ; 8 - question
        ((What is my prognosis ?)
         (How much do you understand so far ?)
         (How much do you currently understand about your prognosis ?)))
      (0 :prompt-examples)
))