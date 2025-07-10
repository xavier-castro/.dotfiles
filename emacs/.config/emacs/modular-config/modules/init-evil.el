;;; init-evil.el --- Evil mode configuration -*- lexical-binding: t; -*-

;; Author: Xavier
;; Version: 1.0
;; Package-Requires: ((emacs "27.1"))

;;; Commentary:
;; This module handles Evil mode configuration including:
;; - Basic Evil mode setup
;; - Evil Collection for additional mode support
;; - Custom Evil keybindings
;; - Evil-specific settings and tweaks

;;; Code:

;; Evil mode - Vim keybindings for Emacs
(use-package evil
  :init
  ;; Pre-load settings
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-redo)

  ;; Window splitting preferences
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)

  ;; Search behavior
  (setq evil-search-module 'evil-search)
  (setq evil-ex-complete-emacs-commands nil)
  (setq evil-ex-interactive-search-highlight 'selected-window)

  :config
  ;; Enable Evil mode
  (evil-mode 1)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  ;; Set initial state for certain modes
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (evil-set-initial-state 'debugger-mode 'normal)
  (evil-set-initial-state 'pdf-view-mode 'normal)
  (evil-set-initial-state 'compilation-mode 'normal)

  ;; Custom keybindings in insert state
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Custom keybindings in normal state
  (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

  ;; Better window management
  (define-key evil-normal-state-map (kbd "C-w h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-w j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-w k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-w l") 'evil-window-right)

  ;; Tab management
  (define-key evil-normal-state-map (kbd "g t") 'tab-next)
  (define-key evil-normal-state-map (kbd "g T") 'tab-previous)

  ;; Quick save
  (define-key evil-normal-state-map (kbd "C-s") 'save-buffer)

  ;; Center screen after jumping
  (advice-add 'evil-goto-line :after (lambda (&rest _) (recenter)))
  (advice-add 'evil-search-next :after (lambda (&rest _) (recenter)))
  (advice-add 'evil-search-previous :after (lambda (&rest _) (recenter))))

;; Evil Collection - Evil bindings for many Emacs modes
(use-package evil-collection
  :after evil
  :config
  ;; Don't use Evil Collection in certain modes
  (setq evil-collection-mode-list
        (remove 'lispy evil-collection-mode-list))

  ;; Initialize Evil Collection
  (evil-collection-init)

  ;; Custom settings for specific modes
  (with-eval-after-load 'dired
    (evil-collection-define-key 'normal 'dired-mode-map
      "h" 'dired-up-directory
      "l" 'dired-find-file)))

;; Evil Commentary - Easy commenting
(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode 1))

;; Evil Surround - Manipulate surrounding characters
(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

;; Evil Numbers - Increment/decrement numbers
(use-package evil-numbers
  :after evil
  :config
  (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt))

;; Evil Escape - Better escape sequences
(use-package evil-escape
  :after evil
  :config
  (evil-escape-mode 1)
  (setq evil-escape-key-sequence "jk")
  (setq evil-escape-delay 0.2))

;; Evil Indent Plus - Better indentation text objects
(use-package evil-indent-plus
  :after evil
  :config
  (define-key evil-inner-text-objects-map "i" 'evil-indent-plus-i-indent)
  (define-key evil-outer-text-objects-map "i" 'evil-indent-plus-a-indent)
  (define-key evil-inner-text-objects-map "I" 'evil-indent-plus-i-indent-up)
  (define-key evil-outer-text-objects-map "I" 'evil-indent-plus-a-indent-up))

;; Evil Matchit - Jump between matching tags
(use-package evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode 1))

;; Evil Visualstar - Search for selected text
(use-package evil-visualstar
  :after evil
  :config
  (global-evil-visualstar-mode 1))

;; Evil Exchange - Easy text exchange
(use-package evil-exchange
  :after evil
  :config
  (evil-exchange-install))

;; Evil Args - Manipulate function arguments
(use-package evil-args
  :after evil
  :config
  ;; Bind evil-args text objects
  (define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
  (define-key evil-outer-text-objects-map "a" 'evil-outer-arg)

  ;; Bind evil-forward/backward-args
  (define-key evil-normal-state-map "L" 'evil-forward-arg)
  (define-key evil-normal-state-map "H" 'evil-backward-arg)

  ;; Bind evil-jump-out-args
  (define-key evil-normal-state-map "K" 'evil-jump-out-args))

;; Evil Goggles - Visual feedback for Evil operations
(use-package evil-goggles
  :after evil
  :config
  (evil-goggles-mode 1)
  (setq evil-goggles-duration 0.100))

;; Helper functions for Evil
(defun my/evil-hook ()
  "Custom hook for Evil mode."
  (dolist (mode '(custom-mode
                  eshell-mode
                  git-rebase-mode
                  erc-mode
                  circe-server-mode
                  circe-chat-mode
                  circe-query-mode
                  sauron-mode
                  term-mode))
    (add-to-list 'evil-emacs-state-modes mode)))

(add-hook 'evil-mode-hook 'my/evil-hook)

;; Fix tab behavior in Evil mode
(defun my/evil-shift-left ()
  "Shift left and maintain selection."
  (interactive)
  (evil-shift-left (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(defun my/evil-shift-right ()
  "Shift right and maintain selection."
  (interactive)
  (evil-shift-right (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(define-key evil-visual-state-map (kbd "<") 'my/evil-shift-left)
(define-key evil-visual-state-map (kbd ">") 'my/evil-shift-right)

;; Better search highlighting
(defun my/evil-search-clear-highlight ()
  "Clear search highlighting."
  (interactive)
  (evil-ex-nohighlight))

(define-key evil-normal-state-map (kbd "C-/") 'my/evil-search-clear-highlight)

;; Custom Evil commands
(evil-ex-define-cmd "q" 'kill-this-buffer)
(evil-ex-define-cmd "quit" 'kill-this-buffer)
(evil-ex-define-cmd "wq" 'my/save-and-kill-buffer)
(evil-ex-define-cmd "W" 'save-buffer)

(defun my/save-and-kill-buffer ()
  "Save current buffer and kill it."
  (interactive)
  (save-buffer)
  (kill-this-buffer))

;; Make Evil play nice with other packages
(with-eval-after-load 'evil
  ;; Make horizontal scrolling work
  (define-key evil-normal-state-map (kbd "z l") 'evil-scroll-right)
  (define-key evil-normal-state-map (kbd "z h") 'evil-scroll-left)

  ;; Make C-i work in terminals
  (define-key evil-normal-state-map (kbd "C-i") 'evil-jump-forward)

  ;; Better mark jumping
  (define-key evil-normal-state-map (kbd "`") 'evil-goto-mark)
  (define-key evil-normal-state-map (kbd "'") 'evil-goto-mark-line))

(provide 'init-evil)
;;; init-evil.el ends here
