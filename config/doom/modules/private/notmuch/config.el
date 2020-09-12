;;; private/mail_notmuch/config.el -*- lexical-binding: t; -*-
;;;###if (featurep! :email notmuch)

(after! notmuch
  (setq +notmuch-mail-folder "~/.mail/gmail"
        +notmuch-sync-backend 'mbsync
        +notmuch-sync-command "mbsync -Va"
        notmuch-message-headers-visible t
        notmuch-hello-sections '(notmuch-hello-insert-header
                                 notmuch-hello-insert-saved-searches
                                 notmuch-hello-insert-search
                                 notmuch-hello-insert-recent-searches
                                 notmuch-hello-insert-alltags
                                 notmuch-hello-insert-footer)
        notmuch-saved-searches
        '((:name "Inbox"   :query "tag:inbox not tag:trash" :key "i")
          (:name "Flagged" :query "tag:flagged"             :key "f")
          (:name "Sent"    :query "tag:sent"                :key "s")
          (:name "Drafts"  :query "tag:draft"               :key "d")
          (:name "Lists"   :query "tag:lists"               :key "l")
          (:name "Arch"    :query "tag:arch"                :key "a")
          (:name "GNOME"   :query "tag:GNOME"               :key "g")
          (:name "Unread"  :query "tag:unread"              :key "u")
          (:name "Uni"     :query "tag:courses"             :key "w")))
  (map! :map notmuch-show-mode-map
        "M-RET" 'browse-url-xdg-open))

(after! notmuch-hello
  (notmuch-unread-mode 1))

(after! notmuch-unread
  (setq notmuch-unread-icon-color-unread "#ff4500"))

(load! "$HOME/.emacs.d/.local/straight/repos/org-mode/contrib/lisp/ol-notmuch.el")
