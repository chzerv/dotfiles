;;; ../../dotfiles/config/doom/autoload/util.el -*- lexical-binding: t; -*-

;;;###autoload
(defun util/append-to-path (path)
  "Add a path to both the $PATH variable and the emac's exec-path."
  (setenv "PATH" (concat (getenv "PATH") ":" path))
  (add-to-list 'exec-path path))

;;;###autoload
(defun util/latex-save-and-compile ()
  "Save the current buffer and compile it with 'xelatex'"
  (interactive)
  (save-buffer)
  (compile (format "xelatex %s" (file-name-nondirectory buffer-file-name))))

;;;###autoload
(defun util/find-in-dotfiles ()
  "Open a file somewhere in ~/.dotfiles via a fuzzy filename search."
  (interactive)
  (doom-project-find-file (expand-file-name "~/dotfiles/")))

;;;###autoload
(defun util/browse-dotfiles ()
  "Browse the files in ~/.dotfiles."
  (interactive)
  (doom-project-browse (expand-file-name "~/dotfiles/")))

;;;###autoload
(defun util/yt-dl-it (url)
    "Downloads the URL in an async shell"
    (let ((default-directory "~/Downloads/yt-dl"))
      (async-shell-command (format "youtube-dl %s" url))))

;;;###autoload
(defun util/eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

;;;###autoload
(defun util/kill-other-buffers ()
  "Kill all buffers except current one."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

;;;###autoload
(defun util/kill-all-dired-buffers ()
  "Kill all open dired buffers."
  (interactive)
  (mapc (lambda (buffer)
          (when (eq 'dired-mode (buffer-local-value 'major-mode buffer))
            (kill-buffer buffer)))
        (buffer-list)))

;;;###autoload
(defun util/markdown-save-and-compile ()
  "Save and compiles the currently loaded markdown buffer using pandoc into a PDF"
  (interactive)
  (save-buffer)
  (shell-command (concat "pandoc " (buffer-file-name) " -o "
                         (replace-regexp-in-string "md" "pdf" (buffer-file-name)))))

;;;###autoload
(defun util/imenu-reveal-entry ()
  "Reveal content of header at point after successful `imenu'
execution."
  (cond
   ((and (eq major-mode 'org-mode)
         (org-at-heading-p))
    (org-show-entry)
    (org-reveal t))
   ((when contrib/outline-minor-mode
      (outline-show-entry)))))

;;;###autoload
(defun util/switch-to-last-window ()
  "Switch to the most recently used window."
  (interactive)
  (let ((win (get-mru-window nil t t)))
    (unless win (error "Most recent window not found."))
    (select-window win)))

;;;###autoload
(defun util/tilix-here ()
  "Open the current dir in a new tilix window"
  (interactive)
  (let ((process-connection-type nil))
    (start-process "" nil "tilix"
                   (concat "--working-directory=" default-directory))))

;;;###autoload
(defun util/isearch-query-replace-symbol-at-point ()
    "Run `query-replace-regexp' for symbol at point."
    (interactive)
    (isearch-forward-symbol-at-point)
    (isearch-query-replace-regexp))

;;;###autoload
(defun util/occur-urls ()
  "Produce a list with all the URLs found in the current buffer."
  (interactive)
  (let ((urls browse-url-button-regexp))
    (occur urls "\\&")))

;;;###autoload
(defun util/find-auth-field (host prop)
  "Search `auth-sources' for HOST entry."
  (let* ((source (auth-source-search :host host))
         (field (plist-get
                 (flatten-list source)
                 prop)))
    (if source
        field
      (user-error "No entry found in auth-sources!"))))
