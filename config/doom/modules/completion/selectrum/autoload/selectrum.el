;;; completion/selectrum/autoload/selectrum.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +selectrum/project-find-file (dir)
  "Jump to a file in DIR (searched recursively).
If DIR is not a project, it will be indexed (but not cached)."
  (unless (file-directory-p dir)
    (error "Directory %S does not exist" dir))
  (unless (file-readable-p dir)
    (error "Directory %S isn't readable" dir))
  (let* ((default-directory (file-truename dir))
         (projectile-project-root (doom-project-root dir))
         (projectile-enable-caching projectile-enable-caching))
    (cond (projectile-project-root
           (unless (doom-project-p default-directory)
             ;; Disable caching if this is not a real project; caching
             ;; non-projects easily has the potential to inflate the projectile
             ;; cache beyond reason.
             (setq projectile-enable-caching nil))
           (if (doom-module-p :completion 'ivy)
               ;; Intentionally avoid `helm-projectile-find-file', because it runs
               ;; asynchronously, and thus doesn't see the lexical
               ;; `default-directory'
               (call-interactively #'counsel-projectile-find-file)
             ;; THIS IS WHAT I CHANGED! projectile comes with a function for
             ;; this exact purpose!
             (projectile-find-file-in-directory default-directory)))
          ((fboundp 'consult-fdfind)
           (call-interactively #'consult-fdfind))
          ((fboundp 'counsel-file-jump) ; ivy only
           (call-interactively #'counsel-file-jump))
          ((project-current nil dir)
           (project-find-file-in nil nil dir))
          ((fboundp 'helm-find-files)
           (call-interactively #'helm-find-files))
          ((call-interactively #'find-file)))))

;;;###autoload
(defun +selectrum/find-file-in-private-config ()
  "Search for a file in `doom-private-dir'."
  (interactive)
  (+selectrum/project-find-file doom-private-dir))

;;;###autoload
(defadvice! +orderless-match-with-one-face (fn &rest args)
    "Function to help company to highlight all candidates with just
one face."
    :around 'company-capf--candidates
    (let ((orderless-match-faces [completions-common-part]))
        (apply fn args)))

;;;###autoload
(defun +embark-which-key-action-indicator (map)
  "Helper function to display the `whichey' help buffer for embark."
  (which-key--show-keymap "Embark" map nil nil 'no-paging)
  #'which-key--hide-popup-ignore-command)

;;;###autoload
(cl-defun +selectrum-file-search (&key query in all-files (recursive t) prompt args)
  "Conduct a file search using ripgrep.

:query STRING
  Determines the initial input to search for.
:in PATH
  Sets what directory to base the search out of. Defaults to the current project's root.
:recursive BOOL
  Whether or not to search files recursively from the base directory."
  (declare (indent defun))
  (unless (executable-find "rg")
    (user-error "Couldn't find ripgrep in your PATH"))
  (require 'consult)
  (setq deactivate-mark t)
  (let* ((this-command 'consult--grep)
         (project-root (or (doom-project-root) default-directory))
         (directory (or in project-root))
         (args (split-string
                (string-trim
                 (concat (if all-files "-uu")
                         (unless recursive "--maxdepth 1")
                         "--null --line-buffered --color=always --max-columns=500 --no-heading --line-number"
                         " --hidden -g !.git "
                         (mapconcat #'shell-quote-argument args " ")))
                " "))
         (prompt (or prompt
                     (format "rg [%s]: "
                             (cond ((equal directory default-directory)
                                    "./")
                                   ((equal directory project-root)
                                    (projectile-project-name))
                                   ((file-relative-name directory project-root))))))
         (query (or query
                    (when (doom-region-active-p)
                      (replace-regexp-in-string
                       "[! |]" (lambda (substr)
                                 (cond ((and (string= substr " ")
                                             (not (featurep! +fuzzy)))
                                        "  ")
                                       ((string= substr "|")
                                        "\\\\\\\\|")
                                       ((concat "\\\\" substr))))
                       (rxt-quote-pcre (doom-thing-at-point-or-region))))))
         (ripgrep-command (mapconcat #'identity `("rg" ,@args "." "-e ARG OPTS" ) " ")))
    (consult--grep prompt ripgrep-command directory query)))

;;;###autoload
(defun +selectrum/project-search (&optional arg initial-query directory)
  "Peforms a live project search from the project root using ripgrep.
If ARG (universal argument), include all files, even hidden or compressed ones,
in the search."
  (interactive "P")
  (+selectrum-file-search :query initial-query :in directory :all-files arg))

;;;###autoload
(defun +selectrum/project-search-from-cwd (&optional arg initial-query)
  "Performs a live project search from the current directory.
If ARG (universal argument), include all files, even hidden or compressed ones."
  (interactive "P")
  (+selectrum/project-search arg initial-query default-directory))

;;;###autoload
(defun +consult-line-symbol-at-point ()
  (interactive)
  (consult-line (thing-at-point 'symbol)))
