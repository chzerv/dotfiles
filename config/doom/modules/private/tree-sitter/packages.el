;; -*- no-byte-compile: t; -*-
;;; editor/tree-sitter/packages.el

(package! tree-sitter
  :ignore (null (bound-and-true-p module-file-suffix)))

(package! tree-sitter-langs
  :ignore (null (bound-and-true-p module-file-suffix)))
