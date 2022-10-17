; This is a small trial pattern base for reacting to the user's
; answer concerning what s/he likes about Rochester.

; We also provide features, supplementing the generic ones in
; "general-word-data.lisp", relevant to the topic here.

(MAPC 'ATTACHFEAT
'(
  ;; (many five six seven eight nine ten eleven twelve thirteen fourteen
  ;;   fifteen sixteen seventeen eighteen nineteen twenty)
	(several_ two three four)	   
  (month months)
		  
	(few a one two three four five six seven eight nine ten eleven)
  (many twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty)
  (lots thirty forty fifty sixty seventy eighty ninety hundred)	  	  
))    


(READRULES '*how-long-in-rochester-input*
'(
  ; Reciprocal questions
  1 (0 what about 0 you 0 ?)
	  2 (How long have I been here in rochester ?) (0 :gist)
  1 (0 how about 0 you 0 ?)
    2 (How long have I been here in rochester ?) (0 :gist)
	1 (0 how long 2 been 0 in Rochester 0 ?)
    2 (How long have I been here in rochester ?) (0 :gist)

  ; Specific answers
  1 (0 life 0)
    2 ((You have been in rochester your whole life \.) (Time-in-rochester)) (0 :gist)
  1 (0 few years 0)
    2 (0 lots 1 years 0)
	    3 ((You have been in rochester for more than 2 years \.) (Time-in-rochester)) (0 :gist)
    2 (0 few years 0)
	    3 ((You have been in rochester for 2 years \.) (Time-in-rochester)) (0 :gist)
  1 (0 many years 0)
    2 ((You have been in rochester for 2 years \.) (Time-in-rochester)) (0 :gist)
  1 (0 several_ years 0)
    2 ((You have been in rochester for 2 years \.) (Time-in-rochester)) (0 :gist)
  1 (0 years 0)
    2 ((You have been in rochester for several years \.) (Time-in-rochester)) (0 :gist)
  1 (0 year 0)
    2 ((You have been in rochester for almost a year \.) (Time-in-rochester)) (0 :gist)
  1 (0 month 0)
    2 ((You have been in rochester for several months \.) (Time-in-rochester)) (0 :gist)

  1 (0) 
	  2 ((NIL gist \: Nothing found for how long you have been in rochester \.) (Time-in-rochester)) (0 :gist)
))


(READRULES '*reaction-to-how-long-in-rochester-input*  
'(
  1 (0 whole life 0)
    2 (Wow\, that is longer than I have been anywhere\!) (100 :out)
  1 (0 many years 0)
    2 (Wow\, that is longer than I have been anywhere\!) (100 :out)
  1 (0 lots years 0)
    2 (Wow\, that is longer than I have been anywhere\!) (100 :out)
  1 (0 several years 0)
    2 (So you have been here for a while\.) (100 :out)
  1 (0 few years 0)
    2 (So you have been here for a while\.) (100 :out)
  1 (0 a year 0)
    2 (So you are pretty new here\.) (100 :out)
    
	1 (0 NIL gist 0)
    2 (So you know something about rochester\.) (100 :out)
)); end of *reaction-to-how-long-in-rochester-input*

