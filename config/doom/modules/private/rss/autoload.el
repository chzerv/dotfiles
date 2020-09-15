;;; private/rss/autoload.el -*- lexical-binding: t; -*-
;;;###if (featurep! :app rss)

;;;###autoload
(defun rss/elfeed-open ()
  (interactive)
  (elfeed)
  (elfeed-update)
  (hide-mode-line-mode +1))

;; Ideas taken from https://github.com/wandersoncferreira/dotfiles#rss-feed,
;; with small modifications.

;;;###autoload
(defun rss/elfeed-play-with-mpv ()
  "Play entry link with mpv."
  (interactive)
  (let ((entry (if (eq major-mode 'elfeed-show-mode) elfeed-show-entry (elfeed-search-selected :single)))
        (quality-arg "")
        (quality-val (completing-read "Max height resolution (0 for unlimited): " '("0" "480" "720") nil nil)))
    (setq quality-val (string-to-number quality-val))
    (message "Opening %s with height≤%s with mpv..." (elfeed-entry-link entry) quality-val)
    (when (< 0 quality-val)
      (setq quality-arg (format "--ytdl-format=[height<=?%s]" quality-val)))
    (start-process "elfeed-mpv" nil "mpv" quality-arg (elfeed-entry-link entry))))

;;;###autoload
(defun rss/elfeed-open-with-eww (&optional use-generic-p)
  "open with eww"
  (interactive "P")
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (elfeed-entry-link entry)
             do (eww-browse-url it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

(defvar elfeed-visit-patterns
  '(("youtu\\.?be" . rss/elfeed-play-with-mpv)
    ("phoronix" . rss/elfeed-open-with-eww))
  "List of (regexps . function) to match against elfeed entry link to know
whether how to visit the link.")

;;;###autoload
(defun rss/elfeed-visit-maybe-external ()
  "Visit with external function if entry link matches `elfeed-visit-patterns',
visit otherwise."
  (interactive)
  (let ((entry (if (eq major-mode 'elfeed-show-mode)
                   elfeed-show-entry
                 (elfeed-search-selected :single)))
        (patterns elfeed-visit-patterns))
    (while (and patterns (not (string-match (caar patterns) (elfeed-entry-link entry))))
      (setq patterns (cdr patterns)))
    (cond
     (patterns
      (funcall (cdar patterns)))
     ((eq major-mode 'elfeed-search-mode)
      (call-interactively 'elfeed-search-show-entry))
     (t (elfeed-show-visit)))))

;;;###autoload
(defun rss/elfeed-dl (&optional use-generic-p)
  "Download enclosure with youtube-dl."
  (interactive "P")
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (elfeed-entry-link entry)
             do (util/yt-dl-it it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

;; From https://gitlab.com/protesilaos/dotfiles/-/blob/master/emacs/.emacs.d/emacs-init.org#h:c519300f-8a9a-472b-b26d-c2f49adbdb5d
;;;###autoload
(defun rss/elfeed-show-eww (&optional link)
  "Browse current `elfeed' entry link in `eww'.
Only show the readable part once the website loads.  This can
fail on poorly-designed websites."
  (interactive)
  (let* ((entry (if (eq major-mode 'elfeed-show-mode)
                    elfeed-show-entry
                  (elfeed-search-selected :ignore-region)))
          (link (if link link (elfeed-entry-link entry))))
    (eww link)
    (delete-other-windows)
    (add-hook 'eww-after-render-hook 'eww-readable nil t)))

;;;###autoload
(defun rss/elfeed-kill-buffer-close-window-dwim ()
    "Do-what-I-mean way to handle `elfeed' windows and buffers.

When in an entry buffer, kill the buffer and return to the Elfeed
Search view.  If the entry is in its own window, delete it as
well.

When in the search view, close all other windows.  Else just kill
the buffer."
    (interactive)
    (let ((win (selected-window)))
      (cond ((eq major-mode 'elfeed-show-mode)
             (elfeed-kill-buffer)
             (unless (one-window-p) (delete-window win))
             (switch-to-buffer "*elfeed-search*"))
            ((eq major-mode 'elfeed-search-mode)
             (if (one-window-p)
                 (elfeed-search-quit-window)
               (delete-other-windows win))))))

;;;###autoload
(defun rss/elfeed-search-browse-url (&optional use-generic-p)
  "Visit the current entry in your browser using `browse-url',
without marking the entry as 'read'.
If there is a prefix argument, visit the current entry in the
browser defined by `browse-url-generic-program'."
  (interactive "P")
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-entry-link entry)
             do (if use-generic-p
                    (browse-url-generic (elfeed-entry-link entry))
                  (browse-url (elfeed-entry-link entry))))
    (mapc #'elfeed-search-update-entry entries)
    (unless (or elfeed-search-remain-on-entry (use-region-p))
      (forward-line))))

;; Stolen from
;; https://gitlab.com/protesilaos/dotfiles/-/blob/master/emacs/.emacs.d/emacs-init.org

;;;###autoload
(defun rss/elfeed-make-archive ()
    "Create an archive copy of the current `elfeed' entry."
    (interactive)
    (let* ((entry (if (eq major-mode 'elfeed-show-mode)
                      elfeed-show-entry
                    (elfeed-search-selected :ignore-region)))
           ;; TODO how to cleanly add hyphens instead of spaces?
           (title (elfeed-entry-title entry))
           (elfeed-show-truncate-long-urls nil)
           (archives "~/Documents/feeds/")
           (file (format "%s%s.txt" archives title)))
      (unless (file-exists-p archives)
        (make-directory archives t))
      (when (derived-mode-p 'elfeed-show-mode)
        ;; Refresh to expand truncated URLs
        (elfeed-show-refresh)
        (write-file file t)
        (message "Saved buffer at %s" file))))

;;;###autoload
(defun rss/elfeed-show-starred-entries ()
  "Show all time starred entries in elfeed."
  (interactive)
  ;; TODO make this work when called from a mode other than
  ;; elfeed-search-mode.
  (elfeed-search-clear-filter)
  (setq elfeed-search-filter "star")
  (elfeed-search-update :force))
