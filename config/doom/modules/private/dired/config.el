;;; private/dired/config.el -*- lexical-binding: t; -*-

;;; Better defaults
(after! dired
  (setq dired-recursive-deletes 'always
        delete-by-moving-to-trash t
        dired-listing-switches "-AGFhlv --group-directories-first --time-style=long-iso")
  (add-hook 'dired-mode-hook (lambda ()
                               (dired-hide-details-mode 1)
                               (hl-line-mode))))

;;; Key bindings
(after! dired
  (map! :after dired
        (:map dired-mode-map
         :enm "M-h" #'evil-window-left
         :enm "M-j" #'evil-window-bottom
         :enm "M-k" #'evil-window-up
         :enm "M-l" #'evil-window-right
         :enm "M-q" #'evil-quit
         "j" 'dired-next-line
         "k" 'dired-previous-line
         "h" 'dired-up-directory
         "l" 'dired-open-file)
        "s-j" 'dired-jump
        "s-J" 'dired-jump-other-window))

;;; dired-x
(after! dired-x
  (setq dired-clean-up-buffers-too t
        dired-clean-confirm-killing-deleted-buffers t
        dired-bind-info nil
        dired-bind-man nil))

;;; dired-async
;; Gives dired the ability to  perform actions asynchronously.
(after! (:and dired async)
  (dired-async-mode 1))

;;; dired-open
;; Let's us specify the default application to be used when opening
;; different files.
(use-package! dired-open
  :after (dired)
  :config
  (setq dired-open-extensions
        '(("pdf" . "evince")
          ("jpg" . "eog")
          ("png" . "eog")
          ("mkv" . "mpv")
          ("mov" . "mpv")
          ("mp3" . "mpv")
          ("mp4" . "mpv")
          ("avi" . "mpv"))))

;;; dired-subtree
;; Provides a more intuitive view of the subtree.
(use-package! dired-subtree
  :after dired
  :config
  (setq dired-subtree-cycle-depth 4)
  (map! :map dired-mode-map
        [backtab] #'dired-subtree-cycle
        [tab] #'dired-subtree-toggle
        :n "g^" #'dired-subtree-beginning
        :n "g$" #'dired-subtree-end
        :n "gm" #'dired-subtree-mark-subtree
        :n "gu" #'dired-subtree-unmark-subtree))

;;; dired-narrow
;; Easier narrowing in dired buffers.
(use-package! dired-narrow
  :after dired
  :config
  (setq dired-narrow-exit-when-one-left t
        dired-narrow-enable-blinking t
        dired-narrow-blink-time 0.3)
  (map! :map dired-mode-map
        "C-c /" 'dired-narrow-regexp))


;;; peep-dired
;; File previews (including images) in dired.
(use-package! peep-dired
  :after dired
  :config
  (setq peep-dired-cleanup-on-disable t
        peep-dired-cleanup-eagerly t
        peep-dired-enable-on-directories nil
        peep-dired-ignored-extensions
        '("mkv" "webm" "mp4" "mp3" "ogg" "iso"))
  (map! :map dired-mode-map
        "P" 'peep-dired))

;;; dired-sidebar
(use-package! dired-sidebar
  :disabled t
  :after dired
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (setq dired-sidebar-width 25
        dired-sidebar-theme 'nerd
        dired-sidebar-tui-update-delay 5
        dired-sidebar-recenter-cursor-on-tui-update t
        dired-sidebar-no-delete-other-windows t
        dired-sidebar-use-custom-modeline t)
  (pushnew! dired-sidebar-toggle-hidden-commands
            'evil-window-rotate-upwards 'evil-window-rotate-downwards)
  (map! :map dired-sidebar-mode-map
        :n "q" #'dired-sidebar-toggle-sidebar))

;;; dired-du
;; Check directory size, inside dired.
(use-package! dired-du
  :after dired
  :commands dired-du-mode)
