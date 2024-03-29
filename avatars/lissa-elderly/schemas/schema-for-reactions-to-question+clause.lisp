
;; Aug, 25/15: define the schema *reactions-to-question+clause*
;; ============================================================
;; 
;; This is intended to "work" for one or more non-question gist 
;; clauses followed by a final gist-clause question.
;;
;; The idea is to react to the question first, followed by "so" 
;; (as a new-topic-initiation signal), followed by a reaction to
;; the initial gist clause. (So this schema ignores any intermediate
;; clauses.) 
;;
;; An alternative would be to react to the initial gist clause
;; first, followed by "As for your question," or something similar;
;; in general, it seems to require stronger discourse signals to
;; get back to an unanswered question than to get back to another
;; component of the user's input. Also, this would work well for 
;; question-deflection responses by Lissa like "Let's keep the 
;; focus on you". Anyway, in future, we might provide multiple
;; applicable schemas in "choose-reactions-to-input.lisp", and
;; choose from these (via a small choice tree, even if only to
;; vary response styles by using non-zero latency?)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *reactions-to-question+clause*

; ** Right now, this schema is the same as *reactions-to-question+clause*
;    and so is really redundant. However, it may well turn out that
;    different sorts of connective phrases (other than "so,") are
;    called for when the question precedes an assertion, rather
;    than being preceded by an assertion.

'(event-schema :header ((^me react-to-question+clause.v ?question ?clause) ** ?e)
;`````````````````````````````````````````````````````````````````````````````````
; LISSA reacts to a gist-clause question plus a (brief) added gist 
; clause assertion from the user (in response to a LISSA question).
;
; The schema simply combines a reaction to the question and perhaps
; a reaction to the extra clause. To be able to process individual
; (^me react-to.v ...) components in the usual way, we "hallucinate"
; separate user inputs of form
;    (^you paraphrase-to.v ^me '...)
; containing single user gist clauses, viewing these as what the
; use had in mind but "paraphrased" in the context of the preceding
; Lissa question.

:episodes ( ; we start execution at this keyword
            ; (other schema components are omitted for the time being.)
?e1 (^you paraphrase-to.v ^me '?question)

?e2 (^me react-to.v ?e1)

?e3 (^me say-to.v ^you '(So \,))

?e4 (^you paraphrase-to.v ^me '?answer)

?e5 (^me react-to.v ?e4)

)

)); end of parameter *reactions-to-question+clause*


;````````````````````````````````````````````````````````
; Store schema variable name under header in *schemas*
;
(store-schema-name 'reactions-to-question+clause.v
                  '*reactions-to-question+clause*)


(setf (get '*reactions-to-question+clause* 'semantics) 
      (make-hash-table))
 ; To fill this in, EL formulas would need to be derived from
 ; Lissa reactions (not yet used). This would be rather unlike
 ; the explicit 'store-output-semantics' used in *lissa-schema*
 ; (see "lissa5-schema.lisp").


(setf (get '*reactions-to-question+clause* 'gist-clauses) 
      (make-hash-table))
 ; Much the same comment as above applies -- something other than
 ; the straightforward 'store-output-gist-clauses' used in
 ; the *lissa-schema* code would be needed.

