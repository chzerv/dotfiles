;;; private/org/config.el -*- lexical-binding: t; -*-

(setq org-directory "~/Documents/Syncthing/Org/roam/"
      org-link-file-path-type 'relative)

;;; Better defaults
(after! org
  (setq org-archive-location
        (concat (org/org-file-path "archive.org") "::* From %s"))

  ;; Enable org-habit
  (add-to-list 'org-modules 'org-habit)

  ;; Place a blank line before a new heading or list item.
  org-blank-before-new-entry (quote ((heading) (plain-list-item)))

  ;; Default arguments to use when evaluating a code block.
  (setq org-babel-default-header-args
        (cons '(:results . "output verbatim replace")
              (assq-delete-all :results org-babel-default-header-args)))

  ;; Improve org-mode's performance.
  (setq org-fontify-quote-and-verse-blocks nil
        org-fontify-whole-heading-line nil
        org-highlight-latex-and-related nil
        org-hide-leading-stars nil)
  (add-hook 'org-mode-hook #'turn-off-smartparens-mode)

  ;; org-startup
  (setq org-startup-indented t
        org-startup-with-latex-preview t
        org-startup-with-inline-images nil
        org-startup-folded 'fold)
  (add-hook 'org-src-mode-hook 'org/disable-flycheck-in-org-src-block)

  (add-hook 'org-mode-hook
            '(lambda ()
               (setq org-file-apps
                     '((auto-mode . emacs)
                       ("\\.mm\\'" . default)
                       ("\\.png\\'" . "eog %s")
                       ("\\.jpg\\'" . "eog %s")
                       ("\\.jpeg\\'" . "eog %s")
                       ("\\.x?html?\\'" . default)
                       ("\\.pdf\\'" . "evince %s"))))))
;;; Key bindings
(after! org
  (map! (:map org-mode-map
         :ne "]i" 'org-next-item
         :ne "[i" 'org-previous-item)
        (:map org-super-agenda-header-map
         "j" 'org-agenda-next-line
         "k" 'org-agenda-previous-line)
        (:leader
         :prefix ("n" . "+notes")
         :desc "Search headline and narrow it"
         "V" 'org/org-search-and-narrow-headlines)))

;;; TODO keywords
(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n!)" "SOMEDAY(s)" "HOLD(h!)" "|" "DONE(d!)" "CANCELLLED(c@/!)")))
  (setq org-todo-keyword-faces
        '(("TODO" :foreground "OrangeRed" :weight bold :underline t :overline t)
          ("NEXT" :foreground "spring green" :weight bold :underline t :overline t)
          ("SOMEDAY" :foreground "coral" :weight bold)
          ("HOLD" :foreground "DeepPink" :weight bold)
          ("DONE" :foreground "slategrey" :weight bold :strike-through t)
          ("CANCELLED" :foreground "red2" :weight bold :strike-through t))))

;;; Logging and drawers
(after! org
  (setq org-log-into-drawer t
        org-log-done 'time
        org-log-repeat 'time
        org-log-redeadline 'note
        org-log-reschedule 'note))

;;; Tags
(after! org
  (setq org-tag-alist
        '(("@uni"         . ?u)
          ("study")
          ("lab")
          ("course")
          ("assignment")
          ("@personal"    . ?p)
          ("health")
          ("coding")
          ("brainstorming")
          ("goal")
          ("learn")
          ("@read"        . ?r)
          ("@appointment" . ?i)
          ("@project"     . ?P)
          ("@note"        . ?n))))

;;; Refiling
;; Make refile work across all agenda-files
(after! org
  (setq org-refile-targets (quote ((nil :maxlevel . 9)
                                   (org-agenda-files :maxlevel . 9)))
        org-refile-use-outline-path t
        org-outline-path-complete-in-steps t
        org-refile-allow-creating-parent-nodes 'confirm))

;;; Syntag highlighting in LaTeX exports, using pygments
(after! org
  (setq org-latex-listings 'minted
        org-latex-minted-options
        '(("mathescape" "true")
          ("linenos" "true")
          ("numbersep" "5pt")
          ("breaklines" "true")
          ("breakanywhere" "true")
          ("frame" "lines")))
          ;; ("framesep" "2mm")))
  (setq org-latex-pdf-process
        '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f")))

;;; org-roam
(after! org-roam
  (setq org-roam-directory "~/Documents/Syncthing/Org/roam"))

(use-package! org-roam-server
  :after org-roam
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8088
        org-roam-server-export-inline-images t
        org-roam-server-authenticate nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20
        org-roam-server-network-poll t
        org-roam-server-network-arrows 'from))

;;; deft
(after! deft
  (setq deft-directory "~/Documents/Syncthing/Org/roam"
        deft-auto-save-interval 0
        deft-recursive t
        deft-current-sort-method 'title
        deft-extensions '("md" "txt" "org")
        deft-use-filename-as-title nil))

(load! "agenda")
