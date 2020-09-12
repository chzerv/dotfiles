;;; private/misc/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun contrib/rg-save-search-as-name ()
    "Save `rg' buffer, naming it after the current search query.

This function is meant to be mapped to a key in `rg-mode-map'."
    (interactive)
    (let ((pattern (car rg-pattern-history)))
      (rg-save-search-as-name (concat "«" pattern "»"))))

;;;###autoload
(defun contrib/imenu-list-dwim (&optional arg)
    "Convenience wrapper for `imenu-list'.
Move between the current buffer and a dedicated window with the
contents of `imenu'.

The dedicated window is created if it does not exist, while it is
updated once it is focused again through this command.

With \\[universal-argument] toggle the display of the window."
    (interactive "P")
    (if arg
        (imenu-list-smart-toggle)
      (with-current-buffer
          (if (eq major-mode 'imenu-list-major-mode)
              (pop-to-buffer (other-buffer (current-buffer) t))
            (imenu-list)))))
