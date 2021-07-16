;

(READRULES '*feedback-input*
; TBC
'(
  1 (bye)
    2 ((Goodbye \.)) (0 :gist)

  1 (0 [SEP] 0)
    2 ((An input was found \: 1 and 3 \.)) (0 :gist)
  
  1 (0)
    2 ((NIL Gist \: nothing found for input \.)) (0 :gist)

)) ; END *feedback-input*