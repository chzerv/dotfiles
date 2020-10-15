;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; Themes
(package! modus-operandi-theme)
(package! modus-vivendi-theme)
(package! color-theme-sanityinc-tomorrow)

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
