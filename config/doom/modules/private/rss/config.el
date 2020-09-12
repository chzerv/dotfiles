;;; private/rss/config.el -*- lexical-binding: t; -*-
;;;###if (featurep! :app rss)

(after! elfeed
  (setq elfeed-search-filter "@2-week-ago +unread -bugs -music -reddit"
        elfeed-show-unique-buffers t)
  (map! (:map elfeed-show-mode-map
         "q" 'nil
         (:localleader
          :desc "Open readable part in eww"
          "e" 'rss/elfeed-show-eww
          :desc "Play enclosure with mpv"
          "m" 'rss/elfeed-play-with-mpv
          :desc "Open with external"
          "x" 'rss/elfeed-visit-maybe-external
          :desc "Kill buffer and close window"
          "q" 'rss/elfeed-kill-buffer-close-window-dwim))
        (:map elfeed-search-mode-map
         "M-RET" 'nil
         :desc "Open entry in $BROWSER"
         "M-RET" 'rss/elfeed-search-browse-url
         (:localleader
          :desc "Open with eww"
          "e" 'rss/elfeed-open-with-eww
          :desc "Fetch feeds"
          "r" 'elfeed-search-fetch
          :desc "Toggle star on entry"
          "s" (cmd! (apply 'elfeed-search-toggle-all '(star)))
          :desc "Download enclosure with youtube-dl"
          "d" 'rss/elfeed-dl))
        (:leader
         (:prefix ("o" . "+open")
          (:when (featurep! :app rss)
           :desc "elfeed"
           "e" '=rss)))))

(after! elfeed-org
  (setq rmh-elfeed-org-files (list "~/Documents/Syncthing/elfeed.org")))
