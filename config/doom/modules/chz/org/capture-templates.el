;;; chz/org/chz_org-capture-templates.el -*- lexical-binding: t; -*-

(defvar org-uni-file "~/Documents/Syncthing/Org/uni.org")
(defvar org-refile-file "~/Documents/Syncthing/Org/refile.org")

(after! org
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline org-refile-file "Todo")
           "* TODO %? \n%U\n%a\n"
           :prepend t)
          ;; Next task
          ("n" "Next task" entry
           (file+headline org-refile-file "Tasks")
           "* NEXT %? \nDEADLINE: %t"
           :prepend t)

          ("N" "Note" entry
           (file+headline org-refile-file "Notes")
           "* %? :@note:\n%U\n%a\n"
           :prepend t)

          ;; Blank
          ("b" "Blank" entry
           (file org-refile-file)
           "* %? \n%U\n%a\n"
           :prepend t)

          ;; Journal
          ("j" "Journal" entry
           (file+olp+datetree +org-capture-journal-file)
           "* %U %?\n%i\n%a"
           :prepend t)

          ;; Interesting: stuff that might seem interesting.
          ("r" "Reading")
          ("rw" "From the web" entry
           (file+headline org-refile-file "Reading")
           "* [[%^C][%^{description}]]  :@read:\n%U\n%i\n%?"
           :prepend t)
          ("re" "From within emacs" entry
           (file+headline org-refile-file "Reading")
           "* %? :@read:\n%U\n%a"
           :prepend t)


          ;; Capture an idea, and clock it.
          ("i" "Idea" entry (file org-refile-file)
           "* %? :#IDEA:\n")

          ;; University related templates.
          ("u" "University")
          ;; Capture a test. Asks for schedule.
          ("ut" "Test" entry
           (file+headline org-uni-file "University")
           "* TODO [#A] %^{Test name} :@university:@tests:\nSCHEDULED:%^{Test date}T\n%i\n%?"
           :prepend t)
          ;; Capture an assignment. Asks for a deadline.
          ("ua" "Assignment" entry
           (file+headline org-uni-file "University")
           "* TODO [#B] %^{Assignment name} :@university:@assignment:\nDEADLINE:%^{Due date}T\n
              %i\n%?"
           :prepend t)
          ;; Capture a course.
          ("uc" "Course" entry
           (file+headline org-uni-file "University")
           "* TODO [#B] %^{Course}  :@university:@course:\nSCHEDULED:%^{Course date}T\n%i\n%?"
           :prepend t)

          ;; Will use {project-root}/{todo,notes,changelog}.org, unless a
          ;; {todo,notes,changelog}.org file is found in a parent directory.
          ;; Uses the basename from `+org-capture-todo-file',
          ("p" "Templates for projects")
          ("pt" "Project-local todo" entry  ; {project-root}/todo.org
           (file+headline +org-capture-project-todo-file "Inbox")
           "* TODO %?\n%i\n%a" :prepend t)
          ("pn" "Project-local notes" entry  ; {project-root}/notes.org
           (file+headline +org-capture-project-notes-file "Inbox")
           "* %U %?\n%i\n%a" :prepend t)
          ("pc" "Project-local changelog" entry  ; {project-root}/changelog.org
           (file+headline +org-capture-project-changelog-file "Unreleased")
           "* %U %?\n%i\n%a" :prepend t)

          ;; Will use {org-directory}/{+org-capture-projects-file} and store
          ;; these under {ProjectName}/{Tasks,Notes,Changelog} headings. They
          ;; support `:parents' to specify what headings to put them under, e.g.
          ;; :parents ("Projects")
          ("o" "Centralized templates for projects")
          ("ot" "Project todo" entry
           (function +org-capture-central-project-todo-file)
           "* TODO %?\n %i\n %a"
           :heading "Tasks"
           :prepend nil)
          ("on" "Project notes" entry
           (function +org-capture-central-project-notes-file)
           "* %U %?\n %i\n %a"
           :heading "Notes"
           :prepend t)
          ("oc" "Project changelog" entry
           (function +org-capture-central-project-changelog-file)
           "* %U %?\n %i\n %a"
           :heading "Changelog"
           :prepend t))))

(provide 'capture-templates)
