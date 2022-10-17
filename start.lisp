;; January 6/2020
;; ================================================
;;
;; Starts Eta using the configuration specified in config.lisp
;;

; Load the config file corresponding to the session's agent-id.
; TODO: could modify this to auto-generate a default config file if one doesn't exist for the agent-id.
(load
  (if (and (boundp '*agent-id*) *agent-id* (or (stringp *agent-id*) (numberp *agent-id*))
           (probe-file (format nil "config/~a.lisp" *agent-id*)))
    (format nil "config/~a.lisp" *agent-id*)
    (format nil "config/config.lisp")))


; Hash tables used for loading word 'is-a' features
(defparameter *isa-features* (make-hash-table)) ; the table with 'isa' data, linking atoms to dot-features
(defparameter *underlying-feat* (make-hash-table)) ; contains feat for dot-predicates of form .feat


(defun get-io-path (fname)
;``````````````````````````
; Yields IO path for avatar instance.
;
  (concatenate 'string *io-path* fname)
) ; END get-io-path


(defun clean-io-files ()
;``````````````````````````
; Overwrites all io files used by Eta with blank files.
;
  (ensure-directories-exist "./io/")
  (ensure-directories-exist *io-path*)
  (ensure-directories-exist (get-io-path "in/"))
  (ensure-directories-exist (get-io-path "out/"))
  (ensure-directories-exist (get-io-path "conversation-log/"))
  (when *read-log-mode*
    (ensure-directories-exist "./logs/")
    (ensure-directories-exist "./logs/logs/")
    (ensure-directories-exist "./logs/logs_out/")
    (ensure-directories-exist "./logs/logs_out/text/")
    (ensure-directories-exist "./logs/logs_out/gist/")
    (ensure-directories-exist "./logs/logs_out/ulf/"))

  ; Ensure all standard input & output files for registered subsystems exist and are empty
  ; Note: input files only created for non-terminal systems,
  ;       output files are only created for non-terminal and non-audio systems
  (mapcar (lambda (system)
  (let ((fname-in (if (not (member system '(|Terminal|)))
                  (concatenate 'string (get-io-path "in/") (string system) ".lisp")))
        (fname-out (if (not (member system '(|Terminal| |Audio|)))
                  (concatenate 'string (get-io-path "out/") (string system) ".lisp"))))
    (if fname-in
    (with-open-file (outfile fname-in :direction :output :if-exists
                                      :supersede :if-does-not-exist :create)))
    (if fname-out
    (with-open-file (outfile fname-out :direction :output :if-exists
                                      :supersede :if-does-not-exist :create)))))
  (append *subsystems-perception* *subsystems-specialist*))

  ; Delete the contents of conversation-log files
  (with-open-file (outfile (get-io-path "conversation-log/text.txt")
    :direction :output :if-exists :supersede :if-does-not-exist :create))
  (with-open-file (outfile (get-io-path "conversation-log/gist.txt")
    :direction :output :if-exists :supersede :if-does-not-exist :create))
  (with-open-file (outfile (get-io-path "conversation-log/ulf.txt")
    :direction :output :if-exists :supersede :if-does-not-exist :create))

  ; Delete the content of the sessionInfo.lisp file after reading
  (with-open-file (outfile (get-io-path "sessionInfo.lisp")
    :direction :output :if-exists :supersede :if-does-not-exist :create))
  ; Delete the content of output.txt, if it exists, otherwise create
  (with-open-file (outfile (get-io-path "output.txt")
    :direction :output :if-exists :supersede :if-does-not-exist :create))                                                                      
) ; END clean-io-files





(defun load-avatar-files (avatar-name)
;``````````````````````````````````````
; Loads all schema and rule files used by a particular avatar
;
  (labels ((load-files-recur (directory)
      (mapcar (lambda (d)
          (mapcar (lambda (f) (load f))
            (directory (concatenate 'string (namestring d) "/*.lisp")))
          (load-files-recur (concatenate 'string
            (coerce (butlast (explode (namestring d))) 'string) "/*")))
        (remove nil (mapcar (lambda (p)
            ; This is pretty awkward, but has to be done to handle differences btwn ACL and SBCL
            (if (fboundp 'probe-directory)
              (if (probe-directory p) p)
              (if (not (pathname-name p)) p)))
          (directory directory))))))
    ; Load all shared rules and schemas files
    (load-files-recur (concatenate 'string "./avatars/" avatar-name "/schemas"))
    (load-files-recur (concatenate 'string "./avatars/" avatar-name "/rules"))
    ; If a multi-session avatar, load all files specific to that day
    (when (and (boundp '*session-number*) (integerp *session-number*))
      (load-files-recur (concatenate 'string "./avatars/" avatar-name "/" (format nil "day~a" *session-number*)))))
) ; END load-avatar-files





; Set IO path based on agent ID (using basic path if no ID is defined)
(defparameter *io-path*
  (if (and (boundp '*agent-id*) *agent-id* (or (stringp *agent-id*) (numberp *agent-id*)))
    (format nil "./io/~a/" *agent-id*)
    (format nil "./io/")))





; If live mode, load *user-id* from sessionInfo file (if it exists).
; Otherwise, manually set *user-id* (or prompt user for input).
;````````````````````````````````````````````````````````````````
(defparameter *user-id* nil)
(if (probe-file (get-io-path "sessionInfo.lisp"))
  (load (get-io-path "sessionInfo.lisp")))
(when (not *user-id*)
  (defparameter *user-id* "_test")
  ;; (format t "~%~%Enter user-id ~%")
  ;; (princ "user id: ") (finish-output)
  ;; (setq *user-id* (write-to-string (read))))
)


; Clean IO files, load Eta, and load avatar-specific files
;``````````````````````````````````````````````````````````
(clean-io-files)
(load "load-eta.lisp")
(load-avatar-files *avatar*)


(cond

  ; Run Eta (safe mode)
  ;`````````````````````````
  (*safe-mode*
    (handler-case (eta :subsystems-perception *subsystems-perception* :subsystems-specialist *subsystems-specialist*
                       :emotions *emotion-tags* :dependencies *dependencies* :debug-patterns *debug-patterns-mode*)
      (error (c)
        (error-message "Execution of Eta failed due to an internal error.")
        (values 0 c))))

  ; Run Eta (read-log mode)
  ;`````````````````````````
  (*read-log-mode*
    (let ((logs (if (stringp *read-log-mode*)
                  (directory (concatenate 'string "logs/logs/" *read-log-mode*))
                  (directory "logs/logs/*"))))
      ; Create empty log_out file
      (mapcar (lambda (log)
        (with-open-file (outfile (pathname (concatenate 'string "logs/logs_out/" (pathname-name log)))
          :direction :output :if-exists :supersede :if-does-not-exist :create))) logs)
      ; Start eta using log
      (mapcar (lambda (log)
        (format t "==:: READING LOG ~a ::==~%" log)
        (load "load-eta.lisp")
        (load-avatar-files *avatar*)
        (eta :read-log log :subsystems-perception *subsystems-perception* :subsystems-specialist *subsystems-specialist*
             :emotions *emotion-tags* :dependencies *dependencies* :debug-patterns *debug-patterns-mode*)) logs)))

  ; Run Eta
  ;`````````````````````````
  (t (eta :subsystems-perception *subsystems-perception* :subsystems-specialist *subsystems-specialist*
          :emotions *emotion-tags* :dependencies *dependencies* :debug-patterns *debug-patterns-mode*)))


; Write user gist clauses to file
;````````````````````````````````````
(print-gist-kb :filename
  (ensure-directories-exist (concatenate 'string "./gist-kb/" *user-id* ".txt")))