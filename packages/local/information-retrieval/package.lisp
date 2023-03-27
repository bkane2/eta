(defpackage information-retrieval
  (:documentation "This is just an empty package to ensure that Eta will still compile when not being used as a dependency.")
  (:use :common-lisp)
  (:export :set-model :set-cross-encoder :init :embed-documents :retrieve :rerank :retrieve+rerank)
)
;;(in-package information-retrieval)
;;(defconstant +load-path+ (system-relative-pathname 'epilog ""))
