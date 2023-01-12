; The rules in this tree are used to match generic statements from the user, particularly
; those that may be associated with a particular skill (empathy, explicit, empowering).
;
;   TODO: add possible empathetic/explicit/empowering statements here that might be missed 
;
; The rules are grouped into various subtopics corresponding to topics that
; appear in schemas:
;
; - cancer-worse
; - medical-history
; - medicine-side-effects
; - appointment
; - chemotherapy-details
; - diagnosis-details
; - energy
; - medicine
; - pain
; - radiation
; - sleep
; - chemotherapy
; - comfort-care
; - medicine-request
; - medicine-working
; - prognosis
; - sleep-poorly
; - tell-family
; - test-results
; - treatment-option
; - treatment-goals
; - open-ended-statement

; Define any useful predicates here:


(READRULES '*statement-input*
'(
; ````````````````````     cancer-worse      ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````    medical-history    ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ```````````````````` medicine-side-effects ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````      appointment      ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ```````````````````` chemotherapy-details  ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````   diagnosis-details   ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````        energy         ```````````````````````
; ``````````````````````````````````````````````````````````````````

  ; You should take an antidepressant/get therapy.
  1 (0 .SHOULD 1 .MED-TAKE 5 .ANTIDEPRESSANT)
    2 ((I should take an antidepressant \.) (Medicine-request)) (0 :gist)
  1 (0 .SHOULD 1 see 1 .THERAPY 0)
    2 ((I should see a therapist \.) (Energy)) (0 :gist)
  1 (0 .SHOULD 1 get 1 .THERAPY 0)
    2 ((I should see a therapist \.) (Energy)) (0 :gist)
  1 (0 .SHOULD 1 sign up 1 .THERAPY 0)
    2 ((I should see a therapist \.) (Energy)) (0 :gist)

; ````````````````````       medicine        ```````````````````````
; ``````````````````````````````````````````````````````````````````

  ; You should take a narcotic.
  1 (0 you 1 .SHOULD 3 .MED-TAKE 5 .MED-NARCOTIC 0)
    2 ((I should take a narcotic \.) (Medicine-request)) (0 :gist)
  1 (0 you 1 .FUTURE-POSS 3 .FEELING better 5 .MED-NARCOTIC 0)
    2 ((I should take a narcotic \.) (Medicine-request)) (0 :gist)
  1 (0 .MED-TAKE 3 .MED-NARCOTIC 3 .MED-HELP 0)
    2 ((I should take a narcotic \.) (Medicine-request)) (0 :gist)

; ````````````````````         pain          ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````       radiation       ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````         sleep         ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````     chemotherapy      ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````     comfort-care      ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````   medicine-request    ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````   medicine-working    ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````       prognosis       ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````     sleep-poorly      ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````      tell-family      ```````````````````````
; ``````````````````````````````````````````````````````````````````

  ; I should plan to spend my remaining time with my family after I tell them about the prognosis \.
  1 (0 make 2 time 4 .FAMILY-PRON 0)
    2 ((I should plan to spend my remaining time with my family after I tell them about the prognosis \.)) (0 :gist)
  1 (0 .GIVE 4 .FAMILY-PRON 4 .VISIT 2 you 0)
    2 ((I should plan to spend my remaining time with my family after I tell them about the prognosis \.)) (0 :gist)
  1 (0 .SPEND 4 time 4 .FAMILY-PRON 0)
    2 ((I should plan to spend my remaining time with my family after I tell them about the prognosis \.)) (0 :gist)
  1 (0 .FAMILY 2 .SPEND 2 time 4 you 0)
    2 ((I should plan to spend my remaining time with my family after I tell them about the prognosis \.)) (0 :gist)
  1 (0 make 2 .MOST 4 time 4 with 2 .FAMILY-PRON 0)
    2 ((I should plan to spend my remaining time with my family after I tell them about the prognosis \.)) (0 :gist)
  ; You empathize with how hard it is for me to tell my family.
  1 (0 .KNOW-GEN 4 .BE 3 .DIFFICULT 6 .TELL 1 .FAMILY-PRON 0)
    2 ((You empathize with how hard it is for me to tell my family \.)) (0 :gist)
  1 (0 .KNOW-GEN 4 how 2 .DIFFICULT 6 .TELL 1 .FAMILY-PRON 0)
    2 ((You empathize with how hard it is for me to tell my family \.)) (0 :gist)
  1 (0 .KNOW-GEN 4 how 2 .FEAR-WORDS 6 .TELL 1 .FAMILY-PRON 0)
    2 ((You empathize with how hard it is for me to tell my family \.)) (0 :gist)
  1 (0 .SHOULD 2 .BE 4 .DIFFICULT 6 .TELL 1 .FAMILY-PRON 0)
    2 ((You empathize with how hard it is for me to tell my family \.)) (0 :gist)
  1 (0 .SHOULD 2 .BE 4 .FRIGHTENING 6 .TELL 1 .FAMILY-PRON 0)
    2 ((You empathize with how hard it is for me to tell my family \.)) (0 :gist)

; ````````````````````     test-results      ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````   treatment-option    ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````    treatment-goals    ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ```````````````````` open-ended-statement  ```````````````````````
; ``````````````````````````````````````````````````````````````````

  ; You empathize with how hard my condition is for me.
  1 (0 .KNOW-GEN 4 .BE 3 .DIFFICULT 0)
    2 ((You empathize with how hard it is to learn my cancer is terminal \.)) (0 :gist)
  1 (0 .KNOW-GEN 4 how 2 .DIFFICULT 0)
    2 ((You empathize with how hard it is to learn my cancer is terminal \.)) (0 :gist)
  1 (0 .KNOW-GEN 4 how 2 .FEAR-WORDS 0)
    2 ((You empathize with how hard it is to learn my cancer is terminal \.)) (0 :gist)
  1 (0 .SHOULD 2 .BE 4 .DIFFICULT 0)
    2 ((You empathize with how hard it is to learn my cancer is terminal \.)) (0 :gist)
  1 (0 .SHOULD 2 .BE 4 .FRIGHTENING 0)
    2 ((You empathize with how hard it is to learn my cancer is terminal \.)) (0 :gist)
  ; You will help me and my family through the treatment process.
  1 (0 .DOCTOR-PRON 4 .BE 2 .AVAILABLE 2 you 4 .CARE 0)
    2 ((You will help me and my family through the treatment process \.)) (0 :gist)
  1 (0 .DOCTOR-PRON 4 .BE 2 .AVAILABLE 2 you 4 .DIFFICULT 1 time 0)
    2 ((You will help me and my family through the treatment process \.)) (0 :gist)
  1 (0 .DOCTOR-PRON 4 .BE 2 .AVAILABLE 2 .FAMILY-PRON 0)
    2 ((You will help me and my family through the treatment process \.)) (0 :gist)
  1 (0 .DOCTOR-PRON 4 .BE 2 .AVAILABLE 2 .HELP 0)
    2 ((You will help me and my family through the treatment process \.)) (0 :gist)
  1 (0 .DOCTOR-PRON 4 .MED-HELP 2 .FAMILY 0)
    2 ((You will help me and my family through the treatment process \.)) (0 :gist)
  1 (0 .DOCTOR-PRON 4 .BE 2 .AVAILABLE 2 every 1 step 2 way 0)
    2 ((You will help me and my family through the treatment process \.)) (0 :gist)

  ; Generic remarks
  1 (0 .NICE to .MEET you 0)
    2 ((It is nice to meet me \.)) (0 :gist)
  1 (0 I 1 .APPRECIATE 2 .AVATAR-ITEMS 0)
    2 ((You like my 6 \.)) (0 :gist)
  1 (0 thank 2 you 2 .COME 0)
    2 ((You are glad that I came to this appointment \.)) (0 :gist)
  1 (0 .HAPPY-WORDS 3 you 2 here 0)
    2 ((You are glad that I came to this appointment \.)) (0 :gist)

  ; Goodbye
  1 (3 .BYE 3)
    2 ((Goodbye \.) (Say-bye)) (0 :gist)
  1 (3 talk 2 again 2 soon 3)
    2 ((Goodbye \.) (Say-bye)) (0 :gist)
  1 (3 talk to you 1 soon 3)
    2 ((Goodbye \.) (Say-bye)) (0 :gist)
  1 (3 talk 2 again 2 next 2 .APPOINTMENT 3)
    2 ((Goodbye \.) (Say-bye)) (0 :gist)
  1 (3 until next time 3)
    2 ((Goodbye \.) (Say-bye)) (0 :gist)

)) ; END *statement-input*