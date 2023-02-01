(defun init (api-key &key engine response-length temperature top-p frequency-penalty presence-penalty) nil)
(defun generate (prompt &key response-length temperature top-p frequency-penalty presence-penalty stop-seq) nil)
(defun generate-with-key (api-key prompt &key engine response-length temperature top-p frequency-penalty presence-penalty stop-seq) nil)
(defun generate-safe (gen-func gen-args &key max-tries) nil)