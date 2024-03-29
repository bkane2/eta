;;  How often do you read the newspaper?  
;;	(0 I do not read newspaper 0) 
;;	(0 I read newspaper 0)
;;	newspaper-how-often
;;	(How often do you read the newspaper ?)  
;;	(3 How often 2 read 2 newspaper 3) 


;; MEETING WITH KIM NOTES (8/4/2017)

;; More likely to read actual newspaper than we are
;; Will also watch news

(MAPC 'ATTACHFEAT
'(
  (time-frequently frequently daily day morning mornings afternoon afternoons evening evenings)
  (time-sometimes sometimes weekly week)
  (time-rarely rarely seldom hardly little scarcely)
  (time-never never)
  (alt-bad bad depressing sad scary)
  (alt-but but however although)
  (alt-internet internet online blog website)
))
  

(READRULES '*newspaper-how-often-input*
'(
  ; Questions
  1 (0 what 2 you 0 ?)
    2 (How often do I read the newspaper ?) (0 :gist)
  1 (0 how 2 you 0 ?)
    2 (How often do I read the newspaper ?) (0 :gist)

  ; Specific answers
  1 (0 NEG 1 often 3 alt-but 2 watch 0)
    2 ((You read newspaper rarely but you do watch the news \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 NEG 1 often 3 alt-but 2 alt-internet 0)
    2 ((You read newspaper rarely but you do look at news online \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 NEG 1 often 8 BADSTATE 0)
    2 ((You read newspaper rarely because of all the bad news \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 NEG 1 often 5 alt-bad 1 news 0)
    2 ((You read newspaper rarely because of all the bad news \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 time-rarely 3 alt-but 2 watch 0)
    2 ((You read newspaper rarely but you do watch the news \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 time-rarely 3 alt-but 2 alt-internet 0)
    2 ((You read newspaper rarely but you do look at news online \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 time-rarely 8 BADSTATE 0)
    2 ((You read newspaper rarely because of all the bad news \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 time-rarely 5 alt-bad 1 news 0)
    2 ((You read newspaper rarely because of all the bad news \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 time-never 3 alt-but 2 watch 0)
    2 ((You do not read newspaper but you do watch the news \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 time-never 3 alt-but 2 alt-internet 0)
    2 ((You do not read newspaper but you do look at news online \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 time-never 8 BADSTATE 0)
    2 ((You do not read newspaper because of all the bad news \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 time-never 5 alt-bad 1 news 0)
    2 ((You do not read newspaper because of all the bad news \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 very often 0)
    2 ((You read newspaper frequently \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 time-frequently 0)
    2 ((You read newspaper frequently \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 time-sometimes 0)
    2 ((You read newspaper sometimes \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 NEG 4 often 0)
    2 ((You read newspaper rarely \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 time-rarely 0)
    2 ((You read newspaper rarely \.)  (Newspaper-how-often)) (0 :gist)
  1 (0 time-never 0)
    2 ((You do not read newspaper \.)  (Newspaper-how-often)) (0 :gist)

  1 (0)
    2 ((NIL gist \: Nothing found for how often you read newspaper \.) (Newspaper-how-often)) (0 :gist)
))


(READRULES '*reaction-to-newspaper-how-often-input*
'(
  1 (0 you read newspaper frequently 0)
    2 (It\'s great that you read the newspaper often\! It\'s important to stay on top of things that are going on in your community and in the world\.) (100 :out)
  1 (0 you read newspaper sometimes 0)
    2 (It\'s good that you still read the newspaper\. It\'s important to stay on top of things that are going on in your community and in the world\.) (100 :out)
  1 (0 you read newspaper rarely 2 do watch 0)
    2 (I don\'t think it matters much whether I read newspaper or watch the news\. The important thing is keeping in touch with things that are happening in the world\.) (100 :out)
  1 (0 you read newspaper rarely 2 do look 2 online 0)
    2 (It\'s great that you are so up to date with modern technology\. There\'s many good news sources online\, though there\'s a lot more bad ones as well\. You just have to be careful\.) (100 :out)
  1 (0 you read newspaper rarely 4 bad news 0)
    2 (The negative things in the news can be too much sometimes\, however there\'s also a lot of good and heartwarming things in the news\.) (100 :out)
  1 (0 you read newspaper rarely 0)
    2 (I think it\'s good to read newspaper sometimes\, or have some other source of news so that I can see what\'s happening in my community and in the world\.) (100 :out)
  1 (0 you do not read newspaper 2 do watch 0)
    2 (I don\'t think it matters much whether I read newspaper or watch the news\. The important thing is keeping in touch with things that are happening in the world\.) (100 :out)
  1 (0 you do not read newspaper 2 do look 2 online 0)
    2 (It\'s great that you are so up to date with modern technology\. There\'s many good news sources online\, though there\'s a lot more bad ones as well\. You just have to be careful\.) (100 :out)
  1 (0 you do not read newspaper 4 bad news 0)
    2 (The negative things in the news can be too much sometimes\, however there\'s also a lot of good and heartwarming things in the news\.) (100 :out)
  1 (0 you do not read newspaper 0)
    2 (I think it\'s good to read newspaper sometimes\, or have some other source of news so that I can see what\'s happening in my community and in the world\.) (100 :out)

  1 (0 NIL gist 0)
    2 (I think it\'s good to read newspaper sometimes\, or have some other source of news so that I can see what\'s happening in my community and in the world\.) (100 :out)
))
