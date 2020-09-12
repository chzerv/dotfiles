;;; private/tools/config.el -*- lexical-binding: t; -*-



;;; Docker configuration

;; Override the default template for Dockerfiles.
(after! dockerfile-mode
  (set-file-template! 'dockerfile-mode
    :trigger "dockerfile-template"))

;;; pdf-tools configuration
(after! pdf-tools
  ;; more fine-grained zooming
  (setq pdf-view-resize-factor 1.1))

;;; Ansible configuration

;; Enable ansible-mode on every YAML file.
(after! yaml-mode
  (add-hook 'yaml-mode-hook #'+ansible-yaml-mode))

;;; LSP configuration

(setq read-process-output-max (* 2 1024 1024)) ;; 2mb
(after! lsp
  (setq lsp-completion-provider :capf
        lsp-idle-delay 0.500))

(after! lsp-ui
  (setq lsp-ui-sideline-enable nil
        lsp-ui-doc-enable t
        lsp-ui-doc-header t
        lsp-ui-doc-position 'at-point ;; top, bottom, or at-point
        lsp-ui-doc-delay 0.500
        lsp-ui-peek-enable t
        lsp-ui-peek-fontify 'on-demand)

  (map! :ne "C-S-k" 'lsp-ui-doc-glance))

;; Python stuff (ms-python server)

(after! lsp
  ;; lsp-python-ms (or rather the ms-python server) doesn't use other backends,
  ;; so manually set `flycheck-checker' in `python-mode'
  (add-hook! lsp-mode (when (derived-mode-p 'python-mode)
                        (setq-local flycheck-checker 'python-flake8))))
