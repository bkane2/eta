;; Used to extract all gist clauses from an avatar's input transduction trees, for use in gist-constrained LM decoding.
;;
;;
;;  TODO: need to automatically switch pronouns
;;   (DUALS 'I 'YOU)
;;   (SETF (GET 'ME 'SUBST) 'YOU)
;;   (SETF (GET 'YOU2 'SUBST) 'ME)		; objective case!
;;   (DUALS 'MY 'YOUR)
;;   (DUALS 'MINE 'YOURS)
;;   (DUALS 'MYSELF 'YOURSELF)
;;   (SETF (GET 'AM 'SUBST) 'ARE)
;;   (SETF (GET 'ARE2 'SUBST) 'AM)		; second person! (after YOU)
;;   (SETF (GET 'WAS2 'SUBST) 'WERE)	; after I?
;;   (SETF (GET 'WERE2 'SUBST) 'WAS)	; after YOU?
;;
;; TODO: if a gist clause refers to a feature in a pattern, should output feature rather than wildcard character.
;; In the gist-constrained decoding, a list of features should be able to be defined and used in matching.

(defparameter *dirs-to-extract* '(
  "../avatars/sophie/rules"
))


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


(defun remove-comments-tree (tree)
;```````````````````````````````````
; Removes all comment lists from a given tree.
;
  (remove-if-deep #'comment-p tree)
) ; END remove-comments-tree


(defun read-file-as-list (filename)
;````````````````````````````````````
; Reads a file into a list structure.
;
  (let (str)
    (setq str (concatenate 'string
      "("
      (apply #'concatenate 'string (mapcar (lambda (line)
            (standardize-spaces (remove-comments line)))
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


(defun format-gist (gist pattern)
;````````````````````````````````````
; Given a gist clause and prior pattern node, format the gist clause by substituting
; any templatic tokens in with the parts of the pattern node that they point to. At the
; moment, any features are just replaced with a single-word wildcard token.
; e.g., (format-gist '(4 likes to 6 .) '(I heard that feat-person enjoys 3 .))
;       => '(1 likes to 3 .)
;
  (mapcar (lambda (token)
    (cond
      ((integerp token)
        (let ((placeholder (nth (- token 1) pattern)))
          (if (integerp placeholder) placeholder 1)))
      (t token)))
  gist)
) ; END format-gist


(defun extract-rule-tree (tree)
;````````````````````````````````````
; Extracts gist clauses from a rule tree by working backwards through the linearalized
; tree, keeping track of each pair of gist clause (indicated by a previous directive)
; and prior pattern rule. The gist clause is formatted using the prior pattern rule.
;
  (let (gists prev-token found-gist)
    (dolist (token (reverse tree))
      (cond
        ((and (listp token) (listp prev-token) (member :gist prev-token))
          (if (every #'listp token)
            (setq found-gist (car token))
            (setq found-gist token)))
        ((and (listp token) found-gist)
          (setq gists (cons (format-gist found-gist token) gists))
          (setq found-gist nil)))
      (setq prev-token token))
    gists)
) ; END extract-rule-tree


(defun extract-file (file)
;````````````````````````````````
; Extracts all gist clauses from a single file (ignoring everything other than
; each rule tree definition in the file).
;
  (let (gists)
    (dolist (section file)
      (if (equal (first section) 'READRULES)
        (setq gists (append gists (extract-rule-tree (second (car (last section))))))))
  gists)
) ; END extract-file


(defun remove-nil-gist (gists)
;````````````````````````````````
; Removes nil gist clauses from a list of gist clauses.
;
  (remove-if (lambda (gist) (equal 'nil (car gist))) gists)
) ; END remove-nil-gist


(defun extract-gists (files-to-extract)
;``````````````````````````````````````````
; Extracts all gist clauses from a list of rule files (removing any duplicates
; or nil gist clauses).
;
  (let (gists files)
    (setq files (mapcar (lambda (filename) (read-file-as-list filename))
      (mapcar (lambda (filename) filename) files-to-extract)))
    (dolist (file files)
      (setq gists (append gists (extract-file file))))
    (remove-nil-gist (remove-duplicates gists :test #'equal)))
) ; END extract-gists


(defun write-gists (gists)
;`````````````````````````````
; Writes a list of gist clauses (in string form) to a file.
;
  (with-open-file (str "gists.txt"
                    :direction :output
                    :if-exists :supersede
                    :if-does-not-exist :create)
    (dolist (gist gists)
      (format str "~a~%" gist)))
) ; END write-gists


(defun gist-to-string (gist)
;``````````````````````````````
; Convert a gist clause (a list of tokens) to a string.
;
  (format nil "~{~a~^ ~}" gist)
) ; END gist-to-string


(write-gists (mapcar #'gist-to-string
  (remove-duplicates (apply #'append
    (mapcar (lambda (dir) (extract-gists (get-all-subfiles dir))) *dirs-to-extract*)) :test #'equal)))