;;; chz/evil/config.el -*- lexical-binding: t; -*-

(after! evil
  (setq
   ;; Don't move the cursor one position back
   ;; when exiting insert mode.
   evil-move-cursor-back nil
   ;; After splitting a window, switch to it immediatelly.
   evil-split-window-below t
   evil-vsplit-window-right t)

  ;;; Key bindings

  ;; Easier window navigation
  (map! "M-h" 'nil
        "M-j" 'nil
        "M-k" 'nil
        "M-l" 'nil
        "M-q" 'nil
        :enm "M-h" #'evil-window-left
        :enm "M-j" #'evil-window-down
        :enm "M-k" #'evil-window-up
        :enm "M-l" #'evil-window-right
        :enm "M-q" #'evil-quit)

  ;; Use vim-surround operator keys for change & delete.
  (map! (:map evil-operator-state-map
         "r" 'evil-surround-change
         "d" 'evil-surround-delete))

  ;; Use j/k instead of gj/gk to move between visual lines.
  (map! (:map evil-normal-state-map
         "j" 'evil-next-visual-line
         "k" 'evil-previous-visual-line)))
