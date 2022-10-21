;; Initial facts to add to the avatar's knowledge base
;;
;; TODO: need to deal with this in a more principled way - some of
;; these facts may be episodic memory, and some sort of retrieval
;; is needed for picking out relevant facts in generation.

(defparameter *init-knowledge* '(
  ;; (Sophie is a woman \.)
  (^me ((pres be.v) (= (a.d woman.n))))
  ;; (Sophie is 65 years old \.)
  (^me ((pres be.v) ((mod-a (65.a (plur year.n))) old.a)))
  ;; (Sophie has lung cancer \.)
  (^me ((pres have.v) (k (lung.n cancer.n))))
  ;; (Sophie has pain in her chest \.)
  (^me ((pres have.v) (k (n+preds pain.n (in.p ((^me 's) chest.n))))))
  ;; (Sophie is taking Lortab for her pain \.)
  (^me ((pres take.v) (k |Lortab|.n) (adv-a (for.p ((^me 's) pain.n)))))
  ;; (Sophie wants to be able to watch her grandson graduate \.)
  (^me ((pres want.v) (to (be.v able.a (to (watch.v ((^me 's) grandson.n) (ke graduate.v)))))))
))