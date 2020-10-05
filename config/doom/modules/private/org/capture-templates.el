;;; private/org/capture-templates.el -*- lexical-binding: t; -*-

(defvar org-refile-file "~/Documents/Syncthing/Org/refile.org")
(defvar org-tasks-file "~/Documents/Syncthing/Org/roam/Index.org")

(after! org
  (setq org-capture-templates
        '(("!" "Quick capture" plain
           (file+headline org-tasks-file "Tasks")
           "** TODO %? \n:PROPERTIES:\n:CREATED: %U\n:END:\n%a"
           :prepend t)
          ("n" "Task with a deadline" entry
           (file+headline org-refile-file "Tasks")
           "* %^{Scope of task||TODO|assignment} %^{Title} %^g\nSCHEDULED: %^t\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n%i%?"
           :prepend t)

          ("r" "Reply to an email" entry
           (file+headline org-refile-file "Mail correspondence")
           "* TODO [#B] %:subject :mail:\nSCHEDULED: %t\n:PROPERTIES:\n:CONTEXT: %a\n:END:\n\n%i%?"
           :prepend t)

          ;; University related templates.
          ("u" "University")
          ;; Capture a test. Asks for schedule.
          ("ut" "Test" entry
           (file+headline org-uni-file "University")
           "* TODO [#A] %^{Test name} :@uni:@tests:\nSCHEDULED:%^{Test date}T\n%i\n%?"
           :prepend t)
          ;; Capture an assignment. Asks for a deadline.
          ("ua" "Assignment" entry
           (file+headline org-uni-file "University")
           "* TODO [#B] %^{Assignment name} :@uni:assignment:\nDEADLINE:%^{Due date}T\n
              %i\n%?"
           :prepend t)
          ;; Capture a course.
          ("uc" "Course" entry
           (file+headline org-uni-file "University")
           "* TODO [#B] %^{Course}  :@uni:course:\nSCHEDULED:%^{Course date}T\n%i\n%?"
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
