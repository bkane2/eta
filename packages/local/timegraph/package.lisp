(defpackage timegraph
  (:documentation "This is just an empty package to ensure that Eta will still compile when not being used in responsive mode
                  (i.e. with no dependencies for response generation).")
  (:use :common-lisp)
  (:export :make-timegraph :assert-prop :eval-prop :encode-timestamp :update-lower-bound-inst :update-upper-bound-inst)
)
;;(in-package ulf-pragmatics)
;;(defconstant +load-path+ (system-relative-pathname 'epilog ""))
