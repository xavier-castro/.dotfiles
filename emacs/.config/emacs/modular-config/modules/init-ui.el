;;; init-ui.el --- UI and appearance configuration -*- lexical-binding: t; -*-

;; Author: Xavier
;; Version: 1.0
;; Package-Requires: ((emacs "27.1"))

;;; Commentary:
;; This module handles all UI-related configuration including:
;; - Disabling unnecessary UI elements
;; - Line numbers and visual improvements
;; - Theme configuration
;; - Window and frame settings

;;; Code:

;; Disable unnecessary UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Show line numbers globally
(global-display-line-numbers-mode 1)

;; Disable line numbers for specific modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Visual line mode for better text wrapping
(global-visual-line-mode t)

;; Highlight current line
(global-hl-line-mode 1)

;; Show matching parentheses
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Better scrolling
(setq scroll-margin 3
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; Smooth scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse 't)

;; Window splitting preferences
(setq split-height-threshold nil
      split-width-threshold 80)

;; Make frame title more useful
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; Blinking cursor
(blink-cursor-mode 1)

;; Column indicator
(setq display-fill-column-indicator-column 80)
(global-display-fill-column-indicator-mode 1)

;; Theme configuration
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)

  ;; Load the theme
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; All the icons (required for doom-themes)
(use-package all-the-icons
  :if (display-graphic-p)
  :commands all-the-icons-install-fonts
  :init
  (unless (find-font (font-spec :name "all-the-icons"))
    (all-the-icons-install-fonts t)))

;; Doom modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 25
        doom-modeline-bar-width 4
        doom-modeline-hud nil
        doom-modeline-window-width-limit 85
        doom-modeline-project-detection 'auto
        doom-modeline-buffer-file-name-style 'truncate-upto-project
        doom-modeline-icon t
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-buffer-state-icon t
        doom-modeline-buffer-modification-icon t
        doom-modeline-unicode-fallback nil
        doom-modeline-minor-modes nil
        doom-modeline-enable-word-count nil
        doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode)
        doom-modeline-buffer-encoding t
        doom-modeline-indent-info nil
        doom-modeline-checker-simple-format t
        doom-modeline-number-limit 99
        doom-modeline-vcs-max-length 12
        doom-modeline-persp-name t
        doom-modeline-display-default-persp-name nil
        doom-modeline-lsp t
        doom-modeline-github nil
        doom-modeline-github-interval (* 30 60)
        doom-modeline-modal-icon t
        doom-modeline-mu4e nil
        doom-modeline-gnus nil
        doom-modeline-irc nil
        doom-modeline-time-icon t
        doom-modeline-time-live-icon t
        doom-modeline-env-version t
        doom-modeline-env-enable-python t
        doom-modeline-env-enable-ruby t
        doom-modeline-env-enable-perl t
        doom-modeline-env-enable-go t
        doom-modeline-env-enable-elixir t
        doom-modeline-env-enable-rust t))

;; Dashboard for a nice startup screen
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo
        dashboard-center-content t
        dashboard-show-shortcuts nil
        dashboard-items '((recents  . 5)
                         (bookmarks . 5)
                         (projects . 5)
                         (agenda . 5)
                         (registers . 5))
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-set-navigator t
        dashboard-navigator-buttons
        `(((,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust 0.0)
           "Homepage"
           "Browse homepage"
           (lambda (&rest _) (browse-url "https://github.com")))
          (,(all-the-icons-material "folder" :height 1.0 :v-adjust -0.2)
           "Projects"
           "Open projects directory"
           (lambda (&rest _) (dired "~/projects")))
          (,(all-the-icons-octicon "gear" :height 1.1 :v-adjust 0.0)
           "Config"
           "Open config file"
           (lambda (&rest _) (find-file user-init-file)))))))

;; Rainbow delimiters for better parentheses visibility
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Highlight TODO keywords
(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))

;; Whitespace visualization
(use-package whitespace
  :diminish whitespace-mode
  :config
  (setq whitespace-style '(face tabs empty trailing lines-tail))
  (setq whitespace-line-column 80)
  (global-whitespace-mode 1))

;; Beacon - highlight cursor when scrolling
(use-package beacon
  :config
  (beacon-mode 1)
  (setq beacon-blink-when-point-moves-vertically 10
        beacon-blink-when-point-moves-horizontally 10
        beacon-blink-when-buffer-changes t
        beacon-blink-when-window-scrolls t
        beacon-blink-when-window-changes t
        beacon-blink-duration 0.3
        beacon-blink-delay 0.3
        beacon-size 20))

(provide 'init-ui)
;;; init-ui.el ends here
