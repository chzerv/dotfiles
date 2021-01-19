;;; completion/selectrum/autoload/embark.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +embark-vterm (file)
  "Run vterm in directory of FILE."
  (interactive "GDirectory: ")
  (let ((default-directory
          (file-name-directory
           (expand-file-name
            (substitute-in-file-name file)))))
    (vterm)))

;;;###autoload
(defun +embark-magit-status ()
  (interactive)
  (magit-status-internal projectile-project-root))
