;;; chz/utils/config.el -*- lexical-binding: t; -*-

;;; This file contains configuration of packages that are not part
;;; of DOOM, and provide no extra functionality to built-in packages.
;;; For example, ivy-posframe is enchancing ivy's functionality, so
;;; it's place is in modules/chz/ivy. Ace-window is a stand-alone
;;; package, so it's place is in here.

;;; Add modes for specific filetypes.
(use-package! pkgbuild-mode
  :mode "\\PKGBUILD")

(use-package! systemd
  :mode "\\.service|\\.timer")

;;; Ace-window
(use-package! ace-window
  :defer t
  :config
  (setq aw-keys '(?h ?j ?k ?l ?y ?u ?i ?o ?p))
  (setq aw-scope 'frame)
  (setq aw-dispatch-always t)
  (setq aw-dispatch-alist
        '((?s aw-swap-window "Swap Windows")
          (?2 aw-split-window-vert "Split Window Vertically")
          (?3 aw-split-window-horz "Split Window Horizontally")
          (?? aw-show-dispatch-help)))
  (setq aw-minibuffer-flag t)
  (setq aw-ignore-current nil)
  (setq aw-display-mode-overlay t)
  (setq aw-background t)

  (map! :leader
        (:prefix ("w" . "+window")
         :desc "Ace window" "a" 'ace-window))
  (ace-window-display-mode -1))

;;; rg.el
;; Credits for the functions go to
;; https://gitlab.com/protesilaos/dotfiles/-/blob/master/emacs/.emacs.d/emacs-init.org#h:c519300f-8a9a-472b-b26d-c2f49adbdb5d
(use-package! rg
  :after wgrep
  :config
  (setq rg-group-result t)
  (setq rg-hide-command t)
  (setq rg-show-columns nil)
  (setq rg-show-header t)
  (setq rg-custom-type-aliases nil)
  (setq rg-default-alias-fallback "all")

  ;; rg.el gives us the ability to define custom search functions.
  (rg-define-search contrib/rg-vc-or-dir
    "RipGrep in project root or present directory."
    :query ask
    :format regexp
    :files "everything"
    :dir (let ((vc (vc-root-dir)))
           (if vc
               vc                         ; search root project dir
             default-directory))          ; or from the current dir
    :confirm prefix
    :flags ("--hidden -g !.git"))

  (rg-define-search contrib/rg-ref-in-dir
    "RipGrep for thing at point in present directory."
    :query point
    :format regexp
    :files "everything":dir default-directory
    :confirm prefix
    :flags ("--hidden -g !.git"))

  (map!
   "M-s g" 'contrib/rg-vc-or-dir
   "M-s r" 'contrib/rg-ref-in-dir
   (:map rg-result-mode-map
    "s" 'contrib/rg-save-search-as-name
    "C-n" 'next-line
    "C-p" 'previous-line
    "M-n" 'rg-next-file
    "M-p" 'rg-prev-file)))

;;; Olivetti mode
(use-package! olivetti
  :defer t
  :config
  (setq olivetti-body-width 100
        olivetti-minimum-body-width 80))

;;; imenu-list
(use-package! imenu-list
  :after imenu
  :config
  (map! :after imenu
        (:leader
         :desc "imenu-list-dwim"
         "s I" 'contrib/imenu-list-dwim)))
