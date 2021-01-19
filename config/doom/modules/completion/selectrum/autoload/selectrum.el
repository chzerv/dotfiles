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
