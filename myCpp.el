;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; C++ commands
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; Add *.cpe files to cpp-mode for Arduino / Quadcopter syntax coloring
;; (add-to-list 'auto-mode-alist '("\\.pde\\'" . cpp-mode))

;; ;; Add Tags to code
;; (require 'ctags)
;; (global-set-key (kbd "M-.")  'ctags-search)
;; (setq tags-revert-without-query t)
;; (global-set-key (kbd "<f7>") 'ctags-create-or-update-tags-table)

;; (setq path-to-ctags "~/Documents/ardupilot-master/") ;; <- your ctags path here
;; (defun create-tags (dir-name)
;; p  "Create tags file."
;;   (interactive "Directory: ")
;;   (shell-command
;;    (format "ctags -f %s -e -R %s" path-to-ctags (directory-file-name dir-name)))
;; )

(require 'flymake)


(defun my-c-mode-keys ()
  "My keys for latex-mode."
  (interactive)
  (local-set-key (kbd "C-x l") 'flymake-display-err-menu-for-current-line)
  (local-set-key (kbd "C-x n") 'flymake-goto-next-error))
  
(add-hook 'c-mode-hook 'my-c-mode-keys) ;; Custom keyboard commands
(add-hook 'cpp-mode-hook 'my-c-mode-keys)

(add-hook 'c-mode-hook 'flymake-mode) ;; Custom keyboard commands
(add-hook 'cpp-mode-hook 'flymake-mode)

