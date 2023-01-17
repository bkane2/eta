; The rules defined in this file contain reactions to specific gist clause statements from the user, in the form of either
; subschemas to instantiate or direct templatic outputs. Note that, in general, GPT-3 generation will be able to
; handle response generation in cases where a specific reaction is not selected here, so these rules are mainly
; used for subschema selection.
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
;

; Define any useful predicates here:
(defpred !not-non-alcoholic x (not (isa x 'non-alcoholic)))
(defpred !not-medicine-gen x (not isa x 'medicine-gen))


(READRULES '*reaction-to-statement*
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



; ````````````````````       medicine        ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````         pain          ```````````````````````
; ``````````````````````````````````````````````````````````````````

  ;; 1 (0 you 2 sorry 2 I am in pain 0)
  ;;   2 () (0 :out)

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

  ; Example explicit response
  1 (0 the prognosis is that I may live for 0)
    2 (:or
        ([SAD] That\'s really difficult to hear \. I thought for sure I would have longer than that \.)
        ([SAD] I knew the prognosis would be bad \, but I wasn\'t expecting to hear that \. I don\'t know how to handle this \.)
        ([SAD] I thought I would have more time than that left \. That\'s extremely depressing to hear \.))
      (0 :out)

; ````````````````````     sleep-poorly      ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````      tell-family      ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````     test-results      ```````````````````````
; ``````````````````````````````````````````````````````````````````

  ; Example empathetic response
  1 (0 you recognize how hard receiving the test results is for me 0)
    2 (:or
        (It was difficult for me to accept the test results \. I\'m still having a hard time coping with the news \,
        but I appreciate your help \.)
        (It\'s just a lot for me to take in at once \.)
        (It\'s never easy to hear things like this \. I think I just need time \.))
      (0 :out)

; ````````````````````   treatment-option    ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````    treatment-goals    ```````````````````````
; ``````````````````````````````````````````````````````````````````

  ;; ; Empowering responses
  ;; 1 (0 do I want to try to fight the cancer 0)
  ;;   2 () (0 :out)
  ;; 1 (0 what are my treatment goals 0)
  ;;   2 () (0 :out)
  ;; 1 (0 what scares me about my condition 0)
  ;;   2 () (0 :out)
  ;; 1 (0 what is the most important thing for my future 0)
  ;;   2 () (0 :out)
  ;; 1 (0 what would help me manage my condition 0)
  ;;   2 () (0 :out)

; ```````````````````` open-ended-statement  ```````````````````````
; ``````````````````````````````````````````````````````````````````

  ; Empathetic responses
  ;; 1 (0 you 2 sorry 0)
  ;;   2 (I appreciate it \. It\'s all just very difficult to take in \.) (5 :out)
  ;;   2 (Thanks \. I\'m just trying to make sense of it all \.) (5 :out)
  ;;   2 (It\'s just very difficult to handle \.) (0 :out)

  ; Goodbye responses
  1 (0 goodbye 0)
    2 (Thank you for meeting with me today \. Bye \.) (0 :out)

)) ; END *reaction-to-statement*