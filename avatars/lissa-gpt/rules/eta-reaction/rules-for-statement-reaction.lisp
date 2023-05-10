; The rules defined in this file contain reactions to specific gist clause statements from the user, in the form of either
; subschemas to instantiate or direct templatic outputs. Note that, in general, GPT-3 generation will be able to
; handle response generation in cases where a specific reaction is not selected here, so these rules are mainly
; used for subschema selection.
;

; Define any useful predicates here:


(READRULES '*reaction-to-statement*
'(
; ````````````````````        topic          ```````````````````````
; ``````````````````````````````````````````````````````````````````



; ````````````````````       general         ```````````````````````
; ``````````````````````````````````````````````````````````````````

  1 (NIL Statement \.)
    2 respond-to-statement.v (0 :schema)
    ;; 2 ask-question.v (0 :schema)

)) ; END *reaction-to-statement*