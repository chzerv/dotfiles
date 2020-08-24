;; -*- no-byte-compile: t; -*-
;;; chz/company/packages.el

;; Doom has the +childframe option for the company module, which uses
;; company-box. company-box works fine, but when emacs is compiled with
;; GTK3, the completion box has trouble resizing depending on how many
;; candidates exist. company-posframe doesn't have this issue.
(package! company-posframe)
