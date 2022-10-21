;;
;; *avatar* : specify the name of one of the available avatars to use
;;
;; *avatar-name* : the full name of the avatar to use
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
;; *dependencies* : NIL to only include local packages (note that some applications may not work without Quicklisp dependencies).
;;                  Otherwise provide a list of quicklisp packages to be loaded at runtime.
;;
;; *generation-mode* : The method to use for generating responses at system reaction schema steps:
;;                     GPT3: uses GPT-3 to generate a response using a prompt created automatically from
;;                           the current schema, relevant knowledge, and sentence to paraphrase (if any).
;;                     RULE (default): uses pattern transduction trees to select reactions/responses.
;;
;; *safe-mode* : T to exit smoothly if exception is thrown during execution,
;;               NIL otherwise
;;
;; *user-id* : unique ID of user (potentially overwritten by sessionInfo.lisp if in live mode)
;;
;; *session-number* : the number session to load (a session-number of 1 corresponds to the files in the day1 directory of an avatar)
;;                    in a multi-session dialogue (potentially overwritten by sessionInfo.lisp if in live mode)
;;

(defparameter *avatar* "sophie-gpt-test")
(defparameter *avatar-name* "Sophie Hallman")
(defparameter *read-log-mode* NIL)
(defparameter *subsystems-perception* '(|Terminal| |Audio|))
(defparameter *subsystems-specialist* '())
(defparameter *emotion-tags* T)
(defparameter *dependencies* '("gpt3-shell"))
(defparameter *generation-mode* 'GPT3)
(defparameter *safe-mode* NIL)
(defparameter *session-number* 1)
 