;; 	Do you live in an apartment or a house? Tell me about it.
;; 	(0 the place I live in is 0)
;;	(0 I would prefer to live in 0)
;;	(0 I would have difficulty to live in 3 because 4)
;;	place-you-live
;;	(Do you live in an apartment or a house ?)
;;	(3 do you live 2 apartment 2 house 3)


;; MEETING WITH KIM NOTES (8/8/2017)

;; Those prefer to live in house if they live in senior living: call it cottage.
;; House on campus,
;; Senior housing: most live in apartment
;; Live with their children
;; Children want them to give up their house so people wanna stay at their home alap -> not a good idea
;; Difficulty with stairs,
;; Moving out from house to apt. because of these things -> it was hard to give up home
;; Sometimes couples-> one stay home, the other nursing home -> get split up

(MAPC 'ATTACHFEAT
'(
  (alt-housing housing living residence)
  (alt-house house home cottage)
  (alt-live live stay)
  (alt-prefer prefer want)
  (alt-difficulty difficulty problem)
  (alt-spouse spouse wife husband)
  (alt-split split seperated)
))
  

(READRULES '*place-you-live-input*
'(
  ; Questions
  1 (0 what 2 you 0 ?)
    2 (Do I live in an apartment or a house ?) (0 :gist)
  1 (0 how 2 you 0 ?)
    2 (Do I live in an apartment or a house ?) (0 :gist)

  ; Specific answers
  1 (0 apartment 5 alt-prefer 4 alt-house 0)
    2 ((You would prefer to live in a house \.) (Place-you-live)) (0 :gist)
  1 (0 alt-house 5 alt-prefer 4 apartment 0)
    2 ((You would prefer to live in an apartment \.) (Place-you-live)) (0 :gist)
  1 (0 house 1 campus 0)
    2 ((The place you live in is in a campus \.) (Place-you-live)) (0 :gist)
  1 (0 senior alt-housing 5 apartment 0)
    2 ((The place you live in is an apartment in senior housing \.) (Place-you-live)) (0 :gist)
  1 (0 apartment 5 senior alt-housing 0)
    2 ((The place you live in is an apartment in senior housing \.) (Place-you-live)) (0 :gist)
  1 (0 senior alt-housing 5 alt-house 0)
    2 ((The place you live in is a cottage in senior housing \.) (Place-you-live)) (0 :gist)
  1 (0 alt-house 5 senior alt-housing 0)
    2 ((The place you live in is a cottage in senior housing \.) (Place-you-live)) (0 :gist)
  1 (0 alt-live 1 with 2 alt-family 0)
    2 ((The place you live in is with your relatives \.) (Place-you-live)) (0 :gist)
  1 (0 alt-difficulty 3 stairs 0)
    2 ((You would have difficulty to live in a house because of stairs \.) (Place-you-live)) (0 :gist)
  1 (0 hard 2 give up 2 alt-house 0)
    2 ((You would have difficulty to live in an apartment because you want to keep house \.) (Place-you-live)) (0 :gist)
  1 (0 NEG 1 want 2 give up 2 alt-house 0)
    2 ((You would have difficulty to live in an apartment because you want to keep house \.) (Place-you-live)) (0 :gist)
  1 (0 alt-spouse 5 alt-split 0)
    2 ((The place you live in is without your spouse \.) (Place-you-live)) (0 :gist)
  1 (0 alt-split 5 alt-spouse 0)
    2 ((The place you live in is without your spouse \.) (Place-you-live)) (0 :gist)

  1 (0)
    2 ((NIL gist \: Nothing found for how the place you live in is like \.) (Place-you-live)) (0 :gist)
))


(READRULES '*reaction-to-place-you-live-input*
'(
  1 (0 place you live in 2 in a campus 0)
    2 (I think it sounds nice to live so close to other people you can become friends with\.) (100 :out)
  1 (0 place you live in 2 apartment in senior housing 0)
    2 (Living in an apartment does have its benefits\. It\'s nice to have everything you need in a smaller area\.) (100 :out)
  1 (0 place you live in 2 cottage in senior housing 0)
    2 (A cottage sounds like a good compromise between an apartment and an independent house\.) (100 :out)
  1 (0 place you live in 2 with your relatives 0)
    2 (Living with relatives has the added benefit that they can help take care of you if you need it\.) (100 :out)
  1 (0 place you live in 2 without your spouse 0)
    2 (Having to split up with your spouse sounds like a difficult situation\. Hopefully you can still see them often\.) (100 :out)
  1 (0 would prefer to live in 2 house 0)
    2 (Living in a house has a lot of advantages\, but it can also be more work\. I hope you can eventually find a place to live in that makes you happy\.) (100 :out)
  1 (0 would prefer to live in 2 apartment 0)
    2 (Living in an apartment can be very convenient if you are willing to make do with less space\. I hope you can eventually find a place to live in that makes you happy\.) (100 :out)
  1 (0 would have difficulty to live in 2 house because 2 stairs 0)
    2 (It makes sense that stairs would be difficult as you get older\.) (100 :out)
  1 (0 would have difficulty to live in 2 apartment because 2 want to keep house 0)
    2 (Sometimes letting go of a house can be very difficult\. It might also make your life easier in the long run to move to a more convenient living place\, though\.) (100 :out)

  1 (0 NIL gist 0)
    2 (I hope you can settle in a home that\'s a good match for you \.) (100 :out)
))
