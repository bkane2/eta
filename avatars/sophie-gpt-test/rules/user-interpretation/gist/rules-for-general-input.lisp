; This rule tree is called in the case where no specific-input pattern is matched;
; this will first try to branch to a topical question-input tree based on generic keywords,
; and if that fails, the system will try to match general question forms, with the aim of
; allowing the system to ask for a clarification.
(READRULES '*general-input*
'(
  
))