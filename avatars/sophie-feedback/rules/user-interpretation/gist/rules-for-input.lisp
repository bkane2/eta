;

(READRULES '*feedback-input*
; TBC
'(
  1 (bye)
    2 ((Goodbye \.)) (0 :gist)

  ;; 1 (0 [SEP] 0)
  ;;   2 ((An input was found \: 1 and 3 \.)) (0 :gist)

  ; Top-level nodes match SOPHIE's responses where we previously had opportunity tags
  1 (WH_ does this mean for my future [SEP] 0)
    ; Second-level nodes detect whether user asked an open-ended question or not
    2 (0 [SEP] 0 WH_ worries you the most 0)
      3 ((The doctor asked an open ended question \.)) (0 :gist)
    ; If doctor did not ask an open-ended question, gist-clause stores suggestion
    2 ((Suggestion \: what worries you the most ?)) (0 :gist)
  
  1 (0)
    2 ((NIL Gist \: nothing found for input \.)) (0 :gist)

)) ; END *feedback-input*