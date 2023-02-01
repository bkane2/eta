;; Initial facts to add to the avatar's knowledge base
;;
;; TODO: currently disused, since the knowledge previously here
;; was added as rigid-conds and static-conds to dialogue schemas.

(defparameter *init-knowledge* '(
  ; Lissa is a woman
  (^me ((pres be.v) (= (a.d woman.n))))
  ; Lissa is 25 years old
  (^me ((pres be.v) ((mod-a (25.a (plur year.n))) old.a)))
  ; Lissa wants to have a casual conversation
  (^me ((pres want.v) (to (have.v (a.d (casual.a conversation.n))))))
))