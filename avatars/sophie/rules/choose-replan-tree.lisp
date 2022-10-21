; Transduction tree for selecting an appropriate subplan conditional on matching the input goal WFF,
; in the case of a failure of a schema to accomplish that goal.
;
(READRULES '*replan-tree*
'(
  1 (^me want.v (that (^me know.v (ans-to (quote (why .HAVE I not been sleeping well ?))))))
    2 *ask-if-stronger-medication-will-help-sleep* (100 :schema)
  1 (^me want.v (that (^me know.v (ans-to (quote (.DO I need .CHEMOTHERAPY ?))))))
    2 *ask-if-need-chemotherapy* (100 :schema)
  1 (^me want.v (that (^me know.v (ans-to (quote (what is my prognosis ?))))))
    2 *ask-about-prognosis* (100 :schema)
  ;; 2 *ask-about-prognosis* (100 :schema)
  1 (^me want.v (that (^me know.v (ans-to (quote (.CAN I trust your prognosis ?))))))
    2 *ask-if-can-outlive-prognosis-quit-smoke* (100 :schema)
  1 (^me want.v (that (^me know.v (ans-to (quote (what .DO my test results mean ?))))))
    2 *ask-about-test-results* (100 :schema)
  1 (^me want.v (that (^me know.v (ans-to (quote (.CAN I .HAVE a stronger .PAIN medication ?))))))
    2 *ask-for-stronger-pain-medication* (100 :schema)
  1 (^me want.v (that (^me know.v (ans-to (quote (what .SHOULD I .TELL my .FAMILY ?))))))
    2 *ask-what-to-tell-family* (100 :schema)
))