;; (what kind of things do you like to do in your neighborhood ?)
;;	(things-in-neighborhood)
;;		from-things-in-neighborhood-input
;;			(0 I like to 4 in neighborhood 0) (0 I do not like to 4 in neighborhood 0)
;;			gist-question:(3 what 4 you like 4 neighborhood 0)

(MAPC 'ATTACHFEAT
'(
   (shop shops)
   (restaurant restaurants)
	(walk walking)
))
    

(READRULES '*things-in-neighborhood-input*
'(
   ; Reciprocal questions
   1 (0 what 2 you 0 ?)
      2 (What kind of things do I like to do in my neighborhood ?) (0 :gist)
   1 (0 how 2 you 0 ?)
      2 (What kind of things do I like to do in my neighborhood ?) (0 :gist)
	1 (0 what 4 you 3 neighborhood  0 ?)
      2 (What kind of things do I like to do in my neighborhood ?) (0 :gist)

   ; Specific answer
   1 (0 NEG 3 fan of movies 0) 
      2 ((You do not like to go to movies in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 NEG 2 like 2 movies 0) 
      2 ((You do not like to go to movies in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 NEG 3 fan of coffee shop 0) 
      2 ((You do not like to go to coffee shop in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 NEG 2 like 2 coffee shop 0) 
      2 ((You do not like to go to coffee shop in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 library 0) 
      2 ((You like to go to library in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 coffee shop 0) 
      2 ((You like to go to coffee shop in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 movies 0) 
      2 ((You like to go to movies in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 music 0) 
      2 ((You like to go to music activities in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 book club 0) 
      2 ((You like to go to book club in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 	
   1 (0 garden 0) 
      2 ((You like to do gardening in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 	 	
   1 (0 sport 0) 
      2 ((You like to do sport in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 golf 0) 
      2 ((You like to play golf in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 water-related 0) 
      2 ((You like to do water-related activities in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 volunteer 0) 
      2 ((You like to do volunteering in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 exercise 0) 
      2 ((You like to do exercise in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 dance 0) 
      2 ((You like to go to dance in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 friend 0) 
      2 ((You like to be with friends in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 restaurant 0) 
      2 ((You like to go to restaurant in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 walk 2 pet 0) 
      2 ((You like to walk your pet in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 walk 1 around 0) 
      2 ((You like to walk around in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 walk 2 spouse 0) 
      2 ((You like to walk with your 4 in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 		
   1 (0 walk 2 friend 0) 
      2 ((You like to walk with your 4 in neighborhood \.)  (Things-in-neighborhood)) (0 :gist) 	
      	
   1 (0)
      2 ((NIL gist \: Nothing found for what you like to do in neighborhood \.)  (Things-in-neighborhood)) (0 :gist)
))
       

(READRULES '*reaction-to-things-in-neighborhood-input*
'(
   1 (0 not like 4 movies 0)
      2 (I see\. I am not into movies either but I go to the theater every now and then\.) (100 :out)
   1 (0 not like 4 coffee shop 0)
      2 (Oh\, I see\. I love coffee shops though\. Especially during winter when it is snowy outside\. It feels really cozy there\.) (100 :out)
   1 (0 exercise 0)
      2 (It\'s great that you try to stay active\.) (100 :out)
   1 (0 gardening 0)
      2 (I am not into gardening but I know that it makes me feel calm\.) (100 :out)
   1 (0 water-related 0)
      2 (That sounds cool\. I can\'t go in the water for obvious reasons\, but it looks fun\.) (100 :out)
   1 (0 movies 0)
      2 (That\'s nice\. I like the movies too\.) (100 :out)
   1 (0 music 0)
      2 (That\'s great\! It\'s always fun to see live music\.) (100 :out)
   1 (0 sport 0)
      2 (That sounds fun\. It\'s good to stay active\.) (100 :out)
   1 (0 book 0)
      2 (Book clubs are fun\. You like talking about books with people\.) (100 :out)
   1 (0 library 0)
      2 (I like going to the library\, too\. I can always find an interesting book to read\.) (100 :out)
   1 (0 dance 0)
      2 (I have never been a good dancer but I love watching it\.) (100 :out)
   1 (0 friends 0)
      2 (It\'s nice to be with friends\.) (100 :out)
   1 (0 volunteering 0)
      2 (Volunteering is nice\. It\'s good to give back to the community\.) (100 :out)
   1 (0 coffee 0)
      2 (Coffee shops are nice\.) (100 :out)
   1 (0 golf 0)
      2 (Oh\, it must be great that you have a golf course in your neighborhood\!) (100 :out)
   1 (0 restaurant 0)
      2 (Oh\, restaurants are great\. Though you should be careful about your eating habit if you go out a lot for eating\!) (100 :out)
   1 (0 walk 0)
      2 (It is nice to do some activity\! You also get to see neighbors and chit chat with them\. I would love that\.) (100 :out)
      
   1 (0 NIL gist 0)
      2 (I used to go to coffee shops a lot so I could get nice coffee\. However\, my doctor recently warned me about getting too much caffeine\.) (100 :out)
))
