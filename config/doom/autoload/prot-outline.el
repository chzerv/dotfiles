;;; ~/dotfiles/doom.d/autoload/chz.el -*- lexical-binding: t; -*-

;; Functions to extend outline-minor-mode's functionality, stolen from Protesilaos Stavrou.
;; https://gitlab.com/protesilaos/dotfiles/-/blob/master/emacs/.emacs.d/emacs-init.org#h:c519300f-8a9a-472b-b26d-c2f49adbdb5d

;;;###autoload
(defun contrib/outline-hide-all ()
  "Hide all `outline-mode' subtrees."
  (interactive)
  (outline-map-region 'outline-hide-subtree (point-min) (point-max)))

;;;###autoload
(defun contrib/outline-down-heading ()
  "Move to the next `outline-mode' subtree."
  (interactive)
  ;; Hacky, but it kinda works.
  (outline-up-heading 1 t)
  (outline-forward-same-level 1))

;;;###autoload
(defun contrib/bicycle-cycle-tab-dwim ()
  "Convenience wrapper for TAB key in `outline-mode'."
  (interactive)
  (if (outline-on-heading-p)
      (bicycle-cycle)
    (indent-for-tab-command)))

(defvar contrib/outline-minor-mode-enter-hook nil
  "Hook that runs when `contrib/outline-minor-mode' is enabled.")

(defvar contrib/outline-minor-mode-exit-hook nil
  "Hook that runs when `contrib/outline-minor-mode' is disabled.")

;; `imenu' integration with `outline-minor-mode'
;;;###autoload
(defun contrib/outline-imenu-heading ()
  "Move to the previous `outline-mode' heading.
This is because `imenu' produces its index by moving backward
from the bottom."
  (outline-previous-heading))

;;;###autoload
(defun contrib/outline-imenu-title ()
  "Return the text of the `outline-mode' heading."
  (interactive)
  ;; NOTE This may be too simplistic and error-prone, though I have
  ;; not ran into any problems.
  (buffer-substring (point-at-bol)
                    (point-at-eol)))

;;;###autoload
(defun contrib/outline-imenu-setup ()
  "`imenu' bindings for the local `outline-mode' buffer.
To be used in tandem with `contrib/outline-minor-mode-enter-hook'."
  (setq-local imenu-prev-index-position-function
              'contrib/outline-imenu-heading)
  (setq-local imenu-extract-index-name-function
              'contrib/outline-imenu-title))

;;;###autoload
(defun contrib/outline-imenu-restore ()
  "Restore `imenu' list when `contrib/outline-minor-mode' is off.
The new index should be the same as the one you would get in a
standard invocation of `imenu'.

To be used in `contrib/outline-minor-mode-exit-hook'."
  (dolist (var '(imenu-prev-index-position-function
                 imenu-extract-index-name-function))
    (kill-local-variable var))
  (save-excursion
    (imenu-default-create-index-function)
    (message "Refreshed `imenu' index")))

;; XXX This could prove problematic when more than one major modes are
;; active, such as when you use C-c ' in an Org block.
;;;###autoload
(defun contrib/outline-minor-refontify ()
  "Re-enable the current buffer's major mode.
Add this to `contrib/outline-minor-mode-exit-hook'."
  (let ((mode major-mode))
    (when (or (derived-mode-p 'text-mode)
              (derived-mode-p 'prog-mode))(funcall mode)
              (message "Re-enabled %s" mode))))
