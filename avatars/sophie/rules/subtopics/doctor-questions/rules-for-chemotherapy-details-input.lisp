(MAPC 'ATTACHFEAT
'(
  (effect effects)

  (side-effect-addiction addiction addicted high)

  (side-effect-fatigue fatigue fatigued exhaustion exhausted sleepiness sleepy sleep tiredness tired energy drowsy insomnia)
  (side-effect-appetite appetite eating eat hunger hungry)
  (side-effect-nausea nausea vomiting vomit sick sickness)
  (side-effect-neuropathy neuropathy numb numbness tingle tingling)

  (side-effects-insignificant side-effect-fatigue side-effect-appetite)
  (side-effects-moderate side-effects-nausea diarrhea)
  (infection infections)
  (side-effects-significant hair side-effect-neuropathy side-effect-addiction blood infection)

  (chemotherapy-injection injection injections vein veins needle needles)
  (chemotherapy-IV IV tube tubes)
  (mediport infusaport port)
  (under underneath)
))


(READRULES '*chemotherapy-details-input*
'(
  ; Side effects
  1 (0 low blood 0)
    2 ((A side effect of chemotherapy is low blood counts \.) (Chemotherapy-side-effects)) (0 :gist)
  1 (0 hair 0)
    2 ((A side effect of chemotherapy is hair loss \.) (Chemotherapy-side-effects)) (0 :gist)
  1 (0 side-effect-neuropathy 0)
    2 ((A side effect of chemotherapy is neuropathy \.) (Chemotherapy-side-effects)) (0 :gist)
  1 (0 side-effect-nausea 0)
    2 ((A side effect of chemotherapy is nausea \.) (Chemotherapy-side-effects)) (0 :gist)
  1 (0 diarrhea 0)
    2 ((A side effect of chemotherapy is diarrhea \.) (Chemotherapy-side-effects)) (0 :gist)
  1 (0 side-effect-fatigue 0)
    2 ((A side effect of chemotherapy is fatigue \.) (Chemotherapy-side-effects)) (0 :gist)
  1 (0 side-effect-appetite 0)
    2 ((A side effect of chemotherapy is loss of appetite \.) (Chemotherapy-side-effects)) (0 :gist)

  ; Different types of chemotherapy
  1 (0 mediport 0)
    2 ((One way to get chemotherapy is by a port \.) (Chemotherapy-details)) (0 :gist)
  1 (0 chemotherapy-IV 0)
    2 ((One way to get chemotherapy is by iv \.) (Chemotherapy-details)) (0 :gist)
  1 (0 under 1 skin 0)
    2 ((One way to get chemotherapy is by iv \.) (Chemotherapy-details)) (0 :gist)
  1 (0 chemotherapy-injection 0)
    2 ((One way to get chemotherapy is by injection \.) (Chemotherapy-details)) (0 :gist)
  1 (0 doublet 0)
    2 ((One way to get chemotherapy is to get two chemotherapies together \.) (Chemotherapy-details)) (0 :gist)
  1 (0 two 2 chemotherapy 0)
    2 ((One way to get chemotherapy is to get two chemotherapies together \.) (Chemotherapy-details)) (0 :gist)

  1 (0)
    2 *general-input* (0 :subtree)
  1 (0)
    2 ((NIL Gist \: nothing found for chemotherapy details \.)) (0 :gist)
))


(READRULES '*chemotherapy-details-question*
'(
))


(READRULES '*chemotherapy-details-reaction*
'(
  1 (One way to get chemotherapy is 0)
    2 (0 two chemotherapy 0)
      3 (I didn\'t know that was possible\. But it makes sense\.) (0 :out)
    2 (If I do chemotherapy\, I would prefer a port or IV \. I don\'t like needles\.) (0 :out)
  1 (A side effect of chemotherapy is 6 \.)
    2 *ask-how-chemotherapy-works* (0 :schema)
  1 (0)
    2 (Ah\, I see\. I\'ll have to read more about chemotherapy\.) (0 :out)
))