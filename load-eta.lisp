(defvar *supported-dependencies* '("ttt" "ulf-lib" "ulf2english" "ulf-pragmatics" "timegraph" "gpt3-shell"))

; For each supported dependency, if it's declared as a dependency in the config file, try to quickload
; the package. Otherwise, load the package from local packages (possibly just a stub to provide necessary symbols).
(when *dependencies*
    (load (truename "packages/quickload-dependencies.lisp")))
(dolist (dependency *supported-dependencies*)
    (cond
        ((member dependency *dependencies* :test #'equal)
            (quickload-package dependency))
        ((equal dependency "ttt")
            (load (truename "packages/local/ttt/src/load.lisp")))
        (t (load (truename (concatenate 'string "packages/local/" dependency "/load.lisp"))))))

; If GPT3 generation mode and GPT3-shell not provided as a dependency, print warning and change mode to RULE.
(when (and (equal *generation-mode* 'GPT3) (not (member "gpt3-shell" *dependencies* :test #'equal)))
    (format t "~% --- Warning: GPT3 generation mode requires gpt3-shell to be listed as a dependency in the config file.")
    (format t "~%              Changing generation mode to RULE.~%")
    (setq *generation-mode* 'RULE)
)


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