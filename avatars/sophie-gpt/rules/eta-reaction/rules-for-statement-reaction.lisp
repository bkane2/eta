(READRULES '*reaction-to-statement*
; Here we match any non-question statements which the user might ask, and respond to them appropriately.
; If some topic has enough possible gist clauses where it gets messy to put them all here, we can branch off
; to a subtree defined in the rule file for that subtopic (e.g. with *general-reaction*).
; NOTE: questions in declarative form might be tricky, and seem to happen frequently enough in the transcripts.
; Will have to figure out whether to make those questions beforehand through some preprocessing step (You think
; this makes more sense) or deal with them here somehow.
'(
  ; Empathetic responses
  ;; 1 (0 you 2 sorry 0)
  ;;   2 (I appreciate it \. It\'s all just very difficult to take in \.) (5 :out)
  ;;   2 (Thanks \. I\'m just trying to make sense of it all \.) (5 :out)
  ;;   2 (It\'s just very difficult to handle \.) (0 :out)
  ;; 1 (0 you 2 sorry 2 I am in pain 0)
  ;;   2 () (0 :out)
  1 (0 you recognize how hard receiving the test results is for me 0)
    2 (:or
        (It was difficult for me to accept the test results \. I\'m still having a hard time coping with the news \,
        but I appreciate your help \.)
        (It\'s just a lot for me to take in at once \.)
        (It\'s never easy to hear things like this \. I think I just need time \.))
      (0 :out)

  ; Explicit responses
  1 (0 the prognosis is that I may live for 0)
    2 (:or
        ([SAD] That\'s really difficult to hear \. I thought for sure I would have longer than that \.)
        ([SAD] I knew the prognosis would be bad \, but I wasn\'t expecting to hear that \. I don\'t know how to handle this \.)
        ([SAD] I thought I would have more time than that left \. That\'s extremely depressing to hear \.))
      (0 :out)

  ;; ; Empowering responses
  ;; 1 (0 do I want to try to fight the cancer 0)
  ;;   2 () (0 :out)
  ;; 1 (0 what are my treatment goals 0)
  ;;   2 () (0 :out)
  ;; 1 (0 what scares me about my condition 0)
  ;;   2 () (0 :out)
  ;; 1 (0 what is the most important thing for my future 0)
  ;;   2 () (0 :out)
  ;; 1 (0 what would help me manage my condition 0)
  ;;   2 () (0 :out)

  ; Goodbye responses
  1 (0 goodbye 0)
    2 (Thank you for meeting with me today \. Bye \.) (0 :out)
))