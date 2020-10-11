;;; private/org/agenda.el -*- lexical-binding: t; -*-

(after! org
  (setq org-agenda-dim-blocked-tasks t
        org-agenda-use-time-grid t
        org-agenda-hide-tags-regexp "\\w+"
        org-agenda-compact-blocks nil
        org-agenda-block-separator ""
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-enforce-todo-checkbox-dependencies nil
        org-enforce-todo-dependencies t
        org-deadline-warning-days 14
        org-agenda-tag-filter-preset '("-ARCHIVE")
        org-habit-show-habits t
        org-agenda-start-on-weekday 1
        org-agenda-start-day "+0d"
        org-agenda-time-grid
        (quote
         ((require-timed remove-match)
          (0900 2100)
          "      " "┈┈┈┈┈┈┈┈┈┈┈┈┈"))
        ;; Modify the way that deadlines are displayed
        org-agenda-deadline-leaders
        '("Deadline:  " "----- In %3d d.: -----")
        ;; Modify the way that scheduled items are displayed
        ;; org-agenda-scheduled-leaders
        ;; '(">> Scheduled: <<" "** Sched.%2dx: **")
        ))

;; org-super-agenda
(after! org
  (setq org-agenda-custom-commands
        '(("o" "Task Overview"
           ((agenda ""
                    ((org-agenda-span 3)
                     (org-agenda-files '("~/Documents/Syncthing/Org/roam/"))))
            (alltodo ""
                     ((org-agenda-overriding-header "Lens")
                      (org-super-agenda-groups
                       '((:name none
                          :discard (:tag "schedule" :todo "SOMEDAY" :tag "bdays"))
                         (:name "Must do!"
                          :priority "A")
                         (:name "Just do it.."
                          :priority<= "B")))))
            (tags-todo "@uni"
                       ((org-agenda-overriding-header "University")
                        (org-super-agenda-groups
                         '((:name "Labs"
                            :tag "lab")
                           (:name "Course"
                            :tag "course")
                           (:name "Assignments"
                            :tag "assignment")
                           (:name "Study"
                            :tag "study")
                           (:discard (:anything t))))))
            (todo "SOMEDAY"
                  ((org-agenda-overriding-header "Maybe, one day..")
                   (org-super-agenda-groups
                    '((:name "Learn stuff"
                       :tag "@read")
                      (:name "What to do.."
                       :anything t)))))
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
