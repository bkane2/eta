;; Benjamin Kane
;; October 2021
;; 
;; A tool for converting rule files in the old pattern-transduction language to rule files using TT syntax.
;; 
;; Usage:
;; 1. Put directories containing rule files that you wish to convert in the old/ directory.
;; 2. Put general-word-data.lisp (from core/resources/) in the old/ directory.
;; 3. Add the directories that you wish to convert to the *dirs-to-convert* global variable.
;; 4. Enter SBCL and type (load "tt-converter.lisp").
;; 5. The converted rule files will appear in the new/ directory.


(defparameter *dirs-to-convert* '(
  "avatars/david-qa/rules"
  "avatars/david-tutoring/rules"
  "avatars/lissa-elderly/rules"
  "avatars/lissa-elderly/day1/rules"
  "avatars/lissa-elderly/day2/rules"
  "avatars/lissa-elderly/day3/rules"
  "avatars/lissa-elderly/day4/rules"
  "avatars/lissa-elderly/day5/rules"
  "avatars/lissa-elderly/day6/rules"
  "avatars/lissa-elderly/day7/rules"
  "avatars/lissa-elderly/day8/rules"
  "avatars/lissa-elderly/day9/rules"
  "avatars/lissa-elderly/day10/rules"
  "avatars/sophie/rules"
  "avatars/sophie-feedback/rules"
))

(defvar *dir-in* "old/")
(defvar *dir-out* "new/")


(defun get-files-to-convert (dir)
;```````````````````````````````````
; Gets all subfiles of a given directory and converts them to relative path strings.
;
  (mapcar (lambda (fname)
      (second (split-string (namestring fname) "old/")))
    (get-all-subfiles (concatenate 'string "old/" dir)))
) ; END get-files-to-convert


(defun get-all-subfiles (dir)
;````````````````````````````````
; Gets all subfiles of a given directory.
;
  (remove-duplicates (apply #'append (mapcar (lambda (d)
      (append
        (directory (concatenate 'string (namestring d) "/*.lisp"))
        (get-all-subfiles (concatenate 'string
          (coerce (butlast (coerce (namestring d) 'list)) 'string) "/*"))))
    (remove nil (mapcar (lambda (p) (if (not (pathname-name p)) p))
      (directory dir))))))
) ; END get-all-subfiles


(defun split-string (str substr)
;``````````````````````````````````````
; Splits string str based on first occurance of substr.
;
  (let ((chs (coerce str 'list)) (sub-chs (coerce substr 'list)) match-lst temp left right)
    (setq match-lst sub-chs)
    (dolist (ch chs)
      (cond
        ((equal ch (car match-lst))
          (push ch temp)
          (setq match-lst (cdr match-lst)))
        ((and (null match-lst) temp)
          (setq temp nil)
          (push ch right))
        ((and match-lst temp)
          (dolist (ch1 (reverse temp)) (push ch1 left))
          (setq match-lst sub-chs)
          (cond
            ((equal ch (car match-lst))
              (setq match-lst (cdr match-lst))
              (setq temp (list ch)))
            (t (setq temp nil) (push ch left))))
        (match-lst (push ch left))
        ((null match-lst) (push ch right))))
    (list (coerce (reverse left) 'string) (coerce (reverse right) 'string))
)) ; END split-string


(defun remove-deep (x lst &key (test #'eq))
;```````````````````````````````````````````
; Similar to 'remove' function, but recursive.
;
  (cond
    ((atom lst) lst)
    (t (remove x (mapcar (lambda (e) (remove-deep x e :test test)) lst) :test test)))
) ; END remove-deep


(defun remove-if-deep (f lst)
;```````````````````````````````````````````
; Similar to 'remove-if' function, but recursive.
;
  (cond
    ((atom lst) lst)
    (t (remove-if f (mapcar (lambda (e) (remove-if-deep f e)) lst))))
) ; END remove-if-deep


(defun comment-p (x)
;```````````````````````````
; Returns t if input is a list representing a lisp comment.
;
  (and (listp x) (member (car x) '(:c :cn)))
) ; END comment-p


(defun ulf-keyword-p (x)
;``````````````````````````
; Returns t if input is a keyword that has to do with a ulf directive.
;
  (member x '(:ulf :ulf-recur :ulf-coref))
) ; END ulf-keyword-p


(defun subtree+clause-keyword-p (x)
;```````````````````````````````````
; Returns t if input is a keyword that has to do with subtree+clause directive.
;
  (member x '(:subtree+clause))
) ; END subtree+clause-keyword-p


(defun directive-keyword-p (x)
;```````````````````````````````
; Returns t if input is a keyword that has to do with a directive (i.e., any keyword
; other than ones marking comments).
;
  (and (keywordp x) (not (member x '(:c :cn))))
) ; END directive-keyword-p


(defun newline-comment-p (x)
;```````````````````````````
; Returns t if input is a list representing a newline lisp comment.
;
  (and (listp x) (equal (car x) :cn))
) ; END newline-comment-p


(defun escaped-symbol-p (x)
;```````````````````````````````````````````
; Returns t if input is an escaped lisp symbol, i.e., enclosed in |...|
;
  (equal (car (coerce (format nil "~s" x) 'list)) #\|)
) ; END escaped-symbol-p


(defun tag-p (x)
;```````````````````````````````
; Returns t if input is a tag, e.g. [SEP] or [HAPPY].
;
  (let ((chs (coerce (format nil "~a" x) 'list)))
    (and (equal (car chs) #\[) (equal (car (last chs)) #\])))
) ; END tag-p


(defun global-variable-p (x)
;```````````````````````````````````````````
; Returns t if input is a global variable, i.e., enclosed in *...*
;
  (let ((chs (coerce (format nil "~s" x) 'list)))
    (and (equal (car chs) #\*) (equal (car (last chs)) #\*)))
) ; END global-variable-p


(defun feat-symbol-p (x)
;```````````````````````````````````````````
; Returns t if input is a feature symbol, i.e., beginning with .
;
  (equal (car (coerce (format nil "~s" x) 'list)) #\.)
) ; END feat-symbol-p


(defun has-apostrophe-p (x)
;```````````````````````````````````
; Checks whether x contains an apostrophe.
;
  (member #\' (coerce (format nil "~s" x) 'list))
) ; END has-apostrophe-p


(defun has-attached-punct-p (x &key end-punct)
;````````````````````````````````````````````````
; Checks whether x ends with an attached punctuation, e.g. |started,|.
; If :end-punct t is given, only return true if attached punct is an end sentence punctuation.
;
  (member (car (last
      (if (escaped-symbol-p x)
        (butlast (cdr (coerce (format nil "~s" x) 'list)))
        (coerce (format nil "~s" x) 'list))))
    (if end-punct '(#\. #\! #\?) '(#\, #\. #\! #\? #\: #\;)))
) ; END has-attached-punct-p


(defun standardize-spaces (line)
;```````````````````````````````````````````
; Ensures a single space before/after each parsed line of file.
;
  (concatenate 'string
    " "
    (string-trim '(#\Space #\Newline #\Backspace #\Tab #\Linefeed #\Page #\Return #\Rubout) line)
    " ")
) ; END standardize-spaces


(defun strip (str &optional direction)
;```````````````````````````````````````
; Strips whitespace before and/or after a string.
;
  (cond
    ((equal direction 'left)
      (string-left-trim '(#\Space #\Newline #\Backspace #\Tab #\Linefeed #\Page #\Return #\Rubout) str))
    ((equal direction 'right)
      (string-right-trim '(#\Space #\Newline #\Backspace #\Tab #\Linefeed #\Page #\Return #\Rubout) str))
    (t (string-trim '(#\Space #\Newline #\Backspace #\Tab #\Linefeed #\Page #\Return #\Rubout) str)))
) ; END strip


(defun remove-comments (line)
;``````````````````````````````````
; Removes all comments from a given line.
;
  (let (in-comment prev-ch ret)
    (dolist (ch (coerce line 'list))
      (cond
        ((and (equal ch #\;) (not (equal prev-ch #\\)))
          (setq in-comment t))
        ((not in-comment)
          (push ch ret)
          (setq prev-ch ch))))
    (coerce (reverse ret) 'string))
) ; END remove-comments


(defun encapsulate-comments (line)
;``````````````````````````````````
; Encapsulates all comments in a given line as a list, i.e.,
; (:cn ...) if line only contains a comment, otherwise (:c ...)
; if an inline comment.
;
  (let (in-comment line-start prev-ch ret)
    (dolist (ch (coerce line 'list))
      (cond
        ; If comment starts line, encapsulate comment in (:cn ...)
        ((and (not in-comment) (equal ch #\;) (not line-start))
          (setq in-comment t)
          (push #\Space ret) (push #\( ret) (push #\: ret) (push #\c ret)
          (push #\n ret) (push #\Space ret) (push #\| ret))
        ; If start of comment, encapsulate comment in (:c ...)
        ((and (not in-comment) (equal ch #\;) (not (equal prev-ch #\\)))
          (setq in-comment t)
          (push #\Space ret) (push #\( ret) (push #\: ret) (push #\c ret)
          (push #\Space ret) (push #\| ret))
        ; If in comment and special character is encountered, add escape
        ((and in-comment (member ch '(#\. #\, #\; #\: #\' #\` #\( #\) #\|)))
          (push #\\ ret)
          (push ch ret))
        ; Otherwise, push normally
        (t (push ch ret)))
      (if (not (member ch '(#\Space #\Newline #\Backspace #\Tab #\Linefeed #\Page #\Return #\Rubout))) (setq line-start t))
      (setq prev-ch ch))
    ; Add closing parenthesis to comment
    (when in-comment (push #\| ret) (push #\) ret) (push #\Space ret))
    (coerce (reverse ret) 'string))
) ; END encapsulate-comments


(defun remove-comments-tree (tree)
;```````````````````````````````````
; Removes all comment lists from a given tree.
;
  (remove-if-deep #'comment-p tree)
) ; END remove-comments-tree


(defun read-file-as-list (filename &key remove-comment)
;````````````````````````````````````````````````````````
; Reads a file into a list structure.
;
  (let (str)
    (setq str (concatenate 'string
      "("
      (apply #'concatenate 'string (mapcar (lambda (line)
            (standardize-spaces (if remove-comment (remove-comments line) (encapsulate-comments line))))
          (read-file filename)))
      ")"))
    (read-from-string str))
) ; END read-file-as-list


(defun read-file (filename)
;```````````````````````````````````
; Reads a file as a string.
;
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line))
) ; END read-file


(defun format-indent (n)
;``````````````````````````````
; Creates an indent for level n.
;
  (if (null n) (setq n 0))
  (format nil "~v@{~A~:*~}" (* 2 n) " ")
) ; END format-indent


(defun format-comment (comment &key (indent 0))
;````````````````````````````````````````````````
; Formats a comment list as a string.
;
  (if (newline-comment-p comment)
    (format nil "~%~a;~a" (format-indent indent) (second comment))
    (format nil " ;~a" (second comment)))
) ; END format-comment


(defun escape-apostrophe (word &key lowercase capitalized)
;````````````````````````````````````````````````````````````
; Converts an escaped symbol with an apostrophe to a string with an
; escape character before the apostrophe, i.e., '|don't| -> "don\'t"
;
  (let ((chs (coerce (format nil "~s" word) 'list)) before after ret)
    (setq after (coerce (butlast (cdr (member #\' chs))) 'string))
    (setq before (coerce (cdr (reverse (cdr (member #\' (reverse chs))))) 'string))
    (cond
      (capitalized (format nil "~@(~a~)\\'~(~a~)" before after))
      (lowercase (format nil "~(~a~)\\'~(~a~)" before after))
      (t (format nil "~a\\'~a" before after))))
) ; END escape-apostrophe


(defun split-attached-punct (word &key lowercase capitalized)
;``````````````````````````````````````````````````````````````
; Splits off a final punctuation attached to a word.
;
  (let ((chs (coerce (format nil "~s" word) 'list)) before ch-punct)
    (when (escaped-symbol-p word)
      (setq chs (butlast (cdr chs))))
    (setq before (coerce (butlast chs) 'string))
    (if (equal before "") (return-from split-attached-punct word))
    (setq ch-punct (car (last chs)))
    (cond
      (capitalized (format nil "~@(~a~) \\~a" before ch-punct))
      (lowercase (format nil "~(~a~) \\~a" before ch-punct))
      (t (format nil "~a \\~a" before ch-punct))))
) ; END split-attached-punct


(defun format-feat (word)
;``````````````````````````````
; Formats a feature as a string.
;
  (cond
    ((and (escaped-symbol-p word) (has-apostrophe-p word))
      (escape-apostrophe word))
    (t (format nil "~s" word)))
) ; END format-feat


(defun format-word (word &key capitalized)
;```````````````````````````````````````````
; Formats a word as a string.
;
  (cond
    ((member word '(|.| |,| |:| |;|))
      (format nil "\\~a" word))
    ((and (escaped-symbol-p word) (has-apostrophe-p word))
      (if capitalized
        (escape-apostrophe word :capitalized t)
        (escape-apostrophe word :lowercase t)))
    ((has-attached-punct-p word)
      (if capitalized
        (split-attached-punct word :capitalized t)
        (split-attached-punct word :lowercase t)))
    ((global-variable-p word) (format nil "~(~s~)" word))
    ((tag-p word) (format nil "~a" word))
    ((equal word 'NIL) "NIL")
    ((equal word 'GIST) "Gist")
    ((equal word 'I) "I")
    ((equal word 'Eta) "Eta")
    (capitalized (format nil "~@(~s~)" word))
    (t (format nil "~(~s~)" word)))
) ; END format-word


(defun format-map-attachfeat (section feats)
;`````````````````````````````````````````````
; Formats a list of form (mapc 'ATTACHFEAT '((feat1 w1 w2 ...) (feat2 ...) ...))
;
  (let ((res "(MAPC 'ATTACHFEAT") has-comment)
    ; Assume all remaining items in section are comments, except last
    (dolist (item (butlast (cddr section)))
      (setq res (concatenate 'string res (format-comment item))))
    (setq res (concatenate 'string res "~%'("))
    (dolist (lst (second (car (last section))))
      (cond
        ; If comment, format and append
        ((comment-p lst)
          (setq res (concatenate 'string res (format-comment lst :indent 1))))
        ; If list, begin list on new line (indented)
        ((listp lst)
          (setq res (concatenate 'string res (format nil "~%~a(~a" (format-indent 1) (car lst))))
          ; Go through each word in list
          (dolist (word (cdr lst))
            (cond
              ; If comment, format and append, and record that list has comment inside
              ((comment-p word)
                (setq has-comment t)
                (setq res (concatenate 'string res (format-comment word :indent 2))))
              ; Otherwise, format differently depending on if list contains comment
              (t
                (cond
                  ; If list has comment, put next word/feature on new line
                  (has-comment
                    (setq res (concatenate 'string res (format nil "~%~a~a" (format-indent 2)
                              (if (member word feats) (format-feat word) (format-word word)))))
                    (setq has-comment nil))
                  ; Otherwise, put next word/feature
                  (t
                    (setq res (concatenate 'string res (format nil " ~a"
                              (if (member word feats) (format-feat word) (format-word word))))))))))
          ; Add final parenthesis (on new line if list has comment)
          (if has-comment
            (setq res (concatenate 'string res (format nil "~%~a)" (format-indent 2))))
            (setq res (concatenate 'string res ")")))
          (setq has-comment nil))))
  ; Close off section
  (concatenate 'string res "~%))"))
) ; END format-map-attachfeat


(defun format-attachfeat (section feats)
;`````````````````````````````````````````
; Formats a list of form (ATTACHFEAT '(feat w1 w2 ...))
;
  (let ((res "(ATTACHFEAT '("))
    (setq res (concatenate 'string res (format-feat (car (second (second section))))))
    (mapcar (lambda (word)
        (setq res (concatenate 'string res (format nil " ~a"
          (if (member word feats) (format-feat word) (format-word word))))))
      (cdr (second (second section))))
    (concatenate 'string res "))"))
) ; END format-attachfeat


(defun format-pattern (pattern)
;``````````````````````````````````
; Formats a pattern, e.g. (0 .WH_ 2 word ...)
;
  (let ((res "("))
    (dolist (token pattern)
      (cond
        ((feat-symbol-p token)
          (setq res (concatenate 'string res (format nil "~a " token))))
        ((numberp token)
          (setq res (concatenate 'string res (format nil "~a " token))))
        (t
          (setq res (concatenate 'string res (format nil "~a " (format-word token)))))))
  (concatenate 'string (coerce (butlast (coerce res 'list)) 'string) ")"))
) ; END format-pattern


(defun format-template (template &optional prev-part)
;`````````````````````````````````````````````````````
; Formats a template, e.g., ((gist clause ...) (topic-key))
;
  (let (prev)
    (cond
      ((atom template)
        (if (or (null prev-part) (member prev-part '(|.| ! ?)) (has-attached-punct-p prev-part :end-punct t))
          (format-word template :capitalized t)
          (format-word template)))
      ((and (listp template) (equal (car template) 'quote))
        (format t ">>>Possible unescaped apostrophe error detected in original file: ~a ~a~%" prev-part template)
        (format nil "\\'~a" (format-template (second template))))
      (t (format nil "(~{~a~^ ~})"
        (mapcar (lambda (part) (let ((formatted (format-template part prev)))
            (setq prev part) formatted)) template)))))
) ; END format-template


(defun format-template-ulf (template &optional prev-part)
;``````````````````````````````````````````````````````````
; Formats a ULF-related template.
;
  (let (prev)
    (cond
      ((atom template)
        (cond
          ((equal template 'lex-ulf!) "lex-ulf!")
          (t (format-word template))))
      ((and (listp template) (equal (car template) 'quote))
        (format nil "'~a" (format-template (second template))))
      (t (format nil "(~{~a~^ ~})"
        (mapcar (lambda (part) (let ((formatted (format-template-ulf part prev)))
            (setq prev part) formatted)) template)))))
) ; END format-template-ulf


(defun format-template-subtree+clause (template &optional prev-part)
;````````````````````````````````````````````````````````````````````
; Formats a subtree+clause template.
;
  (let (prev)
    (cond
      ((atom template)
        (format-word template))
      (t (format nil "(~{~a~^ ~})"
        (mapcar (lambda (part) (let ((formatted (format-template-subtree+clause part prev)))
            (setq prev part) formatted)) template)))))
) ; END format-template-subtree+clause


(defun format-rule-tree (tree)
;``````````````````````````````````
; Formats a rule tree of format (1 (pattern) 2 (rule) (0 :directive) ...)
;
  (let ((res "") (indent 0) (remainder tree))
    (dolist (item tree)
      (cond
        ; Item is a level index
        ((numberp item)
          (setq indent item)
          (setq res (concatenate 'string res (format nil "~%~a~a" (format-indent indent) item))))
        ; Item is a comment
        ((comment-p item)
          (setq res (concatenate 'string res (format-comment item :indent (car (member-if #'numberp remainder))))))
        ; Item is a directive
        ((and (listp item) (some #'keywordp item))
          (setq res (concatenate 'string res (format nil " ~(~s~)" item))))
        ; Item is a ULF template
        ((and (listp item) (listp (cadr remainder)) (some #'ulf-keyword-p (cadr remainder)))
          (setq res (concatenate 'string res (format nil " ~a" (format-template-ulf item)))))
        ; Item is a subtree+clause template
        ((and (listp item) (listp (cadr remainder)) (some #'subtree+clause-keyword-p (cadr remainder)))
          (setq res (concatenate 'string res (format nil " ~a" (format-template-subtree+clause item)))))
        ; Item is some other template
        ((and (listp item) (listp (cadr remainder)) (some #'directive-keyword-p (cadr remainder)))
          (setq res (concatenate 'string res (format nil " ~a" (format-template item)))))
        ; Item is a pattern
        ((listp item)
          (setq res (concatenate 'string res (format nil " ~a" (format-pattern item)))))
        ; Item is something else
        (t
          (setq res (concatenate 'string res (format nil " ~(~s~)" item)))))
      (setq remainder (cdr remainder)))
  res)
) ; END format-rule-tree


(defun format-readrules (section)
;``````````````````````````````````````
; Formats a list of form (READRULES '*rule-tree* '(1 (pattern) 2 (rule) (0 :directive) ...))
;
  (let ((res (format nil "(READRULES ~(~a~)" (second section))))
    ; Assume all remaining items in section are comments, except last
    (dolist (item (butlast (cddr section)))
      (setq res (concatenate 'string res (format-comment item))))
    ; Process rule tree
    (setq res (concatenate 'string res "~%'(" (format-rule-tree (second (car (last section))))))
  (concatenate 'string res "~%))"))
) ; END format-readrules


(defun format-map-other (section)
;``````````````````````````````````````
; Formats a list of form (mapc f '((...) (...) ...))
;
  (let ((res "(MAPC "))
    (setq res (concatenate 'string res (format nil "~s" (second section)) (format nil "~%'(")))
    (dolist (lst (second (third section)))
      (setq res (concatenate 'string res (format nil "~%~a(" (format-indent 1))))
      (setq res (concatenate 'string res (format-feat (car lst))))
      (dolist (word (cdr lst))
        (setq res (concatenate 'string res (format nil " ~a" (format-feat word)))))
      (setq res (concatenate 'string res ")")))
  (concatenate 'string res "~%))"))
) ; END format-map-other


(defun format-other (section)
;``````````````````````````````````````
; Formats a list of form (f '(...))
;
  (format nil "~a" section)
) ; END format-other


(defun format-section (section-string &optional prev-comment)
;```````````````````````````````````````````````````````````````
; Formats a section of a file (already formatted as a string).
;
  (if prev-comment
    (format nil "~%~a" section-string)
    (format nil "~%~%~%~a" section-string))
) ; END format-section


(defun format-file (file feats)
;```````````````````````````````````
; Formats a file as a string.
;
  (let ((res "") prev-comment)
    (dolist (section file)
      (cond
        ((comment-p section)
          (setq res (concatenate 'string res (format-comment section)))
          (if (newline-comment-p section) (setq prev-comment t)))
        ;; ((newline-comment-p section)
        ;;   (setq res (concatenate 'string res (format nil "~%~a" (format-comment section)))))
        ;; ((comment-p section)
        ;;   (setq res (concatenate 'string res (format-comment section))))
        ((and (member (first section) '(mapc mapcar)) (equal (second section) ''ATTACHFEAT))
          (setq res (concatenate 'string res (format-section (format-map-attachfeat section feats) prev-comment)))
          (setq prev-comment nil))
        ((equal (first section) 'ATTACHFEAT)
          (setq res (concatenate 'string res (format-section (format-attachfeat section feats) prev-comment)))
          (setq prev-comment nil))
        ((equal (first section) 'READRULES)
          (setq res (concatenate 'string res (format-section (format-readrules section) prev-comment)))
          (setq prev-comment nil))
        ((member (first section) '(mapc mapcar))
          (setq res (concatenate 'string res (format-section (format-map-other section) prev-comment)))
          (setq prev-comment nil))
        (t (setq res (concatenate 'string res (format-section (format-other section) prev-comment)))
           (setq prev-comment nil))))
  res)
) ; END format-file


(defun write-format-file (file filename feats)
;````````````````````````````````````````````````
; Formats a file and writes the resulting string to filename.
;
  (ensure-directories-exist filename)
  (with-open-file (outfile filename :direction :output :if-exists :supersede :if-does-not-exist :create)
    (format outfile (strip (format-file file feats) 'left)))
) ; END write-format-file


(defun collect-features (files)
;````````````````````````````````````
; Collects all unique features defined in a list of files.
;
  (remove-duplicates (apply #'append
    (mapcar #'collect-features-from-file
      (mapcar #'remove-comments-tree files))))
) ; END collect-features


(defun collect-features-from-file (file)
;```````````````````````````````````````````
; Collects all features defined in a given file.
;
  (let (feats)
    (dolist (section file)
      (cond
        ; Multiple feature lists defined using mapc/mapcar
        ((and (member (first section) '(mapc mapcar)) (equal (second section) ''ATTACHFEAT))
          (mapcar (lambda (featlist) (push (car featlist) feats)) (car (cdaddr section))))
        ; Single feature defined using function call
        ((equal (first section) 'ATTACHFEAT)
          (push (car (cadadr section)) feats))))
    feats)
) ; END collect-features-from-file


(defun convert-pattern (pattern feats)
;``````````````````````````````````````
; Converts a pattern to the new TT format.
;
  (mapcar (lambda (token)
      (if (or (numberp token) (not (member token feats)))
        token
        (intern (format nil ".~a" token))))
    pattern)
) ; END convert-pattern


(defun convert-rule-tree (tree feats)
;```````````````````````````````````````
; Converts a rule tree to the new TT format.
;
  (let (result prev-token)
    (dolist (token (reverse tree))
      (cond
        ; Rule is a comment; ignore
        ((comment-p token)
          (push token result))
        ; Rule is associated with directive; do not convert
        ((and (listp token) (listp prev-token) (some #'directive-keyword-p prev-token))
          (push token result))
        ; Rule is a pattern; convert
        ((listp token)
          (push (convert-pattern token feats) result))
        ; Level indicator
        (t (push token result)))
      (when (not (comment-p token))
        (setq prev-token token)))
    result)
) ; END convert-rule-tree


(defun convert-file (file feats)
;````````````````````````````````````
; Converts a file to the new TT format, given a list of features.
;
  (mapcar (lambda (section)
      (if (equal (first section) 'READRULES)
        (append (butlast section) (list `',(convert-rule-tree (second (car (last section))) feats)))
        section))
    file)
) ; END convert-file


(defun convert-all (feat-files-to-convert files-to-convert &key remove-comment)
;`````````````````````````````````````````````````````````````````````````````````
; Converts all files in files-to-convert to the TT format, writing the outputs in *dir-out*.
; feat-files are assumed to supply domain-independent word features, and so are converted prior to
; everything else (though still supply features for conversion of other files).
;
  (let (new new-feat-files files feat-files feats)
    (setq files (mapcar (lambda (filename) (read-file-as-list filename :remove-comment remove-comment))
      (mapcar (lambda (filename) (concatenate 'string *dir-in* filename)) files-to-convert)))
    (setq feat-files (mapcar (lambda (filename) (read-file-as-list filename :remove-comment remove-comment))
      (mapcar (lambda (filename) (concatenate 'string *dir-in* filename)) feat-files-to-convert)))
    ; First convert feat-files independently
    (setq feats (collect-features feat-files))
    (setq new-feat-files (mapcar (lambda (file) (convert-file file feats)) feat-files))
    (mapcar (lambda (file filename) (write-format-file file filename feats)) new-feat-files
      (mapcar (lambda (filename) (concatenate 'string *dir-out* filename)) feat-files-to-convert))
    ; Next convert remaining files, adding the features from feat-files
    (setq feats (collect-features (append files feat-files)))
    (setq new (mapcar (lambda (file) (convert-file file feats)) files))
    (mapcar (lambda (file filename) (write-format-file file filename feats)) new
      (mapcar (lambda (filename) (concatenate 'string *dir-out* filename)) files-to-convert))
  (append new-feat-files new))
) ; END convert-all


(mapcar (lambda (dir)
    (convert-all '("general-word-data.lisp") (get-files-to-convert dir)))
  *dirs-to-convert*)