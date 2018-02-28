;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-mode settings 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)
;; Set to the location of your Org files on your local system
(setq org-directory "~/Dropbox/org-mode/")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/org-mode/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/mobileorg/")


;; Enable CDLaTeX mode in Org by default
(add-hook 'org-mode-hook 'org-cdlatex-mode)

;; Add flyspell to org-mode
(add-hook 'org-mode-hook 'flyspell-mode)


;;(setq org-indent-mode t)
(setq org-startup-indented t)
(setq delete-old-versions t)


; Change org-mode's ... for folded code to something more useful
(setq org-ellipsis "⤵")

;; org-mode keys
(defun my-org-mode-keys ()
  "My keys for org-mode."
  (interactive)
  (local-set-key (kbd "C-c 1")   'helm-bibtex-custom-menu)
  (local-set-key (kbd "C-c '")   'org-edit-src-code)
  )
(add-hook 'org-mode-hook 'my-org-mode-keys)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-mode for Beamer Export
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
  ;; beamer class, for presentations
  '("beamer"
     "\\documentclass[11pt]{beamer}\n
      \\mode<{{{beamermode}}}>\n
      \\usetheme{{{{beamertheme}}}}\n
      \\usecolortheme{{{{beamercolortheme}}}}\n
      \\beamertemplateballitem\n
      \\setbeameroption{show notes}
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{hyperref}\n
      \\usepackage{color}
      \\usepackage{listings}
      \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
  frame=single,
  basicstyle=\\small,
  showspaces=false,showstringspaces=false,
  showtabs=false,
  keywordstyle=\\color{blue}\\bfseries,
  commentstyle=\\color{red},
  }\n
      \\usepackage{verbatim}\n
      \\institute{{{{beamerinstitute}}}}\n          
       \\subject{{{{beamersubject}}}}\n"

     ("\\section{%s}" . "\\section*{%s}")
     
     ("\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}"
       "\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}")))

  ;; letter class, for formal letters
  (add-to-list 'org-export-latex-classes
  '("letter"
     "\\documentclass[11pt]{letter}\n
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{color}"
     
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

 (add-to-list 'org-export-latex-classes
 '("org-article"
               "\\documentclass{org-article}
                 [NO-DEFAULT-PACKAGES]
                 [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

   ;; songFormat for songs
 (add-to-list 'org-export-latex-classes
    '("songbookForm"
        "\\documentclass{article} 
\\usepackage{guitar} 
\\usepackage{hyperref}
         [NO-DEFAULT-PACKAGES]
         [NO-PACKAGES]
         [NO-EXTRA]"
	("\\section{%s}" . "\\section*{%s}")
	("\\subsection{%s}" . "\\subsection*{%s}")
	("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	))

   ;; article
 (add-to-list 'org-export-latex-classes
    '("article"
        "\\documentclass{article} 
\\usepackage[utf8]{inputenc}\n
\\usepackage[T1]{fontenc}\n
\\usepackage{microtype}
\\usepackage{hyperref}
         [NO-DEFAULT-PACKAGES]
         [PACKAGES]
         [EXTRA]"
	("\\section{%s}" . "\\section*{%s}")
	("\\subsection{%s}" . "\\subsection*{%s}")
	("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	))







(setq org-src-fontify-natively t)

(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))


; Load languages for Babel evaluation
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (python . t)
   (latex  . t)
   (matlab . t)
  ))


; Org bullets to use bullets instead of asterisks
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode t)))

; Use variable-width fonts in org mode
;(add-hook 'org-mode-hook (lambda () (variable-pitch-mode nil)))


; Update default fonts, weightings, etc.
;'(org-agenda-date ((t (:inherit org-agenda-structure :weight semi-bold :height 1.2))) t)
;'(org-date ((t (:foreground "Purple" :underline t :height 0.8 :family "Helvetica Neue"))))
'(org-done ((t (:weight light))))
;'(org-level-1 ((t (:weight semi-bold :height 1.2 :family "Helvetica Neue"))))
'(org-level-2 ((t (:inherit outline-2 :weight semi-bold :height 1.1))))
;'(org-level-3 ((t (:inherit outline-3 :weight bold :family "Helvetica Neue"))))
;'(org-level-5 ((t (:inherit outline-5 :family "Helvetica Neue"))))
'(org-link ((t (:inherit link :weight normal))))
'(org-meta-line ((t (:inherit font-lock-comment-face :height 0.8))))
;'(org-property-value ((t (:height 0.9 :family "Helvetica Neue"))) t)
;'(org-special-keyword ((t (:inherit font-lock-keyword-face :height 0.8 :family "Helvetica Neue"))))
;'(org-table ((t (:foreground "dim gray" :height 0.9 :family "Menlo"))))
'(org-tag ((t (:foreground "dark gray" :weight bold :height 0.8))))
'(org-todo ((t (:foreground "#e67e22" :weight bold))))


;;;;;;;;;;;;;;;;;
;; For org-reveal
;;;;;;;;;;;;;;;;;
(require 'ox-latex)
(use-package ox-reveal :ensure ox-reveal)

(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq org-reveal-mathjax t)

(require 'org)
(let ((current-prefix-arg 1))
  (call-interactively 'org-reload))

(use-package htmlize :ensure t)

;;;;;;;;;;;;;;;;;;
;; Reload org mode
;;;;;;;;;;;;;;;;;;
;(org-reload 1)
