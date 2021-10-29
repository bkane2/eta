;;  What are some ways you manage your money? For example, tell me about 
;;	some of your strategies to pay bills on time or strategies for saving money.
;;	gist: What are some ways you manage your money ?
;;	(0 way 3 manage 1 money 0)
;;	manage-money-ways
;;	(2 What 2 ways 1 manage 1 money 2)

(MAPC 'ATTACHFEAT
'(
  (budget plan planning)
  (advisor advisors consultant consultants)
  (credit card report)
  (software app apps)
  (family grandchildren grandchild children child daughter daughters son sons spouse wife husband siblings brother brothers sister sisters
    parents mother father grandparents grandmother grandfather cousin cousins uncle aunt)
))
  

(READRULES '*manage-money-ways-input*
'(
  ; Questions
  1 (0 how 1 you 1 make money ?)
    2 (How can I make money ?) (0 :gist)
  1 (0 how 2 you 1 manage 1 money 0 ?)
    2 (What are some ways I manage my money ?) (0 :gist)
  1 (0 what 2 you 1 manage 1 money 0 ?)
    2 (What are some ways I manage my money ?) (0 :gist)
  1 (0 wh_ 2 you 1 manage 1 money 0 ?)
    2 (What are some ways I manage my money ?) (0 :gist)

  ; Specific answers
  1 (0 budget 0)
    2 ((The way you manage your money is having plan \.) (Manage-money-ways)) (0 :gist)
  1 (0 advisor 0)
    2 ((The way you manage your money is getting help from 2 \.) (Manage-money-ways)) (0 :gist)
  1 (0 credit credit 0)
    2 ((The way you manage your money is checking 2 3 on time \.) (Manage-money-ways)) (0 :gist)
  1 (0 software 0)
    2 ((The way you manage your money is getting help from 2 \.) (Manage-money-ways)) (0 :gist)
  1 (0 family 0)
    2 ((The way you manage your money is getting help from 2 \.) (Manage-money-ways)) (0 :gist)

  1 (0)
      2 ((NIL gist \: Nothing found for a way to manage your money \.) (Manage-money-ways)) (0 :gist)
))


(READRULES '*reaction-to-manage-money-ways-input*
'(
  1 (0 budget 0)
    2 (It is brilliant to have a plan to manage your money\. It can help you to save money\.) (100 :out)
  1 (0 advisor 0)
    2 (You can get many professional suggestion from 2 \.) (100 :out)
  1 (0 credit credit 0)
    2 (Check 2 3 is a good habbit to manage your money\.) (100 :out)
  1 (0 software 0)
    2 (Sounds cool that you can use modern technology to manage your money\.) (100 :out)
  1 (0 family 0)
    2 (You manage your money with the help with 2 \.) (100 :out)

  1 (0 NIL gist 0)
    2 (That is a good way to manage your money\.) (100 :out)
))
