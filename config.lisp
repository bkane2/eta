;;
;; *avatar* : specify the name of one of the available avatars to use
;;
;; *read-log-mode* : If T, reads and emulates each of the log files in logs/ directory, allows user corrections, and outputs new
;;                   log files in logs_out/
;;                   If a string corresponding to a file name, read just that file from logs/
;;                   (NOTE: currently only relevant to david/blocks world)
;;
;; *subsystems* : A list of subsystems registered with Eta. Supported: |Audio|, |Terminal|, |Blocks-World-System|
;;
;; *dependencies* : T to include Quicklisp dependencies, NIL to only include local packages (note that some applications may not
;;                  work without Quicklisp dependencies).
;;
;; *safe-mode* : T to exit smoothly if exception is thrown during execution,
;;               NIL otherwise
;;
;; *user-id* : unique ID of user (potentially overwritten by sessionInfo.lisp if in live mode)
;;

(defparameter *avatar* "david-tutoring")
(defparameter *read-log-mode* NIL)
(defparameter *subsystems* '(|Terminal| |Blocks-World-System|))
(defparameter *dependencies* T)
(defparameter *safe-mode* NIL)
