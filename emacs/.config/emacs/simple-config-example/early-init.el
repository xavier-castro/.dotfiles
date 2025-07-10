;;; early-init.el --- Early initialization configuration

;; Disable package.el in favor of straight.el or to control initialization manually
(setq package-enable-at-startup nil)

;; Disable native compilation warnings
(setq native-comp-async-report-warnings-errors nil)

;; Increase garbage collection threshold during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Reset garbage collection threshold after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold 16777216))) ; 16mb

;; Disable GUI elements early
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Disable startup screen
(setq inhibit-startup-screen t)

;; Prevent the glimpse of un-styled Emacs by disabling these UI elements early
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t
      inhibit-default-init t
      initial-major-mode 'fundamental-mode
      initial-scratch-message nil)

;;; early-init.el ends here
