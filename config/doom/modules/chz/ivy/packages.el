;; -*- no-byte-compile: t; -*-
;;; chz/ivy/packages.el

;; Doom also installs ivy-posframe when the '+childframe' option in enabled
;; for ivy, but I don't like the defaults.
(package! ivy-posframe
  :recipe (:host github
           :repo "snyball/ivy-posframe"))
