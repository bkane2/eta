(defvar *supported-dependencies* '("ttt" "ulf-lib" "ulf2english" "ulf-pragmatics" "timegraph" "gpt3-shell" "lenulf" "standardize-ulf"))

; For each supported dependency, if it's declared as a dependency in the config file, try to quickload
; the package. Otherwise, load the package from local packages (possibly just a stub to provide necessary symbols).
; (set *dependencies-loaded* to true after loading dependencies the first time, so that (load "start") can be re-run
;  after the first time without restarting the Lisp REPL)
(when (or (not (boundp '*dependencies-loaded*)) (not *dependencies-loaded*))
    (when *dependencies*
        (load (truename "packages/quickload-dependencies.lisp")))
    (let (deps-quicklisp deps-local)
        ; We need to sort dependencies so that quicklisp packages are loaded first.
        (dolist (dependency *supported-dependencies*)
            (if (member dependency *dependencies* :test #'equal)
                (push dependency deps-quicklisp)
                (push dependency deps-local)))

        (dolist (dependency (reverse deps-quicklisp))
            (quickload-package dependency))
        (dolist (dependency (reverse deps-local))
            (if (equal dependency "ttt")
                (load (truename "packages/local/ttt/src/load.lisp"))
                (load (truename (concatenate 'string "packages/local/" dependency "/load.lisp"))))))
    (defvar *dependencies-loaded* t))
; Load priority queue package (should come pre-bundled with quicklisp)
(ql:quickload :priority-queue)

; If GPT3 generation/interpretation mode and GPT3-shell not provided as a dependency, print warning and change mode to RULE.
(when (and (or (equal *generation-mode* 'GPT3) (equal *interpretation-mode* 'GPT3))
           (not (member "gpt3-shell" *dependencies* :test #'equal)))
    (format t "~% --- Warning: GPT3 generation/interpretation mode requires gpt3-shell to be listed as a dependency in the config file.")
    (format t "~%              Changing generation/interpretation mode to RULE.~%")
    (setq *generation-mode* 'RULE)
    (setq *interpretation-mode* 'RULE))

; If BLLIP parser mode and lenulf + standardize-ulf are not provided as dependencies, print warning and change mode to RULE.
(when (and (equal *parser-mode* 'BLLIP) (not (member "lenulf" *dependencies* :test #'equal))
                                        (not (member "standardize-ulf" *dependencies* :test #'equal)))
    (format t "~% --- Warning: BLLIP parser mode requires lenulf and standardize-ulf to be listed as dependencies in the config file.")
    (format t "~%              Changing parser mode to RULE.~%")
    (setq *parser-mode* 'RULE))


; Load core code
; (in directory 'core/')
;````````````````````````
(mapcar (lambda (file) (load file))
    (directory "core/*.lisp"))


; Load core TT code
; (in directory 'core/tt')
;````````````````````````
(mapcar (lambda (file) (load file))
    (directory "core/tt/*.lisp"))


; Load core response generation code
; (in directory 'core/response')
;`````````````````````````````````
(mapcar (lambda (file) (load file))
    (directory "core/response/*.lisp"))


; Load core coreference code
; (in directory 'core/coref')
;``````````````````````````````
(mapcar (lambda (file) (load file))
    (directory "core/coref/*.lisp"))


; Load core resources
; (in directory 'core/resources/')
;``````````````````````````````````
(mapcar (lambda (file) (load file))
    (directory "core/resources/*.lisp"))