(MAPC 'ATTACHFEAT
  '(
  ))


(READRULES '*anyone-here-with-you-input*
'(
  ; Asking about where your daughter works
  1 (0 where does 3 work 0)
    2 (0 she 0)
      3 ((Where does your daughter work ?) (anyone-here-with-you)) (0 :gist)
    2 (0 your daughter 0)
      3 ((Where does your daughter work ?) (anyone-here-with-you)) (0 :gist)
  ; Expressing sympathy about daughter not being able to make it
  1 (0 that be too bad 0)
    2 ((I am sorry that your daughter couldn\'t come today \.) (anyone-here-with-you)) (0 :gist)
  1 (0 I be sorry 0)
    2 ((I am sorry that your daughter couldn\'t come today \.) (anyone-here-with-you)) (0 :gist)
  1 (0)
    2 *general-input* (0 :subtree)
))


(READRULES '*anyone-here-with-you-question*
'(
  1 (0 be you here 1 with 0)
    2 ((Is anyone here with you ?)) (0 :gist)
  1 (0 anyone be here 1 with you 0)
    2 ((Is anyone here with you ?)) (0 :gist)
  1 (0 who be here 1 with you 0)
    2 ((Is anyone here with you ?)) (0 :gist)
  1 (0 did you come with 0)
    2 ((Is anyone here with you ?)) (0 :gist)
  1 (0 be 1 here 1 with you 0)
    2 ((Is anyone here with you ?)) (0 :gist)
  1 (0 be you here alone 0)
    2 ((Is anyone here with you ?)) (0 :gist)
  1 (0 did you come by yourself 0)
    2 ((Is anyone here with you ?)) (0 :gist)
  1 (0 who came with you 0)
    2 ((Is anyone here with you ?)) (0 :gist)
  1 (0)
    2 ((NIL Gist)) (0 :gist)
))


(READRULES '*anyone-here-with-you-reaction*
'(

))