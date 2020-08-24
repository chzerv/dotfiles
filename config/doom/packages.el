;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; Themes
(package! modus-operandi-theme)
(package! modus-vivendi-theme)
(package! color-theme-sanityinc-tomorrow)

;; A much cleaner agenda, with easily defined groups.
(package! org-super-agenda)

;; outline-mode tweaks

;; Add some faces to separate outline headings from comments.
(package! outline-minor-faces)
;; Kinda like narrow.
(package! foldout)
;; Cycle between showall and fold, like in org-mode.
(package! bicycle)

;; Testing tree-sitter for syntax highlighting
(package! tree-sitter 
          :recipe (:host github
                   :repo "ubolonton/emacs-tree-sitter"
                   :files ("lisp/*.el")))

(package! tree-sitter-langs 
          :recipe (:host github
                   :repo "ubolonton/emacs-tree-sitter"
                   :files ("langs/*.el" "langs/queries")))

;; Unpin packages
(unpin! doom-modeline)
(unpin! doom-themes)
(unpin! vterm)

;; Disable packages
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
