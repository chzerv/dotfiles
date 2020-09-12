;;; chz/rust/config.el -*- lexical-binding: t; -*-

(after! rustic
  (setq rust-indent-method-chain t
        rustic-lsp-server 'rust-analyzer
        lsp-rust-analyzer-server-command '("/usr/bin/rust-analyzer")
        rustic-cargo-bin "~/.cargo/bin/cargo"
        rustic-format-on-save t))
