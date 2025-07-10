;;; init.el --- Main Emacs configuration -*- lexical-binding: t; -*-

;; Author: Xavier
;; Version: 1.0
;; Package-Requires: ((emacs "27.1"))

;;; Commentary:
;; This is the main configuration file that loads all modules.
;; Each module handles a specific aspect of the configuration.

;;; Code:

;; Add modules directory to load path
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

;; Package management setup
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Configure use-package defaults
(setq use-package-always-ensure t
      use-package-verbose t
      use-package-compute-statistics t)

;; Load modules in order
(require 'init-ui)          ; UI tweaks and appearance
(require 'init-fonts)       ; Font configuration
(require 'init-evil)        ; Evil mode (Vim keybindings)
(require 'init-keybindings) ; Custom keybindings
(require 'init-org)         ; Org mode configuration
(require 'init-utils)       ; Utility packages

;; Load optional modules (comment out if not needed)
;; (require 'init-programming) ; Programming language support
;; (require 'init-completion)  ; Completion framework
;; (require 'init-projects)    ; Project management

;; Personal settings
(setq user-full-name "Xavier"
      user-mail-address "your-email@example.com")

;; Disable annoying bell
(setq ring-bell-function 'ignore)

;; Better defaults
(setq-default indent-tabs-mode nil
              tab-width 4
              fill-column 80)

;; Enable some useful features
(recentf-mode 1)
(savehist-mode 1)
(save-place-mode 1)
(global-auto-revert-mode 1)

;; Show startup time
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;;; init.el ends here
