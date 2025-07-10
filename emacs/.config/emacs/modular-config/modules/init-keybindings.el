;;; init-keybindings.el --- Custom keybindings configuration -*- lexical-binding: t; -*-

;; Author: Xavier
;; Version: 1.0
;; Package-Requires: ((emacs "27.1"))

;;; Commentary:
;; This module handles all custom keybindings including:
;; - General keybinding framework
;; - Leader key setup
;; - Buffer management keybindings
;; - File management keybindings
;; - Window management keybindings
;; - Application launcher keybindings

;;; Code:

;; General - A more convenient key binding system
(use-package general
  :config
  ;; Set up Evil integration
  (general-evil-setup)

  ;; Create leader key definer
  (general-create-definer my/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")

  ;; Create local leader key definer
  (general-create-definer my/local-leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC m"
    :global-prefix "M-SPC m")

  ;; Buffer management
  (my/leader-keys
    "b" '(:ignore t :wk "buffer")
    "bb" '(switch-to-buffer :wk "Switch buffer")
    "bk" '(kill-this-buffer :wk "Kill this buffer")
    "bK" '(kill-buffer :wk "Kill buffer")
    "bn" '(next-buffer :wk "Next buffer")
    "bp" '(previous-buffer :wk "Previous buffer")
    "br" '(revert-buffer :wk "Reload buffer")
    "bR" '(rename-buffer :wk "Rename buffer")
    "bs" '(save-buffer :wk "Save buffer")
    "bS" '(save-some-buffers :wk "Save some buffers")
    "bd" '(kill-this-buffer :wk "Delete buffer")
    "bD" '(kill-buffer-and-window :wk "Delete buffer and window")
    "bi" '(ibuffer :wk "Ibuffer")
    "bI" '(clone-indirect-buffer :wk "Clone indirect buffer")
    "bl" '(list-buffers :wk "List buffers")
    "bm" '(bookmark-set :wk "Set bookmark")
    "bM" '(bookmark-jump :wk "Jump to bookmark")
    "bu" '(revert-buffer :wk "Revert buffer")
    "bz" '(bury-buffer :wk "Bury buffer"))

  ;; File management
  (my/leader-keys
    "f" '(:ignore t :wk "files")
    "ff" '(find-file :wk "Find file")
    "fF" '(find-file-other-window :wk "Find file other window")
    "fr" '(recentf-open-files :wk "Recent files")
    "fR" '(rename-file :wk "Rename file")
    "fs" '(save-buffer :wk "Save file")
    "fS" '(save-some-buffers :wk "Save some files")
    "fd" '(dired :wk "Dired")
    "fD" '(delete-file :wk "Delete file")
    "fc" '(copy-file :wk "Copy file")
    "fl" '(find-file-literally :wk "Find file literally")
    "fL" '(locate :wk "Locate")
    "fo" '(find-file-other-window :wk "Find file other window")
    "fO" '(find-file-other-frame :wk "Find file other frame")
    "fp" '(find-file-at-point :wk "Find file at point")
    "ft" '(treemacs :wk "Treemacs")
    "fT" '(treemacs-select-window :wk "Treemacs select")
    "fy" '(my/copy-file-path :wk "Copy file path")
    "fY" '(my/copy-file-name :wk "Copy file name"))

  ;; Window management
  (my/leader-keys
    "w" '(:ignore t :wk "windows")
    "ww" '(other-window :wk "Other window")
    "wd" '(delete-window :wk "Delete window")
    "wD" '(delete-other-windows :wk "Delete other windows")
    "ws" '(split-window-below :wk "Split window below")
    "wv" '(split-window-right :wk "Split window right")
    "wh" '(windmove-left :wk "Move to left window")
    "wj" '(windmove-down :wk "Move to below window")
    "wk" '(windmove-up :wk "Move to above window")
    "wl" '(windmove-right :wk "Move to right window")
    "wH" '(windmove-swap-states-left :wk "Swap with left window")
    "wJ" '(windmove-swap-states-down :wk "Swap with below window")
    "wK" '(windmove-swap-states-up :wk "Swap with above window")
    "wL" '(windmove-swap-states-right :wk "Swap with right window")
    "wo" '(delete-other-windows :wk "Delete other windows")
    "wr" '(window-configuration-to-register :wk "Save window config")
    "wR" '(jump-to-register :wk "Restore window config")
    "w=" '(balance-windows :wk "Balance windows")
    "w+" '(enlarge-window :wk "Enlarge window")
    "w-" '(shrink-window :wk "Shrink window")
    "w>" '(enlarge-window-horizontally :wk "Enlarge window horizontally")
    "w<" '(shrink-window-horizontally :wk "Shrink window horizontally")
    "wu" '(winner-undo :wk "Winner undo")
    "wU" '(winner-redo :wk "Winner redo")
    "wf" '(follow-mode :wk "Follow mode")
    "wF" '(make-frame :wk "Make frame")
    "wm" '(maximize-window :wk "Maximize window")
    "wM" '(minimize-window :wk "Minimize window"))

  ;; Tab management
  (my/leader-keys
    "t" '(:ignore t :wk "tabs")
    "tt" '(tab-new :wk "New tab")
    "td" '(tab-close :wk "Close tab")
    "tD" '(tab-close-other :wk "Close other tabs")
    "tn" '(tab-next :wk "Next tab")
    "tp" '(tab-previous :wk "Previous tab")
    "tr" '(tab-rename :wk "Rename tab")
    "tR" '(tab-move :wk "Move tab")
    "ts" '(tab-bar-select-tab :wk "Select tab")
    "tS" '(tab-bar-switch-to-tab :wk "Switch to tab")
    "tl" '(tab-list :wk "List tabs")
    "tu" '(tab-undo :wk "Undo tab close"))

  ;; Search and replace
  (my/leader-keys
    "s" '(:ignore t :wk "search")
    "ss" '(swiper :wk "Swiper")
    "sS" '(swiper-all :wk "Swiper all")
    "sp" '(counsel-rg :wk "Ripgrep")
    "sP" '(counsel-projectile-rg :wk "Projectile ripgrep")
    "sf" '(counsel-fzf :wk "FZF")
    "sF" '(counsel-projectile-find-file :wk "Projectile find file")
    "sg" '(counsel-grep :wk "Grep")
    "sG" '(counsel-git-grep :wk "Git grep")
    "si" '(counsel-imenu :wk "Imenu")
    "sI" '(imenu :wk "Imenu")
    "sl" '(counsel-locate :wk "Locate")
    "sL" '(locate :wk "Locate")
    "sr" '(query-replace :wk "Query replace")
    "sR" '(query-replace-regexp :wk "Query replace regexp")
    "so" '(occur :wk "Occur")
    "sO" '(multi-occur :wk "Multi occur")
    "st" '(counsel-load-theme :wk "Load theme")
    "sT" '(describe-theme :wk "Describe theme"))

  ;; Help and documentation
  (my/leader-keys
    "h" '(:ignore t :wk "help")
    "hf" '(describe-function :wk "Describe function")
    "hv" '(describe-variable :wk "Describe variable")
    "hk" '(describe-key :wk "Describe key")
    "hK" '(describe-keymap :wk "Describe keymap")
    "hm" '(describe-mode :wk "Describe mode")
    "hM" '(describe-minor-mode :wk "Describe minor mode")
    "hp" '(describe-package :wk "Describe package")
    "hP" '(finder-by-keyword :wk "Find package by keyword")
    "ha" '(apropos :wk "Apropos")
    "hA" '(apropos-command :wk "Apropos command")
    "hi" '(info :wk "Info")
    "hI" '(info-lookup-symbol :wk "Info lookup symbol")
    "hb" '(describe-bindings :wk "Describe bindings")
    "hB" '(describe-personal-keybindings :wk "Describe personal keybindings")
    "hs" '(describe-syntax :wk "Describe syntax")
    "hS" '(info-lookup-symbol :wk "Info lookup symbol")
    "hc" '(describe-char :wk "Describe char")
    "hC" '(describe-coding-system :wk "Describe coding system")
    "hF" '(describe-face :wk "Describe face")
    "hl" '(view-lossage :wk "View lossage")
    "hL" '(find-library :wk "Find library")
    "hn" '(view-emacs-news :wk "View Emacs news")
    "hN" '(view-emacs-FAQ :wk "View Emacs FAQ")
    "hr" '(info-emacs-manual :wk "Emacs manual")
    "hR" '(info-display-manual :wk "Display manual")
    "ht" '(help-with-tutorial :wk "Help with tutorial")
    "hT" '(help-with-tutorial-spec-language :wk "Help with tutorial (language)")
    "hu" '(describe-unbound-keys :wk "Describe unbound keys")
    "hU" '(describe-user-option :wk "Describe user option")
    "hw" '(where-is :wk "Where is")
    "hW" '(woman :wk "Woman")
    "h?" '(help-for-help :wk "Help for help"))

  ;; Applications and tools
  (my/leader-keys
    "a" '(:ignore t :wk "apps")
    "at" '(term :wk "Terminal")
    "aT" '(ansi-term :wk "ANSI terminal")
    "as" '(eshell :wk "Eshell")
    "aS" '(shell :wk "Shell")
    "ac" '(calc :wk "Calculator")
    "aC" '(calendar :wk "Calendar")
    "ag" '(magit :wk "Magit")
    "aG" '(magit-status :wk "Magit status")
    "am" '(compose-mail :wk "Compose mail")
    "aM" '(mu4e :wk "Mu4e")
    "an" '(org-agenda :wk "Org agenda")
    "aN" '(org-capture :wk "Org capture")
    "ar" '(org-roam-node-find :wk "Org roam find")
    "aR" '(org-roam-node-insert :wk "Org roam insert")
    "ap" '(proced :wk "Proced")
    "aP" '(list-processes :wk "List processes")
    "ad" '(dired :wk "Dired")
    "aD" '(dired-other-window :wk "Dired other window")
    "ae" '(eww :wk "EWW browser")
    "aE" '(eww-open-file :wk "EWW open file")
    "ai" '(erc :wk "ERC IRC")
    "aI" '(erc-tls :wk "ERC TLS")
    "aj" '(dired-jump :wk "Dired jump")
    "aJ" '(dired-jump-other-window :wk "Dired jump other window")
    "ak" '(bookmark-jump :wk "Jump to bookmark")
    "aK" '(bookmark-set :wk "Set bookmark")
    "al" '(list-bookmarks :wk "List bookmarks")
    "aL" '(bookmark-bmenu-list :wk "Bookmark menu")
    "ao" '(org-open-at-point :wk "Org open at point")
    "aO" '(org-open-at-point-global :wk "Org open at point global")
    "au" '(undo-tree-visualize :wk "Undo tree")
    "aU" '(undo-tree-save-history :wk "Undo tree save history")
    "av" '(vc-dir :wk "Version control")
    "aV" '(vc-annotate :wk "Version control annotate")
    "aw" '(whitespace-mode :wk "Whitespace mode")
    "aW" '(whitespace-cleanup :wk "Whitespace cleanup")
    "ax" '(org-export-dispatch :wk "Org export")
    "aX" '(org-export :wk "Org export")
    "ay" '(yas-new-snippet :wk "Yasnippet new")
    "aY" '(yas-visit-snippet-file :wk "Yasnippet visit")
    "az" '(zone :wk "Zone"))

  ;; Toggles
  (my/leader-keys
    "T" '(:ignore t :wk "toggles")
    "Tt" '(toggle-truncate-lines :wk "Toggle truncate lines")
    "Tw" '(whitespace-mode :wk "Toggle whitespace mode")
    "Tn" '(display-line-numbers-mode :wk "Toggle line numbers")
    "Tr" '(read-only-mode :wk "Toggle read-only")
    "Tf" '(auto-fill-mode :wk "Toggle auto-fill")
    "Th" '(global-hl-line-mode :wk "Toggle highlight line")
    "Ti" '(toggle-input-method :wk "Toggle input method")
    "Tl" '(toggle-word-wrap :wk "Toggle word wrap")
    "Tm" '(menu-bar-mode :wk "Toggle menu bar")
    "TM" '(toggle-frame-maximized :wk "Toggle frame maximized")
    "Tp" '(show-paren-mode :wk "Toggle show paren")
    "Ts" '(flyspell-mode :wk "Toggle flyspell")
    "TS" '(flyspell-prog-mode :wk "Toggle flyspell prog")
    "Tv" '(visual-line-mode :wk "Toggle visual line")
    "TV" '(variable-pitch-mode :wk "Toggle variable pitch")
    "Tx" '(toggle-debug-on-error :wk "Toggle debug on error")
    "TX" '(toggle-debug-on-quit :wk "Toggle debug on quit")
    "Tz" '(zone-mode :wk "Toggle zone mode"))

  ;; Quit/restart
  (my/leader-keys
    "q" '(:ignore t :wk "quit")
    "qq" '(save-buffers-kill-terminal :wk "Quit Emacs")
    "qQ" '(kill-emacs :wk "Kill Emacs")
    "qr" '(restart-emacs :wk "Restart Emacs")
    "qR" '(restart-emacs-start-new-emacs :wk "Restart Emacs (new)")
    "qf" '(delete-frame :wk "Delete frame")
    "qF" '(delete-other-frames :wk "Delete other frames")
    "qk" '(kill-this-buffer :wk "Kill this buffer")
    "qK" '(kill-buffer-and-window :wk "Kill buffer and window")
    "qs" '(save-some-buffers :wk "Save some buffers")
    "qS" '(save-buffers-kill-emacs :wk "Save buffers and kill Emacs"))

  ;; Insert
  (my/leader-keys
    "i" '(:ignore t :wk "insert")
    "iu" '(insert-char :wk "Insert Unicode char")
    "iU" '(counsel-unicode-char :wk "Insert Unicode char (counsel)")
    "ie" '(emoji-insert :wk "Insert emoji")
    "iE" '(emoji-search :wk "Search emoji")
    "if" '(insert-file :wk "Insert file")
    "iF" '(insert-file-contents :wk "Insert file contents")
    "il" '(lorem-ipsum-insert-sentences :wk "Insert lorem ipsum")
    "iL" '(lorem-ipsum-insert-paragraphs :wk "Insert lorem ipsum paragraphs")
    "is" '(yas-insert-snippet :wk "Insert snippet")
    "iS" '(yas-new-snippet :wk "New snippet")
    "it" '(insert-time-stamp :wk "Insert timestamp")
    "iT" '(org-time-stamp :wk "Insert org timestamp")
    "id" '(insert-date :wk "Insert date")
    "iD" '(org-date-from-calendar :wk "Insert date from calendar")
    "ip" '(insert-parentheses :wk "Insert parentheses")
    "iP" '(insert-pair :wk "Insert pair")
    "ir" '(insert-register :wk "Insert register")
    "iR" '(copy-to-register :wk "Copy to register")
    "ib" '(insert-buffer :wk "Insert buffer")
    "iB" '(insert-buffer-substring :wk "Insert buffer substring")
    "ic" '(insert-kbd-macro :wk "Insert keyboard macro")
    "iC" '(insert-char :wk "Insert char")
    "ik" '(insert-kbd-macro :wk "Insert kbd macro")
    "iK" '(kmacro-insert-counter :wk "Insert macro counter")
    "in" '(insert-numbers :wk "Insert numbers")
    "iN" '(insert-numbering :wk "Insert numbering")
    "iy" '(yank :wk "Yank")
    "iY" '(yank-pop :wk "Yank pop"))

  ;; Notes (using space + n for note-taking)
  (my/leader-keys
    "n" '(:ignore t :wk "notes")
    "nn" '(org-capture :wk "New note")
    "nN" '(org-capture-goto-last-stored :wk "Go to last captured note")
    "nf" '(org-roam-node-find :wk "Find note")
    "nF" '(org-roam-node-random :wk "Random note")
    "ni" '(org-roam-node-insert :wk "Insert note link")
    "nI" '(org-roam-node-insert-immediate :wk "Insert note link (immediate)")
    "nr" '(org-roam-buffer-toggle :wk "Toggle roam buffer")
    "nR" '(org-roam-buffer-display-dedicated :wk "Show roam buffer")
    "ns" '(org-roam-db-sync :wk "Sync roam database")
    "nS" '(org-roam-db-build-cache :wk "Build roam cache")
    "ng" '(org-roam-graph :wk "Show roam graph")
    "nG" '(org-roam-ui-mode :wk "Roam UI mode")
    "nt" '(org-roam-tag-add :wk "Add tag")
    "nT" '(org-roam-tag-remove :wk "Remove tag")
    "na" '(org-roam-alias-add :wk "Add alias")
    "nA" '(org-roam-alias-remove :wk "Remove alias")
    "nd" '(org-roam-dailies-capture-today :wk "Daily note today")
    "nD" '(org-roam-dailies-capture-date :wk "Daily note date")
    "ny" '(org-roam-dailies-capture-yesterday :wk "Daily note yesterday")
    "nY" '(org-roam-dailies-capture-tomorrow :wk "Daily note tomorrow")
    "nl" '(org-roam-dailies-goto-today :wk "Go to today's daily note")
    "nL" '(org-roam-dailies-goto-date :wk "Go to daily note")
    "no" '(org-open-at-point :wk "Open link at point")
    "nO" '(org-open-at-point-global :wk "Open link at point (global)")
    "np" '(org-priority :wk "Set priority")
    "nP" '(org-priority-up :wk "Increase priority")
    "nj" '(org-next-visible-heading :wk "Next heading")
    "nk" '(org-previous-visible-heading :wk "Previous heading")
    "nh" '(org-toggle-heading :wk "Toggle heading")
    "nH" '(org-insert-heading :wk "Insert heading")
    "nc" '(org-ctrl-c-ctrl-c :wk "Ctrl-c Ctrl-c")
    "nC" '(org-columns :wk "Columns view")
    "ne" '(org-export-dispatch :wk "Export")
    "nE" '(org-export :wk "Export")
    "nb" '(org-backward-heading-same-level :wk "Backward heading same level")
    "nw" '(org-forward-heading-same-level :wk "Forward heading same level")
    "nu" '(outline-up-heading :wk "Up heading")
    "nU" '(org-up-element :wk "Up element")
    "nm" '(org-mark-subtree :wk "Mark subtree")
    "nM" '(org-mark-element :wk "Mark element")
    "nq" '(org-set-tags-command :wk "Set tags")
    "nQ" '(org-toggle-tag :wk "Toggle tag")
    "nv" '(org-show-subtree :wk "Show subtree")
    "nV" '(org-show-all :wk "Show all")
    "nx" '(org-toggle-checkbox :wk "Toggle checkbox")
    "nX" '(org-insert-todo-heading :wk "Insert todo heading")
    "nz" '(org-add-note :wk "Add note")
    "nZ" '(org-store-link :wk "Store link"))

  ;; Version control (git)
  (my/leader-keys
    "g" '(:ignore t :wk "git")
    "gs" '(magit-status :wk "Git status")
    "gS" '(magit-stage-file :wk "Git stage file")
    "gu" '(magit-unstage-file :wk "Git unstage file")
    "gU" '(magit-unstage-all :wk "Git unstage all")
    "gc" '(magit-commit :wk "Git commit")
    "gC" '(magit-commit-amend :wk "Git commit amend")
    "gp" '(magit-push :wk "Git push")
    "gP" '(magit-pull :wk "Git pull")
    "gf" '(magit-fetch :wk "Git fetch")
    "gF" '(magit-fetch-all :wk "Git fetch all")
    "gb" '(magit-branch :wk "Git branch")
    "gB" '(magit-checkout :wk "Git checkout")
    "gl" '(magit-log :wk "Git log")
    "gL" '(magit-log-all :wk "Git log all")
    "gd" '(magit-diff :wk "Git diff")
    "gD" '(magit-diff-staged :wk "Git diff staged")
    "gr" '(magit-rebase :wk "Git rebase")
    "gR" '(magit-reset :wk "Git reset")
    "gt" '(magit-tag :wk "Git tag")
    "gT" '(magit-stash :wk "Git stash")
    "gm" '(magit-merge :wk "Git merge")
    "gM" '(magit-remote :wk "Git remote")
    "gn" '(git-gutter:next-hunk :wk "Next hunk")
    "gN" '(git-gutter:previous-hunk :wk "Previous hunk")
    "gh" '(git-gutter:popup-hunk :wk "Show hunk")
    "gH" '(git-gutter:revert-hunk :wk "Revert hunk")
    "gi" '(magit-init :wk "Git init")
    "gI" '(magit-ignore :wk "Git ignore")
    "gj" '(git-gutter:next-hunk :wk "Next hunk")
    "gk" '(git-gutter:previous-hunk :wk "Previous hunk")
    "go" '(magit-submodule :wk "Git submodule")
    "gO" '(magit-subtree :wk "Git subtree")
    "gv" '(magit-show-refs :wk "Git show refs")
    "gV" '(magit-cherry :wk "Git cherry")
    "gw" '(magit-worktree :wk "Git worktree")
    "gW" '(magit-wip-mode :wk "Git wip mode")
    "gx" '(magit-reset-hard :wk "Git reset hard")
    "gX" '(magit-reset-soft :wk "Git reset soft")
    "gy" '(magit-show-refs :wk "Git show refs")
    "gY" '(magit-cherry-pick :wk "Git cherry pick")
    "gz" '(magit-stash-pop :wk "Git stash pop")
    "gZ" '(magit-stash-drop :wk "Git stash drop"))

  ;; Project management
  (my/leader-keys
    "p" '(:ignore t :wk "project")
    "pp" '(projectile-switch-project :wk "Switch project")
    "pf" '(projectile-find-file :wk "Find file in project")
    "pF" '(projectile-find-file-other-window :wk "Find file other window")
    "pd" '(projectile-find-dir :wk "Find directory")
    "pD" '(projectile-dired :wk "Dired root")
    "pb" '(projectile-switch-to-buffer :wk "Switch to buffer")
    "pB" '(projectile-ibuffer :wk "Ibuffer")
    "pk" '(projectile-kill-buffers :wk "Kill project buffers")
    "pK" '(projectile-remove-known-project :wk "Remove known project")
    "pr" '(projectile-run-project :wk "Run project")
    "pR" '(projectile-replace :wk "Replace in project")
    "ps" '(projectile-save-project-buffers :wk "Save project buffers")
    "pS" '(projectile-grep :wk "Grep in project")
    "pt" '(projectile-test-project :wk "Test project")
    "pT" '(projectile-toggle-between-implementation-and-test :wk "Toggle impl/test")
    "pc" '(projectile-compile-project :wk "Compile project")
    "pC" '(projectile-configure-project :wk "Configure project")
    "pe" '(projectile-run-eshell :wk "Run eshell")
    "pE" '(projectile-run-shell :wk "Run shell")
    "pg" '(projectile-regenerate-tags :wk "Regenerate tags")
    "pG" '(projectile-find-tag :wk "Find tag")
    "pi" '(projectile-invalidate-cache :wk "Invalidate cache")
    "pI" '(projectile-install-project :wk "Install project")
    "pj" '(projectile-find-tag :wk "Find tag")
    "pJ" '(projectile-tags-command :wk "Tags command")
    "pl" '(projectile-find-file-in-directory :wk "Find file in directory")
    "pL" '(projectile-find-file-in-known-projects :wk "Find file in known projects")
    "pm" '(projectile-commander :wk "Project commander")
    "pM" '(projectile-multi-occur :wk "Multi occur")
    "pn" '(projectile-next-project-buffer :wk "Next project buffer")
    "pN" '(projectile-previous-project-buffer :wk "Previous project buffer")
    "po" '(projectile-find-other-file :wk "Find other file")
    "pO" '(projectile-find-other-file-other-window :wk "Find other file other window")
    "pu" '(projectile-run-project :wk "Run project")
    "pU" '(projectile-run-command-in-root :wk "Run command in root")
    "pv" '(projectile-vc :wk "Version control")
    "pV" '(projectile-browse-dirty-projects :wk "Browse dirty projects")
    "pw" '(projectile-find-references :wk "Find references")
    "pW" '(projectile-find-implementation-or-test-other-window :wk "Find impl/test other window")
    "px" '(projectile-run-shell-command-in-root :wk "Run shell command in root")
    "pX" '(projectile-run-async-shell-command-in-root :wk "Run async shell command in root")
    "py" '(projectile-find-test-file :wk "Find test file")
    "pY" '(projectile-test-project :wk "Test project")
    "pz" '(projectile-cache-current-file :wk "Cache current file")
    "pZ" '(projectile-cleanup-known-projects :wk "Cleanup known projects"))

  ;; Local leader keys (mode-specific)
  (my/local-leader-keys
    "," '(nil :wk "local leader")))

;; Which-key integration
(use-package which-key
  :config
  (which-key-mode 1)
  (setq which-key-idle-delay 0.4
        which-key-separator " → "
        which-key-sort-order 'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10
        which-key-side-window-max-height 0.25
        which-key-allow-imprecise-window-fit t))

;; Hydra for transient keymaps
(use-package hydra
  :config
  ;; Window management hydra
  (defhydra hydra-window (:timeout 4)
    "Window management"
    ("h" windmove-left "left")
    ("j" windmove-down "down")
    ("k" windmove-up "up")
    ("l" windmove-right "right")
    ("H" windmove-swap-states-left "swap left")
    ("J" windmove-swap-states-down "swap down")
    ("K" windmove-swap-states-up "swap up")
    ("L" windmove-swap-states-right "swap right")
    ("+" enlarge-window "enlarge")
    ("-" shrink-window "shrink")
    (">" enlarge-window-horizontally "enlarge horizontal")
    ("<" shrink-window-horizontally "shrink horizontal")
    ("=" balance-windows "balance")
    ("u" winner-undo "undo")
    ("r" winner-redo "redo")
    ("q" nil "quit"))

  ;; Text scaling hydra
  (defhydra hydra-zoom (global-map "<f2>")
    "Zoom"
    ("g" text-scale-increase "in")
    ("l" text-scale-decrease "out")
    ("r" (text-scale-set 0) "reset")
    ("0" (text-scale-set 0) :bind nil :exit t)
    ("1" (text-scale-set 0) nil :bind nil :exit t))

  ;; Org mode hydra
  (defhydra hydra-org-clock (:color blue)
    "Clock"
    ("i" org-clock-in "in")
    ("o" org-clock-out "out")
    ("r" org-clock-report "report")
    ("g" org-clock-goto "goto")
    ("j" org-clock-jump-to-current-clock "jump")
    ("c" org-clock-cancel "cancel")
    ("d" org-clock-display "display")
    ("q" nil "quit"))

  ;; Rectangle hydra
  (defhydra hydra-rectangle (:body-pre (rectangle-mark-mode 1)
                             :color pink
                             :post (deactivate-mark))
    "Rectangle"
    ("h" rectangle-backward-char nil)
    ("l" rectangle-forward-char nil)
    ("k" rectangle-previous-line nil)
    ("j" rectangle-next-line nil)
    ("e" rectangle-exchange-point-and-mark nil)
    ("n" copy-rectangle-as-kill nil)
    ("d" delete-rectangle nil)
    ("r" (if (region-active-p)
             (deactivate-mark)
           (rectangle-mark-mode 1)) nil)
    ("y" copy-rectangle-as-kill nil)
    ("o" open-rectangle nil)
    ("p" yank-rectangle nil)
    ("i" string-insert-rectangle nil)
    ("t" string-rectangle nil)
    ("q" nil nil))

  ;; Bind hydras to leader keys
  (my/leader-keys
    "ww" '(hydra-window/body :wk "Window hydra")
    "Tz" '(hydra-zoom/body :wk "Zoom hydra")
    "nr" '(hydra-rectangle/body :wk "Rectangle hydra")
    "nc" '(hydra-org-clock/body :wk "Org clock hydra")))

;; Utility functions for keybindings
(defun my/copy-file-path ()
  "Copy the current file path to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied file path: %s" filename))))

(defun my/copy-file-name ()
  "Copy the current file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      (dired-get-filename)
                    (buffer-file-name))))
    (when filename
      (kill-new (file-name-nondirectory filename))
      (message "Copied file name: %s" (file-name-nondirectory filename)))))

(defun my/insert-date ()
  "Insert the current date."
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(defun my/insert-time-stamp ()
  "Insert the current date and time."
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S")))

(defun my/insert-numbers (start end)
  "Insert numbers from START to END."
  (interactive "nStart: \nnEnd: ")
  (let ((current start))
    (while (<= current end)
      (insert (number-to-string current))
      (newline)
      (setq current (1+ current)))))

;; Better defaults for some built-in keybindings
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-r") 'swiper-backward)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c s") 'swiper-all)
(global-set-key (kbd "C-c f") 'counsel-fzf)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
(global-set-key (kbd "C-h o") 'counsel-describe-symbol)
(global-set-key (kbd "C-h l") 'counsel-find-library)
(global-set-key (kbd "C-h u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-c i") 'counsel-imenu)
(global-set-key (kbd "C-c y") 'counsel-yank-pop)

;; ESC quits everything
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Window management shortcuts
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <down>") 'windmove-down)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <right>") 'windmove-right)

;; Better movement keys
(global-set-key (kbd "C-a") 'move-beginning-of-line)
(global-set-key (kbd "C-e") 'move-end-of-line)
(global-set-key (kbd "M-<") 'beginning-of-buffer)
(global-set-key (kbd "M->") 'end-of-buffer)

;; Text manipulation
(global-set-key (kbd "M-u") 'upcase-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-c") 'capitalize-dwim)

;; Better kill and yank
(global-set-key (kbd "C-w") 'kill-region)
(global-set-key (kbd "M-w") 'kill-ring-save)
(global-set-key (kbd "C-y") 'yank)
(global-set-key (kbd "M-y") 'yank-pop)

;; Better search and replace
(global-set-key (kbd "M-%") 'query-replace)
(global-set-key (kbd "C-M-%") 'query-replace-regexp)

;; Font size adjustment
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-0") 'text-scale-adjust)

;; Multiple cursors (if available)
(when (featurep 'multiple-cursors)
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

;; Expand region (if available)
(when (featurep 'expand-region)
  (global-set-key (kbd "C-=") 'er/expand-region))

;; Avy jump (if available)
(when (featurep 'avy)
  (global-set-key (kbd "C-;") 'avy-goto-char-timer)
  (global-set-key (kbd "C-'") 'avy-goto-line))

;; Ace window (if available)
(when (featurep 'ace-window)
  (global-set-key (kbd "M-o") 'ace-window))

;; Company completion (if available)
(when (featurep 'company)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "C-d") 'company-show-doc-buffer)
  (define-key company-active-map (kbd "M-.") 'company-show-location))

;; Ivy/Counsel completion (if available)
(when (featurep 'ivy)
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)
  (define-key ivy-minibuffer-map (kbd "C-h") 'ivy-backward-delete-char)
  (define-key ivy-minibuffer-map (kbd "C-l") 'ivy-alt-done)
  (define-key ivy-minibuffer-map (kbd "C-w") 'ivy-yank-word)
  (define-key ivy-minibuffer-map (kbd "C-u") 'ivy-kill-line)
  (define-key ivy-minibuffer-map (kbd "C-r") 'ivy-previous-history-element)
  (define-key ivy-minibuffer-map (kbd "C-s") 'ivy-next-history-element))

;; Org mode specific keybindings
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-q") 'counsel-org-tag)
  (define-key org-mode-map (kbd "C-c C-j") 'counsel-org-goto)
  (define-key org-mode-map (kbd "C-c C-r") 'counsel-org-goto-all)
  (define-key org-mode-map (kbd "C-c C-o") 'counsel-org-link)
  (define-key org-mode-map (kbd "C-c C-w") 'counsel-org-refile)
  (define-key org-mode-map (kbd "C-c C-s") 'counsel-org-schedule)
  (define-key org-mode-map (kbd "C-c C-d") 'counsel-org-deadline)
  (define-key org-mode-map (kbd "C-c C-p") 'counsel-org-property)
  (define-key org-mode-map (kbd "C-c C-e") 'counsel-org-entity)
  (define-key org-mode-map (kbd "C-c C-k") 'counsel-org-capture))

;; Dired mode specific keybindings
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "C-c C-o") 'dired-find-file-other-window)
  (define-key dired-mode-map (kbd "C-c C-q") 'wdired-change-to-wdired-mode)
  (define-key dired-mode-map (kbd "C-c C-r") 'dired-do-query-replace-regexp)
  (define-key dired-mode-map (kbd "C-c C-s") 'dired-do-isearch)
  (define-key dired-mode-map (kbd "C-c C-d") 'dired-do-delete)
  (define-key dired-mode-map (kbd "C-c C-c") 'dired-do-copy)
  (define-key dired-mode-map (kbd "C-c C-m") 'dired-do-rename)
  (define-key dired-mode-map (kbd "C-c C-l") 'dired-do-symlink)
  (define-key dired-mode-map (kbd "C-c C-h") 'dired-do-hardlink)
  (define-key dired-mode-map (kbd "C-c C-p") 'dired-do-print)
  (define-key dired-mode-map (kbd "C-c C-z") 'dired-do-compress)
  (define-key dired-mode-map (kbd "C-c C-a") 'dired-do-async-shell-command)
  (define-key dired-mode-map (kbd "C-c C-!") 'dired-do-shell-command))

;; Magit keybindings
(with-eval-after-load 'magit
  (define-key magit-status-mode-map (kbd "C-c C-a") 'magit-commit-amend)
  (define-key magit-status-mode-map (kbd "C-c C-c") 'magit-commit-create)
  (define-key magit-status-mode-map (kbd "C-c C-e") 'magit-commit-extend)
  (define-key magit-status-mode-map (kbd "C-c C-f") 'magit-commit-fixup)
  (define-key magit-status-mode-map (kbd "C-c C-i") 'magit-commit-instant-fixup)
  (define-key magit-status-mode-map (kbd "C-c C-r") 'magit-commit-reword)
  (define-key magit-status-mode-map (kbd "C-c C-s") 'magit-commit-squash)
  (define-key magit-status-mode-map (kbd "C-c C-w") 'magit-commit-augment))

(provide 'init-keybindings)
;;; init-keybindings.el ends here
