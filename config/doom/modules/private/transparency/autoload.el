;;; private/transparency/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun prv/transparency-toggle ()
  "Toggels transparency on and off. If the transparency is 100 prompts
for a alpha value. If transparency is not 100 it's set to 100."
  (interactive)
  (if (and (not (eq (frame-parameter nil 'alpha) 100))
           (not (eq (frame-parameter nil 'alpha) nil)))
      (set-frame-parameter (selected-frame) 'alpha 100)
    (set-frame-parameter (selected-frame) 'alpha
                         (read-number "Enter transparency(0-100):"))))
