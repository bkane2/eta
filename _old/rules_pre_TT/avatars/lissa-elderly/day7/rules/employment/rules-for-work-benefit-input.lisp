;; 	Think about work you have done\, it might be in the home\, a career or a volunteer work\. How did that work benefit you?
;;	(0 work benefited me 0)
;;	work-benefit
;;	(How could work benefit you ?)
;;	(3 How 2 work benefit 3)


;; MEETING WITH KIM NOTES (8/4/2017)

;; New question prompt: "Think about work you've done. It might be in the home, a career, or volunteer work.
;; How did that work benefit you?"

;; It paid the bills
;; Source of income
;; Supporting their family
;; Money for retirement
;; Sense of meaning / purpose
;; Travel
;; Learning new things
;; Being around other people / making friends/connections
;; Keeping busy

(MAPC 'ATTACHFEAT
'(
  (alt-paid paid pay handled handle took source) ;; "took care of the bills" "source of income"
  (alt-retirement retirement retiring)
  (alt-purpose purpose meaning)
  (alt-make-friend being be making make finding find talking talk)
  (alt-friend friend friends people connections relationship relationships acquaintances others)
  (alt-keep keep keeping stay staying help helping make making)
  (alt-busy busy occupied entertained engaged involved)
))


(READRULES '*work-benefit-input*
; NOTE: Proposed new gist clause: "(0 work benefited me by 0)"
; Needs new tag
'(
  ; Questions
  1 (0 are 2 you 2 working ?)
    2 (Am I still working ?) (0 :gist)
  1 (0 have 2 you 2 retired ?)
    2 (Am I still working ?) (0 :gist)
  1 (0 what 2 you 2 work ?)
    2 (Am I still working ?) (0 :gist)
  1 (0 what 2 you 0 ?)
    2 (How did work benefit me ?) (0 :gist)
  1 (0 how 2 you 0 ?)
    2 (How did work benefit me ?) (0 :gist)

  ; Specific answers
  1 (0 alt-paid 3 alt-money 0)
    2 ((Your work benefited you by paying the bills \.) (Work-benefit)) (0 :gist)
  1 (0 alt-volunteer 2 relative-types 0)
    2 ((Your work benefited you by supporting your family \.) (Work-benefit)) (0 :gist)
  1 (0 alt-money 2 alt-retirement 0)
    2 ((Your work benefited you by giving you money for retirement \.) (Work-benefit)) (0 :gist)
  1 (0 alt-learn 1 alt-new 0)
    2 ((Your work benefited you by letting you learn new things \.) (Work-benefit)) (0 :gist)
  1 (0 alt-purpose 0)
    2 ((Your work benefited you by giving you a sense of purpose \.) (Work-benefit)) (0 :gist)
  1 (0 alt-travel 0)
    2 ((Your work benefited you by letting you travel \.) (Work-benefit)) (0 :gist)
  1 (0 alt-make-friend 2 alt-friend 0)
    2 ((Your work benefited you by letting you be around friends \.) (Work-benefit)) (0 :gist)
  1 (0 alt-keep 2 alt-busy 0)
    2 ((Your work benefited you by keeping you busy \.) (Work-benefit)) (0 :gist)

  1 (0)
      2 ((NIL gist \: Nothing found for how your work benefited you \.) (Work-benefit)) (0 :gist)
))


(READRULES '*reaction-to-work-benefit-input*
'( 
  1 (0 paying the bills 0)
    2 (Being a source of income is a very practical way of looking at work\. But it\'s the truth\.) (100 :out)
  1 (0 supporting your family 0)
    2 (It\'s great that your work helped support the important people in your life as well as you \.) (100 :out)
  1 (0 money for retirement 0)
    2 (I am sure all the hard work you put in is worth it once you are able to retire\.) (100 :out)
  1 (0 learn new things 0)
    2 (Work can be an excellent way to learn and master life skills\.) (100 :out)
  1 (0 a sense of purpose 0)
    2 (It\'s cool that work made you feel some sense of purpose\. I hope that feeling can stay with you \.) (100 :out)
  1 (0 travel 0)
    2 (It must be very lucky to have a job that lets you go on nice vacations\.) (100 :out)
  1 (0 be around friends 0)
    2 (Work can be quite the social hub sometimes\. It\'s cool that you were able to have friends through work\.) (100 :out)
  1 (0 keeping you busy 0)
    2 (Sometimes when you stop working you realize just how nice it was to have something to occupy you \.) (100 :out)

  1 (0 NIL gist 0)
    2 (Work can be a valuable experience for many people\, even if it can be stressful at times\.) (100 :out)
))
