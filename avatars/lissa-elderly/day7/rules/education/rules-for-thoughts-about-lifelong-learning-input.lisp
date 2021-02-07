;;  Lifelong learning is important to me. What do you think about lifelong learning?
;;  (0 I think life long learning 0)   
;;	thoughts-about-lifelong-learning
;;	(What do you think about lifelong learning ?)
;;	(3 what 2 think 3 lifelong learning 3)


;; MEETING WITH KIM NOTES (8/4/2017)

;; Question prompt: "Some people like to take up hobbies like photography, or take classes at a community college..."

;; Doesn't matter to them / that's not important to me
;; Response: "Think of the most positive person you know. Tell me what that person would say..."

;; Continuing to learn new things, even after school is completed / even after you're done with school
;; Still teaching
;; Retired professor
;; Informal classes / OSHER (life long learning institute/organization connected with RIT)
;; Oasis (teaches classes to older people)
;; Photography classes
;; Read a lot
;; Keeps their mind sharp
;; Keeps them engaged in the world
;; Gives them something to talk about

(MAPC 'ATTACHFEAT
'(
  (matter important mean)
  (object-pron me us we you them people person)
  (verb-make make makes making cause causes causing help helps helping keep keeps keeping get gets getting)
  (verb-show show shows showing give gives giving)
  (syn-happiness happiness wellness pleasure delight gladness satisfaction contentness joy fun)
  (syn-relaxation relaxation relax relaxes relaxing calm calms calming therapy therapeutic)
  (syn-creativity creativity creative imagination imaginative express expression)
  (institute organization college classes osher oasis)
  (photography art draw drawing craft crafts baking cake cooking)
  (body-activity swim gym yoga dancing)
  (social topic talk)
))


(READRULES '*thoughts-about-lifelong-learning-input*
'(
  ; Questions
  1 (0 what 2 you 0 ?)
    2 (What do I think about lifelong learning ?) (0 :gist)
  1 (0 how 1 lifelong learning 1 you 0 ?)
    2 (What do I think about lifelong learning ?) (0 :gist)
  ;; 1 (0 can 1 you 1 learning 0 ?)
  ;;   2 (Can I learning things ?) (0 :gist)
  ;; 1 (0 can 1 you 1 reading 0 ?)
  ;;   2 (Can I do some reading ?) (0 :gist)

  ; Specific answers
  1 (0 verb-make 1 object-pron 1 syn-happiness 0)
    2 ((You think life long learning makes 4 happy \.) (Thoughts-about-lifelong-learning)) (0 :gist)
  1 (0 verb-make 1 object-pron 1 syn-relaxation 0)
    2 ((You think life long learning makes 4 relaxing \.) (Thoughts-about-lifelong-learning)) (0 :gist)
  1 (0 verb-make 1 object-pron 1 syn-creativity 0)
    2 ((You think life long learning makes 4 become creative \.) (Thoughts-about-lifelong-learning)) (0 :gist)
  1 (0 verb-show 1 object-pron 2 social 0)
    2 ((You think life long learning helps 4 with social \.) (Thoughts-about-lifelong-learning)) (0 :gist)
  1 (0 insititute 0)
    2 ((You think life long learning can be given from 2 \.) (Thoughts-about-lifelong-learning)) (0 :gist)
  1 (0 photography 0)
    2 ((You think life long learning helps you with 2 \.) (Thoughts-about-lifelong-learning)) (0 :gist)
  1 (0 body-activity 0)
    2 ((You think life long learning helps you with 2 \.) (Thoughts-about-lifelong-learning)) (0 :gist)
  1 (0 NEG 1 matter 0)
    2 ((You think life long learning is not important to you \.) (Thoughts-about-lifelong-learning)) (0 :gist)  

  1 (0)
    2 ((NIL gist \: Nothing found for what you think life long learning means \.) (Thoughts-about-lifelong-learning)) (0 :gist)
))
  

(READRULES '*reaction-to-thoughts-about-lifelong-learning-input*
'(
; NOTE: "Think of the most positive person I know. Tell you what that person would say" should be dealt
; with using a subschema rather than as a reaction

  ;; 1 (0 life long learning is not important 0)
  ;;   2 (Think of the most positive person you know. Tell me what that person would say\.) (100 :out)

  1 (0 makes 1 object-pron 1 happy 0)
    2 (That is awesome to hear that you are happy with lifelong learning \.) (100 :out)
  1 (0 makes 1 object-pron 1 relaxing 0)
    2 (I think taking time to learn things is a good way to relax yourself \.) (100 :out)
  1 (0 makes 1 object-pron 1 creative 0)
    2 (That is great to hear that learning improves the creativity of people \.) (100 :out)
  1 (0 helps 1 object-pron 1 social 0)
    2 (Learning is great for improving social skills\. You can have more topics when talking with your friends if you learn new things \.) (100 :out)
  1 (0 can be given from institute 0)
    2 (That is great that people have proper access to professional classes for learning \.) (100 :out)
  1 (0 helps you with photography 0)
    2 (Sounds great that you love 5 \! That\'s a good way to spend your time and relax yourself \.) (100 :out)
  1 (0 helps you with body-activity 0)
    2 (Sounds great that you love 5 \! You can stay healthy if you do some exercise \.) (100 :out)

  1 (0 NIL gist 0)
    2 (I think lifelong learning can help keep your mind sharp \. I know some people who even take classes online or through organizations such as osher and oasis \.) (100 :out)
))
