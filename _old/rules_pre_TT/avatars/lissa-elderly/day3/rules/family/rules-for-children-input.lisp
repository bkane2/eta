;; (Do you have children or grandchildren ?)
;;	(children)
;;		from-children-input
;;			(0 I have 2 child 0) (I have 2 grandchild  0)
;;			gist-question:(3 do you have children 0)

(MAPC 'ATTACHFEAT
'(
   (first-per-pron I we)
   (child children son daughter sons  daughters )
   (grandchild grandchildren grandkid grandkids grandson granddaughter grandsons granddaughters)
   (few a one two three four five six seven eight nine ten eleven)
   (boy boys)
   (girl girls)
))


(READRULES '*children-input*
'( 
   ; Reciprocal questions
   1 (0 what 2 you 0 ?)
      2 (Do I have any children or grandchildren ?) (0 :gist)
   1 (0 how 2 you 0 ?)
      2 (Do I have any children or grandchildren ?) (0 :gist)
	1 (0 do you 4 children 0 ?)
      2 (Do I have any children or grandchildren ?) (0 :gist)

   ; Specific answers
   1 (No first-per-pron 2 NEG 0) 
      2 ((You have no children \.)  (Children)) (0 :gist) 		
   1 (0 no child 0)
      2 ((You have no 3 \.) (Children)) (0 :gist)
   1 (0 no grandchild 0)
      2 ((You have no 3 \.) (Children)) (0 :gist)  		
   1 (0 NEG 1 any child 0)
      2 ((You have no 5 \.) (Children)) (0 :gist)
   1 (0 NEG 1 any 3 grandchild 0)
      2 ((You have no 6 \.) (Children)) (0 :gist)  		
   ;; this one makes "i have a son". from where? I dont know?
   1 (0 first-per-pron have 1 few 3 child 0) 
      2 ((You have 5 7 \.)  (Children)) (0 :gist) 		
   1 (0 first-per-pron have 1 few 3 grandchild 0) 
      2 ((You have 5 7 \.)  (Children)) (0 :gist) 		  		    
   1 (0 first-per-pron have no child 0) 
      2 ((You have no 5 \.)  (Children)) (0 :gist) 		
   1 (0 first-per-pron do not have 1 child 0) 
      2 ((You have no 7 \.)  (Children)) (0 :gist) 		
   
   1 (0 first-per-pron have no grandchild 0) 
      2 ((You have no 5 \.)  (Children)) (0 :gist) 		
   1 (0 first-per-pron do not have 1 grandchild 0) 
      2 ((You have no 7 \.)  (Children)) (0 :gist) 		
   
   1 (1 Yes 0) 
      2 ((You have children \.)  (Children)) (0 :gist) 		
   1 (1 first-per-pron do 0) 
      2 ((You have children \.)  (Children)) (0 :gist) 		
   
   1 (0 my 1 child 0) 
      2 ((You have at least a 4 \.)  (Children)) (0 :gist) 		
   1 (0 my 1 grandchild 0) 
      2 ((You have at least a 4 \.)  (Children)) (0 :gist) 	

   1 (0)
      2 ((NIL gist \: Nothing found for if you have any children or grandchildren \.) (Children)) (0 :gist)
))
       
       
(READRULES '*thematic-children-input*
'(
   1 (0 first-per-pron have 2 children 4 few boy 0)
      2 ((You have 7 sons \.)  (Children)) (0 :gist)
   1 (0 first-per-pron have 2 children 4 few girl 0)
      2 ((You have 7 daughters \.)  (Children)) (0 :gist)
   1 (0 first-per-pron have 2 grandchildren 4 few boys 0)
      2 ((You have 7 grandsons \.)  (Children)) (0 :gist)
   1 (0 first-per-pron have 2 grandchildren 4 few girl 0)
      2 ((You have 7 granddaughters \.)  (Children)) (0 :gist)
))

		
(READRULES '*reaction-to-children-input*
'(
   1 (0 no 0)
      2 (Oh\, okay! I do have two girls but no grandchildren \.) (100 :out)
   1 (0 child 0)
      2 (It must\'ve been nice raising children\.) (100 :out)
   1 (0 grandchild 0)
      2 (It must be wonderful having grandchildren\.) (100 :out)

   1 (0 NIL gist 0)
       2 (Oh\, okay! I do have two girls but no grandchildren \.) (100 :out)
))
