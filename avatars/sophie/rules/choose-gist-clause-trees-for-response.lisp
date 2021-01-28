(READRULES '*gist-clause-trees-for-response*
'(
  1 (can 1 rephrase 1 question 1)
    2 (*response-tree-general*) (0 :subtrees)
))


(READRULES '*response-tree-general*
'(
  1 (0)
    2 (You are sorry\, you didn\'t quite understand\. Can I say it again ?) (3 :out)
    2 (Would I mind rephrasing ?) (3 :out)
    2 (Could I repeat that one more time using a different phrasing ?) (0 :out)
))
