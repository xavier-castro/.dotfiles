;;; early-init.el --- Early initialization configuration -*- lexical-binding: t; -*-

;; Author: Xavier
;; Version: 1.0
;; Package-Requires: ((emacs "27.1"))

;;; Commentary:
;; This file is loaded before the package system and GUI is initialized.
;; It's used for early optimizations and setup.

;;; Code:

;; Disable package.el in favor of manual control
(setq package-enable-at-startup nil)

;; Disable native compilation warnings (Emacs 28+)
(when (featurep 'native-compile)
  (setq native-comp-async-report-warnings-errors nil))

;; Optimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Reset garbage collection threshold after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold 16777216  ; 16mb
                  gc-cons-percentage 0.1)))

;; Disable GUI elements early to prevent flickering
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Disable startup screen and messages
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t
      inhibit-default-init t
      initial-major-mode 'fundamental-mode
      initial-scratch-message nil)

;; Prevent the glimpse of un-styled Emacs
(setq frame-inhibit-implied-resize t)

;;; early-init.el ends here
