;; -*- no-byte-compile: t; -*-
;;; chz/misc/packages.el

;; Additonal modes.
(package! pkgbuild-mode)
(package! systemd)

;; An interactive ripgrep wrapper.
(package! rg)

;; Doom installs ace-window when the 'window-select' module is enabled,
;; but I don't like the defaults.
(package! ace-window)

;; Distraction-free writing.
(package! olivetti)

;; A sidebar for imenu
(package! imenu-list)

;; Add some faces to separate outline headings from comments.
(package! outline-minor-faces)
;; Kinda like narrow.
(package! foldout)
;; Cycle between showall and fold, like in org-mode.
(package! bicycle)
