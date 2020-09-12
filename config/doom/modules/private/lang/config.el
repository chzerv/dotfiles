;;; private/lang/config.el -*- lexical-binding: t; -*-

;;; LaTeX configuration

(setq +latex-viewers '(pdf-tools evince zathura))

(after! latex
  ;; Save without asking when invoking TeX commands
  (setq TeX-save-query nil)
  ;; While inserting commands in comment sections, do not be intelligent and comment the command
  (setq LaTeX-insert-into-comments nil)
  ;; Allow `TeX-view' to refresh a PDF in another frame
  ;; https://emacs.stackexchange.com/questions/55395/auctex-and-pdf-tools-in-2-separate-frames-for-dual-monitor-setup
  (advice-add 'TeX-pdf-tools-sync-view :around #'latex/display-buffer-use-some-frame)
  (advice-add 'pdf-sync-backward-search-mouse :around #'latex/display-buffer-use-some-frame))

;; Do not spellcheck latex documents when opened, this takes a lot of time.
;;(remove-hook 'flyspell-mode-hook #'+spellcheck|immediately)
(after! tex
  (setq-hook! 'TeX-mode-hook +flyspell-immediately nil))

;;; Rust configuration

(after! rustic
  (setq rust-indent-method-chain t
        rustic-lsp-server 'rust-analyzer
        lsp-rust-analyzer-server-command '("/usr/bin/rust-analyzer")
        rustic-cargo-bin "~/.cargo/bin/cargo"
        rustic-format-on-save t))


;;; Python configuration
(after! python
  (setq python-indent-offset 4
        python-shell-interpreter "python3"
        importmagic-python-interpreter "python3"
        flycheck-python-pylint-executable "pylint"
        flycheck-python-flake8-executable "flake8"))
