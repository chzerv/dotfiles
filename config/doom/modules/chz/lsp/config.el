;;; chz/lsp/config.el -*- lexical-binding: t; -*-

(setq read-process-output-max (* 2 1024 1024)) ;; 2mb

(after! lsp
  (setq lsp-completion-provider :capf))

(after! lsp-ui
  (setq lsp-ui-sideline-enable nil
        lsp-ui-doc-enable t
        lsp-ui-doc-header t
        lsp-ui-doc-position 'at-point ;; top, bottom, or at-point
        lsp-ui-peek-enable t
        lsp-ui-peek-fontify 'on-demand)

  (map! :ne "C-S-k" 'lsp-ui-doc-glance))

