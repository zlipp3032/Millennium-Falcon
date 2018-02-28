
;; Disable splash screen on startup
(setq inhibit-startup-screen t)

;; Open .emacs file to change settings with C-c 9
(defun open-init-file ()
  (interactive)
  (eval-expression (quote (find-file user-init-file)) nil))

;; Global key bindings
(global-set-key (kbd "C-c 9") 'open-init-file)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)
(global-set-key (kbd "<C-M-up>") 'shrink-window)
(global-set-key (kbd "<C-M-down>") 'enlarge-window)
(global-set-key (kbd "<C-M-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-M-right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ; Old M-x 


; Default window width and height
(defun custom-set-frame-size ()
  (add-to-list 'default-frame-alist '(height . 80))
  (add-to-list 'default-frame-alist '(width . 100)))
;(custom-set-frame-size)
(add-hook 'before-make-frame-hook 'custom-set-frame-size)

;; Install package manager
;(require 'package)
;(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
;                  ("elpa" . "http://tromey.com/elpa/")
;                  ("melpa" . "http://melpa.milkbox.net/packages/")
;                  ))
;  (add-to-list 'package-archives source t))
;(package-initialize)

;; MAC-SPECIFIC commands
(exec-path-from-shell-initialize) ;; Add /usr/texbin to executable path
(setq mac-option-key-is-meta nil)
(setq mac-command-modifier 'control) ;; Switch control and command keys.
(setq mac-control-modifier 'super)
;(setq mac-meta-modifier 'super)
(setq mac-emulate-three-button-mouse t) ;; Access middle and right click with M-<mouse-1> and C-<mouse-1>

;; Highlight current line
(global-hl-line-mode 1)

;; Visual line mode
(setq line-move-visual nil)

(set-default 'truncate-lines nil)
(setq longlines-wrap-follows-window-size t)

;; Set tabs to 2 spaces
(setq tab-width 2) 

;; Mouse-wheel
(mouse-wheel-mode -1)

;; Disable auto-fill mode
(auto-fill-mode -1)

;; Remove tool bar
(tool-bar-mode -1)

;; Change yes/no prompts to y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Add icicles mode to help with minibuffer completion
;(require 'icicles)
;(icy-mode nil)



;; Store backups in ~/.emacs.d/backups, not in current directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Enable version control
(setq version-control t)
(setq vc-make-backup-files t)

;; Delete highlighted text with keystroke
(delete-selection-mode 1)

;; Change minibuffer size
(setq resize-mini-windows t)
(setq max-mini-window-height 0.33)

;; Use yas for command completion
(yas-global-mode 1)

;; Add matching parentheses
;(require 'mic-paren)
;(paren-activate)
;(add-hook 'LaTeX-mode-hook
 ;          (function (lambda ()
  ;                     (paren-toggle-matching-quoted-paren 1)
   ;                    (paren-toggle-matching-paired-delimiter 1))))


;; Visual line mode when working with text files
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)



;; IDO mode for buffer navigation
(ido-mode 1)
(ido-mode 'buffers) ;; only use this line to turn off ido for file names!
(setq ido-ignore-buffers '("^ " "*Completions*" "*Shell Command Output*"
			   "*Messages*" "Async Shell Command"))




