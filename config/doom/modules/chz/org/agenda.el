;;; chz/org/chz_org-agenda.el -*- lexical-binding: t; -*-

;; Agenda
(after! org
  (setq org-agenda-dim-blocked-tasks t
        org-agenda-use-time-grid t
        org-agenda-files '("~/Documents/Syncthing/Org/"
                            "~/Documents/Syncthing/Org/Notebooks/")
        ;; org-agenda-hide-tags-regexp ":\\w+:"
        ;; Ignore archived tasks in agenda.
        org-agenda-tag-filter-preset '("-ARCHIVE")
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-enforce-todo-checkbox-dependencies nil
        org-habit-show-habits t
        org-deadline-warning-days 14
        org-agenda-start-day (org-today)
        org-agenda-time-grid
        (quote
         ((daily today remove-match)
          (800 1200 1600 2000)
          "......" "----------------"))
        ;; Modify the way that deadlines are displayed
        org-agenda-deadline-leaders
        '("Deadline:  " "----- In %3d d.: -----")
        ;; Modify the way that scheduled items are displayed
        org-agenda-scheduled-leaders
        '(">> Scheduled: <<" "** Sched.%2dx: **")))

(after! org
  (setq org-agenda-custom-commands
        '(("o" "Task Overview"
           ((agenda ""
                    ((org-agenda-span 3)
                     (org-agenda-files '("~/Documents/Syncthing/Org/index.org"
                                         "~/Documents/Syncthing/Org/projects.org"
                                         "~/Documents/Syncthing/Org/refile.org"))))
            (tags-todo "@university"
                       ((org-agenda-overriding-header "University")
                        (org-super-agenda-groups
                         '((:name "Labs"
                            :tag "@lab")
                           (:name "Projects"
                            :tag "@project")))))
            (tags-todo "@personal"
                       ((org-agenda-overriding-header "Personal")))
            (tags-todo "@appointment"
                       ((org-agenda-overriding-header "Appointments")))
            ))
          ("p" "Projects"
           ((todo ""
                  ((org-agenda-overriding-header "Projects")
                   (org-agenda-files '("~/Documents/Syncthing/Org/projects.org"))
                   (org-super-agenda-groups
                    '((:auto-group t)))))
            ))
          ("w" "Will do.."
           ((todo ""
                  ((org-agenda-overriding-header "Maybe sometime in the future..")
                   (org-agenda-files '("~/Documents/Syncthing/Org/index.org"
                                       "~/Documents/Syncthing/Org/refile.org"))
                   (org-super-agenda-groups
                    '((:name "Someday"
                       :todo "SOMEDAY")
                      (:discard (:anything))))))
            ))
          ("r" "Tasks to refile"
           ((tags-todo "REFILE"
                       ((org-agenda-overriding-header "Needs refiling")
                        (org-agenda-files '("~/Documents/Syncthing/Org/refile.org"))
                        (org-super-agenda-groups
                         '((:auto-parent t )))))
            ))
          ))
  (org-super-agenda-mode t))

(provide 'agenda)
