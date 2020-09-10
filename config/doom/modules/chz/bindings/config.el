;;; chz/bindings/config.el -*- lexical-binding: t; -*-

;; Bindings for utility functions
(map! (:when (featurep! :lang latex)
       (:map LaTeX-mode-map
        :ni "C-c s" 'util/latex-save-and-compile))
      (:leader
       :desc "Find file in private notes"
       "n f" 'org/find-in-notes
       :desc "Find file in dotfiles"
       "f t" #'util/find-in-dotfiles
       :desc "Browse dotiles"
       "f T" #'util/browse-dotfiles
       (:prefix ("o" . "+open")
        :desc "Open external terminal here"
        "x" 'util/terminal-here))
      "s-k" 'util/kill-other-buffers
      "s-K" 'util/kill-all-dired-buffers
      "s-o" 'util/switch-to-last-window)

;; Show git diff of the current buffer.
(map!
 (:after magit
  (:leader
   :desc "Git diff buffer"
   "g d" 'magit-diff-buffer-file)))

;; dired-sidebar
(map! (:when (not (featurep! :ui treemacs))
       :leader
       :prefix ("o" . "+open")
       :desc "Project sidebar"
       "p" #'dired-sidebar-toggle-sidebar))

 ;; Open RSS/mail (if the modules are enabled).
(map! :leader
      (:prefix ("e" . "External")
       ;; Mail
       (:when (featurep! :email notmuch)
        (:prefix ("m" . "Mail")
         :desc "Open notmuch" "o" 'notmuch
         :desc "counsel-notmuch" "c" 'counsel-notmuch
         :desc "Update notmuch" "u" '+notmuch/update))
       (:when (featurep! :email mu4e)
        (:prefix ("m" . "Mail")
         :desc "Open mu4e" "o" 'mu4e
         :desc "Show unread" "u" 'mu4e-alert-view-unread-mails))
       ;; Elfeed
       (:when (featurep! :app rss)
        (:prefix ("e" . "Elfeed")
         :desc "Open elfeed" "o" 'rss/elfeed-open))))

;; Wrap selection in an existing snippet, according to active major-mode.
(map! :v [tab] (cmds! (and (bound-and-true-p yas-minor-mode)
                           (or (eq evil-visual-selection 'line)
                               (not (memq (char-after) (list ?\( ?\[ ?\{ ?\} ?\] ?\))))))
                      #'yas-insert-snippet
                      (fboundp 'evil-jump-item)
                      #'evil-jump-item))

 ;; Hydras
 (defhydra hydra-search-notes ()
   "Search notes"
   ("g" org/org-notes-search "General notes")
   ("o" +default/org-notes-search "Org dir"))

 (map! (:leader
        "n s" 'hydra-search-notes/body))
