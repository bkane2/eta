(READRULES '*reaction-to-question-specific-session*
; This tree can be used to define reactions to questions specific to module 1.
;
'(
  1 (0 comfort-care-word 0)
    2 *redirect-to-prognosis* (0 :schema)

  1 (0 treatment 1 options 0)
    2 *redirect-to-prognosis* (0 :schema)
  1 (0 treatment 1 goals 0)
    2 *redirect-to-prognosis* (0 :schema)

  1 (0 medicine 0)
    2 *redirect-to-prognosis* (0 :schema)
  1 (0 pain-med 0)
    2 *redirect-to-prognosis* (0 :schema)
  1 (0 pain-med-other 0)
    2 *redirect-to-prognosis* (0 :schema)
  1 (0 blood-pressure-med 0)
    2 *redirect-to-prognosis* (0 :schema)
  1 (0 med-narcotic 0)
    2 *redirect-to-prognosis* (0 :schema)
  1 (0 medication 0)
    2 *redirect-to-prognosis* (0 :schema)

  1 (0 chemotherapy 0)
    2 *redirect-to-prognosis* (0 :schema)
)) ; END *reaction-to-question-specific-session*