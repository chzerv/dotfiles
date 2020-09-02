;; -*- no-byte-compile: t; -*-
;;; chz/dired/packages.el

;; Specify default programs to use for different filetypes, in dired-mode.
(package! dired-open)

;; Give dired the ability to use subtrees instead of the default flat directory
;; preview.
(package! dired-subtree)

;; Provide an easier to narrow dired buffers.
(package! dired-narrow)

;; File previews (including images) in dired.
(package! peep-dired)

;; dired-sidebar
(package! dired-sidebar)

;; Check disk usage using dired.
(package! dired-du)
