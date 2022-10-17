;; (how do you spend your days ?)
;;	(spend-your-days)
;;		from-spend-your-days-input
;;			(0 I spend my days 0)
;;			gist-question:(3 how 2 you spend 1 days 0)

(MAPC 'ATTACHFEAT
'(
  (pet pets cat dog)
  (library)
  (friends friend)
	(NegMood boring bored)
  (lay laying lie lying)
))
    

(READRULES '*spend-your-days-input*
'(
  ; Reciprocal questions
  1 (0 what 2 you 0 ?)
    2 (How do I spend my days ?) (0 :gist)
  1 (0 how 2 you 0 ?)
    2 (How do I spend my days ?) (0 :gist)
  1 (0 wh_ 5 spend 0 ?)
    2 (How do I spend my days ?) (0 :gist)
  1 (0 what do you do 0 ?)
    2 (How do I spend my days ?) (0 :gist)		

  ; Specific input
  1 (0 exercise 0) 
    2 ((You spend your days doing some physical activities \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 garden 0) 
    2 ((You spend your days gardening \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 sew 0) 
    2 ((You spend your days 2 \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 water-related 0) 
    2 ((You spend your days doing a kind of water sport \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 play game 0) 
    2 ((You spend your days playing 3 \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 theater 0) 
    2 ((You spend your days going to theater \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 music 0) 
    2 ((You spend your days doing music related activities \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 sport 0) 
    2 ((You spend your days doing a sport \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 golf 0) 
    2 ((You spend your days playing golf \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 library 0)
    2 ((You spend your days going to library \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 read 0) 
    2 ((You spend your days reading \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 book clubs 0) 
    2 ((You spend your days reading \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 dance 0) 
    2 ((You spend your days dancing \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 friends 0) 
    2 ((You spend your days contacting friends \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 travel 0) 
    2 ((You spend your days traveling \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 cook 0) 
    2 ((You spend your days cooking \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 volunteer 0) 
    2 ((You spend your days volunteering \.)  (Spend-your-days)) (0 :gist) 		
  1 (0 grandchild 0) 
    2 ((You spend your days being with your grandchildren \.)  (Spend-your-days)) (0 :gist)
  1 (0 pet 0) 
    2 ((You spend your days with your pet \.)  (Spend-your-days)) (0 :gist)
  1 (0 coffee shop 0)
    2 ((You spend your days going to coffee shop \.)  (Spend-your-days)) (0 :gist)
	1 (0 NegMood 0)
    2 ((You spend your days in a boring way \.)  (Spend-your-days)) (0 :gist)
	1 (0 lay down 0)
    2 ((You spend your days laying down \.)  (Spend-your-days)) (0 :gist)
	1 (0 lay 2 bed 0)
    2 ((You spend your days laying down \.)  (Spend-your-days)) (0 :gist)

	1 (0)
     2 ((NIL gist \: Nothing found for how you spend your days \.)  (Spend-your-days)) (0 :gist)
))


(READRULES '*reaction-to-spend-your-days-input*
'(
  1 (0 physical activities 0)
    2 (It\'s good to spend some time on exercise or other physical activities regularly\.) (100 :out)
  1 (0 gardening 0)
    2 (Gardening is a good hobby\. It\'s nice to be outdoors\.) (100 :out)
  1 (0 sew 0)
    2 (That\'s nice\! Sewing is very practical hobby too\.) (100 :out)
  1 (0 water sport 0)
    2 (Water sports are fantastic\. I can\'t go in the water for obvious reasons\, but it looks fun\.) (100 :out)
  1 (0 playing game 0)
    2 (3 sounds like a fun game\.) (100 :out)
  1 (0 theater 0)
    2 (That\'s nice\. I like the theater too\.) (100 :out)
  1 (0 music 0)
    2 (That\'s great\! I like music too\.) (100 :out)
  1 (0 sport 0)
    2 (That sounds fun\. It\'s good to stay active\.) (100 :out)
  1 (0 golf 0)
    2 (That\'s great\. It\'s nice to spend time on the golf course\.) (100 :out)
  1 (0 reading 0)
    2 (It is so great to keep your mind busy by reading books or magazines\.) (100 :out)
  1 (0 dancing 0)
    2 (I love dancing \. It makes you feel young and energetic \.) (100 :out)
  1 (0 friends 0)
    2 (It\'s nice to talk with friends\. It helps me stay positive\.) (100 :out)
  1 (0 traveling 0)
    2 (I like traveling\. It\'s fun to see new places\.) (100 :out)
  1 (0 library 0)
    2 (Oh\, library is a good choice. You get to meet people in library\.) (100 :out)
  1 (0 cooking 0)
    2 (Cooking is really fun\! I like trying out new recipes\.) (100 :out)
  1 (0 volunteering 0)
    2 (Volunteering is nice\. It\'s good to give back to the community\.) (100 :out)
  1 (0 grandchildren 0)
    2 (It\'s nice to be with family\. I have heard grandchildren are especially fun\.) (100 :out)
  1 (0 pet 0)
    2 (It\'s nice to play and spend time with cute pets\. They are always entertaining\.) (100 :out)  
  1 (0 coffee shop 0)
    2 (I would love to go to coffee shops but I haven\'t had the chance to try much of them around\.) (100 :out) 
	1 (0 boring 0)
    2 (There are a lot of fun things you can do around \. Especially when the weather is nice\, you can spend time outside and enjoy the weather \.) (100 :out) 
	1 (0 laying down 0)
	  2 (There are a lot of fun things you can do around \. Especially when the weather is nice\, you can spend time outside and enjoy the weather \.) (100 :out) 

	1 (0 NIL gist 0)
     2 (There are a lot of fun things you can do around \. Especially when the weather is nice\, you can spend time outside and enjoy the weather \.) (100 :out) 
))
