;; -*- no-byte-compile: t; -*-

(unpin! doom-modeline)
(unpin! doom-themes)
(unpin! vterm)

(package! evil-escape :disable t)
(package! evil-quick-diff :disable t)
(package! evil-traces :disable t)
(package! cuda-mode :disable t)
(package! demangle-mode :disable t)
(package! disaster :disable t)
(package! overseer :disable t)
(package! buttercup :disable t)
(package! opencl-mode :disable t)
(package! glsl-mode :disable t)
(package! company-glsl :disable t)
(package! flyspell-lazy :disable t)

(package! modus-operandi-theme)
(package! modus-vivendi-theme)
(package! color-theme-sanityinc-tomorrow)

(package! imenu-list)

(package! dired-open)

(package! dired-subtree)

(package! dired-narrow)

(package! peep-dired)

(package! dired-du)

(package! ace-window)

(package! highlight-indent-guides :pin "cf352c85cd15dd18aa096ba9d9ab9b7ab493e8f6")

;; (package! magit-delta :pin "b8526f890415374822514e488341d2b706d6bc2f")

(package! systemd)

(package! pkgbuild-mode)

;; (package! org-mode
;;   :recipe (:host github
;;            :repo "yantar92/org"
;;            :branch "feature/org-fold"
;;            :files ("*.el" "lisp/*.el" "contrib/lisp/*.el")
;;            :build (with-temp-file (expand-file-name "org-version.el" (straight--repos-dir "org"))
;;                     (insert "(fset 'org-release (lambda () \"9.5\"))\n"
;;                             "(fset 'org-git-version #'ignore)\n"
;;                             "(provide 'org-version)\n")))
;;   :pin "ac4874e39e7b2239857410a279e24ae3dcf482ea"
;;   :shadow 'org)

(package! org-superstar :pin "7f83636db215bf5a10edbfdf11d12a132864a914")

(package! org-protocol-capture-html
  :recipe (:host github :repo "alphapapa/org-protocol-capture-html")
  :pin "3359ce9a2f3b48df26329adaee0c4710b1024250")

(package! org-wild-notifier)

(package! org-super-agenda)

;; (package! org-roam-server)

(package! olivetti)
