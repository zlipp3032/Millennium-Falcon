;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;         Python configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(require 'package)

;(add-to-list 'package-archives
 ;      '("melpa" . "http://melpa.org/packages/") t)

;(package-initialize)
;(when (not package-archive-contents)
 ; (package-refresh-contents))

;(defvar myPackages
  ;'(better-defaults
 ;   ein
;    elpy
   ; flycheck
  ;  material-theme
 ;   py-autopep8))

;(mapc #'(lambda (package)
   ; (unless (package-installed-p package)
  ;    (package-install package)))
 ;     myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

;; PYTHON CONFIGURATION
;; --------------------------------------

;(elpy-enable)
;(elpy-use-ipython)

;; use flycheck not flymake with elpy
;(when (require 'flycheck nil t)
 ; (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
 ; (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
;(require 'py-autopep8)
;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;-------------------;
;;; Auto-Complete ;;;
;-------------------;

(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1")
(require 'auto-complete) 
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config) 
(ac-config-default)
(global-auto-complete-mode t)

(provide 'auto-complete-settings)

;------------------------;
;;; Python Programming ;;;
;------------------------;

; python-mode
(setq py-install-directory "~/.emacs.d/python-mode-6.0.11")
(add-to-list 'load-path py-install-directory)
(require 'python-mode) 

; use IPython
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
; use the wx backend, for both mayavi and matplotlib
(setq py-python-command-args 
  '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
(setq py-force-py-shell-name-p t)

; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
; don't split windows
(setq py-split-windows-on-execute-p nil)
; try to automagically figure out indentation
(setq py-smart-indentation t)

; pymacs
(add-to-list 'load-path "~/.emacs.d/pymacs-0.25")
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")
(setq py-load-pymacs-p t)

; ropemacs
;(require 'pymacs)
;(pymacs-load "ropemacs" "rope-")

(provide 'python-settings)

;-------------------------;
;;; Syntax Highlighting ;;;
;-------------------------;

; text decoration
(require 'font-lock)
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)
(global-hi-lock-mode nil)
(setq jit-lock-contextually t)
(setq jit-lock-stealth-verbose t)

; if there is size information associated with text, change the text
; size to reflect it
(size-indication-mode t)

; highlight parentheses when the cursor is next to them
(require 'paren)
(show-paren-mode t)

(provide 'text-settings)

;--------------------;
;;; User Interface ;;;
;--------------------;

; always use spaces, not tabs, when indenting
(setq indent-tabs-mode nil)
 
; ignore case when searching
(setq case-fold-search t)

; require final newlines in files when they are saved
(setq require-final-newline t)

; window modifications
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

; set the keybinding so that you can use f4 for goto line
(global-set-key [f4] 'goto-line)

(provide 'ui-settings)

;-----------------------------;
;;; Interactively Do Things ;;;
;-----------------------------;

(require 'ido)
(ido-mode t)

(provide 'ido-settings)

;----------------------;
;;; Windows & Frames ;;;
;----------------------;

; language
(setq current-language-environment "English")

; don't show the startup screen
(setq inhibit-startup-screen t)
; don't show the menu bar
(menu-bar-mode nil)
; don't show the tool bar
(require 'tool-bar)
(tool-bar-mode nil)
; don't show the scroll bar
(scroll-bar-mode nil)

; number of characters until the fill column 
(setq fill-column 70)

; specify the fringe width for windows -- this sets both the left and
; right fringes to 10
(require 'fringe)
(fringe-mode 10)

; lines which are exactly as wide as the window (not counting the
; final newline character) are not continued. Instead, when point is
; at the end of the line, the cursor appears in the right fringe.
(setq overflow-newline-into-fringe t)

; each line of text gets one line on the screen (i.e., text will run
; off the left instead of wrapping around onto a new line)
(setq truncate-lines t)
; truncate lines even in partial-width windows
(setq truncate-partial-width-windows t)

; display line numbers to the right of the window
(global-linum-mode t)
; show the current line and column numbers in the stats bar as well
(line-number-mode t)
(column-number-mode t)

(provide 'window-settings)

;-----------------;
;;; Color Theme ;;;
;-----------------;

; use the "Subtle Hacker" color theme as a base for the custom scheme
;(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
;(require 'color-theme)
;(color-theme-initialize)
;(setq color-theme-is-global t)
;(color-theme-subtle-hacker)

;(custom-set-faces
; '(default ((t (:inherit nil :stipple nil :background "gray2" :foreground "#FFF991" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 83 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
; '(border ((t nil)))
; '(cursor ((t (:background "firebrick1" :foreground "black"))))
; '(font-lock-comment-delimiter-face ((default (:inherit font-lock-comment-face :weight ultra-bold)) (((class color) (min-colors 16)) nil)))
; '(font-lock-comment-face ((t (:foreground "lime green"))))
; '(font-lock-doc-face ((t (:foreground "tomato" :slant italic))))
; '(font-lock-function-name-face ((t (:foreground "deep sky blue" :underline t :weight bold))))
; '(font-lock-keyword-face ((t (:foreground "gold" :weight bold))))
; '(font-lock-string-face ((t (:foreground "tomato" :slant italic))))
; '(fringe ((nil (:background "black"))))
; '(highlight ((t (:background "khaki1" :foreground "black" :box (:line-width -1 :color "firebrick1")))))
; '(highlight-current-line-face ((t (:inherit highlight))))
; '(lazy-highlight ((t (:background "paleturquoise" :foreground "black"))))
; '(link ((t (:foreground "DodgerBlue3" :underline t))))
; '(menu ((t (:background "gray2" :foreground "#FFF991"))))
; '(minibuffer-prompt ((t (:foreground "royal blue"))))
; '(mode-line ((t (:background "dark olive green" :foreground "dark blue" :box (:line-width -1 :color "gray75") :weight bold))))
; '(mode-line-buffer-id ((t (:background "dark olive green" :foreground "beige"))))
; '(mode-line-highlight ((((class color) (min-colors 88)) nil)))
; '(mode-line-inactive ((t (:background "dark olive green" :foreground "dark khaki" :weight light))))
; '(mouse ((t (:background "Grey" :foreground "black"))))
 ;'(trailing-whitespace ((((class color) (background dark)) (:background "firebrick1")))))

; make sure the frames have the dark background mode by default
;(setq default-frame-alist (quote (
;  (frame-background-mode . dark)
;)))

;(provide 'color-theme-settings)

;------------;
;;; Cursor ;;;
;------------;

; highlight the current line
;(add-to-list 'load-path "~/.emacs.d/highlight-current-line-0.57")
;(require 'highlight-current-line)
;(global-hl-line-mode t)
;(setq highlight-current-line-globally t)
;(setq highlight-current-line-high-faces nil)
;(setq highlight-current-line-whole-line nil)
;(setq hl-line-face (quote highlight))

; don't blink the cursor
;(blink-cursor-mode nil)

; make sure transient mark mode is enabled (it should be by default,
; but just in case)
;(transient-mark-mode t)

; turn on mouse wheel support for scrolling
;(require 'mwheel)
;(mouse-wheel-mode t)

;(provide 'cursor-settings)

;---------------------------;
;;; Fill Column Indicator ;;;
;---------------------------;

;(add-to-list 'load-path "~/.emacs.d/fill-column-indicator-1.83")
;(require 'fill-column-indicator)
;(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
;(global-fci-mode t)

;(provide 'fill-column-indicator-settings)

