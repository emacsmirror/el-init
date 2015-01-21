;; -*- lexical-binding: t; -*-

(require 'cl-lib)
(require 'el-init)

(defvar el-init-test:test-directory
  (file-name-directory
   (or load-file-name (buffer-file-name))))

(defmacro el-init-test:sandbox (&rest body)
  (declare (indent 0))
  (let ((snapshot (cl-gensym)))
    `(let ((el-init:record nil)
           (load-path load-path)
           (after-load-alist after-load-alist)
           (,snapshot features))
       ,@body
       (mapc #'unload-feature
             (cl-reduce #'remq
                        ,snapshot
                        :initial-value features
                        :from-end t)))))

(defun el-init-test:get-path (path)
  (expand-file-name path el-init-test:test-directory))

(provide 'el-init-test-helper)