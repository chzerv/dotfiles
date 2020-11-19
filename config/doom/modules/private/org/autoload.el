;;; private/org/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
;; Disable flycheck in SRC blocks
;; (https://github.com/wandersoncferreira/dotfiles#configuration)
(defun org/disable-flycheck-in-org-src-block ()
  (setq-local flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;;;###autoload
(defun org/org-file-path (filename)
  "Return the absolute address of an org file, given its relative name."
  (concat (file-name-as-directory org-directory) filename))

;;;###autoload
(defun org/find-in-notes ()
  "Find a file under ~/Documents/Notes, recursively"
  (interactive)
  (counsel-fzf nil "~/Documents/Notes"))

;;;###autoload
(defun org/org-notes-search ()
  "Perform a text search on `~/Documents/Notes'"
  (interactive)
  (let ((default-directory "~/Documents/Notes"))
    (+default/search-project-for-symbol-at-point "")))

;;;###autoload
(defun org/org-search-and-narrow-headlines ()
  "Jump to an Org headline in `org-agenda-files' and narrow it."
  (interactive)
  (doom-completing-read-org-headings
   "Jump to org headline: " org-agenda-files 3 t)
  (org-narrow-to-subtree))

;; Create org-roam notes from org-headings.
;; Idea/code taken from https://ag91.github.io/blog/2020/11/12/write-org-roam-notes-via-elisp/

;;;###autoload
(defun org/make-filepath (title now &optional zone)
  "Make filename from note TITLE and NOW time (assumed in the current time ZONE)."
  (concat
   org-roam-directory
   (format-time-string "%Y%m%d%H%M%S_" now (or zone (current-time-zone)))
   (org-roam--title-to-slug title)
   ".org"))

;;;###autoload
(defun org/insert-org-roam-file (file-path title &optional links sources text quote)
  "Insert org roam file in FILE-PATH with TITLE, LINKS, SOURCES, TEXT, QUOTE."
  (with-temp-file file-path
    (insert
     "#+TITLE: " title "\n"
     "\n"
     "- tags :: " (--reduce (concat acc ", " it) links) "\n"
     (if sources (concat "- source :: " (--reduce (concat acc ", " it) sources) "\n") "")
     "\n"
     (if text text "")
     "\n"
     "\n"
     (if quote
         (concat "#+begin_src text \n"
                 quote "\n"
                 "#+end_src")
       ""))))

;;;###autoload
(defun org/convert-task-to-org-note ()
  "Convert a task in a `org-roam' note."
  (interactive)
  (let* ((heading (org-get-heading t t t t))
         (body (org-get-entry))
         (link (format "[[id:%s][%s]]" (org-id-get-create) heading))
         (filepath (org/make-filepath heading (current-time))))
    (org/insert-org-roam-file
     filepath
     heading
     nil
     (list link)
     (format "* Note stored from tasks\n%s" body)
     nil)
    (find-file filepath)))

;;;###autoload
(defun org/open-link-in-other-window ()
  (interactive)
  (let ((org-link-frame-setup (quote
                               ((vm . vm-visit-folder)
                                (vm-imap . vm-visit-imap-folder)
                                (gnus . gnus)
                                (file . find-file-other-window)
                                (wl . wl)))
                              ))
    (org-open-at-point)))
