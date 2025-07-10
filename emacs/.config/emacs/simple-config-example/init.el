;;; init.el --- Simple Emacs Configuration Example

;; Configure package archives
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

;; Make sure to install packages by default
(setq use-package-always-ensure t)

;; Basic UI improvements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

;; Font configuration
(set-face-attribute 'default nil
  :font "Hack Nerd Font"
  :height 110
  :weight 'medium)

;; Evil mode (Vim keybindings)
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; General keybindings
(use-package general
  :config
  (general-create-definer my/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")

  (my/leader-keys
    "b" '(:ignore t :wk "buffer")
    "bb" '(switch-to-buffer :wk "Switch buffer")
    "bk" '(kill-this-buffer :wk "Kill this buffer")
    "bn" '(next-buffer :wk "Next buffer")
    "bp" '(previous-buffer :wk "Previous buffer")
    "br" '(revert-buffer :wk "Reload buffer")))

;; Which-key for keybinding help
(use-package which-key
  :config
  (which-key-mode 1)
  (setq which-key-idle-delay 0.8
        which-key-separator " → "))

;; Org mode enhancements
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(use-package toc-org
  :hook (org-mode . toc-org-enable))

;; Org mode configuration
(add-hook 'org-mode-hook 'org-indent-mode)

;; Disable bell
(setq ring-bell-function 'ignore)

;;; init.el ends here
