;;; private/utils/config.el -*- lexical-binding: t; -*-

;;; This file contains configuration of packages that are not part
;;; of DOOM, and provide no extra functionality to built-in packages.
;;; For example, ivy-posframe is enchancing ivy's functionality, so
;;; it's place is in modules/private/ivy. Ace-window is a stand-alone
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

;;; outline-minor-mode

;; Stolen from
;; https://gitlab.com/protesilaos/dotfiles/-/blob/master/emacs/.emacs.d/emacs-init.org#h:c519300f-8a9a-472b-b26d-c2f49adbdb5d

(use-package! outline-minor-faces
  :after outline
  :config (add-hook 'outline-minor-mode-hook
                    'outline-minor-faces-add-font-lock-keywords))

(use-package! foldout
  :after outline)

(use-package! bicycle
  :after outline)

(use-package! outline
  :config
  (defvar contrib/outline-minor-mode-map
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "M-n") 'outline-next-visible-heading)
      (define-key map (kbd "M-p") 'outline-previous-visible-heading)
      (define-key map (kbd "C-c C-n") 'outline-next-visible-heading)
      (define-key map (kbd "C-c C-p") 'outline-previous-visible-heading)
      (define-key map (kbd "C-c C-f") 'outline-forward-same-level)
      (define-key map (kbd "C-c C-b") 'outline-backward-same-level)
      (define-key map (kbd "C-c C-a") 'outline-show-all)
      (define-key map (kbd "C-c C-q") 'contrib/outline-hide-all)
      (define-key map (kbd "C-c C-u") 'outline-up-heading)
      (define-key map (kbd "C-c C-d") 'contrib/outline-down-heading)
      (define-key map (kbd "C-c C-z") 'foldout-zoom-subtree)
      (define-key map (kbd "C-c C-x") 'foldout-exit-fold)
      (define-key map (kbd "<tab>") 'contrib/bicycle-cycle-tab-dwim)
      (define-key map (kbd "<C-tab>") 'bicycle-cycle)
      (define-key map (kbd "<S-iso-lefttab>") 'bicycle-cycle-global)
      map)
    "Key map for `prot/outline-minor-mode'.
The idea is to make `outline-minor-mode' keys a bit easier to
work with.")

  (define-minor-mode contrib/outline-minor-mode
    "Toggles `outline-minor-mode' and extras.

\\{contrib/outline-minor-mode-map}"
    :init-value nil
    :lighter " =┆"
    :global nil
    :keymap contrib/outline-minor-mode-map
    (if contrib/outline-minor-mode
        (progn
          (when (eq major-mode 'org-mode)
            (user-error "Don't use `outline-minor-mode' with Org"))
          (outline-minor-mode 1)
          (run-hooks 'contrib/outline-minor-mode-enter-hook))
      (outline-minor-mode -1)
      (run-hooks 'contrib/outline-minor-mode-exit-hook)))

  ;; Use f9 to toggle the minor mode.
  (map! [f9] 'contrib/outline-minor-mode)

  :hook ((contrib/outline-minor-mode-enter-hook . contrib/outline-imenu-setup)
         (contrib/outline-minor-mode-exit-hook . contrib/outline-imenu-restore)
         (contrib/outline-minor-mode-exit-hook . contrib/outline-minor-refontify)))
