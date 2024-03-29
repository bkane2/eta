;; (Are there other holidays you prefer ?)
;;	(holidays-you-prefer)
;;		from-holidays-you-prefer-input
;;			(0 The holiday I prefer is 0)
;;			gist-question:(3 are there 2 holidays you prefer 0)

(MAPC 'ATTACHFEAT
'(
   (american-holidays Christmas Halloween Thanksgiving Easter)
   (fourth 4th)
))


(READRULES '*holidays-you-prefer-input*
'(
   ; Reciprocal question
   1 (0 what 2 you 0 ?)
      2 (Are there other holidays I prefer ?) (0 :gist)
   1 (0 how 2 you 0 ?)
      2 (Are there other holidays I prefer ?) (0 :gist)
   1 (0 wh_ 2 holidays 2 do you 0 ?)
      2 (Are there other holidays I prefer ?) (0 :gist)
   1 (0 holidays you 0 ?)
      2 (Are there other holidays I prefer ?) (0 :gist)

   ; Specific answer
   1 (NEG 0) 
      2 ((You do not know what the holiday you prefer is \.)  (Holidays-you-prefer)) (0 :gist) 		
   1 (0 american-holidays 0) 
      2 ((The holiday you prefer is 2 \.)  (Holidays-you-prefer)) (0 :gist) 		
   1 (0 Independence day 0) 
      2 ((The holiday you prefer is 2 3 \.)  (Holidays-you-prefer)) (0 :gist) 		
   1 (0 New year\'s 0) 
      2 ((The holiday you prefer is new year\'s \.)  (Holidays-you-prefer)) (0 :gist) 		
   1 (0 fourth 1 July 0) 
      2 ((The holiday you prefer is fourth of july \.)  (Holidays-you-prefer)) (0 :gist) 		
   1 (0 mother\'s day 0) 
      2 ((The holiday you prefer is mother\'s day \.)  (Holidays-you-prefer)) (0 :gist) 		
   1 (0 father\'s day 0) 
      2 ((The holiday you prefer is father\'s day \.)  (Holidays-you-prefer)) (0 :gist) 		
   1 (0 valentine\'s day 0) 
      2 ((The holiday you prefer is valentine \.)  (Holidays-you-prefer)) (0 :gist) 
   1 (0 valentine 0) 
      2 ((The holiday you prefer is valentine \.)  (Holidays-you-prefer)) (0 :gist) 	

   1 (0)
      2 ((NIL gist \: Nothing found for what the holiday you prefer is \.) (Holidays-you-prefer)) (0 :gist)
))


(READRULES '*reaction-to-holidays-you-prefer-input*
'(
   1 (0 american-holidays 0)
      2 (0 christmas 0)
         3 (I love christmas\, seeing all the lights makes me happy\.) (100 :out)
      2 (0 halloween 0)
         3 (Halloween is so much fun\! All dressing up and stuff always make a great night\.) (100 :out)
      2 (0 thanksgiving 0)
         3 (Thanksgiving is a great holiday in my opinion\, since I get to see all my family \.) (100 :out)
      2 (0 easter 0)
         3 (Easter is a fun holiday\, I like watching people do egg scavanger hunts\.) (100 :out)
   1 (0 independence 0)
      2 (I always enjoy the fourth of july fireworks\.) (100 :out)
   1 (0 new year\'s 0)
      2 (I like celebrating a new year\, a fresh start\.) (100 :out)
   1 (0 fourth 0)
      2 (I always enjoy the fourth of july fireworks\.) (100 :out)
   1 (0 mother\'s 0)
      2 (It\'s nice to have a day to think of the parents\.) (100 :out)
   1 (0 father\'s 0)
      2 (It\'s nice to have a day to think of the parents\.) (100 :out)
   1 (0 valentine 0)
      2 (Well\, valentine\'s day is too romantic for me \, it is more for young people I think \.) (100 :out)
   1 (0 you do not know 0)
      2 (Oh\, okay\. I personally love christmas\, seeing all the lights makes me happy\.) (100 :out)
      
   1 (0 NIL gist 0)
      2 (I personally love christmas\, seeing all the lights makes me happy\.) (100 :out)
))
