;;; init-org.el --- Org mode configuration -*- lexical-binding: t; -*-

;; Author: Xavier
;; Version: 1.0
;; Package-Requires: ((emacs "27.1"))

;;; Commentary:
;; This module handles all Org mode configuration including:
;; - Basic Org mode setup
;; - Org agenda configuration
;; - Org capture templates
;; - Org export settings
;; - Org babel configuration
;; - Org roam setup

;;; Code:

;; Basic Org mode configuration
(use-package org
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c b" . org-switchb))
  :config
  ;; Basic settings
  (setq org-directory "~/org/"
        org-default-notes-file (concat org-directory "notes.org")
        org-agenda-files (list org-directory)
        org-refile-targets '((org-agenda-files :maxlevel . 3))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-refile-allow-creating-parent-nodes 'confirm)

  ;; Better defaults
  (setq org-startup-indented t
        org-startup-folded 'content
        org-startup-with-inline-images t
        org-image-actual-width '(300)
        org-hide-emphasis-markers t
        org-fontify-whole-heading-line t
        org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-src-preserve-indentation t
        org-edit-src-content-indentation 0
        org-confirm-babel-evaluate nil
        org-use-speed-commands t
        org-return-follows-link t
        org-mouse-1-follows-link t
        org-link-descriptive t
        org-pretty-entities t
        org-pretty-entities-include-sub-superscripts t)

  ;; TODO keywords
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "HOLD(h)" "|" "DONE(d)" "CANCELLED(c)")
          (sequence "IDEA(i)" "MAYBE(m)" "SOMEDAY(s)" "|" "ARCHIVE(a)")))

  ;; TODO keyword faces
  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "#ff6c6b" :weight bold))
          ("NEXT" . (:foreground "#ECBE7B" :weight bold))
          ("WAITING" . (:foreground "#a9a1e1" :weight bold))
          ("HOLD" . (:foreground "#da8548" :weight bold))
          ("DONE" . (:foreground "#98be65" :weight bold))
          ("CANCELLED" . (:foreground "#5B6268" :weight bold))
          ("IDEA" . (:foreground "#51afef" :weight bold))
          ("MAYBE" . (:foreground "#c678dd" :weight bold))
          ("SOMEDAY" . (:foreground "#46D9FF" :weight bold))
          ("ARCHIVE" . (:foreground "#5B6268" :weight bold))))

  ;; Priority settings
  (setq org-priority-faces
        '((?A . (:foreground "#ff6c6b" :weight bold))
          (?B . (:foreground "#ECBE7B" :weight bold))
          (?C . (:foreground "#51afef" :weight bold))))

  ;; Tags
  (setq org-tag-alist
        '(("@work" . ?w)
          ("@home" . ?h)
          ("@errands" . ?e)
          ("@computer" . ?c)
          ("@phone" . ?p)
          ("@read" . ?r)
          ("@review" . ?v)
          ("project" . ?j)
          ("urgent" . ?u)
          ("someday" . ?s)
          ("waiting" . ?W)))

  ;; Agenda settings
  (setq org-agenda-window-setup 'current-window
        org-agenda-span 'week
        org-agenda-start-with-log-mode t
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-include-deadlines t
        org-agenda-block-separator nil
        org-agenda-compact-blocks t
        org-agenda-start-day nil
        org-agenda-start-on-weekday nil)

  ;; Custom agenda commands
  (setq org-agenda-custom-commands
        '(("d" "Dashboard"
           ((agenda "" ((org-deadline-warning-days 7)))
            (todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))
            (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))
          ("n" "Next Tasks"
           ((todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))))
          ("w" "Work Tasks" tags-todo "@work")
          ("h" "Home Tasks" tags-todo "@home")
          ("p" "Projects" tags "project")
          ("r" "Reading List" tags "@read")
          ("W" "Weekly Review"
           ((agenda "" ((org-agenda-span 'week)
                        (org-deadline-warning-days 0)
                        (org-agenda-overriding-header "Weekly Review")))
            (todo "DONE"
                  ((org-agenda-overriding-header "Completed Tasks")))
            (todo "CANCELLED"
                  ((org-agenda-overriding-header "Cancelled Tasks")))))))

  ;; Capture templates
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline org-default-notes-file "Tasks")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)
          ("n" "Note" entry (file+headline org-default-notes-file "Notes")
           "* %?\n  %U\n  %a\n  %i" :empty-lines 1)
          ("j" "Journal" entry (file+datetree (concat org-directory "journal.org"))
           "* %?\n  %U\n  %i" :empty-lines 1)
          ("m" "Meeting" entry (file+headline org-default-notes-file "Meetings")
           "* Meeting with %?\n  %U\n  %a\n  %i" :empty-lines 1)
          ("p" "Project" entry (file+headline org-default-notes-file "Projects")
           "* %? :project:\n  %U\n  %a\n  %i" :empty-lines 1)
          ("i" "Idea" entry (file+headline org-default-notes-file "Ideas")
           "* IDEA %?\n  %U\n  %a\n  %i" :empty-lines 1)
          ("r" "Reading" entry (file+headline org-default-notes-file "Reading")
           "* TODO Read %?\n  %U\n  %a\n  %i" :empty-lines 1 :tags "@read")
          ("w" "Work Task" entry (file+headline org-default-notes-file "Work")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1 :tags "@work")
          ("h" "Home Task" entry (file+headline org-default-notes-file "Home")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1 :tags "@home")))

  ;; Export settings
  (setq org-export-with-smart-quotes t
        org-export-with-section-numbers nil
        org-export-with-toc nil
        org-export-with-author nil
        org-export-with-email nil
        org-export-with-date nil
        org-export-with-creator nil
        org-export-with-sub-superscripts nil
        org-export-with-special-strings t
        org-export-with-todo-keywords nil
        org-export-with-tags nil
        org-export-with-planning nil
        org-export-with-priority nil
        org-export-with-drawers nil
        org-export-with-properties nil
        org-export-with-timestamps t
        org-export-preserve-breaks t
        org-export-allow-bind-keywords t)

  ;; Babel configuration
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (shell . t)
     (javascript . t)
     (css . t)
     (sql . t)
     (dot . t)
     (plantuml . t)))

  ;; Clock settings
  (setq org-clock-persist t
        org-clock-in-resume t
        org-clock-into-drawer t
        org-clock-out-remove-zero-time-clocks t
        org-clock-out-when-done t
        org-clock-report-include-clocking-task t
        org-clock-resolve-expert t)

  ;; Archive settings
  (setq org-archive-location "archive/%s_archive::datetree/")

  ;; Logging
  (setq org-log-done 'time
        org-log-into-drawer t
        org-log-redeadline 'time
        org-log-reschedule 'time))

;; Org bullets for better visual hierarchy
(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Table of contents generation
(use-package toc-org
  :hook (org-mode . toc-org-enable)
  :config
  (setq toc-org-hrefify-default "gh"))

;; Org superstar (modern bullets)
(use-package org-superstar
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-remove-leading-stars t
        org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")
        org-superstar-item-bullet-alist '((?+ . ?➤) (?- . ?➤) (?* . ?➤))
        org-superstar-todo-bullet-alist '(("TODO" . ?☐)
                                          ("NEXT" . ?⚡)
                                          ("WAITING" . ?⏳)
                                          ("HOLD" . ?⏸)
                                          ("DONE" . ?☑)
                                          ("CANCELLED" . ?☒))))

;; Org modern for better styling
(use-package org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-keyword nil
        org-modern-checkbox nil
        org-modern-table nil))

;; Org appear - show emphasis markers when cursor is on them
(use-package org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autolinks t
        org-appear-autosubmarkers t
        org-appear-autoentities t
        org-appear-autokeywords t))

;; Visual fill column for better reading
(use-package visual-fill-column
  :hook (org-mode . visual-fill-column-mode)
  :config
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t))

;; Org roam for note-taking
(use-package org-roam
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/org/roam/")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("r" "reference" plain
      "%?"
      :target (file+head "reference/${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("a" "article" plain
      "%?"
      :target (file+head "articles/${slug}.org" "#+title: ${title}\n#+filetags: :article:\n")
      :unnarrowed t)))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-setup)
  (org-roam-db-autosync-mode))

;; Org roam UI for graph visualization
(use-package org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

;; Org journal
(use-package org-journal
  :custom
  (org-journal-dir "~/org/journal/")
  (org-journal-date-format "%A, %d %B %Y")
  (org-journal-file-format "%Y-%m-%d.org")
  (org-journal-file-type 'daily)
  :bind (("C-c j j" . org-journal-new-entry)
         ("C-c j s" . org-journal-search)
         ("C-c j n" . org-journal-next-entry)
         ("C-c j p" . org-journal-previous-entry)))

;; Org download for handling images
(use-package org-download
  :hook (dired-mode . org-download-enable)
  :config
  (setq org-download-method 'directory
        org-download-image-dir "~/org/images/"
        org-download-heading-lvl nil
        org-download-timestamp "%Y%m%d_%H%M%S_"))

;; Org cliplink for easy link insertion
(use-package org-cliplink
  :bind ("C-c l" . org-cliplink))

;; Org web tools
(use-package org-web-tools
  :bind (("C-c w w" . org-web-tools-insert-link-for-url)
         ("C-c w r" . org-web-tools-read-url-as-org)
         ("C-c w c" . org-web-tools-convert-links-to-page-entries)))

;; Org pomodoro
(use-package org-pomodoro
  :bind ("C-c p" . org-pomodoro)
  :config
  (setq org-pomodoro-length 25
        org-pomodoro-short-break-length 5
        org-pomodoro-long-break-length 15
        org-pomodoro-ask-upon-killing t
        org-pomodoro-format "🍅 %s"
        org-pomodoro-short-break-format "☕ %s"
        org-pomodoro-long-break-format "🌴 %s"))

;; Org tree slide for presentations
(use-package org-tree-slide
  :bind (("C-c s s" . org-tree-slide-mode)
         ("C-c s n" . org-tree-slide-move-next-tree)
         ("C-c s p" . org-tree-slide-move-previous-tree))
  :config
  (setq org-tree-slide-slide-in-effect t
        org-tree-slide-activate-message "Presentation started!"
        org-tree-slide-deactivate-message "Presentation ended!"
        org-tree-slide-header t
        org-tree-slide-breadcrumbs " > "
        org-tree-slide-content-margin-top 4))

;; Org habit tracking
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60
      org-habit-preceding-days 21
      org-habit-following-days 7
      org-habit-show-habits-only-for-today t)

;; Org protocol for browser integration
(require 'org-protocol)

;; Additional org settings
(with-eval-after-load 'org
  ;; Enable org-indent-mode by default
  (add-hook 'org-mode-hook 'org-indent-mode)

  ;; Enable visual-line-mode in org
  (add-hook 'org-mode-hook 'visual-line-mode)

  ;; Enable auto-fill-mode in org
  (add-hook 'org-mode-hook 'auto-fill-mode)

  ;; Set fill-column for org-mode
  (add-hook 'org-mode-hook (lambda () (setq fill-column 80)))

  ;; Enable flyspell in org-mode
  (add-hook 'org-mode-hook 'flyspell-mode)

  ;; Custom functions for org-mode
  (defun my/org-mode-setup ()
    "Custom setup for org-mode."
    (variable-pitch-mode 1)
    (visual-line-mode 1)
    (setq evil-auto-indent nil))

  (add-hook 'org-mode-hook 'my/org-mode-setup)

  ;; Hide drawers by default
  (defun my/org-hide-drawers ()
    "Hide all drawers in the current buffer."
    (interactive)
    (org-cycle-hide-drawers 'all))

  (add-hook 'org-mode-hook 'my/org-hide-drawers)

  ;; Custom org link types
  (org-link-set-parameters
   "id"
   :follow #'org-id-open
   :store #'org-id-store-link)

  ;; Org clock persistence
  (org-clock-persistence-insinuate)

  ;; Save org buffers automatically
  (add-hook 'org-mode-hook
            (lambda ()
              (add-hook 'after-save-hook 'org-babel-tangle nil t))))

;; Org export backends
(with-eval-after-load 'ox
  (require 'ox-md)
  (require 'ox-beamer)
  (require 'ox-latex)
  (require 'ox-html)
  (require 'ox-ascii)
  (require 'ox-odt)
  (require 'ox-publish))

;; LaTeX configuration for org export
(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("article"
                 "\\documentclass[11pt]{article}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  (setq org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

  (setq org-latex-with-hyperref nil
        org-latex-hyperref-template nil))

(provide 'init-org)
;;; init-org.el ends here
