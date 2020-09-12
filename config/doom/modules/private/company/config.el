;;; private/company/config.el -*- lexical-binding: t; -*-

(after! company
  (setq company-idle-delay 0.6
        company-global-modes '(not shell-mode)
        company-minimum-prefix-length 1
        company-tooltip-align-annotations t
        company-dabbrev-downcase nil
        company-tooltip-limit 10)
  (when (featurep! :completion company +childframe)
    (setq company-box-doc-delay 6
          company-box-enable-icon nil))
  ;; Make aborting less annoying.
  (add-hook 'evil-normal-state-entry-hook #'company-abort))

(use-package! company-posframe
  :disabled t
  :after company
  :config
  (setq company-posframe-quickhelp-delay 6
        company-posframe-show-metadata nil
        company-posframe-show-indicator nil
        company-posframe-show-params nil)
  (map! :after company-posframe-active-map
        :map company-posframe-active-map
        "RET" 'company-complete-selection)
  (company-posframe-mode 1))
