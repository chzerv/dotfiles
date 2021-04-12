;;; private/selectrum/config.el -*- lexical-binding: t; -*-

;;; `selectrum'
(use-package! selectrum
  :hook (doom-first-input . selectrum-mode)
  :init
  (setq selectrum-display-action nil
        selectrum-extend-current-candidate-highlight t
        selectrum-count-style 'current/matches)
  (unless (featurep! +orderless)
    (setq completion-styles '(substring partial-completion)))

  :config
  (setq selectrum-fix-vertical-window-height t)

  ;; (setq flyspell-correct-interface #'flyspell-correct-dummy)
  ;; (setq projectile-completion-system 'default)

  (map! :leader
        "f p" '+selectrum/find-file-in-private-config
        "'" 'selectrum-repeat))

;;; `selectrum-prescient'
(use-package! selectrum-prescient
  :when (featurep! +prescient)
  :hook (selectrum-mode . selectrum-prescient-mode)
  :hook (selectrum-mode . prescient-persist-mode)
  :config
  (setq selectrum-preprocess-candidates-function #'selectrum-prescient--preprocess)
  (add-hook 'selectrum-candidate-selected-hook #'selectrum-prescient--remember)
  (add-hook 'selectrum-candidate-inserted-hook #'selectrum-prescient--remember))

;;; `orderless'
(defun flex-if-twiddle (pattern _index _total)
  (when (string-suffix-p "~" pattern)
    `(orderless-flex . ,(substring pattern 0 -1))))

(defun first-initialism (pattern index _total)
  (if (= index 0) 'orderless-initialism))

(defun without-if-bang (pattern _index _total)
  "Define a '!not' exclusion prefix for literal strings."
  (when (string-prefix-p "!" pattern)
    `(orderless-without-literal . ,(substring pattern 1))))

(use-package! orderless
  :when (featurep! +orderless)
  :defer t
  :init
  (setq orderless-component-separator "[ &]"
        orderless-matching-styles '(orderless-prefixes
                                    orderless-initialism
                                    orderless-regexp))
  :config
  (setq completion-styles '(orderless))
  (setq orderless-skip-highlighting (lambda () selectrum-active-p))
  (setq selectrum-highlight-candidates-function #'orderless-highlight-matches)
  (setq orderless-matching-styles '(orderless-regexp)
        orderless-style-dispatchers '(flex-if-twiddle
                                      without-if-bang)))

;;; `consult'
(use-package consult
  :defer t
  :init
  ;; Replace `multi-occur' with `consult-multi-occur', which is a drop-in replacement.
  (fset 'multi-occur #'consult-multi-occur)
  (define-key!
    [remap switch-to-buffer]              #'consult-buffer
    [remap switch-to-buffer-other-window] #'consult-buffer-other-window
    [remap switch-to-buffer-other-frame]  #'consult-buffer-other-frame
    [remap evil-show-marks]               #'consult-mark
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
  (setq consult-project-root-function #'doom-project-root
        completion-in-region-function #'consult-completion-in-region
        consult-line-numbers-widen t
        consult-async-input-debounce 0.5
        consult-async-input-throttle 0.8
        consult-narrow-key "<"
        consult-widen-key ">"
        ;; Previews are way to "heavy", disable them.
        consult-preview-key nil)

  (setq consult-ripgrep-command "rg --null --line-buffered --color=always --hidden -g !.git --max-columns=500 --no-heading --line-number . -e ARG OPTS")

  ;; Use `fd' for `consult-find', with the following arguments.
  (setq consult-find-command "fd -i -H -a -c never OPTS ARG")

  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-root-function #'projectile-project-root)

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
         "s p" '+selectrum/project-search
         :desc "Search project from cwd"
         "s c" '+selectrum/project-search-from-cwd
         :desc "Ripgrep"
         "/" 'consult-ripgrep
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
  ;;:defer t
  :bind
  ("C-,"   . embark-act)
  :init
  (setq embark-action-indicator #'+embark-which-key-action-indicator
        embark-become-indicator embark-action-indicator)

  ;; No unnecessary computation delay after injection.
  (add-hook 'embark-setup-hook 'selectrum-set-selected-candidate)

  ; (embark-define-keymap embark-become-general-map
  ;   "Embark become keymap for files and buffers."
  ;   ("f" consult-find)
  ;   ("r" consult-ripgrep))

  (setq embark-become-keymaps '(embark-become-help-map embark-become-file+buffer-map embark-become-shell-command-map embark-become-match-map embark-become-general-map))

  (map! (:map embark-general-map
         :desc "Open vterm"
         "v" '+embark-vterm
         :desc "Magit status"
         "m" '+embark-magit-status)

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
  ;; When using Selectrum, ensure that Selectrum is refreshed when cycling annotations.
  (advice-add #'marginalia-cycle :after
              (lambda () (when (bound-and-true-p selectrum-mode) (selectrum-exhibit 'keep-selected))))

  (setq marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light))
  (add-to-list 'marginalia-command-categories '(persp-switch-to-buffer . buffer)))

;;; `wgrep'
(use-package! wgrep
  :commands wgrep-change-to-wgrep-mode
  :config (setq wgrep-auto-save-buffer t))

;; When using `imenu' in org-mode buffers, reveal the contents of the candidate
;; heading on jump
(after! imenu
  (add-hook 'consult-after-jump-hook 'ch/imenu-reveal-content))

;; FIXME Why is this broken when ivy is disabled?
(after! projectile
  (setq projectile-switch-project-action (lambda ()
                                           (+workspaces-set-project-action-fn)
                                           (+workspaces-switch-to-project-h))))
