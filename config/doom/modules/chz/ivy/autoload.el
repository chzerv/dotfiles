;;; chz/ivy/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun contrib/counsel-fzf-rg-files (&optional input dir)
  "Run `fzf' in tandem with `ripgrep' to find files in the
present directory.  If invoked from inside a version-controlled
repository, then the corresponding root is used instead."
  (interactive)
  (let* ((process-environment
          (cons (concat "FZF_DEFAULT_COMMAND=rg -Sn --color never --files --no-follow --hidden")
                process-environment))
         (vc (vc-root-dir)))
    (if dir
        (counsel-fzf input dir)
      (if (eq vc nil)
          (counsel-fzf input default-directory)
        (counsel-fzf input vc)))))

;;;###autoload
(defun contrib/counsel-fzf-ace-window (arg)
  "Use `ace-window' on `contrib/counsel-fzf-rg-files' candidate."
  (ace-window t)
  (let ((default-directory (if (eq (vc-root-dir) nil)
                               counsel--fzf-dir
                             (vc-root-dir))))
    (if (> (length (aw-window-list)) 1)
        (find-file arg)
      (find-file-other-window arg))
    (balance-windows (current-buffer))))

;;;###autoload
(defun contrib/counsel-fzf-dir (arg)
  "Specify root directory for `counsel-fzf'."
  (contrib/counsel-fzf-rg-files ivy-text
                             (read-directory-name
                              (concat (car (split-string counsel-fzf-cmd))
                                      " in directory: "))))

;;;###autoload
(defun contrib/counsel-rg-dir (arg)
  "Specify root directory for `counsel-rg'."
  (let ((current-prefix-arg '(4)))
    (counsel-rg ivy-text nil "")))
