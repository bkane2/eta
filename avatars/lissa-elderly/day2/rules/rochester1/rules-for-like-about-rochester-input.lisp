; This is a small trial pattern base for reacting to the user's
; answer concerning what s/he likes about Rochester.

; We also provide features, supplementing the generic ones in
; "general-word-data.lisp", relevant to the topic here.
 
(MAPC 'ATTACHFEAT
'(
   (nature park parks green tree trees hiking hike trail trails)
   (social-environment people community university)
   (weather cold snow snows snowy winter)
   (urban-life streets)
   (much many)
   (culture art museum music)
   (nice good great nice-food)
   (nice-food delicious tasty)
   (cuisine food restaurant eating)
   (restaurant restaurants diner diners)
   (food foods garbage)
))

;; N.B.: FOR THE DECLARATIVE GIST CLAUSES OBTAINED FROM THE USER'S 
;;       RESPONSE TO A LISSA QUESTION, EACH OUTPUT FROM THE CORRESPONDING 
;;       CHOICE PACKETS (DIRECTLY BELOW) MUST BE OF FORM 
;;          (WORD-DIGIT-LIST KEY-LIST), E.G.,
;;          ((My favorite class was 2 3 \.) (favorite-class))
;;       BY CONTRAST, QUESTIONS OBTAINED FROM THE USER RESPONSES,
;;       AND LISSA REACTIONS TO USER RESPONSES, CURRENTLY CONSIST
;;       JUST OF A WORD-DIGIT LIST, WITHOUT A KEY LIST.

 
(READRULES '*like-about-rochester-input*
'(
   ; Reciprocal questions
   1 (0 what 0 you 0 ?)
		2 (What do I like about rochester ?) (0 :gist)
   1 (0 how 0 you 0 ?)
      2 (What do I like about rochester ?) (0 :gist)
	1 (0 what 0 you like 0 ?)
      2 (What do I like about rochester ?) (0 :gist)

   ; Specific answers
   1 (0 like 3 weather 0)
      2 ((You like the weather in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 weather 2 nice 0)
      2 ((You like the weather in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 weather 0)
      2 ((You like the weather in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 not 5 much 0)
      2 ((No opinion about what you like in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 much 3 city 0)
      2 ((No opinion about what you like in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 not 1 around 0)
      2 ((No opinion about what you like in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 like 3 cuisine 0) ;;;;;;;;;;;;;;;
      2 ((You like eating in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 cuisine 3 nice 0) 
      2 (0 restaurant 0)
         3 ((You like some restaurants in rochester \.) (Like-rochester)) (0 :gist)
      2 (0 food 0)
         3 ((You like some foods in rochester \.) (Like-rochester)) (0 :gist)   
   1 (0 nice 3 cuisine 0) 
      2 (0 restaurant 0)
         3 ((You like some restaurants in rochester \.) (Like-rochester)) (0 :gist)
      2 (0 food 0)
         3 ((You like some foods in rochester \.) (Like-rochester)) (0 :gist)   
   1 (0 social-environment 0)
      2 ((You like 2 in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 culture 0) 
      2 ((You like 2 in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 urban-life 0) 
      2 ((You like 2 in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 festivals 0) 
      2 ((You like festivals in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 nature 0) 
      2 ((You like the nature in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 NEG 2 traffic 0) 
      2 ((You like that there is no traffic in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 NEG 2 traffic 0) 
      2 ((You like that there is no traffic in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 amenities 0) 
      2 ((You like that there are all amenities in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 like everything 0) 
      2 ((You like everything in rochester \.) (Like-rochester)) (0 :gist)
   1 (0 everything 2 nice 0) 
      2 ((You like everything in rochester \.) (Like-rochester)) (0 :gist)  

   ; Unbidden answers
   1 (0 not like 3 weather)
	   2 ((You do not like the weather in rochester \.) (Not-like-rochester)) (0 :gist)
	1 (0 weather 2 not nice 0)
		2 ((You do not like the weather in rochester \.) (Not-like-rochester)) (0 :gist)

   1 (0) 
      2 ((NIL gist \: Nothing found for what you like in rochester \.) (Like-rochester)) (0 :gist)
))
 
 
(READRULES '*reaction-to-like-about-rochester-input*  
'(
   1 (0 you like 0 \.)
      2 (0 weather 0)
	      3 (Really? I wish it would be warmer in the winter\.) (100 :out)
      2 (0 cuisine 0)
	      3 (So you should be a fan of eating\.) (100 :out) ; Aren't we all!
      2 (0 culture 0)
	      3 (So you care about culture\, rochester is good for that\.) (100 :out)
      2 (0 social-environment 0)	
	      3 (I also like the social environment\.) (100 :out)
      2 (0 urban-life 0)
         3 (I also like the city and streets\.) (100 :out)
      2 (0 festivals 0)
         3 (I love festivals too\. They are so fun\.) (100 :out)
      2 (0 nature 0)
         3 (I also like that every place is so green during summer and colorful during winter\. It is just so beatiful\.) (100 :out)
   1 (0 no traffic 0)
      2 (Having not much traffic in rochester is just great\. I lived in new york city for a few months and the traffic made me nuts\!) (100 :out)
   1 (0 all amenities 0)
      2 (I agree that rochester is a nice city to live \. You can find whatever amenity you would want for life \.) (100 :out)
   1 (0 like everything 0)
      2 (I agree that rochester is a nice city to live \. You can find whatever amenity you would want for life \.) (100 :out)
   1 (0 no opinion 0)
      2 (I am sure you would find many interesting things here if you go around\.) (100 :out)

   1 (0 NIL gist 0)
      2 (I see\!) (100 :out)	
)); end of *reaction-to-like-about-rochester-input*
