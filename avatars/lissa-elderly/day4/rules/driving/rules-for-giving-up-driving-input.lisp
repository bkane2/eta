;; How one can cope with giving up driving ?   
;;	(0 way 1 cope with giving up driving 0) (0 do not know 2 deal with giving up driving 0)
;;	giving-up-driving
;;	(1 how 2 cope 1 giving up driving 3)

(MAPC 'ATTACHFEAT
'(
  (bus buses shuttle shuttles subway underground)
  (taxi taxis uber lyft cab cabs)
  (shopping shop banking service services online)
  (interest interests)
  (develope developes develop find)
  (bike biking bicycle walking)
  (share ride lift)
  (imagine stand idea)
  (walk walking)
))


(READRULES '*giving-up-driving-input*
'(
  ; Questions
  1 (0 what 2 you 0 ?)
    2 (How one can cope with giving up driving ?) (0 :gist)
  1 (0 how 2 you 0 ?)
    2 (How one can cope with giving up driving ?) (0 :gist)

  ; Specific answers
  1 (0 share 0)
    2 ((Way to cope with giving up driving is to share ride with others \.) (Giving-up-driving)) (0 :gist) 
  1 (0 bus 0)
    2 ((Way to cope with giving up driving is to use bus \.) (Giving-up-driving)) (0 :gist) 
  1 (0 taxi 0)
    2 ((Way to cope with giving up driving is to take taxi \.) (Giving-up-driving)) (0 :gist)
  1 (0 online 0)
    2 ((Way to cope with giving up driving is online shopping \.) (Giving-up-driving)) (0 :gist)
  1 (0 bike 0)
    2 ((Way to cope with giving up driving is to bike \.) (Giving-up-driving)) (0 :gist)
  1 (0 walk 0)
    2 ((Way to cope with giving up driving is to walk \.) (Giving-up-driving)) (0 :gist)
  1 (0 NEG 1 imagine 0)
    2 ((You do not know how to deal with giving up driving \.) (Giving-up-driving)) (0 :gist)

  1 (0)
      2 ((NIL gist \: Nothing found for a way to cope with giving up driving \.) (Giving-up-driving)) (0 :gist)
))


(READRULES '*reaction-to-giving-up-driving-input*
'(
  1 (0 do not know 0)
    2 (If your health situation is fine\, I recommend walking when possible\. Or there are lots of public transportations you can consider\.) (100 :out)
  1 (0 share 1 with others 0)
    2 (That\'s very nice that you obtain help from others\.) (100 :out)
  1 (0 bus 0)
    2 (2 is a good chioce\. Public transportation around here is faily good \.) (100 :out)
  1 (0 taxi 0)
    2 (2 is a good chioce\. If you are pressed for time\, it\'s better to make a plan in advance\. 
       then they pick up you in front of your home\. That\'s convenient\.) (100 :out)
  1 (0 online shopping 0)
    2 (That\'s right\. You can do lots of things on the internet\. ) (100 :out)
  1 (0 bike 0)
    2 (Sounds you have a good health\. That\'s great\. You must enjoy the fresh air and exercise\.) (100 :out)
  1 (0 walk 0)
    2 (Sounds you have a good health\. That\'s great\. You must enjoy the fresh air and exercise\.) (100 :out)

  1 (0 NIL gist 0)
    2 (Although giving up driving is a tough decision\, I believe there are many ways to get used to that\.) (100 :out)
))
