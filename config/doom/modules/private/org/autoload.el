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
