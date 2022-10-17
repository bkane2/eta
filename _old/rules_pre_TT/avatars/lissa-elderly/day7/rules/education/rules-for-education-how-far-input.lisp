;;	How far did you go in school?
;;	(0 I went to school 0)   
;;	education-how-far
;;	(How far did you go in school ?)
;;	(3 how far 3 go in school 3)

(MAPC 'ATTACHFEAT
'(
  (year-num one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty)
  (grade-num first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelveth)
  (alt-grade grade year years)
  (college university)
  (school-type high secondary primary graduate public private)
  (degree-type bachelor bachelors master masters phd doctor postdoctor postdoc)
))
  

(READRULES '*education-how-far-input*
'(
  ; Questions
  1 (0 how 2 you 2 go 1 school 0 ?)
    2 (How can I go to school ?) (0 :gist)
  1 (0 how 2 you 2 taking classes 0 ?)
    2 (How can I go to school ?) (0 :gist)
  1 (0 what 2 you 0 ?)
    2 (How far did I go in school ?) (0 :gist)
  1 (0 how 2 you 3 school 0 ?)
    2 (How far did I go in school ?) (0 :gist)

  ; Specific answers
  1 (0 college 0)
    2 ((You went to school for college \.) (Education-how-far)) (0 :gist)
  1 (0 school-type school 0)
    2 ((You went to school for 2 school \.) (Education-how-far)) (0 :gist)
  1 (0 school-type 0)
    2 ((You went to school for 2 \.) (Education-how-far)) (0 :gist)
  1 (0 degree-type 0)
    2 ((You went to school for 2 degree \.) (Education-how-far)) (0 :gist)
  1 (0 grade-num alt-grade 0)
    2 ((You went to school for 2 grade \.) (Education-how-far)) (0 :gist)
  1 (0 year-num alt-grade 0)
    2 ((You went to school for 2 years \.) (Education-how-far)) (0 :gist)

  1 (0)
    2 ((NIL gist \: Nothing found for how far you went to school \.) (Education-how-far)) (0 :gist)
))


(READRULES '*reaction-to-education-how-far-input*
'(
  1 (0 college 0)
    2 (It is so cool that you went to college\. You must have been very much into studying\.) (100 :out)
  1 (0 grade-num grade 0)
    2 (2 grade is still a decent enough education\. Enough to get you where you are today\.) (100 :out)
  1 (0 year-num years 0)
    2 (2 years is a decent amount of time for education\. I am sure you must have learned a lot in that time\.) (100 :out)
  1 (0 school-type school 0)
    2 (I really enjoyed 2 school\. I hope you had a good time there\.) (100 :out)
  1 (0 school-type 0)
    2 (I really enjoyed 2 \. I hope you had a good time there\.) (100 :out)
  1 (0 degree-type degree 0)
    2 (Getting your 2 degree sounds like an impressive goal\. I am sure you must have worked hard to get there\.) (100 :out)

  1 (0 NIL gist 0)
    2 (It\'s good that your education helped you get where you are today\.) (100 :out)
))
