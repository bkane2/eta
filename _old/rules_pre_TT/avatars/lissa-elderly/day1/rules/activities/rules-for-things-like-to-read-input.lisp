;; (what kind of things you like to read ?)
;;	(things-like-to-read)
;;		from-things-like-to-read-input
;;			(0 I like to read 0)
;;			gist-question:(3 what 2 things you like to read 0)

(MAPC 'ATTACHFEAT
'(
       (novel novels) 
       (magazine magazines)
       (religion religious bible)
       (mystery mysteries)
       (fiction fictions)
       (non-fiction non-fictions)
       (history historical)
       (cookbook cookbooks)
       (book-genre novel magazine health mystery sci-fi Religion Literature fantasy fiction 
       non-fiction Philosophy romance detective humor biographies autobiography art Ethics 
       history newspaper horror satire diaries cookbook poetry )
       (book-genre novel magazine health mystery sci-fi religion literature fantasy fiction non-fiction philosophy)
))
    


(READRULES '*things-like-to-read-input*
'(
       ; Reciprocal questions
       1 (0 what 2 you 0 ?)
              2 (What kind of things do I like to read ?) (0 :gist)
       1 (0 how 2 you 0 ?)
              2 (What kind of things do I like to read ?) (0 :gist)
	1 (0 what 4 you 2 read 0 ?)
              2 (What kind of things do I like to read ?) (0 :gist)

       ; Specific answer
       1 (0 book-genre 0) 
              2 ((You like to read 2 \.)  (Things-like-to-read)) (0 :gist) 	
       1 (0 hate 2 read 0) 
              2 ((Nothing you like to read \.)  (Things-like-to-read)) (0 :gist) 		
	1 (0 cannot 2 read 0) 
              2 ((Nothing you like to read \.)  (Things-like-to-read)) (0 :gist) 		
	1 (0 NEG 4 read 0) 
              2 ((Nothing you like to read \.)  (Things-like-to-read)) (0 :gist) 		
       1 (0 NEG 3 reader 0) 
              2 ((Nothing you like to read \.)  (Things-like-to-read)) (0 :gist) 		
       1 (1 I do not 0)
              2 ((Nothing you like to read \.)  (Things-like-to-read)) (0 :gist) 

       1 (0)
              2 ((NIL gist \: Nothing found for what you like to read \.)  (Things-like-to-read)) (0 :gist)
	 		
))


(READRULES '*reaction-to-things-like-to-read-input*
'(
       1 (0 novel 0)
              2 (I like novels too\. They can keep my mind engaged the whole day\.) (100 :out)
       1 (0 magazine 0)
              2 (Oh\, that\'s nice\. Magazines are a fun\, light read\.) (100 :out)
       1 (0 health 0)
              2 (That\'s nice\. It\'s good to learn new ways to stay healthy\.) (100 :out)
       1 (0 mystery 0)
              2 (Mystery novels are always interesting to read\.) (100 :out)
       1 (0 sci-fi 0)
              2 (Sci-fi is probably my favorite genre\. Though I may be biased\.) (100 :out)
       1 (0 religion 0)
              2 (It\'s good to find comfort in reading about religion\.) (100 :out)
       1 (0 literature 0)
              2 (Reading literature is a good way to engage your mind\.) (100 :out)
       1 (0 fiction 0)
              2 (Reading fiction is always fun\. It can keep your mind engaged the whole day\.) (100 :out)
       1 (0 fantasy 0)
              2 (It\'s fun to be immersed in a fantasy world\.) (100 :out)
       1 (0 non-fiction 0)
              2 (I like reading non-fiction too\. It\'s always good to learn something new\.) (100 :out)
       1 (0 romance 0)
              2 (I have read some romance novels\. But I am not a big fan of them\.) (100 :out)
       1 (0 detective 0)
              2 (Oh\, I love detective novels\. They really engage my mind\.) (100 :ouohit)
       1 (0 humor 0)
              2 (Oh\, humor books are fun to read\.) (100 :out)
       1 (0 biographies 0)
              2 (I like reading biographies too\. I love to know about people\'s lives\.) (100 :out)
       1 (0 art 0)
              2 (I haven\'t read a lot of books on art\, but that sounds cool\.) (100 :out)
       1 (0 history 0)
              2 (I like reading history too\. It\'s always good to learn something new\.) (100 :out)
       1 (0 newspaper 0)
              2 (Oh\, that\'s nice\. Newspapers are a fun\, light read\.) (100 :out)
       1 (0 horror 0)
              2 (Oh\, I haven\'t read a lot of horror books\, they sound scary to me \.) (100 :out)
       1 (0 satire 0)
              2 (I like reading satire too\. They are fun to read\.) (100 :out)
       1 (0 diaries 0)
              2 (I like reading diaries too\. It\'s always good to learn something new\.) (100 :out)
       1 (0 cookbook 0)
              2 (I like cookbooks too\. You could learn a lot of new ideas for cooking\.) (100 :out)
       1 (0 poetry 0)
              2 (Reading poetry is a good way to engage your mind\.) (100 :out)
       1 (0 nothing you like to read 0)
              2 (That\'s fine\, there are plenty of other fun things to do\.) (100 :out)
              
       1 (0 NIL gist 0)
              2 (Sounds nice\. My favorite genre is probably sci-fi\. Though I may be biased a little bit\.) (100 :out)
))
