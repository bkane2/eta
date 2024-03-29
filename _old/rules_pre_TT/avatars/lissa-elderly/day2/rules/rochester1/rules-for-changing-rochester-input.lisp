(MAPC 'ATTACHFEAT
'(
	(safety crime dangerous safe neighborhood neighborhoods ward safer)
  (anything nothing)
	(transportation bus buses)
	(weather cold snow snows snowy winter warmer temperature)
	(entertainments entertainment entertaining exciting)
	(modern new renovate)
))
       
 
(READRULES '*changing-rochester-input*
'(
	; Reciprocal questions
	1 (0 what 0 you 0 ?)
		2 (What would I change about rochester ?) (0 :gist)
	1 (0 how 0 you 0 ?)
		2 (What would I change about rochester ?) (0 :gist)

	; Specific answers
	1 (0 NEG 0 anything 0) 
		2 ((There is nothing that you would change in rochester \.)  (Rochester-enhancements)) (0 :gist)
	1 (0 no 0) 
		2 ((There is nothing that you would change in rochester \.)  (Rochester-enhancements)) (0 :gist)
	1 (0 not 1 really 0)  
		2 ((There is nothing that you would change in rochester \.)  (Rochester-enhancements)) (0 :gist)  
	1 (0 I wish 1 0) 
		2	((I would change it so that 4 \.) (Rochester-enhancements)) (0 :gist)
	1 (0 entertainment 0)  
		2 ((You would change it by adding some entertainments \.) (Rochester-enhancements)) (0 :gist)
	1 (0 weather 0)
		2 ((You would change the weather in rochester \.) (Rochester-enhancements)) (0 :gist)    
	1 (0 spring 0)
		2 ((You would change the weather in rochester \.) (Rochester-enhancements)) (0 :gist)    
	1 (0 safety 0) 
		2 ((You would change rochester to be safer \.) (Rochester-enhancements)) (0 :gist)
	1 (0 transportation 0) 
		2 ((You would change the transportation system in rochester \.)  (Rochester-enhancements)) (0 :gist)
	1 (0 modern 0) 
		2 ((You would change the old things in rochester \.)  (Rochester-enhancements)) (0 :gist)
	1 (0 no opinion 0) 
		2 ((You have no opinion about what you would change in rochester \.)  (Rochester-enhancements)) (0 :gist)
	1 (0 like everything 0) 
		2 ((There is nothing that you would change in rochester \.) (Rochester-enhancements)) (0 :gist)
	1 (0 everything 2 nice 0) 
		2 ((There is nothing that you would change in rochester \.) (Rochester-enhancements)) (0 :gist)  

	1 (0) 
		2 ((NIL gist \: Nothing found for what you would change in rochester \.) (Rochester-enhancements)) (0 :gist)
))
	

(READRULES '*reaction-to-changing-rochester-input*  
'(
	1 (0 nothing that you would change 0)
		2 (It\'s good to be content with how things are\.) (100 :out)
	1 (0 change it so that 0)
		2 (That sounds like it would be nice\.) (100 :out)
	1 (0 entertainments 0)
		2 (Yeah\, it can get quiet here\. It\'s good to have hobbies to keep myself occupied\.) (100 :out)
	1 (0 weather 0)
		2 (Not much we can do about it\. It is a snowy place\! Try to stay warm\!) (100 :out)
	1 (0 safer 0)
		2 (I hope all neighborhoods of the city gets safe enough soon\. Be sure to stay safe\.) (100 :out)
	1 (0 transportation 0)
		2 (It is hard to get around sometimes\.) (100 :out)
	1 (0 old things 0)
		2 (Things do change\, don\'t they\?) (100 :out)
	1 (0 no opinion 0)
		2 (Okay\, it\'s good to be generally content\.) (100 :out)
		
	1 (0 NIL gist 0)
		2 (Right\. Every place has its own pros and cons \.) (100 :out)
)); end of *reaction-to-changing-rochester-input*
	  
