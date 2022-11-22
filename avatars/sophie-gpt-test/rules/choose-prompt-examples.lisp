; A tree for selecting relevant GPT3 prompt examples based on the gist-clause to paraphrase.
; 
; A prompt-examples directive consists of several tuples, each consisting of a context gist-clause,
; a response gist-clause, and a surface form version of the response gist-clause.
;
; Currently, only a single set of prompt-examples are used, but in the future different sets could
; be created tailored for different Eta gist-cluses in order to improve performance.
;

(READRULES '*prompt-examples-tree*
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