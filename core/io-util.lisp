;; Aug 13/2020
;; ================================================
;;
;; Contains utility functions used for file IO
;;


(defun read-from-system (system)
;``````````````````````````````````
; Reads input (as a list of propositions) from given subsystem.
;
  (case system
    (|Audio| (read-audio))
    (|Terminal| (read-terminal))
    (otherwise (read-subsystem system)))
) ; END read-from-system



(defun read-terminal ()
;```````````````````````
; Scans input from the terminal. If the user presses enter, read the
; input, create and return a (^you say-to.v ^me '(...)) proposition.
; NOTE: previously in eta.lisp, it would call detach-final-punctuation
; after reading input from hear-words or read-words. However, I suspect
; we want punctuation since Google ASR is capable of it. The pattern-
; matching files therefore need to take punctuation into account.
;
  (when (listen)
    (let ((text (parse-chars (coerce (read-line) 'list))))
      (if text `((^you say-to.v ^me ',text)))))
) ; END read-terminal



(defun read-audio ()
;`````````````````````
; Reads input from |Audio| subsystem (i.e., (^you say-to.v ^me '(...)), or
; possibly (^you say-to.v ^me "...")) propositions from io/Audio.lisp.
; NOTE: previously in eta.lisp, it would call detach-final-punctuation
; after reading input from hear-words or read-words. However, I suspect
; we want punctuation since Google ASR is capable of it. The pattern-
; matching files therefore need to take punctuation into account.
; 
  (setq *input* nil)
  (load "./io/Audio.lisp")
  (if *input*
    (with-open-file (outfile "./io/Audio.lisp" :direction :output
                                               :if-exists :supersede
                                               :if-does-not-exist :create)))
  (mapcar (lambda (wff)
      ; If say-to.v argument given in string form, parse it into list form
      (if (and (equal (butlast wff) '(^you say-to.v ^me)) (stringp (car (last wff))))
        (append (butlast wff) `(',(parse-chars (coerce (car (last wff)) 'list))))
        wff))
    *input*)
) ; END read-audio



(defun read-subsystem (system)
;```````````````````````````````````
; Reads input ULF propositions from io/in/<system>.lisp.
;
  (let ((fname (concatenate 'string "./io/in/" (string system) ".lisp")))
  (setq *input* nil)
  (load fname)
  (if *input*
    (with-open-file (outfile fname :direction :output
                                   :if-exists :supersede
                                   :if-does-not-exist :create)))
  *input*
)) ; END read-subsystem



(defun write-subsystem (output system)
;`````````````````````````````````````````
; Writes output/"query" ULF propositions to io/out/<system>.lisp.
;
  (let ((fname (concatenate 'string "./io/out/" (string system) ".lisp")))
    (with-open-file (outfile fname :direction :output
                                   :if-exists :supersede
                                   :if-does-not-exist :create)
      (format outfile "(setq *output* ~a)" output))
)) ; END write-subsystem



(defun print-words (wordlist)
;``````````````````````````````
; This is intended for the keyboard-based mode of interaction,
; i.e., with *live* = nil.
;
  (format t "~%...")
  (dolist (word wordlist)
    (princ " ")
    (princ word)
    (if (or (member word '(? ! \.))
            (member (car (last (explode word))) '(#\? #\! #\.)))
      (format t "~%")))
) ; END print-words



(defun say-words (wordlist)
;````````````````````````````
; This is intended for th *live* = T mode of operation, i.e., I/O
; is via the virtual agent; (but the output is printed as well).
; For terminal mode only, we use 'print-words'.
;
  (let (wordstring)
    ; Write ETA's words to "./io/output.txt" as a continuous string
    ; (preceded by the output count and a colon)
    (dolist (word wordlist)
      (push (string word) wordstring)
      (push " " wordstring))
    (setq wordstring (reverse (cdr wordstring)))
    (setq wordstring (eval (cons 'concatenate (cons ''string wordstring))))

    ; Increment output number
    (setq *output-count* (1+ *output-count*))
	  
    ; Output words
    (with-open-file (outfile "./io/output.txt" :direction :output
                                               :if-exists :append
                                               :if-does-not-exist :create)
      (format outfile "~%#~D: ~a" *output-count* wordstring))

    ; Also write ETA's words to standard output:
    (format t "~% ... ")
    (dolist (word wordlist)
      (format t "~a " word)
      (if (or (member word '(? ! \.))
              (member (car (last (explode word))) '(#\? #\! #\.)))
        (format t "~%")))
    (format t "~%")
)) ; END say-words





;; --------------------------------------------------
;; The functions after this point need to be vetted.
;; --------------------------------------------------





(defun read-input-timeout (n)
;``````````````````````````````
; Reads terminal input for n seconds and returns accumulated string.
;
  (finish-output)
  (let ((i 0) result)
    (loop while (< i n) do
      (sleep 1)
      (if (listen) (setq result (cons " " (cons (read-line) result))))
      (setq i (+ 1 i)))
    (if (listen) (setq result (cons (read-line) result)))
    (eval (append '(concatenate 'string) (reverse result))))
) ; END read-input-timeout



(defun read-log-contents (log)
;```````````````````````````````
; Reads the contents of a given log file and converts to list.
;
  (let (result)
    (with-open-file (logfile log :if-does-not-exist :create)
      (do ((l (read-line logfile) (read-line logfile nil 'eof)))
          ((eq l 'eof) "Reached end of file.")
        (setq result (concatenate 'string result " " l))))
    (read-from-string (concatenate 'string "(" result ")")))
) ; END read-log-contents



(defun write-ulf (ulf)
;````````````````````````
; Writes a ulf to the file ulf.lisp, so that it can be used
; by the blocksworld system.
;
  (with-open-file (outfile "./io/ulf.lisp" :direction :output
                                        :if-exists :supersede
                                        :if-does-not-exist :create)
    (format outfile "(setq *next-ulf* ~a)" ulf))
) ; END write-ulf



(defun read-words (&optional str) 
;``````````````````````````````````
; This is the input reader when ETA is used with argument live =
; nil (hence also *live* = nil), i.e., with terminal input rather
; than live spoken input.
; If optional str parameter given, simply read words from str.
;
  (finish-output)
  (parse-chars (coerce (if str str (read-line)) 'list))
) ; END read-words



(defun hear-words (&key (delay nil)) 
;`````````````````````````````````````
; This waits until it can load a character sequence from "./io/input.lisp",
; which will set the value of *next-input*, and then processes *input*
; in the same way as the result of (read-line) is processed in direct
; terminal input mode.
; If some delay (an integer) is given, move on if no words heard after that
; number of seconds.
;
  (let ((s 0))
    ; Write empty star line to output to prompt avatar to listen
    ; TODO: there has to be a better way of doing this...
    (setq *output-count* (1+ *output-count*))
    (with-open-file (outfile "./io/output.txt" :direction :output
                                               :if-exists :append
                                               :if-does-not-exist :create)
      (format outfile "~%*~D: dummy" *output-count*))

    (setq *next-input* nil)
    (loop while (and (not *next-input*) (or (not delay) (< s delay))) do
      (sleep .5)
      (setq s (+ s .5))
      (progn
        (load "./io/input.lisp")
		    (if *next-input*
          (progn
            (format t "~a~%" *next-input*)
            (with-open-file (outfile "./io/input.lisp" :direction :output 
                                                       :if-exists :supersede
                                                       :if-does-not-exist :create))))))
          
  (parse-chars (coerce *next-input* 'list))
)) ; END hear-words



(defun get-perceptions () 
;``````````````````````
; This waits until it can load a list of block perceptions from "./io/perceptions.lisp".
; This should have a list of relations of the following two forms:
; ((the.d (|Twitter| block.n)) at-loc.p ($ loc ?x ?y ?z))
; ((the.d (|Toyota| block.n)) ((past move.v) (from.p-arg ($ loc ?x1 ?y1 ?z1)) (to.p-arg ($ loc ?x2 ?y2 ?z2))))
;
  (setq *next-perceptions* nil)
  (loop while (not *next-perceptions*) do
    (sleep .5)
    (progn
      (load "./io/perceptions.lisp")
		  (if *next-perceptions*
        (with-open-file (outfile "./io/perceptions.lisp" :direction :output 
                                                 :if-exists :supersede
                                                 :if-does-not-exist :create)))))
          
  *next-perceptions*
) ; END get-perceptions



(defun get-perceptions-offline () 
;``````````````````````````````````
; This is the perceptions reader when ETA is used with argument live =
; nil (hence also *live* = nil)
;
  (finish-output)
  (format t "enter perceptions below:~%")
  (finish-output)
  (read-from-string (read-line))
) ; END get-perceptions-offline



(defun load-obj-schemas ()
;```````````````````````````````````````````````
; Load core object schemas
; (in directory 'core/resources/obj-schemas')
; NOTE: I don't like having this here (loaded during Eta's
; 'init' function), but it's currently necessary since
; the equality sets and context are only defined in 'init'.
;
(mapcar (lambda (file) (load file))
    (directory "core/resources/obj-schemas/*.lisp"))
) ; END load-obj-schemas



(defun request-goal-rep (wff)
;`````````````````````````````
; Writes a formula (containing an indefinite quantifier with a lambda abstract)
; to the file goal-request.lisp, so that it can be processed by BW system.
;
  (with-open-file (outfile "./io/goal-request.lisp" :direction :output
                                                    :if-exists :supersede
                                                    :if-does-not-exist :create)
    (format outfile "(setq *goal-request* '~s)" wff))
) ; END request-goal-rep



(defun get-goal-rep ()
;```````````````````````
; This waits until it can load a goal representation from "./io/goal-rep.lisp".
;
  (setq *goal-rep* nil)
  (loop while (not *goal-rep*) do
    (sleep .5)
    (progn
      (load "./io/goal-rep.lisp")
		  (if *goal-rep*
        (with-open-file (outfile "./io/goal-rep.lisp" :direction :output 
                                                      :if-exists :supersede
                                                      :if-does-not-exist :create)))))
  *goal-rep*
) ; END get-goal-rep



(defun planner-input-to-ka (planner-input)
;```````````````````````````````````````````
; Converts planner input to the appropriate reified action.
; e.g.:
; Failure -> nil
; None -> (ka (do2.v nothing.pro))
; (|B1| on.p |B2|) -> (ka (put.v |B1| (on.p |B2|)))
; ((|B1| on.p |B2|) (|B1| behind.p |B3|))
;   -> (ka (put.v |B1| (set-of (on.p |B2|) (behind.p |B3|))))
; (undo (|B1| on.p |B2|)) -> (ka (move.v |B1| (back.mod-a (on.p |B2|))))
; (clarification (|B1| touching.p |B2|)) -> (ka (make.v |B1| (touching.p |B2|)))
; (clarification (|B1| ((mod-a (by.p (one.d (half.a block.n)))) to_the_left.a)))
;   -> (ka (make.v |B1| ((mod-a (by.p (one.d (half.a block.n)))) to_the_left.a)))
;
  (cond
    ((equal planner-input 'Failure) nil)
    ((equal planner-input 'None)
      '(ka (do2.v nothing.pro)))
    ((atom planner-input) nil)
    ; If single relation, convert to put.v ka
    ((relation-prop? planner-input)
      `(ka (put.v ,(car planner-input)
                  ,(cdr1 planner-input))))
    ; If multiple relations, convert to put.v ka with plural argument
    ((every #'relation-prop? planner-input)
      `(ka (put.v ,(caar planner-input)
                  ,(make-set (mapcar #'cdr1 planner-input)))))
    ; If undo step, generate put.v ka and transform to 'move back' ka
    ((undo-relation-prop? planner-input)
      (ttt:apply-rule
          '(/ (put.v _!1 _!2) (move.v _!1 (back.mod-a _!2)))
        (planner-input-to-ka (second planner-input))))
    ; If clarification step, generate put.v ka and transform to make.v ka
    ((clarification-relation-prop? planner-input)
      (ttt:apply-rule
          '(/ (put.v _!1 _!2) (make.v _!1 _!2))
        (planner-input-to-ka (second planner-input)))))
) ; END planner-input-to-ka



(defun get-planner-input ()
;````````````````````````````
; This waits until it can load a goal representation from "./io/planner-input.lisp".
; The value of *planner-input* is a list of relations that hold after the proposed
; action, e.g., ((|B1| to-the-left-of.p |B2|) (|B1| touching.p |B2|))
; Each relation is assumed to have the same subject.
;
  (setq *planner-input* nil)
  (loop while (not *planner-input*) do
    (sleep .5)
    (progn
      (load "./io/planner-input.lisp")
		  (if *planner-input*
        (with-open-file (outfile "./io/planner-input.lisp" :direction :output 
                                                           :if-exists :supersede
                                                           :if-does-not-exist :create)))))
  (planner-input-to-ka *planner-input*)
) ; END get-planner-input



(defun get-planner-input-offline () 
;````````````````````````````````````
; This is the planner input when ETA is used with argument live =
; nil (hence also *live* = nil)
; The input should be a list of relations that hold after the proposed action,
; e.g., ((|B1| to-the-left-of.p |B2|) (|B1| touching.p |B2|))
; Each relation is assumed to have the same subject.
;
  (finish-output)
  (format t "enter planner input below:~%")
  (finish-output)
  (planner-input-to-ka (read-from-string (read-line)))
) ; END get-planner-input-offline



(defun get-answer () 
;``````````````````````
; This waits until it can load a list of relations from "./io/answer.lisp".
;
  (setq *next-answer* nil)
  (loop while (not *next-answer*) do
    (sleep .5)
    (progn
      (load "./io/answer.lisp")
		  (if *next-answer*
        (with-open-file (outfile "./io/answer.lisp" :direction :output 
                                                    :if-exists :supersede
                                                    :if-does-not-exist :create)))))
          
  (if (equal *next-answer* 'None) nil
    *next-answer*)
) ; END get-answer



(defun get-answer-offline () 
;`````````````````````````````
; This is the answer reader when ETA is used with argument live =
; nil (hence also *live* = nil)
;
  (finish-output)
  (format t "enter answer relations below:~%")
  (finish-output)
  (let ((ans (read-from-string (read-line))))
    (if (equal ans 'None) nil ans))
) ; END get-answer-offline



(defun get-user-try-ka-success () 
;``````````````````````````````````
; This waits until it can load a list of relations from "./io/user-try-ka-success.lisp".
;
  (setq *user-try-ka-success* nil)
  (loop while (not *user-try-ka-success*) do
    (sleep .5)
    (progn
      (load "./io/user-try-ka-success.lisp")
		  (if *user-try-ka-success*
        (with-open-file (outfile "./io/user-try-ka-success.lisp" :direction :output 
                                                                 :if-exists :supersede
                                                                 :if-does-not-exist :create)))))
          
  (if (equal *user-try-ka-success* 'Failure) nil
    *user-try-ka-success*)
) ; END get-user-try-ka-success



(defun get-user-try-ka-success-offline () 
;```````````````````````````````````````````
; This is the user-try-ka-success reader when ETA is 
; used with argument live = nil (hence also *live* = nil)
;
  (finish-output)
  (format t "enter user-try-ka-success below:~%")
  (finish-output)
  (let ((user-try-ka-success (read-from-string (read-line))))
    (if (equal user-try-ka-success 'Failure) nil user-try-ka-success))
) ; END get-user-try-ka-success-offline



(defun get-answer-string () 
;````````````````````````````
; This waits until it can load a character sequence from "./io/answer.lisp",
; which will set the value of *next-answer*, and then processes it.
;
  (setq *next-answer* nil)
  (loop while (not *next-answer*) do
    (sleep .5)
    (progn
      (load "./io/answer.lisp")
		  (if *next-answer*
        (with-open-file (outfile "./io/answer.lisp" :direction :output 
                                                   :if-exists :supersede
                                                   :if-does-not-exist :create)))))
          
  ;; (parse-chars (if (stringp *next-answer*) (coerce *next-answer* 'list)
  ;;                                            (coerce (car *next-answer*) 'list)))
  (cond
    ((stringp *next-answer*) (list (parse-chars (coerce *next-answer* 'list))))
    ((listp *next-answer*) (cons (parse-chars (coerce (car *next-answer*) 'list))
                            (cdr *next-answer*))))
) ; END get-answer-string



(defun update-block-coordinates (moves)
;````````````````````````````````````````
; Given a list of moves (in sequential order), update *block-coordinates*. Return a list of
; perceptions, i.e. the given moves combined with the current block coordinates.
;
  (mapcar (lambda (move)
    (setq *block-coordinates* (mapcar (lambda (coordinate)
        (if (equal (car move) (car coordinate))
          (list (car coordinate) 'at-loc.p (cadar (cddadr move)))
          coordinate))
      *block-coordinates*))) moves)
  (append *block-coordinates* moves)
) ; END update-block-coordinates



(defun verify-log (answer-new turn-tuple filename)
;```````````````````````````````````````````````````
; Given Eta's answer for a turn, allow the user to compare to the answer in the log
; and amend the correctness judgment for that turn. Output to the corresponding
; filename in log_out/ directory.
;
  (let ((filename-out (concatenate 'string "logs/logs_out/" (pathname-name filename)))
        (answer-old (read-words (third turn-tuple))) (feedback-old (fourth turn-tuple)) feedback-new)
    ;; (format t "/~a~%\\~a~%" answer-old answer-new)
    (with-open-file (outfile filename-out :direction :output :if-exists :append :if-does-not-exist :create)
      (cond
        ; If answer is the same, just output without modification
        ((equal answer-old answer-new)
          (format outfile "(\"~a\" ~S \"~a\" ~a)~%" (first turn-tuple) (second turn-tuple) (third turn-tuple) (fourth turn-tuple)))
        ; If question was marked as non-historical, also skip
        ((member (fourth turn-tuple) '(XC XI XP XE))
          (format outfile "(\"~a\" ~S \"~a\" ~a)~%" (first turn-tuple) (second turn-tuple) (third turn-tuple) (fourth turn-tuple)))
        ; If "when" question with specific time, also skip
        ((and (equal "when" (string-downcase (subseq (first turn-tuple) 0 4)))
              (find-if (lambda (x) (member x '(zero one two three four five six seven eight nine ten eleven twelve thirteen
                                               fourteen fifteen sixteen seventeen eighteen nineteen twenty thirty forty
                                               fifty sixty seventy eighty ninety hundred))) answer-old))
          (format outfile "(\"~a\" ~S \"~a\" ~a)~%" (first turn-tuple) (second turn-tuple) (third turn-tuple) (fourth turn-tuple)))
        ; Otherwise, check the new output with the user and prompt them to change feedback

        (t
          (format t " ----------------------------------------------------------~%")
          (format t "| A CHANGE WAS DETECTED IN LOG '~a':~%" (pathname-name filename))
          (format t "| * question: ~a~%" (first turn-tuple))
          (format t "| * old answer: ~a~%" answer-old)
          (format t "| * old feedback: ~a~%" (fourth turn-tuple))
          (format t "| * new answer: ~a~%" answer-new)
          (format t "| > new feedback: ")
          (finish-output) (setq feedback-new (read-from-string (read-line)))
          (format t " ----------------------------------------------------------~%")
          (if (not (member feedback-new '(C I P F E))) (setq feedback-new 'E))
          (format outfile "(\"~a\" ~S \"~a\" ~a)~%"
            (first turn-tuple) (second turn-tuple) (format nil "~{~a~^ ~}" answer-new) feedback-new)))))
) ; END verify-log