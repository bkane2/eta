;; Records telic verbs which are assumed to be "instantaneously" true, and thus need
;; to be removed from context after a certain period of time has passed.   (Jan 7/21)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar *verbs-telic* '(say-to.v reply-to.v react-to.v move.v))