(READRULES '*energy-input*
'(
    1 (0 be-aux 3 ment-health 3 recently 0)
    2 ((How is my mental health ?) (Energy)) (0 :gist)
  1 (0 how 5 think-gen 0)
    2 ((How is my mental health ?) (Energy)) (0 :gist)
  1 (0 how 3 ment-health 5)
    2 ((How is my mental health ?) (Energy)) (0 :gist)
  1 (0 wh_ 5 think-gen 0)
    2 ((How is my mental health ?) (Energy)) (0 :gist)
  1 (0 do 1 pron 5 ment-health 0 )
    2 ((How is my mental health ?) (Energy)) (0 :gist)
  1 (0 have 1 pron 5 ment-health 0)
    2 ((How is my mental health ?) (Energy)) (0 :gist)

  1 (0 antidepressant 0)
    2 ((I should take an antidepressant \.) (Medicine-request)) (0 :gist)
  1 (0 therapy 0)
    2 ((I should see a therapist \.) (Energy)) (0 :gist)
  1 (0)
    2 *general-input* (0 :subtree)
))


(READRULES '*energy-question*
'(
  1 (0 be-aux 5 ment-health 5)
    2 ((How is my mental health ?) (Energy)) (0 :gist)
  1 (0 trouble 1 concentrate 0)
    2 ((Have I had trouble concentrating ?) (Energy)) (0 :gist)
  1 (0 you 1 have 1 energy 0)
    2 ((How is my energy ?) (Energy)) (0 :gist)
  1 (0 trouble 1 energy 0)
    2 ((How is my energy ?) (Energy)) (0 :gist)
  1 (0 med-take 5 antidepressant)
    2 ((I should take an antidepressant \.) (Medicine-request)) (0 :gist)
  1 (0 therapy 0)
    2 ((I should see a therapist \.) (Energy)) (0 :gist)
  1 (0)
    2 ((NIL Gist)) (0 :gist)

))


(READRULES '*energy-reaction*
'(
  1 (You can give me an antidepressant \.)
    2 *ask-about-antidepressant* (100 :schema)
    2 (Okay\. I\'ll give the antidepressant medication a shot\.) (0 :out)
  1 (I should take an antidepressant \.)
    2 *ask-about-antidepressant* (100 :schema)
    2 (Okay\. I\'ll give the antidepressant medication a shot\.) (0 :out)
  1 (I should see a therapist \.)
    2 *ask-about-medication-before-therapy* (100 :schema)
    2 (Okay\. I\'ll give the therapy a shot\.) (0 :out)
))
