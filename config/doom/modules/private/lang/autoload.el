;;; private/lang/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun latex/run-latexmk ()
  "Save the file and and run latexmk"
  (interactive)
  (TeX-save-document (TeX-master-file))
  (TeX-command "LatexMk" #'TeX-master-file -1))

;;;###autoload
(defun latex/display-buffer-use-some-frame (fun &rest args)
  "Use `display-buffer-use-some-frame' as `display-buffer-overriding-action'.
Then run FUN with ARGS."
  (let ((display-buffer-overriding-action '(display-buffer-use-some-frame)))
    (apply fun args)))

;;;###autoload
(defun latex/latex-save-and-compile ()
  "Save the current buffer and compile it with 'xelatex'"
  (interactive)
  (save-buffer)
  (compile (format "xelatex %s" (file-name-nondirectory buffer-file-name))))
