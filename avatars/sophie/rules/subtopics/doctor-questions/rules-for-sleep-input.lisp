(READRULES '*sleep-input*
'(
  

  1 (0 sleep 2 during 3 day 0)
    2 (*sleep-question* (do you sleep during the day ?)) (0 :subtree+clause)
  1 (0 how 1 frequently 0 wake)
    2 (*sleep-question* (how often are you waking up at night ?)) (0 :subtree+clause)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((Nil Gist \: nothing found for sleeping well \.)) (0 :gist)
))


(READRULES '*sleep-question*
'(
  ; Have you been sleeping okay?
  1 (0 be you 2 sleep 1 okay 0)
    2 ((Have I been sleeping okay ?) (Sleep)) (0 :gist)
  1 (0 have you 2 sleep 1 okay 0)
    2 ((Have I been sleeping okay ?) (Sleep)) (0 :gist)
  1 (0 you 3 trouble sleep 0)
    2 ((Have I been sleeping okay ?) (Sleep)) (0 :gist)
  1 (0 you 2 sleep 1 much 0)
    2 ((Have I been sleeping okay ?) (Sleep)) (0 :gist)

  ; How often are you waking up at night?
  1 (0 how frequently 0)
    2 ((How often am I waking up at night ?) (Waking-frequency)) (0 :gist)

  ; Do you sleep during the day?
  1 (0 sleep 2 during 3 day 0)
    2 ((Do I sleep during the day ?) (Sleep)) (0 :gist)

  ; What's going through your head while you're sleeping?
  1 (0 wh_ 5 sleep-thought 5 sleep 0)
    2 ((What is on my mind when I try to sleep ?) (Sleep)) (0 :gist)

  ; What happens when you try to sleep?
  1 (0 wh_ 2 happen 4 sleep 0)
    2 ((What happens when I try to sleep ?) (Sleep)) (0 :gist)
))


(READRULES '*sleep-reaction*
'(

))