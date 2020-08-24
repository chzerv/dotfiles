;;; chz/org/config.el -*- lexical-binding: t; -*-

;; Set these before org loads.
;; org-directory is self explanatory but
;; the other two, often help to avoid hangs
;; in case inline images exist.
(setq org-directory "~/Documents/Syncthing/Org/"
      org-startup-with-inline-images nil)

(add-hook 'org-src-mode-hook 'org/disable-flycheck-in-org-src-block)

;;; Improve org-mode's performance.
(after! org
  (setq org-fontify-quote-and-verse-blocks nil
        org-fontify-whole-heading-line nil
        ;; org-hide-leading-stars t
        org-hide-leading-stars nil))

;;; Key bindings
(after! org
(map! (:map org-mode-map
        :ne "]i" 'org-next-item
        :ne "[i" 'org-previous-item)
       (:map org-super-agenda-header-map
        "j" 'org-agenda-next-line
        "k" 'org-agenda-previous-line)))

;;; Better defaults
(after! org
  (setq org-use-property-inheritance t
        ;; Place a blank line before a new heading or list item.
        org-blank-before-new-entry (quote ((heading) (plain-list-item)))
        ;; I think the highlighting is terrible.
        ;; Also fixes some scrolling performance issues in
        ;; large org files.
        org-highlight-latex-and-related nil
        org-startup-indented t
        org-startup-with-latex-preview t
        org-startup-folded 'fold
        org-list-allow-alphabetical t)
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

;;; Archive location
(after! org
  (setq org-archive-location
        (concat (org/org-file-path "archive.org") "::* From %s")))

;; org-habit
(after! org
  (add-to-list 'org-modules 'org-habit))

;; org-babel
(after! org
  (setq org-babel-default-header-args
        (cons '(:results . "output verbatim replace")
              (assq-delete-all :results org-babel-default-header-args))))


;;; Todo keywords
(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n!)" "SOMEDAY(s)" "ACTIVE(a!)" "|" "DONE(d!)")
          (sequence "PROJ(p)")
          (sequence "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))
  (setq org-todo-keyword-faces
        '(("TODO" :foreground "OrangeRed" :weight bold :underline t :overline t)
          ("NEXT" :foreground "SteelBlue" :weight bold)
          ("SOMEDAY" :foreground "gold" :weight bold)
          ("ACTIVE" :foreground "DeepPink" :weight bold)
          ("NEXT" :foreground "spring green" :weight bold)
          ("PROJ" :foreground "BlueViolet" :weight bold :underline t)
          ("CANCELLED" :foreground "red2" :weight bold :strike-through t)
          ("DONE" :foreground "slategrey" :weight bold :strike-through t))))

;;; Tags
(after! org
  (setq org-tag-alist
        '(("@university"  . ?u)
          ("@study"       . ?s)
          ("@tests"       . ?t)
          ("@lab"         . ?l)
          ("@course"      . ?c)
          ("@assignment"  . ?a)
          ("@read"        . ?r)
          ("@idea"        . ?i)
          ("@appointment" . ?i)
          ("@emacs"       . ?e)
          ("@personal"    . ?p)
          ("@project"     . ?P)
          ("@note"        . ?n))))

(after! org
  (setq org-tags-exclude-from-inheritance '("#PROJ")))

;;; Logging & Drawers
(after! org
  (setq org-log-state-notes-insert-after-drawers nil
        org-log-into-drawer t
        org-log-done 'time
        org-log-repeat 'time
        org-log-redeadline 'note
        org-log-reschedule 'note))

;; Prettify
(after! org
  (setq org-hide-emphasis-markers nil
        org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+"))))
        ;; org-ellipsis " ⤵ "))
        ;; org-ellipsis " ▼"))

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

;;; Load 3rd party libraries
(load! "agenda")
(load! "capture-templates")
