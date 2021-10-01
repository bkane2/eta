;;  What makes this goal important to you? How can it improve your life quality?
;; (0 being healthier improves my life quality 0)
;; being-healthier-life-quality
;; (How can being healthier improve your life quality ?)
;; (3 how 2 being healthier 2 improve your life quality 4)

;; NOTE: Proposed new gist clause: "(0 being healthier improves my life quality by 0)"
;; New tag: being-healthier-life-quality


;; MEETING WITH KIM NOTES (8/4/2017)

;; New question prompt: "How can being healthier improve your life quality?"

;; Feel better about myself / happier
;; Feel more confident / gives me more confidence
;; Self esteem
;; Get my doctor off my back
;; Get my husband/wife/kids off my back
;; Do things I like to do (taking walks, exercise)
;; Helping memory
;; Staying independent longer / not going to nursing home
;; Living longer
;; Not having a stroke
;; Not needing surgery
;; Not needing to take medicine / as much medicine
;; Keeping blood sugar stable

(MAPC 'ATTACHFEAT
'(
  (alt-feel feel feeling think thinking be being make makes making get getting give gives giving)
  (alt-better GOODPROP happier happiness confident confidence)
  (alt-person alt-friend alt-doctor husband wife kid kids child children son sons daughter daughters)
  (alt-stop stop stopping quit)
  (alt-nagging nagging nag pestering pester bothering bother hassle hassling badger badgering hound hounding harass harassing)
  (alt-activities activities activity exersize things stuff)
  (alt-like like enjoy fun love)
  (alt-improve improve improving help helping benefit benefitting enhance enhancing polish polishing)
  (alt-memory memory memorization remember remembering mind mental)
  (alt-staying staying stay remaining remain keeping keep being be)
  (alt-nursing-home nursing home assisted living retirement facility elderly)
  (alt-living living live alive survive)
  (alt-having having have needing need getting get)
  (alt-medical-issue stroke failure heart liver kidney diabetes imbalance surgery treatment treatments medicine pill pills)
))
  

(READRULES '*being-healthier-life-quality-input*
'(
  ; Questions
  1 (0 what 2 you 0 ?)
      2 (How can being healthier improve my life quality ?) (0 :gist)
  1 (0 how 2 you 0 ?)
      2 (How can being healthier improve my life quality ?) (0 :gist)

  ; Specific answers
  1 (0 alt-feel 2 alt-better 0)
    2 ((Being healthier improves your life quality by making you feel happier about yourself \.) (Being-healthier-life-quality)) (0 :gist)
  1 (0 self 1 esteem 0)
    2 ((Being healthier improves your life quality by making you feel happier about yourself \.) (Being-healthier-life-quality)) (0 :gist)
  1 (0 alt-stop 1 alt-person 2 alt-nagging 0)
    2 ((Being healthier improves your life quality by getting people to stop nagging \.) (Being-healthier-life-quality)) (0 :gist)
  1 (0 alt-person 1 alt-stop 2 alt-nagging 0)
    2 ((Being healthier improves your life quality by getting people to stop nagging \.) (Being-healthier-life-quality)) (0 :gist)
  1 (0 alt-person 2 off 2 back 0)
    2 ((Being healthier improves your life quality by getting people to stop nagging \.) (Being-healthier-life-quality)) (0 :gist)
  1 (0 alt-person 2 leave 2 alone 0)
    2 ((Being healthier improves your life quality by getting people to stop nagging \.) (Being-healthier-life-quality)) (0 :gist)
  1 (0 do 2 alt-activities 3 alt-like 0)
    2 ((Being healthier improves your life quality by letting you do activities you like \.) (Being-healthier-life-quality)) (0 :gist)
  1 (0 alt-improve 2 alt-memory 0)
    2 ((Being healthier improves your life quality by helping your memory \.) (Being-healthier-life-quality)) (0 :gist)
  1 (0 alt-staying 2 independent 0)
    2 ((Being healthier improves your life quality by letting you stay independent longer \.) (Being-healthier-life-quality)) (0 :gist)
  1 (0 NEG 3 alt-nursing-home alt-nursing-home 0)
    2 ((Being healthier improves your life quality by letting you stay independent longer \.) (Being-healthier-life-quality)) (0 :gist)
  1 (0 alt-living 2 longer 0)
    2 ((Being healthier improves your life quality by letting you live longer \.) (Being-healthier-life-quality)) (0 :gist)
  1 (0 NEG alt-having 3 alt-medical-issue 0)
    2 ((Being healthier improves your life quality by preventing medical issues \.) (Being-healthier-life-quality)) (0 :gist)
  1 (0 alt-improve 2 blood sugar 0)
    2 ((Being healthier improves your life quality by preventing medical issues \.) (Being-healthier-life-quality)) (0 :gist)
  1 (0 alt-staying 2 blood sugar 0)
    2 ((Being healthier improves your life quality by preventing medical issues \.) (Being-healthier-life-quality)) (0 :gist)

  1 (0)
    2 ((NIL gist \: Nothing found for how being healthier improves your life quality \.) (Being-healthier-life-quality)) (0 :gist)
))


(READRULES '*reaction-to-being-healthier-life-quality-input*
'(
  1 (0 making you feel happier about yourself 0)
    2 (Though you should always try to have high self esteem\, it\'s especially easy when you know you are healthy\.) (100 :out)
  1 (0 getting people to stop nagging 0)
    2 (I am sure nagging can be annoying\. It must be nice to get people off your back\.) (100 :out)
  1 (0 letting you do activities you like 0)
    2 (Being healthier can be very freeing sometimes\, because it lets you do activities you couldn\'t do before\.) (100 :out)
  1 (0 helping your memory 0)
    2 (It must feel great to have a fresh memory compared to before\.) (100 :out)
  1 (0 letting you stay independent longer 0)
    2 (I am sure it must be great to be independent as long as possible\.) (100 :out)
  1 (0 letting you live longer 0)
    2 (Living a healthy lifestyle is definitely the key to living a long time\. I hope I am able to live that long when I get older\.) (100 :out)
  1 (0 preventing medical issues 0)
    2 (Living with the threat of medical issues can be scary sometimes\. I am sure it\'s nice to get those fears off your back by being healthier\.) (100 :out)

  1 (0 NIL gist 0)
    2 (Being healthier can feel like a breath of fresh air in many ways\. I hope you can stay healthy as you get older\.) (100 :out)
))
