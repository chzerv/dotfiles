;;; private/selectrum/config.el -*- lexical-binding: t; -*-

;;; `selectrum'
(use-package! selectrum
  :hook (doom-first-input . selectrum-mode)
  :config
  (setq selectrum-extend-current-candidate-highlight t
        selectrum-fix-minibuffer-height t)

  ;; Use a different background for the current candidate.
  (set-face-attribute 'selectrum-current-candidate nil :background "#3a3f5a" :weight 'bold)

  (setq flyspell-correct-interface #'flyspell-correct-dummy)
  (setq projectile-completion-system 'default)

  (map! :leader
        "f p" '+selectrum/find-file-in-private-config)

  (unless (featurep! +orderless)
    (setq completion-styles '(basic partial-completion emacs22))))

;;; `prescient' and `selectrum-prescient'
(use-package! selectrum-prescient
  :when (featurep! +prescient)
  :after selectrum
  ;; :hook ((selectrum-mode . selectrum-prescient-mode)
  ;;        (selectrum-mode . prescient-persist-mode))
  :config
  (setq prescient-history-length 1000)
  (selectrum-prescient-mode +1)
  (prescient-persist-mode +1))

;;; `orderless'
(use-package! orderless
  :when (featurep! +orderless)
  :config
  (setq completion-styles '(orderless)
        selectrum-refine-candidates-function #'orderless-filter
        selectrum-highlight-candidates-function #'orderless-highlight-matches)

  ;; Integration with `company'
  (setq orderless-component-separator "[ &]")
  (defun just-one-face (fn &rest args)
    (let ((orderless-match-faces [completions-common-part]))
      (apply fn args)))

  (advice-add 'company-capf--candidates :around #'just-one-face))

;;; `consult'
(use-package consult
  :init
  ;; Replace `multi-occur' with `consult-multi-occur', which is a drop-in replacement.
  (fset 'multi-occur #'consult-multi-occur)
  (define-key!
    [remap switch-to-buffer]              #'consult-buffer
    [remap switch-to-buffer-other-window] #'consult-buffer-other-window
    [remap evil-show-marks]               #'+selectrum/evil-marks
    [remap apropos]                       #'consult-apropos
    [remap goto-line]                     #'consult-goto-line
    [remap bookmark-jump]                 #'consult-bookmark
    [remap imenu]                         #'consult-imenu
    [remap load-theme]                    #'consult-theme
    [remap org-goto]                      #'consult-outline
    [remap recentf-open-files]            #'consult-recent-file
    [remap swiper]                        #'consult-line
    [remap locate]                        #'consult-locate
    [remap man]                           #'consult-man
    [remap yank-pop]                      #'consult-yank-pop)
  :config
  (setq consult-line-numbers-widen t
        ;; Previews are way to "heavy".
        consult-preview-key nil
        consult-narrow-key "<"
        consult-widen-key ">"
        completion-in-region-function #'consult-completion-in-region)

  (setq consult-ripgrep-command '("rg" "--null" "--line-buffered" "--color=always"
                                  "--hidden" "-g" "!.git" "--max-columns=500"
                                  "--no-heading" "--line-number" "." "-e"))

  ;; Use `fd' for `consult-find', with the following arguments.
  (setq consult-find-command '("fd" "-i" "-H" "-a" "-c" "never"))

  (autoload 'projectile-project-root "projectile")
  (setq consult-project-root-function #'projectile-project-root)

  (map! (:leader
         "s s" 'nil
         "s S" 'nil
         :desc "Search buffer"
         "s b" 'consult-line
         :desc "Search errors"
         "s e" 'consult-error
         :desc "Yank pop"
         "i y" 'consult-yank-pop
         :desc "Search in project"
         "s p" 'consult-ripgrep
         :desc "Ripgrep"
         "/" 'consult-ripgrep
         :desc "Ripgrep"
         "s R" 'consult-ripgrep
         :desc "Locate file"
         "s F" 'consult-locate
         :desc "Find file"
         "s f" 'consult-find)

        :desc "Complex command"
        "C-x M-:" 'consult-complex-command
        :desc "History"
        "C-c h"   'consult-history
        "M-X"     'consult-mode-command
        "M-g m"   'consult-mark
        "M-g k"   'consult-global-mark
        "M-g G"   'consult-git-grep
        "M-s g"   'consult-ripgrep))

;;; `consult-flycheck'
(use-package! consult-flycheck
  :when (featurep! :checkers syntax)
  :after (consult flycheck))

;;; `embark'
(use-package embark
  :bind
  ("C-," . embark-act)
  ("C-b" . embark-become)
  ("C->" . embark-act-noexit)
  :config

  ;; which-key integration for embark actions.
  (setq embark-action-indicator
        (lambda (map)
          (which-key--show-keymap "Embark" map nil nil 'no-paging)
          #'which-key--hide-popup-ignore-command)
        embark-become-indicator embark-action-indicator)

  ;; No unnecessary computation delay after injection.
  (add-hook 'embark-setup-hook 'selectrum-set-selected-candidate)

  (embark-define-keymap embark-become-general-map
    "Embark become keymap for files and buffers."
    ("f" consult-find)
    ("r" consult-ripgrep))

  (setq embark-become-keymaps '(embark-become-help-map embark-become-file+buffer-map embark-become-shell-command-map embark-become-match-map embark-become-general-map))

  (map! (:map embark-general-map
         :desc "Open vterm"
         "v" '+embark-vterm
         :desc "Magit status"
         "m" '+embark-magit-status
         "o" 'switch-to-buffer-other-window)

        (:map embark-file-map
         :desc "Open project vterm."
         "V" 'ch/vterm-in-project)

        (:map embark-become-match-map
         :desc "Find"
         "f" 'consult-find
         :desc "Ripgrep"
         "r" 'consult-ripgrep)

        (:map embark-match-map
         :desc "Find"
         "f" 'consult-find
         :desc "Ripgrep"
         "r" 'consult-ripgrep)))

;;; `embark-consult'
(use-package! embark-consult
  :after (embark consult))

;;; `marginalia'
(use-package marginalia
  :config
  (marginalia-mode)
  (advice-add #'marginalia-cycle :after
              (lambda () (when (bound-and-true-p selectrum-mode) (selectrum-exhibit))))

  (setq marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light)))

;;; `wgrep'
(use-package! wgrep
  :commands wgrep-change-to-wgrep-mode
  :config (setq wgrep-auto-save-buffer t))

;; When using `imenu' in org-mode buffers, reveal the contents of the candidate
;; heading on jump
(after! imenu
  (add-hook 'consult-after-jump-hook 'ch/imenu-reveal-content))

(after! projectile
  ;; FIXME Why is this broken when ivy is disabled?
  (setq projectile-switch-project-action (lambda ()
                                           (+workspaces-set-project-action-fn)
                                           (+workspaces-switch-to-project-h))))
