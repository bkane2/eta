(READRULES '*reaction-to-statement-specific-session*
; This tree can be used to define reactions to statements specific to module 1.
;
'(
  1 (0 comfort 1 care 0)
    2 *redirect-to-prognosis* (0 :schema)

  1 (0 medication 0)
    2 *redirect-to-prognosis* (0 :schema)
  1 (0 med-narcotic 0)
    2 *redirect-to-prognosis* (0 :schema)
  1 (0 take 1 different 0)
    2 *redirect-to-prognosis* (0 :schema)
  
  1 (0 treatment 1 option 0)
    2 *redirect-to-prognosis* (0 :schema)
  1 (0 cancer-goals 0)
    2 *redirect-to-prognosis* (0 :schema)

  1 (0 chemotherapy 0)
    2 *redirect-to-prognosis* (0 :schema)
)) ; END *reaction-to-statement-specific-session*