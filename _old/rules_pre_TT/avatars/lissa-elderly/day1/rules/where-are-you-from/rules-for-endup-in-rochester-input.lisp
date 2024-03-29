;; (how did you end up in rochester ?)
;;	(endup-in-rochester)
;;		from-endup-in-rochester-input
;;			(0 I ended up in Rochester 0)
;;			gist-question:(3 how 2 end up in Rochester 0)

(MAPC 'ATTACHFEAT
'(
   (work-related recruited job working work company)
   (family-member family parents son daughter sister brother)
   (school college RIT University studying study) 
))
;(WORK WORKING WORKED JOB JOBS)  already have it


(READRULES '*endup-in-rochester-input*
'(
   ; Specific answer
   1 (0 I 2 born 1 rochester 0) 
      2 ((You ended up in rochester since it is your hometown  \.)  (Endup-in-rochester)) (0 :gist)
   1 (0 rochester 3 home 0) 
      2 ((You ended up in rochester since it is your hometown  \.)  (Endup-in-rochester)) (0 :gist)
   1 (0 rochester 3 hometown 0) 
      2 ((You ended up in rochester since it is your hometown  \.)  (Endup-in-rochester)) (0 :gist)
   1 (0 I 2 from rochester 0) 
      2 ((You ended up in rochester since it is your hometown  \.)  (Endup-in-rochester)) (0 :gist)
   1 (0 I 4 rochesterian 0) 
      2 ((You ended up in rochester since it is your hometown  \.)  (Endup-in-rochester)) (0 :gist)
   1 (0 parents 2 here 0) 
      2 ((You ended up in rochester since your parents live here  \.)  (Endup-in-rochester)) (0 :gist)
   1 (0 family-member 0) 
      2 ((You ended up in rochester since your family live here  \.)  (Endup-in-rochester)) (0 :gist)
   1 (0 school 0)
      2 ((You ended up in rochester because of going to school \.) (Endup-in-rochester)) (0 :gist)
   1 (0 work-related 0)
      2 (0 SELF 3 work-related 0)
         3 ((You ended up in rochester for your job \.)  (Endup-in-rochester)) (0 :gist)	 
      2 (0)
         3 ((You ended up in rochester since you had job related reasons \.)  (Endup-in-rochester)) (0 :gist)	 
   1 (0 met 2 husband 4 rochester 0) 
      2 ((You ended up in rochester since you married here  \.)  (Endup-in-rochester)) (0 :gist)
   1 (0 met 2 husband 4 here 0) 
      2 ((You ended up in rochester since you married here  \.)  (Endup-in-rochester)) (0 :gist)
   1 (0 married 4 rochester 0) 
      2 ((You ended up in rochester since you married here  \.)  (Endup-in-rochester)) (0 :gist)
   1 (0 married 4 here 0) 
      2 ((You ended up in rochester since you married here  \.)  (Endup-in-rochester)) (0 :gist)

   1 (0)
      2 ((NIL gist \: Nothing found for how ended up in rochester \.) (Endup-in-rochester)) (0 :gist)
))
      

(READRULES '*reaction-to-endup-in-rochester-input*
'(
   1 (0 hometown 0)
      2 (It must really be your home\.) (100 :out)
   1 (0 parents 0)
      2 (So you have roots here\.) (100 :out)
   1 (0 school 0)
      2 (Rochester has at least two good universities and a bunch of colleges\. A lot of people move to rochester to either study or work at these schools \.) (100 :out)
   1 (0 family 0)
      2 (It is great to have the opportunity to live close to your family \.) (100 :out)
   1 (0 job 0)
      2 (It must have been exciting to move to a new place for work\.) (100 :out)	
   1 (0 married 0)
      2 (That\'s nice\. It must have been exciting to move somewhere new after getting married\.) (100 :out)
      
   1 (0 NIL gist 0)
      2 (Oh\, okay\.) (100 :out)
))
