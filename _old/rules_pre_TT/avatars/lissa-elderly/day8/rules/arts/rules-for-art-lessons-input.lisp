;;  Have you ever taken lessons in music, dance, theatre, drawing, or another kind of art?
;;	(0 I have not taken lessons in any kind of art 0)
;;	(0 I have taken lessons in 0)
;;	art-lessons
;;	(Have you ever taken lessons in a kind of art ?)
;;	(3 Have you ever taken lessons 5 art 3)

(MAPC 'ATTACHFEAT
'(
  (art-types art-types-paint art-types-draw art-types-photography art-types-clay art-types-dance art-types-theatre art-types-music)

  (art-types-paint art paint painting paintings painting-types)
  (painting-types watercolor watercoloring oil oils acrylic abstract modern cubism surrealism surrealist impressionism
    impressionist medieval realistic realism colorful minimalistic minimalism)

  (art-types-draw draw drawing sketch sketching)

  (art-types-photography photography photos photographs)

  (art-types-clay clay pots pottery sculptures sculpture sculpting ceramics)

  (art-types-knitting knitting sewing crochet stitching)

  (art-types-dance dance dancing dance-types)
  (dance-types ballet waltz salsa tango quickstep swing tap jive samba belly latin ribbon break)

  (art-types-theatre theatre theater acting cinema cinematography film animation theatre-types)
  (theatre-types drama comedy tradgedy play musical reenactment romance)

  (art-types-music music music-types-group music-types-genre music-types-singing music-types-wind music-types-string music-types-other)
  (music-types-genre classical rock pop jazz folk blues rap reggae country punk instrumental opera
    electronic metal soul disco alternative bluegrass)
  (music-types-group band orchestra ensemble chorus choir)
  (music-types-singing singing vocal voice opera)
  (music-types-wind flute clarinet trumpet trombone bass oboe horn saxophone sax recorder)
  (music-types-string guitar violin cello viola bass)
  (music-types-other piano drum drums percussion)
  ; Offering art lessons at senior living community
  (syn-lessons lesson lessons class classes school)
))


(READRULES '*art-lessons-input*
'(
  ; Questions
  1 (0 what 2 you 0 ?)
    2 (Have I ever taken lessons in a kind of art ?) (0 :gist)
  1 (0 how 2 you 0 ?)
    2 (Have I ever taken lessons in a kind of art ?) (0 :gist)
  1 (0 have 2 you 0 ?)
    2 (Have I ever taken lessons in a kind of art ?) (0 :gist)
  1 (0 can 1 you 1 art-types 0 ?)
    2 (Can I do art ?) (0 :gist)
  1 (0 how do you 1 art-types 0 ?)
    2 (Can I do art ?) (0 :gist)
  1 (0 do you like 1 art-types 0 ?)
    2 (What types of art do I enjoy ?) (0 :gist)

  ; Specific answers
  1 (0 art-types-paint 0)
    2 ((You have taken lessons in painting \.) (Art-lessons)) (0 :gist)
  1 (0 art-types-draw 0)
    2 ((You have taken lessons in drawing \.) (Art-lessons)) (0 :gist)
  1 (0 art-types-photography 0)
    2 ((You have taken lessons in photography \.) (Art-lessons)) (0 :gist)
  1 (0 art-types-clay 0)
    2 ((You have taken lessons in clay \.) (Art-lessons)) (0 :gist)
  1 (0 art-types-knitting 0)
    2 ((You have taken lessons in knitting \.) (Art-lessons)) (0 :gist)
  1 (0 art-types-dance 0)
    2 ((You have taken lessons in 2 \.) (Art-lessons)) (0 :gist)
  1 (0 art-types-theatre 0)
    2 ((You have taken lessons in theatre \.) (Art-lessons)) (0 :gist)
  1 (0 art-types-music 0)
    2 ((You have taken lessons in 2 \.) (Art-lessons)) (0 :gist)

  1 (0 NEG 1 taken 0)
    2 ((You have not taken lessons in any kind of art \.) (Art-lessons)) (0 :gist)
  1 (0 NEG 1 had 0)
    2 ((You have not taken lessons in any kind of art \.) (Art-lessons)) (0 :gist)
  1 (0 NEG really 0)
    2 ((You have not taken lessons in any kind of art \.) (Art-lessons)) (0 :gist)

  1 (0)
    2 ((NIL gist \: Nothing found for areas you have taken lessons in \.) (Art-lessons)) (0 :gist)
))


(READRULES '*reaction-to-art-lessons-input*
'(
  1 (0 taken lessons 1 painting 0)
    2 (I think painting can be beautiful\, but I was never very good at it\. You are lucky you could get experience with it\.) (100 :out)

  1 (0 taken lessons 1 drawing 0)
    2 (Drawing is a fun way to spend your time\! I like drawing as well\, though I am not very good at it\.) (100 :out)

  1 (0 taken lessons 1 photography 0)
    2 (I love taking photos\, especially of nature\. I never had formal training in it though\.) (100 :out)

  1 (0 taken lessons 1 clay 0)
    2 (Clay sculpting sounds interesting\, I don\'t know much about it but I have seen some really neat creations\.) (100 :out)

  1 (0 taken lessons 1 knitting 0)
    2 (Kniting is a good skill to have\. I am sure it can come in handy when I need to fix broken fabric\.) (100 :out)

  1 (0 taken lessons 1 art-types-dance 0)
    2 (0 ballet 0)
      3 (That\'s cool\! I am not sure how people do ballet\, it seems like it would make me really dizzy\.) (100 :out)
    2 (0 salsa 0)
      3 (Salsa dancing\, very interesting\. I always found it fun to watch on dancing shows\.) (100 :out)
    2 (Dance lessons sound like a lot of fun\, a good way to get excersize too\.) (100 :out)

  1 (0 taken lessons 1 theatre 0)
    2 (Theatre lessons sound interesting\, making movies has always just seemed like magic to me \.) (100 :out)

  1 (0 taken lessons 1 art-types-music 0)
    2 (0 music-types-genre 0)
      3 (I have heard some 2 music before\, it seems like a really fun genre to play\.) (100 :out)
    2 (0 music-types-group 0)
      3 (Playing music with a group is even more fun than playing music by myself\. I played flute in school band when I was younger\.) (100 :out)
    2 (0 music-types-singing 0)
      3 (That\'s awesome that you sang\! I am sure it must have sounded beautiful\.) (100 :out)
    2 (0 music-types-wind 0)
      3 (Wind instruments are fun to play\. I played the flute when I was younger\.) (100 :out)
    2 (0 music-types-string 0)
      3 (I always found string instruments really difficult\. They sure sound nice though\!) (100 :out)
    2 (It\'s great that you had some music education growing up\!) (100 :out)

  1 (0 neg taken lessons 0)
    2 (Well\, it\'s never too late to start taking more art lessons\!) (100 :out)

  1 (0 NIL gist 0)
    2 (I think it\'s important to have a way to express yourself through art\.) (100 :out)
))
