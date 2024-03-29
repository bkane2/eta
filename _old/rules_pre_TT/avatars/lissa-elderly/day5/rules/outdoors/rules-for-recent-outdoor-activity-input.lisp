;; What is a recent outdoor activity you have done?
;; (0 recent outdoor activity 0) (0 have not done any recent outdoor activty 0)
;; recent-outdoor-activity
;; (2 what 2 recent outdoor activity 4)

(MAPC 'ATTACHFEAT
'(
  (walk walking)
  (social musical concert fireworks picnic social-a craft crafts car performance 
    performances show shows market markets sport game party)
  (social-a art artwork artworks)
  (run running bike biking)
  (flying kite kites)
  (sport sports badminton tennis volleyball frisbee golf golfing soccer football baseball)
  (nature-related hike hiking boat boating fishing bird birds watching birdwatching botanical garden zoo
    berry strawberry picking scavenger hunt)
  (garden gardening)
  (swimming swim)
  (friend friends)
  (spouse husband wife)
  (grandchild grandchildren granddaugher granddaughter grandson grandsons)
  (child children daughter daughters son sons girl girls boy boys)
))


(READRULES '*recent-outdoor-activity-input*
'(  
  ; Questions
  1 (2 what 2 recent outdoor activity 4 ?)
    2 (What is a recent outdoor activity I have done ?) (0 :gist)
  1 (0 what 2 outdoor activtiy 2 like 0 ?) ; What is the outdoor activity you would like to do?
    2 (What is a recent outdoor activity I have done ?) (0 :gist)
  1 (0 what 2 you 0 ?)
    2 (What is a recent outdoor activity I have done ?) (0 :gist)
  1 (0 how 2 you 0 ?)
    2 (What is a recent outdoor activity I have done ?) (0 :gist)
  1 (0 how 2 you 3 outdoor 0 ?)
    2 (How can I go outside ?) (0 :gist)

  ; Specific answers
  1 (0 social social 0) 
    2 (0 social-a social 0) 
      3 ((Your recent outdoor activty is going to an 2 3 \.)  (Recent-outdoor-activity)) (0 :gist) 
    2 (0 social social 0) 
      3 ((Your recent outdoor activty is going to a 2 3 \.)  (Recent-outdoor-activity)) (0 :gist) 
  1 (0 flying kite 0) 
    2 ((Your recent outdoor activty is 2 3 \.)  (Recent-outdoor-activity)) (0 :gist) 
  1 (0 nature-related nature-related 0) 
    2 ((Your recent outdoor activty is 2 3 \.)  (Recent-outdoor-activity)) (0 :gist) 
  1 (0 nature-related 0) 
    2 ((Your recent outdoor activty is 2 \.)  (Recent-outdoor-activity)) (0 :gist) 
  1 (0 walking 0) 
    2 ((Your recent outdoor activty is 2 \.)  (Recent-outdoor-activity)) (0 :gist) 
  1 (0 running 0) 
    2 ((Your recent outdoor activty is 2 \.)  (Recent-outdoor-activity)) (0 :gist)
  1 (0 sport 0) 
    2 ((Your recent outdoor activty is 2 \.)  (Recent-outdoor-activity)) (0 :gist) 
  1 (0 swimming 0) 
    2 ((Your recent outdoor activty is 2 \.)  (Recent-outdoor-activity)) (0 :gist)
  1 (0 friend 0) 
    2 ((Your recent outdoor activity is with your 2 \.)  (Recent-outdoor-activity)) (0 :gist)
  1 (0 spouse 0) 
    2 ((Your recent outdoor activity is with your 2 \.)  (Recent-outdoor-activity)) (0 :gist)
  1 (0 grandchild 0) 
    2 ((Your recent outdoor activity is with your 2 \.)  (Recent-outdoor-activity)) (0 :gist)
  1 (0 child 0) 
    2 ((Your recent outdoor activity is with your 2 \.)  (Recent-outdoor-activity)) (0 :gist)
  1 (1 NEG 2 outdoor 0) 
    2 ((You have not done any recent outdoor activty \.)  (Recent-outdoor-activity)) (0 :gist)

  1 (0)
    2 ((NIL gist \: Nothing found for recent outdoor activity  \.) (Recent-outdoor-activity)) (0 :gist)
))


(READRULES '*reaction-to-recent-outdoor-activity-input*
'(
  1 (0 social social 0)
    2 (0 social-a social 0) 
      3 (I love art history and are more than willing to spend my afternoon appreciating artworks\.) (100 :out)
    2 (0 musical 0) 
      3 (Listening live music and recorded one are never the same experience\. The sounds and voice are so powerful\.) (100 :out)
    2 (0 sport game 0) 
      3 (I used to watch baseball game with your children\. That was really fun\.) (100 :out)
    2 (0 social social 0) 
      3 (Sounds nice that you have went to the 2 3 \.) (100 :out)
  1 (0 flying kite 0)
    2 (I rarely fly kites\, but that sounds like a good way to get some sunshine\.) (100 :out)
  1 (0 nature-related nature-related 0)
    2 (0 watching 0) ;; bird watching
      3 (Observing animals helps you to appreciate the beauty of mother nature\.) (100 :out)
    2 (0 garden 0) 
      3 (I am horrible at keeping plants\, but I enjoy wandering around a beautiful garden\.) (100 :out)
    2 (0 picking 0) 
      3 (I went for berry picking in summer\! It was wonderful\.) (100 :out)
    2 (0 nature-related nature-related 0)
      3 (It is good to be back to nature from time to time\.) (100 :out)
  1 (0 nature-related 0)
    2 (0 hiking 0) 
      3 (I have been hiking at the adirondack park last august\. Feels good to be back to nature sometimes\.) (100 :out)
    2 (0 fishing 0) 
      3 (I have never tried\, but fishing looks very interesting\.) (100 :out)
    2 (0 nature-related 0) 
      3 (It is good to be back to nature from time to time\.) (100 :out)
  1 (0 walking 0)
    2 (Yeah\, my parents also used to walk together after dinner\. We knew other senior people in their community through this\,
      because we would chat along our way\.) (100 :out)
  1 (0 running 0)
    2 (Running is hard exercise\. You must be in good shape\.) (100 :out)
  1 (0 swimming 0)
    2 (I still go swimming sometimes\. I love being in water\, despite having to be more careful than when I was young\. ) (100 :out)
  1 (0 sport 0)
    2 (I dropped 2 a year ago\. Maybe I should pick it back up\.) (100 :out)
  1 (0 friend 0)
    2 (I love going out with friends\! They keep me happy\.) (100 :out)
  1 (0 spouse 0)
    2 (Going outdoor with my 2 sounds lovely\. Wish you will have more good time together\.) (100 :out)
  1 (0 grandchildren 0)
    2 (I love to keep in touch with young lives and stay up-to-date\.) (100 :out)
  1 (0 child 0)
    2 (I love to keep in touch with my children and stay up-to-date\.) (100 :out)
  1 (1 neg 2 outdoor 0)
    2 (Sometimes people just need to spend some time indoors\.) (100 :out)
    
  1 (0 NIL gist 0)
    2 (It\'s healthy to spend some time outdoors every day\.) (100 :out)
))
