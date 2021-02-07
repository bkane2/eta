;; (Do you live by yourself or with others ?)
;;	(live-alone)
;;		from-live-alone-input
;;			(0 I live by myself 0) (0 I live with  0)
;;			gist-question:(3 do you live 2 yourself 0)

(MAPC 'ATTACHFEAT
'(
   (live living)
   (spouse husband wife)
	(mother mom)
	(father dad)
))


(READRULES '*live-alone-input*
'(
   ; Reciprocal questions
   1 (0 what 2 you 0 ?)
      2 (Do I live by myself ?) (0 :gist)
   1 (0 how 2 you 0 ?)
      2 (Do I live by myself ?) (0 :gist)
	1 (0 do you live 0 ?)
      2 (Do I live by myself ?) (0 :gist)

   ; Specific answers
   1 (0 by myself 0) 
      2 ((You live by yourself \.)  (Live-alone)) (0 :gist) 		
   1 (0 live alone 0) 
      2 ((You live by yourself \.)  (Live-alone)) (0 :gist) 		
   1 (0 live 2 family 0) 
      2 ((You live with your family \.)  (Live-alone)) (0 :gist) 		
   1 (0 live 2 spouse 0) 
      2 ((You live with your spouse \.)  (Live-alone)) (0 :gist) 		
   1 (0 spouse 3 live 0) 
      2 ((You live with your spouse \.)  (Live-alone)) (0 :gist) 		
   1 (0 live 2 partner 0) 
      2 ((You live with your partner \.)  (Live-alone)) (0 :gist) 		
   1 (0 live 2 child 0) 
      2 ((You live with your children \.)  (Live-alone)) (0 :gist) 		
   1 (0 children 3 live 0) 
      2 ((You live with your children \.)  (Live-alone)) (0 :gist) 		
   1 (0 live 2 mother 0) 
      2 ((You live with your mother \.)  (Live-alone)) (0 :gist) 		
   1 (0 mother 3 live 0) 
      2 ((You live with your mother \.)  (Live-alone)) (0 :gist) 		
   1 (0 live 2 friend 0) 
      2 ((You live with your friend \.)  (Live-alone)) (0 :gist) 		
   1 (0 friend 3 live 0) 
      2 ((You live with your mother \.)  (Live-alone)) (0 :gist) 		
   1 (0 live 2 bg-friend 0) 
      2 ((You live with your 4 \.)  (Live-alone)) (0 :gist) 		
   1 (0 bg-friend 3 live 0) 
      2 ((You live with your 4 \.)  (Live-alone)) (0 :gist) 		

   1 (0)
      2 ((NIL gist \: Nothing found for who you live with \.) (Live-alone)) (0 :gist)
))


(READRULES '*reaction-to-live-alone-input*
'(
   1 (0 yourself 0)	
      2 (Lots of people live alone\. There are good things about having your own space\.) (100 :out)
   1 (0 spouse 0)
      2 (It\'s good you live together and can look out for each other\.) (100 :out)
   1 (0 partner 0)
      2 (It\'s good you live together and can look out for each other\.) (100 :out)
   1 (0 family 0)
      2 (It\'s good to live with your family\. They must be nice\.) (100 :out)
   1 (0 child 0)
      2 (It\'s good to live with your children\. They must be nice\.) (100 :out)
   1 (0 friend 0)
      2 (It is nice to live with a good friend \.) (100 :out)
   1 (0 bg-friend 0)
      2 (Oh\, that\'s cool \.) (100 :out)
   1 (0 mother 0)
      2 (That\'s nice\. I have never lived with my parents since I got married\. Sometimes I miss them a lot\.) (100 :out)

   1 (0 NIL gist 0)
      2 (I find that some people prefer to live alone\, and some with others\. It really just depends on preference\.) (100 :out)
))
