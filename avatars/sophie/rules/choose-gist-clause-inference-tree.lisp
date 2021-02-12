; Transduction tree for inferring additional facts from the gist-clause interpretations of user input
;

(READRULES '*clause-inference-tree*
'(
  1 (0 I 1 sleeping poorly because 2 side effect 0)
    2 (^me know.v (ans-to '(Why have I not been sleeping well ?))) (0 :ulf)
))