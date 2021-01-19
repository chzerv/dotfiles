;;; completion/selectrum/autoload.el -*- lexical-binding: t; -*-

(defface selectrum-marks-highlight '((t :inherit highlight))
  "Face used to highlight the position of the mark in `selectrum-marks'."
  :group 'selectrum)

(defvar evil-markers-alist)

(defvar selectrum--marks-history ()
  "History for the command `selectrum-marks'.
This is probably not so useful, since marks can move with text.")

;;;###autoload
(defun +selectrum/evil-marks ()
  "Jump to a marker in `evil-marker-alist', signified by a highlighted \"|\".
Currently truncates line if longer than window body width."
  (interactive)
  (if-let ((placed-markers
            (sort (cl-remove-if (lambda (elem)
                                  (not (markerp (cdr-safe elem))))
                                evil-markers-alist)
                  #'car-less-than-car)))
      (let* ((selectrum-should-sort-p nil)
             (formatted-candidates
              (save-excursion
                (cl-loop with window-width = (window-body-width (minibuffer-window))
                         for (char-key . marker) in placed-markers
                         for pos          = (goto-char (marker-position marker))
                         for line-beg-pos = (line-beginning-position)
                         for str-pos      = (- pos line-beg-pos)
                         for line-string  = (buffer-substring
                                             line-beg-pos (line-end-position))
                         for highlighted-candidate = (concat (substring line-string 0 str-pos)
                                                             (propertize
                                                              "|"
                                                              'face 'selectrum-marks-highlight)
                                                             (substring line-string str-pos))
                         ;; Final formatting.
                         collect  char-key              into char-keys
                         collect  pos                   into marker-positions
                         collect  highlighted-candidate into highlighted-candidates
                         for      line-number           =    (line-number-at-pos pos t)
                         collect  line-number           into line-numbers
                         maximize line-number           into max-line-number
                         collect  str-pos               into column-numbers
                         maximize str-pos               into max-col-number
                         finally return
                         (cl-loop with form = (concat "%0"   (number-to-string (length (number-to-string max-line-number)))


                                                      "d,%0" (number-to-string (length (number-to-string max-col-number)))
                                                      "d: %s")
                                  for marker-pos in marker-positions
                                  for line-num   in line-numbers
                                  for col-num    in column-numbers
                                  for cand       in highlighted-candidates
                                  for str        =  (format form line-num col-num cand)
                                  for key        in char-keys
                                  collect (cons (propertize
                                                 (if (> (length str) window-width)
                                                     (concat (substring str 0 (- window-width 10)) "...")
                                                   str)
                                                 'selectrum-candidate-display-prefix (format "%c: " key))
                                                marker-pos)))))
             (chosen-cand (completing-read "Go to position: " formatted-candidates nil
                                           t nil selectrum--marks-history)))
        (goto-char (cdr (assoc chosen-cand formatted-candidates))))
    (user-error "selectrum-evil-marks: No Evil marks placed.")))
