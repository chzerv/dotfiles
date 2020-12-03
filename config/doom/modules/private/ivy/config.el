;;; private/ivy/config.el -*- lexical-binding: t; -*-

;;; Better defaults
(after! ivy
  (setq ivy-count-format "(%d/%d) "
        ivy-display-style 'fancy
        ivy-use-selectable-prompt t
        ivy-fixed-height-minibuffer nil
        ivy-read-action-function #'ivy-hydra-read-action))

;;; Key-bindings
(after! ivy
  (map! (:leader
         :desc "Search all buffers"
         "s a" 'swiper-all
         :desc "Search all buffers for thing at point"
         "s A" 'swiper-all-thing-at-point)))

;;; Counsel

;;;; Better defaults
(after! counsel
  (setq counsel-yank-pop-preselect-last t
        counsel-yank-pop-separator "\n—————————\n")
  ;; Use ripgrep for fzf, grep and git grep
  (setq counsel-fzf-cmd "rg --files --hidden --no-ignore --smart-case --glob !.git | fzf -f \"%s\"")
  (setq counsel-grep-base-command
        "rg -M 120 --line-number --smart-case --with-filename --color never --hidden --no-heading %s")
  (setq counsel-git-cmd "rg --files"))

;;;; Key bindings
(after! counsel
  (map!
   "s-f" 'counsel-find-file
   "s-F" 'find-file-other-window
   "s-d" 'counsel-dired
   "s-D" 'dired-other-window
   "s-p" 'counsel-fzf))

;;;; Ivy actions
(after! counsel
  (ivy-add-actions
   'counsel-fzf
   '(("r" contrib/counsel-fzf-dir "change root directory")
     ("g" contrib/counsel-rg-dir "use ripgrep in root directory")
     ("a" contrib/counsel-fzf-ace-window "ace-window switch")))

  (ivy-add-actions
   'counsel-rg
   '(("r" contrib/counsel-rg-dir "change root directory")
     ("z" contrib/counsel-fzf-dir "find file with fzf in root directory")))

  (ivy-add-actions
   'counsel-find-file
   '(("g" contrib/counsel-rg-dir "use ripgrep in root directory")
     ("z" contrib/counsel-fzf-dir "find file with fzf in root directory")))

  (ivy-set-actions
   'counsel-recentf
   '(("a" contrib/counsel-fzf-ace-window "ace-window switch"))))
