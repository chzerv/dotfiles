;; -*- no-byte-compile: t; -*-
;;; private/selectrum/packages.el

(package! selectrum)

(when (featurep! +prescient)
  (package! prescient)
  (package! selectrum-prescient))

(when (featurep! +orderless)
  (package! orderless))

(package! consult)

(when (featurep! :checkers syntax)
  (package! consult-flycheck))

(package! embark)
(package! embark-consult)

(package! marginalia)

(package! wgrep)
