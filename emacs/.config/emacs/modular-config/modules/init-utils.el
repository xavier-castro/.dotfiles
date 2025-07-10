;;; init-utils.el --- Utility packages configuration -*- lexical-binding: t; -*-

;; Author: Xavier
;; Version: 1.0
;; Package-Requires: ((emacs "27.1"))

;;; Commentary:
;; This module handles utility packages including:
;; - Completion frameworks (Ivy, Counsel, Swiper)
;; - File management utilities
;; - Text editing enhancements
;; - Navigation improvements
;; - Productivity tools

;;; Code:

;; Ivy - completion framework
(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d) "
        ivy-use-selectable-prompt t
        ivy-initial-inputs-alist nil
        ivy-re-builders-alist '((t . ivy--regex-plus))
        ivy-wrap t
        ivy-height 15
        ivy-fixed-height-minibuffer t))

;; Counsel - Ivy-enhanced commands
(use-package counsel
  :after ivy
  :config
  (counsel-mode 1)
  (setq counsel-find-file-ignore-regexp
        "\\(?:^[#.]\\)\\|\\(?:[#~]$\\)\\|\\(?:^Icon?\\)"))

;; Swiper - Ivy-enhanced search
(use-package swiper
  :after ivy
  :config
  (setq swiper-goto-start-of-match t))

;; Avy - jump to characters
(use-package avy
  :bind (("C-;" . avy-goto-char-timer)
         ("C-'" . avy-goto-line))
  :config
  (setq avy-timeout-seconds 0.3
        avy-all-windows t
        avy-background t))

;; Expand region - intelligent text selection
(use-package expand-region
  :bind ("C-=" . er/expand-region))

;; Multiple cursors - edit multiple locations
(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

;; Smartparens - intelligent parentheses
(use-package smartparens
  :config
  (smartparens-global-mode 1)
  (require 'smartparens-config))

;; Projectile - project management
(use-package projectile
  :config
  (projectile-mode 1)
  (setq projectile-project-search-path '("~/projects/" "~/work/")
        projectile-completion-system 'ivy
        projectile-indexing-method 'alien
        projectile-enable-caching t)
  :bind-keymap
  ("C-c p" . projectile-command-map))

;; Magit - git interface
(use-package magit
  :bind (("C-M-g" . magit-status)
         ("C-x g" . magit-status))
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; Company - completion framework
(use-package company
  :config
  (global-company-mode 1)
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 2
        company-show-numbers t
        company-tooltip-align-annotations t
        company-tooltip-limit 12))

;; Yasnippet - snippet expansion
(use-package yasnippet
  :config
  (yas-global-mode 1))

;; Yasnippet snippets - collection of snippets
(use-package yasnippet-snippets
  :after yasnippet)

;; Helpful - better help buffers
(use-package helpful
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)))

;; Restart emacs
(use-package restart-emacs
  :bind ("C-x M-c" . restart-emacs))

;; Winner mode - window configuration history
(use-package winner
  :ensure nil
  :config
  (winner-mode 1))

;; Recentf - recent files
(use-package recentf
  :ensure nil
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-items 25
        recentf-max-saved-items 100))

;; Saveplace - remember cursor position
(use-package saveplace
  :ensure nil
  :config
  (save-place-mode 1))

;; Savehist - save minibuffer history
(use-package savehist
  :ensure nil
  :config
  (savehist-mode 1))

;; Auto-revert - reload files when changed on disk
(use-package autorevert
  :ensure nil
  :config
  (global-auto-revert-mode 1)
  (setq auto-revert-verbose nil
        global-auto-revert-non-file-buffers t))

;; Ibuffer - better buffer list
(use-package ibuffer
  :ensure nil
  :bind ("C-x C-b" . ibuffer)
  :config
  (setq ibuffer-saved-filter-groups
        '(("default"
           ("dired" (mode . dired-mode))
           ("org" (mode . org-mode))
           ("programming" (or
                          (mode . python-mode)
                          (mode . c-mode)
                          (mode . c++-mode)
                          (mode . java-mode)
                          (mode . js-mode)
                          (mode . emacs-lisp-mode)
                          (mode . lisp-mode)))
           ("text" (or
                   (mode . text-mode)
                   (mode . markdown-mode)))
           ("magit" (name . "\\*magit"))
           ("help" (or
                   (mode . help-mode)
                   (mode . helpful-mode)))
           ("emacs" (or
                    (name . "^\\*scratch\\*$")
                    (name . "^\\*Messages\\*$")))))))

;; Auto-save and backup configuration
(setq auto-save-default t
      auto-save-timeout 20
      auto-save-interval 200
      backup-directory-alist `(("." . ,(expand-file-name "backups/" user-emacs-directory)))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 10
      kept-old-versions 5
      create-lockfiles nil)

;; Better defaults for some built-in keybindings
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)

;; ESC quits everything
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Font size adjustment
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-0") 'text-scale-adjust)

(provide 'init-utils)
;;; init-utils.el ends here
