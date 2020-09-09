;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; Appearance

;;;; Font configuration

(if (<= (display-pixel-width) 1366)
    (setq doom-font (font-spec :family "Hack" :size 13)
          doom-big-font (font-spec :family "Hack" :size 15)
          doom-variable-pitch-font (font-spec :family "FiraGO" :size 14))
  (setq doom-font (font-spec :family "Hack" :size 15)
        doom-big-font (font-spec :family "Hack" :size 18)
        doom-variable-pitch-font (font-spec :family "FiraGO" :size 17)))
(setq doom-unicode-font (font-spec :name "DejaVu Sans Mono"))

;;;; Theme configuration
(setq doom-theme 'modus-operandi)

;;;;; Modus-themes tweaks
(if (equal doom-theme 'modus-operandi)
    (setq modus-operandi-theme-distinct-org-blocks t
          modus-operandi-theme-scale-headings nil
          modus-operandi-theme-completions 'moderate
          modus-operandi-theme-visible-fringes 'subtle))

(if (equal doom-theme 'modus-vivendi)
    (setq modus-vivendi-theme-distinct-org-blocks t
          modus-vivendi-theme-scale-headings nil
          modus-vivendi-theme-completions 'moderate
          modus-vivendi-theme-visible-fringes 'subtle))

;;;; Don't show line numbers.
(setq display-line-numbers-type nil)

;;;; Show the default Emacs logo in the dashboard.
(setq fancy-splash-image (concat doom-private-dir "splash.png"))
;;;; Don't show the shortcut menu in the dashboard.
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

;;;; Use the buffer's name as the frame title.
(setq frame-title-format '("%b"))

;;;; Built-in modeline tweaks
;;;;; Smaller height for modeline +light
(when (featurep! :ui modeline +light)
  (setq +modeline-height 20
        +modeline-encoding nil))

;;;;; When using 'doom-modeline', don't show the buffer encoding.
(after! doom-modeline
  (setq doom-modeline-buffer-encoding nil))

;;;;; Use smaller all-the-icons icons.
;; This helps fix padding issues where doom-modeline "overflows" from
;; the right.
(setq all-the-icons-scale-factor 1.1)

;;;;; Always show the time in the modeline, but not the load average.
(after! time
  (setq display-time-default-load-average nil)
  (display-time-mode 1))

;;; Better defaults

;;;; Indentation settings
(setq-default tab-always-indent 'complete ;; Indent first, complete later
              indent-tabs-mode nil        ;; Indent with spaces
              tab-width 4)                ;; Use 4 spaces/TAB

;;;; Scrolling tweaks

;; Page scrolling should keep the point at the same visual position,
;; rather than force it to the top or bottom of the viewport.
(setq-default scroll-preserve-screen-position t)
(setq-default scroll-conservatively 1) ; affects `scroll-step'
(setq-default scroll-margin 0)

;;;; Enable disabled functions

;; By default, Doom disables the 'narrow-to-region' function.
;; I find it quite useful.
(put 'narrow-to-region 'disabled nil)

;;;; Auto-saving
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;;; Associate filetypes with modes
(add-to-list 'auto-mode-alist '("\\.cheat\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\zshenv" . sh-mode))

;;; Projectile configuration

;; 1. Open up the the project in dired instead of the search prompt.
;; 2. Don't require a project for projectile to work.
;; 3. Don't create projects in the ignored directories.

(defun +projectile-ignore-project-p (project-root)
  (string-match-p "/\\.emacs\\.d/\\.local/straight/repos" project-root))

(after! projectile
  (setq
   projectile-switch-project-action 'projectile-dired
   projectile-require-project-root nil
   projectile-indexing-method 'alien
   projectile-ignored-projects '("~/" "/tmp" "~/.emacs.d/.local/straight/repos" "~/.emacs/.local/straight/build")
   projectile-ignored-project-function #'+projectile-ignore-project-p))

;;; Flycheck configuration

;; Don't enable flycheck in org-mode buffers.
;; Use 'symbols' as the highlighting method.
;; Note that 'lines' can be (way) faster, but 'symbols' behaves
;; like most modern editors.
(after! flycheck
  (setq flycheck-highlighting-mode 'symbols
        flycheck-global-modes '(not org-mode)))

;;; ibuffer configuration

(after! ibuffer
  (setq ibuffer-display-summary nil)
  (setq ibuffer-formats
        '((mark modified read-only locked " "
                (name 30 30 :left :elide)
                " "
                (mode 16 16 :left :elide)
                " " filename-and-process)
          (mark " "
                (name 16 -1)
                " " filename))))

;;; isearch configuration

(after! isearch
  (setq search-highlight t
        search-whitespace-regexp ".*?"
        isearch-lazy-count t
        lazy-count-prefix-format nil
        lazy-count-suffix-format " (%s/%s)"
        isearch-yank-on-move 'shift
        isearch-allow-scroll 'unlimited))

;;; yasnippet configuration

;; Use the same indentation as the snippet itself.
(after! yasnippet
  (setq yas-indent-line 'fixed
        yas-also-auto-indent-first-line t))

;;; highlight-indent-guides configuration

;; Disable indent-guides everywhere but yaml and python modes.
(after! highlight-indent-guides
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-auto-odd-face-perc 15
        highlight-indent-guides-auto-even-face-perc 15
        highlight-indent-guides-auto-character-face-perc 20))

(remove-hook 'text-mode-hook #'highlight-indent-guides-mode)
(remove-hook 'prog-mode-hook #'highlight-indent-guides-mode)
(add-hook 'yaml-mode-hook #'highlight-indent-guides-mode)
(add-hook 'python-mode-hook #'highlight-indent-guides-mode)

;;; yaml-mode
;; Enable ansible-mode on every YAML file.
(after! yaml-mode
  (add-hook 'yaml-mode-hook #'+ansible-yaml-mode))

;;; Popup rules

;; TODO: There might be a way to autoload those rules, for better performance.
(set-popup-rule! "*eww*" :side 'bottom :size .70 :slect t :vslot 5 :ttl 3 :quit nil)
(set-popup-rule! "*Help.*" :side 'right :width .50 :select t :vslot 0 :ttl 3 :quit nil)
(set-popup-rule! "*Man.*" :side 'right :width .50 :select t :slot 1 :ttl 3 :quit t :modeline nil)
(set-popup-rule! "*ansible-doc.*" :side 'bottom :height .40 :select t :vslot 1 :ttl 3 :quit nil)
(set-popup-rule! "*Flycheck errors*" :side 'bottom :height .2 :select nil :quit t)
(set-popup-rule! "*Ilist" :side 'right :width .3 :select t :slot 2 :quit t :parameters '(no-other-window . nil))
(set-popup-rule! "*helpful.*" :side 'bottom :height .30 :select t :vslot 0 :ttl 3 :quit 'other)

;;; Run all Doom hooks on startup.

;; This will delay startup a bit, but it can offer a much
;; more responsive experience.
(run-hooks 'doom-first-input-hook)

;;; File templates

(after! dockerfile-mode
  (set-file-template! 'dockerfile-mode
    :trigger "dockerfile-template"))

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

;;; imenu

(after! imenu
  (add-hook 'imenu-after-jump-hook 'util/imenu-reveal-entry))

;;; Tree-sitter

(use-package! tree-sitter
  :defer 2
  :config
  (global-tree-sitter-mode t)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package! tree-sitter-langs)

;;; Spelling

;; Use ispell's multiple dictionaries functionality.
(after! ispell
  (setq ispell-program-name "hunspell"
        ispell-dictionary "en_US,el_GR")
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "en_US,el_GR")

  ;; Don't spell check the following org source blocks.
  (add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
  (add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_LATEX" . "#\\+END_LATEX"))
  (add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE")))

;; Don't immediately run a spell check on every LaTeX file.
(setq-hook! 'TeX-mode-hook +spellcheck-immediately nil)
