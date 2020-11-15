;;; private/org/config.el -*- lexical-binding: t; -*-

;; Set these as early as possible.
(setq-default org-directory "~/Documents/Syncthing/Org/roam/")

(when (featurep! :lang org +roam)
  (setq org-roam-directory "~/Documents/Syncthing/Org/roam/"))

(setq org-archive-location
        (concat (org/org-file-path "archive.org") "::* From %s"))

;;; Better defaults
(after! org

  ;; Make the title just a little bit bigger.
  (custom-set-faces!
    '(org-document-title :height 1.5))

  (custom-set-faces!
    '(org-level-1 :weight extra-bold :height 1.1)
    '(org-level-2 :weight bold :height 1.085)
    '(org-level-3 :weight bold :height 1.065)
    '(org-level-4 :weight semi-bold :height 1.055)
    '(org-level-5 :weight semi-bold :height 1.035)
    '(org-level-6 :weight semi-bold :height 1.025)
    '(org-level-8 :weight semi-bold)
    '(org-level-9 :weight semi-bold))

  ;; Enable org-habit
  (add-to-list 'org-modules 'org-habit)

  ;; Place a blank line before a new heading or list item.
  org-blank-before-new-entry (quote ((heading) (plain-list-item)))

  ;; Default arguments to use when evaluating a code block.
  (setq org-babel-default-header-args
        (cons '(:results . "output verbatim replace")
              (assq-delete-all :results org-babel-default-header-args)))

  ;; Improve org-mode's performance.
  (setq org-fontify-whole-heading-line nil
        org-highlight-latex-and-related nil
        org-hide-leading-stars nil)

  ;; org-startup
  (setq org-startup-indented t
        org-startup-with-latex-preview t
        org-startup-with-inline-images nil
        org-startup-folded t)
  (add-hook 'org-src-mode-hook 'org/disable-flycheck-in-org-src-block)

  (add-hook 'org-mode-hook
            '(lambda ()
               (setq org-file-apps
                     '((auto-mode . emacs)
                       ("\\.mm\\'"      . default)
                       ("\\.png\\'"     . "eog %s")
                       ("\\.jpg\\'"     . "eog %s")
                       ("\\.jpeg\\'"    . "eog %s")
                       ("\\.mp4\\'"     . "mpv %s")
                       ("\\.x?html?\\'" . firefox)))))

  ;; Set width of images according to display size
  org-image-actual-width (truncate (* (display-pixel-width) 0.15)))

;;; Key bindings
(after! org
  (map! (:map org-mode-map
         :ne "]i" 'org-next-item
         :ne "[i" 'org-previous-item
         (:localleader
          :desc "Heading to roam note"
          "n" 'org/convert-task-to-org-note))
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
        '((sequence "TODO(t)" "NEXT(n!)" "WIP(w)" "SOMEDAY(s)" "HOLD(h!)" "|" "DONE(d!)" "CANCELLLED(c@/!)")))
  (setq org-todo-keyword-faces
        '(("TODO" :foreground "OrangeRed" :weight bold :underline t :overline t)
          ("NEXT" :foreground "spring green" :weight bold :underline t :overline t)
          ("SOMEDAY" :foreground "coral" :weight bold)
          ("HOLD" :foreground "DeepPink" :weight bold)
          ("WIP" :foreground "DarkCyan" :weight bold)
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
          ("study"            )
          ("lab"              )
          ("course"           )
          ("assignment"       )
          ("@personal"    . ?p)
          ("health"           )
          ("coding"           )
          ("brainstorming"    )
          ("goal"             )
          ("learn"            )
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

;;; LaTeX stuff
;; Syntax highlighting in LaTeX exports, using pygments
(after! org
  (add-to-list 'org-latex-packages-alist '("minted" "cancel"))
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
        '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

  ;; Adjust org-latex-preview scaling.
  ;; The default 1.5 makes latex previews seem kinda out of place.
  (plist-put org-format-latex-options :scale 1.3))

;;; org-roam
(after! org-roam
  (add-hook 'org-roam-backlinks-mode-hook #'flyspell-mode-off)

  (map! :leader
        "n r t" 'org-roam-dailies-find-today)

  ;; Change the default "daily" org-roam-dailies-capture-template
  ;; so it: includes the name of the day in the filename and the title.
  (setq org-roam-dailies-capture-templates
        '(("d" "daily" plain (function org-roam-capture--get-point) ""
           :immediate-finish t
           :file-name "%<%A-%Y-%m-%d>"
           :head "#+TITLE: %<%A %Y-%m-%d>\n#+STARTUP: content\n\n"))))

(use-package! org-roam-server
  :disabled t
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
  (setq deft-directory "~/Documents/Syncthing/Org/roam/"
        deft-auto-save-interval 0
        deft-recursive t
        deft-current-sort-method 'title
        deft-extensions '("md" "txt" "org")
        deft-use-filename-as-title nil))

(load! "agenda")
(load! "capture-templates")
