;; (What do you usually do for holidays ?)
;;	(holidays-activities)
;;		from-holidays-activities-input
;;			(0 On holidays 0)
;;			gist-question:(3 what 2 you 3 holidays 0)

(MAPC 'ATTACHFEAT
'(
   (family grandchildren grandchild children child daughter daughters son sons spouse wife husband siblings brother brothers sister sisters
      niece nephew parents mother father grandparents grandmother grandfather)
   (siblings brother sister brothers sisters)
   (travel travels trip trips)
   (first-per-poss-pron my our)
   (first-per-pron I we)
   (syn-home home house place apartment)
   (meal dinner lunch brunch breakfast)
))


(READRULES '*holidays-activities-input*
'(
   ; Reciprocal question
   1 (0 what 2 you 0 ?)
      2 (What do I do for holidays ?) (0 :gist)
   1 (0 how 2 you 0 ?)
      2 (What do I do for holidays ?) (0 :gist)
   1 (0 what do 4 holidays 0 ?)
      2 (What do I do for holidays ?) (0 :gist)
   1 (0 what do 4 thanksgiving 0 ?)
      2 (What do I do for holidays ?) (0 :gist)

   ; Specific answer
   1 (0 get together 0) 
      2 ((On holidays you get together \.)  (Holidays-activities)) (0 :gist) 		
   1 (0 first-per-pron 2 gather 0) 
      2 ((On holidays you get together \.)  (Holidays-activities)) (0 :gist) 		
   1 (0 first-per-poss-pron 4 siblings 0) 
      2 ((On holidays you get together with your siblings \.)  (Holidays-activities)) (0 :gist) 		
   1 (0 first-per-poss-pron 4 family 0) 
      2 ((On holidays you get together with your 4 \.)  (Holidays-activities)) (0 :gist) 
   1 (0 join 2 family 0) 
      2 ((On holidays you get together with your 4 \.)  (Holidays-activities)) (0 :gist) 	
   1 (0 first-per-poss-pron syn-home 0) 
      2 ((On holidays you get together in your home \.)  (Holidays-activities)) (0 :gist) 
   1 (0 have 2 family over 0) 
      2 ((On holidays you get together in your home \.)  (Holidays-activities)) (0 :gist) 
   1 (0 invite 2 family over 0) 
      2 ((On holidays you get together in your home \.)  (Holidays-activities)) (0 :gist) 
   1 (0 family 2 come over 0) 
      2 ((On holidays you get together in your home \.)  (Holidays-activities)) (0 :gist) 

   1 (0 first-per-pron 3 invite 2 family 0) 
      2 ((On holidays you invite family members \.)  (Holidays-activities)) (0 :gist) 		
   1 (0 first-per-pron 3 invite 2 friends 0) 
      2 ((On holidays you invite friends \.)  (Holidays-activities)) (0 :gist) 

   1 (0 first-per-pron 3 meal 0)
      2 ((On holidays you have a meal \.)  (Holidays-activities))  (0 :gist)

   1 (0 first-per-pron 2 travel 0) 
      2 ((On holidays you travel \.)  (Holidays-activities)) (0 :gist) 

   1 (0)
      2 ((NIL gist \: Nothing found for what you do on holidays \.) (Holidays-activities)) (0 :gist)
))


(READRULES '*reaction-to-holidays-activities-input*
'(
   1 (0 on holidays 1 get together 3 0)
      2 (0 siblings 0)
         3 (That sounds fun\. It\'s always good to reuinite with family\.) (100 :out)
      2 (0 home 0)
         3 (That sounds fun\. It\'s nice to be able to have events at your own home and not have to go anywhere\.) (100 :out)
      2 (0 family 0)
         3 (0 grandchildren 0)
            4 (Oh\, that\'s so sweet to have your grandchildren around for holidays \.) (100 :out)
         3 (0)
            4 (It\'s always nice to get together with the family members\.)
      2 (0)
         3 (It\'s always nice to get together with the people you love\.) (100 :out)
   1 (0 on holidays 1 travel 0)
      2 (Travelling over the holidays sounds like a nice thing to look forward to\.) (100 :out)
   1 (0 on holidays 1 invite friends 0)
      2 (Having friends over is always fun\.) (100 :out)
   1 (0 on holidays 1 invite family 0)
      2 (Having family over is always fun\.) (100 :out)
   1 (0 on holidays 3 meal 0)
      2 (Having a tasty meal is always a good way to spend a holiday\!) (100 :out)
      
   1 (0 NIL gist 0)
      2 (I think the holidays are a great time to do things outside of the usual routine\.) (100 :out)
))
