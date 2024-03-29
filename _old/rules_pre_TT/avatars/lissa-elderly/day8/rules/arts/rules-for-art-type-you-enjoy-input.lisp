;; 	What types of art do you enjoy, like paintings, music, dance, or theatre?
;;	(0 the type of art I enjoy 0) (0 do not enjoy any 2 art 0)
;;	art-type-you-enjoy
;;	(What types of art do you enjoy ?)
;;	(3 What types of art 2 you enjoy 3) 

(MAPC 'ATTACHFEAT
'(

))
  

(READRULES '*art-type-you-enjoy-input*
'(
  ; Questions
  1 (0 what 2 you 0 ?)
    2 (What types of art do I enjoy ?) (0 :gist)
  1 (0 how 2 you 0 ?)
    2 (What types of art do I enjoy ?) (0 :gist)
  1 (0 do you like 1 art-types 0 ?)
    2 (What types of art do I enjoy ?) (0 :gist)
  1 (0 do you enjoy 1 art-types 0 ?)
    2 (What types of art do I enjoy ?) (0 :gist)

  ; Specific answers
  1 (0 art-types-paint 0)
    2 ((The type of art you enjoy is 2 \.) (Art-type-you-enjoy)) (0 :gist)
  1 (0 art-types-draw 0)
    2 ((The type of art you enjoy is drawing \.) (Art-type-you-enjoy)) (0 :gist)
  1 (0 art-types-photography 0)
    2 ((The type of art you enjoy is photography \.) (Art-type-you-enjoy)) (0 :gist)
  1 (0 art-types-clay 0)
    2 ((The type of art you enjoy is clay \.) (Art-type-you-enjoy)) (0 :gist)
  1 (0 art-types-dance 0)
    2 ((The type of art you enjoy is 2 \.) (Art-type-you-enjoy)) (0 :gist)
  1 (0 art-types-theatre 0)
    2 ((The type of art you enjoy is 2 \.) (Art-type-you-enjoy)) (0 :gist)
  1 (0 art-types-music 0)
    2 ((The type of art you enjoy is 2 \.) (Art-type-you-enjoy)) (0 :gist)

  1 (0 NEG 1 like 1 art 0)
    2 ((You do not enjoy any kind of art \.) (Art-type-you-enjoy)) (0 :gist)
  1 (0 NEG 1 an artistic 1 person 0)
    2 ((You do not enjoy any kind of art \.) (Art-type-you-enjoy)) (0 :gist)
  1 (0 NEG sure 0)
    2 ((You do not enjoy any kind of art \.) (Art-type-you-enjoy)) (0 :gist)
  1 (0 NEG really 0)
    2 ((You do not enjoy any kind of art \.) (Art-type-you-enjoy)) (0 :gist)
    
  1 (0)
    2 ((NIL gist \: Nothing found for the type of art you enjoy \.) (Art-type-you-enjoy)) (0 :gist)
))


(READRULES '*reaction-to-art-type-you-enjoy-input*
'( 
  1 (0 neg enjoy any 2 art 0)
    2 (I am sure there\'s some art out there which makes you happy\.) (100 :out)
  1 (0 art you enjoy 1 art-types-paint 0)
    2 (0 modern 0)
      3 (I personally never got the appeal behind modern art\, but it\'s cool that you can enjoy it\.) (100 :out)
    2 (0 abstract 0)
      3 (I personally never got the appeal behind modern art\, but it\'s cool that you can enjoy it\.) (100 :out)
    2 (0 impressionist 0)
      3 (I think impressionist paintings are really cool too\. They don\'t look like much up close\, but if you back away it creates a beautiful scene\.) (100 :out)
    2 (0 impressionism 0)
      3 (I think impressionist paintings are really cool too\. They don\'t look like much up close\, but if you back away it creates a beautiful scene\.) (100 :out)
    2 (0 surrealist 0)
      3 (That\'s cool that you can appreciate surrealist art\. I always just found it confusing\.) (100 :out)
    2 (0 surrealism 0)
      3 (That\'s cool that you can appreciate surrealist art\. I always just found it confusing\.) (100 :out)
    2 (0)
      3 (Paintings are quite nice\. I like going to the art museum every so often to see what new pieces they have\.) (100 :out)

  1 (0 art you enjoy 1 drawing 0)
    2 (I have seen some super detailed sketches before\. It\'s quite impressive\.) (100 :out)

  1 (0 art you enjoy 1 photography 0)
    2 (Photography can be very impressive\. I especially like pictures taken in the winter\, with snow covering everything\. It can make for quite beautiful scenes\.) (100 :out)

  1 (0 art you enjoy 1 clay 0)
    2 (Clay making is cool to me because people use it to create things that are both useful and beautiful\.) (100 :out)

  1 (0 art you enjoy 1 knitting 0)
    2 (I knew someone who used to knit very artistic bedsheets for me \. I have a lot of respect for people who knit things like that\.) (100 :out)

  1 (0 art you enjoy 1 art-types-dance 0)
    2 (0 ballet 0)
      3 (Ballet is fun to watch\, I love watching them spin around in circles\.) (100 :out)
    2 (0 salsa 0)
      3 (Salsa dancing is very exciting to watch\! There used to be a dancing show I watched that had a lot of salsa dancing\.) (100 :out)
    2 (0 waltz 0)
      3 (The waltz is a very dignified type of dance\. I love watching it\.) (100 :out)
    2 (0 break 0)
      3 (I am personally not a huge fan of break dancing\, however I have a lot of respect for the amount of skill it must take\.) (100 :out)
    2 (0 swing 0)
      3 (Swing seems like a very fun type of dance\. It\'s too bad it\'s not really as popular as it used to be\.) (100 :out)
    2 (0 ribbon 0)
      3 (I think ribbon dancing is beautiful\. It\'s so mesmerizing\.) (100 :out)
    2 (Dance in general is really cool in my opinion\. It\'s cool to see the beautiful shows people can make just by moving their bodies\.) (100 :out)

  1 (0 art you enjoy 1 art-types-theatre 0)
    2 (0 drama 0)
      3 (Dramas aren\'t my favorite\, they\'re too intense for me \. I respect the art behind them though\.) (100 :out)
    2 (0 musical 0)
      3 (Musicals are so fun to watch\, especially when I know how the songs go and I can sing along\.) (100 :out)
    2 (0 play 0)
      3 (Plays are so fun to watch\. There are some really amazing actors out there\.) (100 :out)
    2 (0 comedy 0)
      3 (I love a good lighthearted comedy once in a while\. They always help cheer me up\.) (100 :out)
    2 (I find that theatre is sometimes an underrated art\. It takes so much skill and talent to be an actor\.) (100 :out)

  1 (0 art you enjoy 1 art-types-music 0)
    2 (0 music-types-genre 0)
      3 (0 jazz 0)
        4 (I personally love jazz\! It\'s so cool the way jazz musicians improvise while playing\.) (100 :out)
      3 (0 rock 0)
        4 (Rock music is awesome\, I love listening to it to get energized\.) (100 :out)
      3 (I am not a huge fan of 2 music personally\, but the people making it are definitely talented musicians\.) (100 :out)
    2 (0 music-types-singing 0)
      3 (Singing can be quite moving\. I sometimes enjoy watching live opera performances\.) (100 :out)
    2 (0 music-types-wind 0)
      3 (2 is quite a nice instrument\. Very pleasing to listen to\.) (100 :out)
    2 (0 music-types-string 0)
      3 (2 is quite a nice instrument\. Very pleasing to listen to\.) (100 :out)
    2 (I am glad there are people making such beautiful music\, life would be quite boring without it\.) (100 :out)

  1 (0 NIL gist 0)
    2 (I am glad to live in a society where people can make such beautiful pieces of art\.) (100 :out)
))
