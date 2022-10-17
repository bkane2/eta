; Transduction tree for selecting an appropriate subplan conditional on the quoted contents of a
; (^me want.v (that (^me know.v (ans-to '(...))))) goal statement, in the case of a failure of a
; schema to accomplish that goal.
;
; TODO: currently this only supports goal statements above the above type, due to the lack of support
; for matching LFs to patterns in transduction trees, but once this support is added, these rules
; should support any (^me want.v (that ...)) goal statement.
;
(READRULES '*replan-tree*
'(
  1 (why .HAVE I not been sleeping well ?)
    2 *ask-if-stronger-medication-will-help-sleep* (100 :schema)
  1 (.DO I need .CHEMOTHERAPY ?)
    2 *ask-if-need-chemotherapy* (100 :schema)
  1 (what is my prognosis ?)
    2 *ask-about-prognosis* (100 :schema)
  ;; 2 *ask-about-prognosis* (100 :schema)
  1 (.CAN I trust your prognosis ?)
    2 *ask-if-can-outlive-prognosis-quit-smoke* (100 :schema)
  1 (what .DO my test results mean ?)
    2 *ask-about-test-results* (100 :schema)
  1 (.CAN I .HAVE a stronger .PAIN medication ?)
    2 *ask-for-stronger-pain-medication* (100 :schema)
  1 (What should I tell my family ?)
    2 *ask-what-to-tell-family* (100 :schema)
))