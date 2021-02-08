(MAPC 'ATTACHFEAT
  '(
    (married marry spouse partner husband wife)
    (doing feeling feel)
  ))


(READRULES '*appointment-input*
'(
  ; Asking about where your daughter works
  1 (0 where does 3 work 0)
    2 (0 she 0)
      3 ((Where does my daughter work ?) (Anyone-here-with-you)) (0 :gist)
    2 (0 your daughter 0)
      3 ((Where does my daughter work ?) (Anyone-here-with-you)) (0 :gist)
    2 (0 he 0)
      3 ((Where does my son work ?) (Anyone-here-with-you)) (0 :gist)
    2 (0 your son 0)
      3 ((Where does my son work ?) (Anyone-here-with-you)) (0 :gist)
  1 (0 how old be 0)
    2 (0 she 0)
      3 ((How old is my daughter ?)) (0 :gist)
    2 (0 your daughter 0)
      3 ((How old is my daughter ?)) (0 :gist)
    2 (0 he 0)
      3 ((How old is my son ?)) (0 :gist)
    2 (0 your son 0)
      3 ((How old is my son ?)) (0 :gist)
  ;Do you have grandchildren or children?
  1 (0 children 0)
   2 ((Do I have any children ?) (Anyone-here-with-you)) (0 :gist)
  1 (0 child 0)
   2 ((Do I have any children ?) (Anyone-here-with-you)) (0 :gist)
  1 (0 grandchildren 0)
   2 ((Do I have any grandchildren ?) (Anyone-here-with-you)) (0 :gist)
  1 (0 grandchild 0)
   2 ((Do I have any grandchildren ?) (Anyone-here-with-you)) (0 :gist)
  ;Were you ever married?
  1 (0 married 0)
   2 ((Am I married ?) (Anyone-here-with-you)) (0 :gist)
  ;How are you doing today?
  1 (0 wh_ 2 you 3 feeling 0)
   2 ((How am I doing today ?)) (0 :gist)

  ; Expressing sympathy about daughter not being able to make it
  1 (0 that be too bad 0)
    2 ((You are sorry that my daughter couldn\'t come today \.) (Anyone-here-with-you)) (0 :gist)
  1 (0 I be sorry 0)
    2 ((You are sorry that my daughter couldn\'t come today \.) (Anyone-here-with-you)) (0 :gist)
  1 (0)
    2 *general-input* (0 :subtree)
))


(READRULES '*appointment-question*
'(
  ; Did you drive here?
  1 (0 drive 0)
    2 ((Did I drive here ?)) (0 :gist)

  ; Is anyone here with you?
  1 (0 be you here 1 with 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 anyone be here 1 with you 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 who be here 1 with you 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 did you come with 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 be 1 here 1 with you 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 be you here alone 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 did you come by yourself 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 who came with you 0)
    2 ((Is anyone here with me ?)) (0 :gist)
  1 (0 come here with 0)
    2 ((Is anyone here with me ?)) (0 :gist)

   ; Asking about where your daughter works
  1 (0 where does 3 work 0)
    2 (0 she 0)
      3 ((Where does my daughter work ?) (Anyone-here-with-you)) (0 :gist)
    2 (0 your daughter 0)
      3 ((Where does my daughter work ?) (Anyone-here-with-you)) (0 :gist)
    2 (0 he 0)
      3 ((Where does my son work ?) (Anyone-here-with-you)) (0 :gist)
    2 (0 your son 0)
      3 ((Where does my son work ?) (Anyone-here-with-you)) (0 :gist)
  1 (0 how old be 0)
    2 (0 she 0)
      3 ((How old is my daughter ?)) (0 :gist)
    2 (0 your daughter 0)
      3 ((How old is my daughter ?)) (0 :gist)
    2 (0 he 0)
      3 ((How old is my son ?)) (0 :gist)
    2 (0 your son 0)
      3 ((How old is my son ?)) (0 :gist)
  ;Do you have grandchildren or children?
  1 (0 grandchildren 0)
   2 ((Do I have any grandchildren ?) (Anyone-here-with-you)) (0 :gist)
  1 (0 grandchild 0)
   2 ((Do I have any grandchildren ?) (Anyone-here-with-you)) (0 :gist)
  1 (0 children 0)
   2 ((Do I have any children ?) (Anyone-here-with-you)) (0 :gist)
  1 (0 child 0)
   2 ((Do I have any children ?) (Anyone-here-with-you)) (0 :gist)
  ;Were you ever married?
  1 (0 married 0)
   2 ((Am I married ?) (Anyone-here-with-you)) (0 :gist)
  ;How are you doing today?
  1 (0 wh_ 2 you 3 feeling 0)
   2 ((How am I doing today ?)) (0 :gist)


  1 (0)
    2 ((NIL Gist)) (0 :gist)
))


(READRULES '*appointment-reaction*
'(

))
