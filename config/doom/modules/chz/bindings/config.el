;;; chz/bindings/config.el -*- lexical-binding: t; -*-

;; Find file in/Browse user-defined directories.
(map!
 (:leader
  :desc "Find File in private Notes"
  "n f" 'org/find-in-notes
  "f t" #'util/find-in-dotfiles
  "f T" #'util/browse-dotfiles))

;; Show git diff of the current buffer.
(map!
 (:after magit
  (:leader
   :desc "Git diff buffer"
   "g d" 'magit-diff-buffer-file)))

;; Mode maps
(map! (:when (featurep! :lang latex)
       (:map LaTeX-mode-map
        :ni "C-c s" 'util/latex-save-and-compile)))

 ;; Custom bindings
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

 ;; ;; Hydras
 (defhydra hydra-search-notes ()
   "Search notes"
   ("g" org/org-notes-search "General notes")
   ("o" +default/org-notes-search "Org dir"))

 (map! (:leader
        "n s" 'hydra-search-notes/body))

(map! :v [tab] (cmds! (and (bound-and-true-p yas-minor-mode)
                           (or (eq evil-visual-selection 'line)
                               (not (memq (char-after) (list ?\( ?\[ ?\{ ?\} ?\] ?\))))))
                      #'yas-insert-snippet
                      (fboundp 'evil-jump-item)
                      #'evil-jump-item))
