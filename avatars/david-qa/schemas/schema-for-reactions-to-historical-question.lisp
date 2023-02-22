
;; July, 11/19: define the schema *reactions-to-historical-question*
;; ================================================================
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
;; question-deflection responses by Eta like "Let's keep the 
;; focus on you". Anyway, in future, we might provide multiple
;; applicable schemas in "choose-reactions-to-input.lisp", and
;; choose from these (via a small choice tree, even if only to
;; vary response styles by using non-zero latency?)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *reactions-to-historical-question*

  '(event-schema :header ((^me react-to-historical-question) ** ?e)
  ;````````````````````````````````````````````````````````````````````````````````````
    :episodes (
              ;; ?e1 (^me perceive-world.v |Blocks-World-System| ?ulf ?perceptions)
              ;; ?e2 (:store-in-context (get-actions.f ?perceptions))
               ; this is where Eta "sees" the blocks world, specifically block movements.
               ; ?perceptions is given as a list of propositions reflecting Eta's perceptions
               ; e.g. locations of blocks (at-loc.p), things that have moved (move.v), etc.
              ?e1 (^you articulate2-to.v ^me ?ulf)
              ?e3 (^me recall-answer.v ?ulf ?ans-relations)
               ; this would attempt to recall an answer from Eta's context (containing
               ; block moves at each time step), using the observed locations of blocks
               ; at the present time step.
              ?e4 (^me conditionally-paraphrase-to.v ^you ?ulf ?ans-relations)
               ; here ?ans is split off from ?ans+alternates;
               ; "conditionally say to you" would normally expand
               ; into just (me say-to.v you '?ans); but I'm thinking
               ; of keeping the door open to something more complex,
               ; in cases where Georgiy's system provides multiple,
               ; weighted possibilities, in which case one might
               ; instantiate a subplan for generating a main answer
               ; but also mention alternates (attached as property
               ; to ?e4, I suppose).
    )

)) ; END parameter *reactions-to-historical-question*


(setf (get '*reactions-to-historical-question* 'semantics) (make-hash-table))
 ; To fill this in, EL formulas would need to be derived from
 ; Eta reactions (not yet used). This would be rather unlike
 ; the explicit 'store-output-semantics' used in *Eta-schema*
 ; (see "Eta5-schema.lisp").


(setf (get '*reactions-to-historical-question* 'gist-clauses) (make-hash-table))
 ; Much the same comment as above applies -- something other than
 ; the straightforward 'store-output-gist-clauses' used in
 ; the *Eta-schema* code would be needed.

(setf (get '*reactions-to-historical-question* 'topic-keys) (make-hash-table))

