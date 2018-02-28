;; Mac Emacs init file


;(add-to-list 'load-path "~/Dropbox/Mackup/.emacs.d/cl-lib/")
;(require 'cl-lib)

(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin/"))  
(setq exec-path (append exec-path '("/Library/TeX/texbin/")))


(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ("melpa" . "http://melpa.milkbox.net/packages/")
                  ))
    (add-to-list 'package-archives source t))
(package-initialize)
(setq package-list '(
		     ;alert
		     ;async
		     auctex
		     auctex-latexmk
		     biblio
		     ;biblio-core
		     ;cdlatex
		     ;ctags
		     ;dash
		     ;deferred
		     ;ecb
		     ;epl
		     exec-path-from-shell
		     ;f
		     ;flatui-theme
		     ;haskell-mode
		     ;helm
		     ;helm-bibtex
		     ;helm-core
		     ;hydra
		     ;intero
		     ;icicles
		     ;key-chord
		     ;latex-pretty-symbols
		     ;latex-preview-pane
		     latex-extra
		     ;let-alist
		     magic-latex-buffer
		     ;magit
		     matlab-mode
		     ;mic-paren
		     ;org
		     ;org-bullets
		     ;org-ref
		     ;ox-reveal		     
		     ;parsebib
		     pdf-tools ; Needed brew install automake autoconf glib poppler
		     ;pkg-info
		     ;popup
		     python
		     python-mode
		     pyvenv
		     pyenv-mode
		     ;s
		     smex
		     ;seq
		     ;use-package
		     yasnippet
 ))

(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;; ;; To open these, move the cursor over the string and use M-x RET ffap RET
(load "~/.emacs.d/myEmacs/myEmacs.el")
(load "~/.emacs.d/myEmacs/myLaTeX.el")
;; (load "~/.emacs.d/myEmacs/myOrg.el")
;; (load "~/.emacs.d/myEmacs/myCpp.el")
 (load "~/.emacs.d/myEmacs/myMatlab.el")
;; (load "~/.emacs.d/myEmacs/myHaskell.el")
;;(load "~/.emacs.d/myEmacs/myPython.el")




;; ;; Global key bindings
;; (global-set-key (kbd "C-x g") 'eval-buffer)
;; (global-set-key (kbd "C-x j") 'ffap)




;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(LaTeX-command "latex -shell-escape")
;;  '(TeX-command-default "LaTeX" t)
;;  '(TeX-command-list
;;    (quote
;;     (("latexmk_clean" "latexmk -c %s" TeX-run-TeX nil t :help "Run latexmk -c on file")
;;      ("LatexMk" "latexmk %S%(mode) %t" TeX-run-latexmk nil
;;       (plain-tex-mode latex-mode doctex-mode)
;;       :help "Run LatexMk")
;;      ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil
;;       (latex-mode doctex-mode)
;;       :help "Run LaTeX")
;;      ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX")
;;      ("Biber" "biber %s" TeX-run-Biber nil t :help "Run Biber")
;;      ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")
;;      ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
;;      ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files"))))
;;  '(TeX-source-correlate-start-server t)
;;  '(ansi-color-faces-vector
;;    [default default default italic underline success warning error])
;;  '(ansi-color-names-vector
;;    ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
;;  '(custom-enabled-themes (quote (flatui)))
;;  '(custom-safe-themes
;;    (quote
;;     ("bcc6775934c9adf5f3bd1f428326ce0dcd34d743a92df48c128e6438b815b44f" "3b24f986084001ae46aa29ca791d2bc7f005c5c939646d2b800143526ab4d323" default)))
;;  '(debug-on-error t)
;;  '(fci-rule-color "#f1c40f")
;;  '(hl-paren-background-colors (quote ("#2492db" "#95a5a6" nil)))
;;  '(hl-paren-colors (quote ("#ecf0f1" "#ecf0f1" "#c0392b")))
;;  '(org-agenda-files (quote ("~/Google Drive/flock/notes.org")))
;;  '(org-modules
;;    (quote
;;     (org-bbdb org-bibtex org-docview org-gnus org-info org-rmail org-w3m)))
;;  '(preview-auto-cache-preamble t)
;;  '(preview-gs-options
;;    (quote
;;     ("-q" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4")))
;;  '(quote (show-paren-mode t))
;;  '(safe-local-variable-values
;;    (quote
;;     ((TeX-command-extra-options . "-shell-escape")
;;      (TeX-engine . default-shell-escape)
;;      (org-export-babel-evaluate . t)
;;      (org-confirm-babel-evaluate))))
;;  '(save-place t nil (saveplace))
;;  '(show-paren-mode t)
;;  '(sml/active-background-color "#34495e")
;;  '(sml/active-foreground-color "#ecf0f1")
;;  '(sml/inactive-background-color "#dfe4ea")
;;  '(sml/inactive-foreground-color "#34495e")
;;  '(tool-bar-mode nil)
;;  '(tooltip-mode nil)
;;  '(uniquify-buffer-name-style nil nil (uniquify))
;;  '(vc-annotate-background "#ecf0f1")
;;  '(vc-annotate-color-map
;;    (quote
;;     ((30 . "#e74c3c")
;;      (60 . "#c0392b")
;;      (90 . "#e67e22")
;;      (120 . "#d35400")
;;      (150 . "#f1c40f")
;;      (180 . "#d98c10")
;;      (210 . "#2ecc71")
;;      (240 . "#27ae60")
;;      (270 . "#1abc9c")
;;      (300 . "#16a085")
;;      (330 . "#2492db")
;;      (360 . "#0a74b9"))))
;;  '(vc-annotate-very-old-color "#0a74b9")
;;  '(visual-line-mode t t))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
;; (put 'downcase-region 'disabled nil)


;; (message "Finished loading init file!!")
;; (put 'erase-buffer 'disabled nil)
