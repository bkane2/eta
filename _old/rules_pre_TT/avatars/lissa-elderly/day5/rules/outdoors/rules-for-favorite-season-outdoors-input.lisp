;; What is your favorite season to be outdoors?
;;	(0 favorite season 2 outdoors is 0)  (0 I do not like to be outdoors 0)
;;   favorite-season-outdoors
;;	(2 What 2 favorite season 2 outdoors 2)

(MAPC 'ATTACHFEAT
'(
   (autumn fall)
   (degree-serious too over strong very really)
   (warm mild)
   (cold chilly)
   (snow snowy)
   (wind winds windy)
   (rains rain raining rainy)
))


(READRULES '*favorite-season-outdoors-input*
'(
   ; Questions
   1 (0 what 2 you 0 ?)
      2 (What is my favorite season to be outdoors ?) (0 :gist)
   1 (0 how 2 you 0 ?)
      2 (What is my favorite season to be outdoors ?) (0 :gist)
   1 (2 What 2 favorite season 2 outdoors 2 ?)
      2 (What is my favorite season to be outdoors ?) (0 :gist)

   ; Specific answers
   1 (0 spring 0) 
      2 ((Your favorite season to be outdoors is 2 \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (0 summer 0) 
      2 ((Your favorite season to be outdoors is 2 \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (0 autumn 0) 
      2 ((Your favorite season to be outdoors is fall \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (0 winter 0) 
      2 ((Your favorite season to be outdoors is 2 \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (0 is warm 0) 
      2 ((Your favorite season to be outdoors is 3 \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (1 NEG 1 hot 0)  ;; is not very hot
      2 ((Your favorite season to be outdoors 1 not 4 \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (1 NEG 1 cold 0) 
      2 ((Your favorite season to be outdoors 1 not 4 \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (1 NEG 1 dry 0) 
      2 ((Your favorite season to be outdoors 1 not 4 \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (1 NEG 1 wet 0) 
      2 ((Your favorite season to be outdoors 1 not 4 \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (1 NEG 1 extreme 0) 
      2 ((Your favorite season to be outdoors 1 not 4 \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (1 NEG 2 wind 0) ;; don't have much winds/snow
      2 ((Your favorite season to be outdoors 1 not 4 \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (1 NEG 2 snow 0) 
      2 ((Your favorite season to be outdoors 1 not 4 \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (1 NEG 2 rain 0) 
      2 ((Your favorite season to be outdoors 1 not 4 \.)  (Favorite-season-outdoors)) (0 :gist)
   1 (1 NEG 5 spring 0) ;; I don't like to be outdoors in spring
      2 ((Your favorite season to be outdoors is not 4 \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (1 NEG 5 summer 0) 
      2 ((Your favorite season to be outdoors is not 4 \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (1 NEG 5 autumn 0) 
      2 ((Your favorite season to be outdoors is not 4 \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (1 NEG 5 winter 0) 
      2 ((Your favorite season to be outdoors is not 4 \.)  (Favorite-season-outdoors)) (0 :gist) 
   1 (1 NEG 1 like 2 outdoors 0) 
      2 ((You do not like to be outdoors \.)  (Favorite-season-outdoors)) (0 :gist) 

   1 (0)
      2 ((NIL gist \: Nothing found for what your favorite season to be outdoors is \.) (Favorite-season-outdoors)) (0 :gist)
))


(READRULES '*reaction-to-favorite-season-outdoors-input*
'(
   1 (0 spring 0)
      2 (Spring in rochester is kind of chilly\, but I generally like the weather and would go outdoors\. ) (100 :out)
   1 (0 summer 0)
      2 (Rochester\'s summer can be hot in the end of august\, but it\'s generally nice\. ) (100 :out)
   1 (0 autumn 0)
      2 (Leaves turn red and yellow in fall\. They are gorgeous\. I enjoy the scene a lot when I am exercising\.) (100 :out)
   1 (0 winter 0)
      2 (The weather can get very snowy and cold in rochester\, so in winter I don\'t go out as much as I do in summer or autumn\.) (100 :out)
   1 (0 neg hot 0)
      2 (I like weather that isn\'t very hot because I don\'t want to be sweaty\. ) (100 :out)
   1 (0 warm 0)
      2 (Warm weather makes it so tempting to go outdoors\. ) (100 :out)
   1 (0 neg cold 0)
      2 (Weathers that are not too cold are good for doing outdoor activities\. ) (100 :out)
   1 (0 neg dry 0)
      2 (I need to drink a lot of water if I go outdoors in dry weather\. ) (100 :out)
   1 (0 neg wet 0)
      2 (It will be difficult to go outdoors in wet weather\. ) (100 :out)
   1 (0 neg extreme 0)
      2 (Going out in an extreme weather might trigger potential dangers\. ) (100 :out)
   1 (0 neg winds 0)
      2 (Walking in windy weathers are nice\, but I don\'t want to do strenuous exercises when it is windy\. ) (100 :out)
   1 (0 neg snow 0)
      2 (Rochester\'s snow can be very heavy sometimes\. I just want to stay indoors when that happens\.) (100 :out)
   1 (0 neg rain 0)
      2 (Raining can make outdoor exercises very hard\. ) (100 :out)
   1 (0 neg 1 like 2 outdoors 0)
      2 (Oh\, I love to spend time outdoors\, especially during summer\!) (100 :out)
      
   1 (0 NIL gist 0)
      2 (I like it when it\'s warm outside\, though the snow can be beautiful sometimes\.) (100 :out)
))
