(MAPC 'ATTACHFEAT
'(
  (yes yeah)
))

; phrases for gist extraction:
(READRULES '*dinosaur-bbq-input*
'(
  ; Reciprocal questions
  1 (0 have you 0 ?)
    2 (Have I been to dinosaur barbecue ?) (0 :gist)
  1 (0 wh_ 1 you 0 ?)
    2 (Have I been to dinosaur barbecue ?) (0 :gist)

  ; Specific answers
  1 (NEG 1 I 0)
    2 ((You have not been to dinosaur barbecue \.) (Dinosaur)) (0 :gist)
  1 (0 I 1 have 2 NEG 0)
    2 ((You have not been to dinosaur barbecue \.) (Dinosaur)) (0 :gist)
  1 (0 I 1 have 2 never 0)
    2 ((You have not been to dinosaur barbecue \.) (Dinosaur)) (0 :gist)
  1 (0 I 1 never 2 have 0)
    2 ((You have not been to dinosaur barbecue \.) (Dinosaur)) (0 :gist)
  ;; 1 (4 NEG 0)
  ;;   2 ((You have not been to dinosaur barbecue \.) (Dinosaur)) (0 :gist)
  ;; 1 (5 NEG 0)
  ;;   2 ((You have not been to dinosaur barbecue \.) (Dinosaur)) (0 :gist)
  1 (0 I GOODATTITUDE Dinosaur 0)
    2 ((You love dinosaur barbecue \.) (Dinosaur)) (0 :gist)
  1 (0 I GOODATTITUDE 2 Barbecue 0)
    2 ((You love dinosaur barbecue \.) (Dinosaur)) (0 :gist)
  1 (2 yes 0)
    2 ((You have been to dinosaur barbecue \.) (Dinosaur)) (0 :gist)
  1 (2 of course 0)
    2 ((You have been to dinosaur barbecue \.) (Dinosaur)) (0 :gist)
  1 (3 I 1 have 0)
    2 ((You have been to dinosaur barbecue \.) (Dinosaur)) (0 :gist)

  1 (0) 
    2 ((NIL gist \: Nothing found for whether you have been to dinosaur barbecue \.) (Dinosaur)) (0 :gist)
))

 
(READRULES '*reaction-to-dinosaur-bbq-input*
'(
  1 (0 love dinosaur barbecue 0)
    2 (So you are a fan of the place\. I definitely should try it soon\.) (100 :out)
  1 (0 have been 0)
    2 (I have not been there but I plan to try it soon\, since I am a fan of barbecue\.) (100 :out)
  1 (0 have not been 0)
    2 (You should try it\. I have heard it\'s a nice place\.) (100 :out)
    
  1 (0 NIL gist 0)
    2 (I have heard so many nice comments about the place\.) (100 :out)
)); end of *reaction-to-dinosaur-input*
