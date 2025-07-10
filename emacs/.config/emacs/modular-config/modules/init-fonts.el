;;; init-fonts.el --- Font configuration -*- lexical-binding: t; -*-

;; Author: Xavier
;; Version: 1.0
;; Package-Requires: ((emacs "27.1"))

;;; Commentary:
;; This module handles all font-related configuration including:
;; - Default font settings
;; - Variable pitch fonts
;; - Font sizes and weights
;; - Platform-specific font configurations

;;; Code:

;; Font settings
(defvar my/default-font "Hack Nerd Font"
  "The default font to use for fixed-pitch text.")

(defvar my/variable-font "Hack Nerd Font"
  "The font to use for variable-pitch text.")

(defvar my/default-font-size 110
  "The default font size (height * 10).")

(defvar my/variable-font-size 120
  "The variable font size (height * 10).")

;; Function to check if a font is available
(defun my/font-available-p (font-name)
  "Check if FONT-NAME is available on the system."
  (if (find-font (font-spec :name font-name))
      t
    nil))

;; Function to set fonts with fallbacks
(defun my/set-font-faces ()
  "Set font faces with fallback options."
  (let ((default-font (cond
                       ((my/font-available-p "Hack Nerd Font") "Hack Nerd Font")
                       ((my/font-available-p "Fira Code") "Fira Code")
                       ((my/font-available-p "JetBrains Mono") "JetBrains Mono")
                       ((my/font-available-p "Source Code Pro") "Source Code Pro")
                       ((my/font-available-p "Consolas") "Consolas")
                       ((my/font-available-p "Monaco") "Monaco")
                       (t "monospace")))
        (variable-font (cond
                        ((my/font-available-p "Hack Nerd Font") "Hack Nerd Font")
                        ((my/font-available-p "SF Pro Display") "SF Pro Display")
                        ((my/font-available-p "Segoe UI") "Segoe UI")
                        ((my/font-available-p "Roboto") "Roboto")
                        ((my/font-available-p "Helvetica") "Helvetica")
                        ((my/font-available-p "Arial") "Arial")
                        (t "sans-serif"))))

    ;; Set default font
    (set-face-attribute 'default nil
                        :font default-font
                        :height my/default-font-size
                        :weight 'medium)

    ;; Set variable pitch font
    (set-face-attribute 'variable-pitch nil
                        :font variable-font
                        :height my/variable-font-size
                        :weight 'medium)

    ;; Set fixed pitch font
    (set-face-attribute 'fixed-pitch nil
                        :font default-font
                        :height my/default-font-size
                        :weight 'medium)

    ;; Font lock faces for better syntax highlighting
    (set-face-attribute 'font-lock-comment-face nil
                        :slant 'italic)
    (set-face-attribute 'font-lock-keyword-face nil
                        :slant 'italic)
    (set-face-attribute 'font-lock-doc-face nil
                        :slant 'italic)

    ;; Set default font for all future frames
    (add-to-list 'default-frame-alist `(font . ,default-font))

    (message "Fonts configured: Default=%s, Variable=%s" default-font variable-font)))

;; Apply font configuration
(my/set-font-faces)

;; Platform-specific font adjustments
(cond
 ;; macOS specific settings
 ((eq system-type 'darwin)
  (setq ns-use-thin-smoothing t)
  (setq mac-allow-anti-aliasing t))

 ;; Windows specific settings
 ((eq system-type 'windows-nt)
  (setq inhibit-compacting-font-caches t))

 ;; Linux specific settings
 ((eq system-type 'gnu/linux)
  (setq x-underline-at-descent-line t)))

;; Line spacing
(setq-default line-spacing 0.1)

;; Mixed pitch mode for better reading experience
(use-package mixed-pitch
  :hook
  (text-mode . mixed-pitch-mode)
  :config
  (setq mixed-pitch-set-height t))

;; Ligatures support (if available)
(when (fboundp 'mac-auto-operator-composition-mode)
  (mac-auto-operator-composition-mode))

;; Font scaling functions
(defun my/increase-font-size ()
  "Increase font size globally."
  (interactive)
  (let ((new-size (+ (face-attribute 'default :height) 10)))
    (set-face-attribute 'default nil :height new-size)
    (message "Font size increased to %d" new-size)))

(defun my/decrease-font-size ()
  "Decrease font size globally."
  (interactive)
  (let ((new-size (- (face-attribute 'default :height) 10)))
    (when (> new-size 80)
      (set-face-attribute 'default nil :height new-size)
      (message "Font size decreased to %d" new-size))))

(defun my/reset-font-size ()
  "Reset font size to default."
  (interactive)
  (set-face-attribute 'default nil :height my/default-font-size)
  (message "Font size reset to %d" my/default-font-size))

;; Font configuration for specific modes
(defun my/setup-org-fonts ()
  "Set up fonts for org-mode."
  (dolist (face '((org-level-1 . 1.3)
                  (org-level-2 . 1.2)
                  (org-level-3 . 1.15)
                  (org-level-4 . 1.1)
                  (org-level-5 . 1.05)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil
                        :font my/variable-font
                        :weight 'medium
                        :height (floor (* my/variable-font-size (cdr face))))))

;; Apply org font configuration
(with-eval-after-load 'org
  (my/setup-org-fonts))

;; Unicode font support
(defun my/setup-unicode-fonts ()
  "Set up Unicode font support."
  (when (display-graphic-p)
    ;; Emoji support
    (set-fontset-font t 'emoji
                      (font-spec :family "Apple Color Emoji") nil 'prepend)
    (set-fontset-font t 'emoji
                      (font-spec :family "Segoe UI Emoji") nil 'prepend)
    (set-fontset-font t 'emoji
                      (font-spec :family "Noto Color Emoji") nil 'prepend)

    ;; Symbol support
    (set-fontset-font t 'symbol
                      (font-spec :family "Symbol") nil 'prepend)

    ;; Mathematical symbols
    (set-fontset-font t 'mathematical
                      (font-spec :family "STIX Two Math") nil 'prepend)))

;; Apply Unicode font configuration
(my/setup-unicode-fonts)

;; Refresh font configuration after theme changes
(defun my/refresh-fonts ()
  "Refresh font configuration."
  (interactive)
  (my/set-font-faces)
  (my/setup-unicode-fonts)
  (when (featurep 'org)
    (my/setup-org-fonts)))

;; Auto-refresh fonts when changing themes
(advice-add 'load-theme :after (lambda (&rest _) (my/refresh-fonts)))

(provide 'init-fonts)
;;; init-fonts.el ends here
