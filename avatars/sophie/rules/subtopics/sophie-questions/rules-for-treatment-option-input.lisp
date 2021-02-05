(MAPC 'ATTACHFEAT
'(
))


(READRULES '*treatment-option-input*
'(
  1 (0 palliative care 0)
    2 ((Comfort care is a treatment option \.) (comfort-care)) (0 :gist)
  1 (0 hospice 0)
    2 ((Comfort care is a treatment option \.) (comfort-care)) (0 :gist)

  1 (0 med-chemotherapy 0)
    2 ((Chemotherapy is a treatment option \.) (chemotherapy)) (0 :gist)
  1 (0 chemotherapy 0)
    2 ((Chemotherapy is a treatment option \.) (chemotherapy)) (0 :gist)

  1 (0 radiation 0)
    2 ((Radiation is a treatment option \.) (radiation)) (0 :gist)
  1 (0 surgery 0)
    2 ((Surgery is a treatment option \.) (surgery)) (0 :gist)

  1 (0 quality 2 life 0)
    2 ((Maintaining good quality of life is a treatment option \.) (comfort-care)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for treatment option \.)) (0 :gist)
))


(READRULES '*treatment-option-question*
'(

))


(READRULES '*treatment-option-reaction*
'(
  1 (Maintaining good quality of life is a treatment option \.)
    2 *ask-about-treatment-options* (100 :schema)
  
  1 (Radiation is a treatment option \.)
    2 *ask-about-will-radiation-help* (0 :schema)

  1 (Chemotherapy is a treatment option \.)
    2 *ask-about-what-happens-without-chemotherapy* (100 :schema)
    2 *ask-about-will-chemotherapy-help* (0 :schema)
    
  1 (Comfort care is a treatment option \.)
    2 *ask-about-comfort-care* (0 :schema)

  1 (0)
    2 (You will have to think about what I said more\.) (0 :out)
))