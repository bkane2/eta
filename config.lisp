;;
;; *avatar* : specify the name of one of the available avatars to use
;;
;; *read-log-mode* : If T, reads and emulates each of the log files in logs/ directory, allows user corrections, and outputs new
;;                   log files in logs_out/
;;                   If a string corresponding to a file name, read just that file from logs/
;;                   (NOTE: currently only relevant to david/blocks world)
;;
;; *subsystems-perception* : A list of perception subsystems registered with Eta.
;;                           Supported: |Audio|, |Terminal|, |Blocks-World-System|
;;
;; *subsystems-specialist* : A list of specialist subsystems registered with Eta.
;;                           Supported: |Spatial-Reasoning-System|
;;
;; *emotion-tags* : T to allow insertion of emotion tags (e.g., [SAD]) at beginning of outputs. If no emotion tag is
;;                  explicitly specified in the output, a default [NEUTRAL] tag will be prepended.
;;                  NIL to disable emotion tags. Any tags at the beginning of :out directives will be stripped.
;;
;; *opportunity-tags* : T to allow insertion of opportunity tags (e.g., [OPPORTUNITY]) at beginning of outputs to
;;                      signal to an external feedback system that the user has an opportunity for a particular type
;;                      of response. NIL to disable opportunity tags.
;;
;; *dependencies* : T to include Quicklisp dependencies, NIL to only include local packages (note that some applications may not
;;                  work without Quicklisp dependencies).
;;
;; *safe-mode* : T to exit smoothly if exception is thrown during execution,
;;               NIL otherwise
;;
;; *user-id* : unique ID of user (potentially overwritten by sessionInfo.lisp if in live mode)
;;
;; *session-number* : the number session to load (a session-number of 1 corresponds to the files in the day1 directory of an avatar)
;;                    in a multi-session dialogue (potentially overwritten by sessionInfo.lisp if in live mode)
;;

(defparameter *avatar* "sophie")
(defparameter *read-log-mode* NIL)
(defparameter *subsystems-perception* '(|Terminal| |Audio|))
(defparameter *subsystems-specialist* '())
(defparameter *emotion-tags* T)
(defparameter *opportunity-tags* T)
(defparameter *dependencies* NIL)
(defparameter *safe-mode* NIL)
(defparameter *session-number* 1)
 