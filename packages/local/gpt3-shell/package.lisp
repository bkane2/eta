(defpackage gpt3-shell
  (:documentation "This is just an empty package to ensure that Eta will still compile when not being used as a dependency.")
  (:use :common-lisp)
  (:export :init :generate :generate-with-key :generate-safe)
)
;;(in-package gpt3-shell)
;;(defconstant +load-path+ (system-relative-pathname 'epilog ""))
