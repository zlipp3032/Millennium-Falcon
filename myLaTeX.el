
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;         LaTeX configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load AucTeX
(load "auctex.el" nil t t)

;; Add path for latexmk %%%
(setenv "PATH" (concat (getenv "PATH") ":/usr/texbin"))

(require 'tex)


;; Turn off minor modes
(defun turn-off-minor-modes ()
  "Turn off iimage-mode and auto-fill minor modes"
  (interactive)
  (iimage-mode -1)
  (auto-fill-mode -1)
  (message "Turned off those stupid modes!")
  )
;(eval-after-load 'LaTeX-mode
;  (turn-off-minor-modes))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))



;; Define new keyboard commands
(defun my-latex-mode-keys ()
  "My keys for latex-mode."
  (interactive)
  (local-set-key (kbd "C-x h") 'helm-bibtex-custom-menu)
  (local-set-key (kbd "C-x r") 'reftex-change-label)
  (local-set-key (kbd "C-l")   'recenter-top-bottom)
  (local-set-key (kbd "C-x e") 'TeX-next-error)
  (local-set-key (kbd "C-x g") 'magit-status)
  (local-set-key (kbd "C-c 3") 'turn-off-minor-modes)
;  (local-set-key (kbd "C-c u") 'LaTeX-find-matching-begin)
;  (local-set-key (kbd "C-c d") 'LaTeX-find-matching-end)
  )

;; Add pdf-tools
(pdf-tools-install)

;; Electric brackets
(setq TeX-electric-sub-and-superscript nil)

;; Add latex-mode for *.tikz files
(add-to-list 'auto-mode-alist '("\\.tikz\\'" . latex-mode))

;; magic-LaTeX-buffer 
(require 'magic-latex-buffer)
(add-hook 'LaTeX-mode-hook 'magic-latex-buffer)
;(setq magic-latex-enable-block-highlight nil
;      magic-latex-enable-suscript        t
;      magic-latex-enable-pretty-symbols  t
(setq magic-latex-enable-block-align     nil )
(setq magic-latex-enable-inline-image    nil )
;      magic-latex-enable-minibuffer-echo nil)

;; Do not ask to confirm when cleaning or compiling files
(setq TeX-clean-confirm nil)
(setq TeX-save-query nil)

;; LaTeX major mode commands
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;; Skim PDF viewer
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -g %n %o %b")))

;; PDF Tools embedded viewer
;(setq TeX-view-program-selection
;      '((output-pdf "PDF Tools")
;       (output-pdf "PDF Viewer"))
;      TeX-source-correlate-start-server t)
;(setq TeX-view-program-list
;    '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -g %n %o %b")
;	("PDF Tools" )))
      
(add-hook 'TeX-after-TeX-LaTeX-command-finished-hook
	  #'TeX-revert-document-buffer)



;; Hooks
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook #'latex-extra-mode)  ;; LaTeX-extra package for more customizations
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook '(lambda () (setq TeX-command-default "LaTeX")))
(add-hook 'LaTeX-mode-hook 'my-latex-mode-keys) ;; Custom keyboard commands
;(remove-hook 'LaTeX-mode-hook 'auto-fill-mode)




;; Add RefTeX support for citations
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

;; use \eqref autocompletion
(setq reftex-label-alist '((nil ?e nil "~\\eqref{%s}" nil nil))) 
(add-hook 'LaTeX-mode-hook
      '(lambda ()
         (TeX-add-symbols '("eqref" TeX-arg-ref (ignore)))))


;; Add latexmk
(add-to-list 'load-path "~/.emacs.d/elpa/auctex-latexmk-20140904.1918/")
(require 'auctex-latexmk)
(auctex-latexmk-setup)





;; Change minor mode keys
(progn
  (require 'iimage)
  (define-key iimage-mode-map (kbd "C-l") 'recenter-top-bottom)
  ;(require 'latex-extra)
  ;(define-key latex-extra-mode-map (kbd "<backtab>") nil)
  )


;; Stacked snippets
(setq yas/triggers-in-field t)


(add-hook 'LaTeX-mode-hook ( lambda () (auto-fill-mode -1)))


;; ;; Add helm-bibtex for bibliography management
;; (autoload 'helm-bibtex "helm-bibtex" "" t)
;; (require 'helm)
;; (setq bibtex-completion-bibliography '("~/Dropbox/LaTeX/common/bib_flock.bib"))
;; (setq bibtex-completion-library-path '("~/Dropbox/LaTeX/common/pdf_source/"))
;; (setq bibtex-completion-notes-path "~/Dropbox/LaTeX/common/bib_flock.org")
;; (setq bibtex-completion-pdf-open-function
;;   (lambda (fpath)
;;     (call-process "open" nil 0 nil "-a" "/Applications/Skim.app" fpath)))

;; ;; helm-bibtex functions opens a new window or resumes
;; (defun helm-bibtex-custom-menu ()
;;   "Opens a new helm-bibtex session or resumes current one"
;;   (interactive)
;;   (if (get-buffer "*helm bibtex*")
;;     (progn
;;       (message "Resuming helm-bibtex")
;;       (helm-resume () ))
;;     (progn
;;       (message "Starting helm-bibtex")
;;       (helm-bibtex))))




