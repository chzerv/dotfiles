;;; chz/treemacs/config.el -*- lexical-binding: t; -*-
;;;###if (featurep! :ui treemacs)

(after! treemacs
  (setq treemacs-width 25)
  (setq doom-themes-treemacs-enable-variable-pitch nil))

;;; Key bindings
(after! treemacs
  (map! (:after evil
         (:map evil-treemacs-state-map
          "M-h" #'evil-window-left
          "M-l" #'evil-window-right))))

;;; Ignore specific files
(after! treemacs
  ;; https://github.com/tecosaur/emacs-config/blob/master/config.org
  ;; Quite often there are superfluous files I’m not that interested in. There’s no good reason for them to take up space. Let’s add a mechanism to ignore them.
  (defvar treemacs-file-ignore-extensions '()
    "File extension which `treemacs-ignore-filter' will ensure are ignored")
  (defvar treemacs-file-ignore-globs '()
    "Globs which will are transformed to `treemacs-file-ignore-regexps' which `treemacs-ignore-filter' will ensure are ignored")
  (defvar treemacs-file-ignore-regexps '()
    "RegExps to be tested to ignore files, generated from `treeemacs-file-ignore-globs'")
  (defun treemacs-file-ignore-generate-regexps ()
    "Generate `treemacs-file-ignore-regexps' from `treemacs-file-ignore-globs'"
    (setq treemacs-file-ignore-regexps (mapcar 'dired-glob-regexp treemacs-file-ignore-globs)))
  (if (equal treemacs-file-ignore-globs '()) nil (treemacs-file-ignore-generate-regexps))
  (defun treemacs-ignore-filter (file full-path)
    "Ignore files specified by `treemacs-file-ignore-extensions', and `treemacs-file-ignore-regexps'"
    (or (member (file-name-extension file) treemacs-file-ignore-extensions)
        (let ((ignore-file nil))
          (dolist (regexp treemacs-file-ignore-regexps ignore-file)
            (setq ignore-file (or ignore-file (if (string-match-p regexp full-path) t nil)))))))
  (add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-filter)

  (setq treemacs-file-ignore-extensions '(;; LaTeX
                                          "aux"
                                          "ptc"
                                          "fdb_latexmk"
                                          "fls"
                                          "synctex.gz"
                                          "toc"
                                          ;; LaTeX - glossary
                                          "glg"
                                          "glo"
                                          "gls"
                                          "glsdefs"
                                          "ist"
                                          "acn"
                                          "acr"
                                          "alg"
                                          ;; LaTeX - pgfplots
                                          "mw"
                                          ;; LaTeX - pdfx
                                          "pdfa.xmpi"
                                          ))
  (setq treemacs-file-ignore-globs '(;; LaTeX
                                     "*/_minted-*"
                                     ;; AucTeX
                                     "*/.auctex-auto"
                                     "*/_region_.log"
                                     "*/_region_.tex")))
