
;; Haskell MODE
(add-hook 'haskell-mode-hook 'haskell-indent-mode)
;(add-hook 'haskell-mode-hook 'flycheck-mode)
;(add-hook 'haskell-mode-hook 'intero-mode)


;; Add import shortcut
;(eval-after-load 'haskell-mode
;          '(define-key haskell-mode-map C-x 'haskell-navigate-imports))



;; Define new keyboard commands
(defun my-haskell-mode-keys ()
  "My keys for latex-mode."
  (interactive)
  (local-set-key (kbd "C-x g") 'magit-status)
  )

(add-hook 'LaTeX-mode-hook 'my-haskell-mode-keys) ;; Custom keyboard commands


(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))
;(custom-set-variables '(haskell-tags-on-save t))




;; See the tutorial at 
;;   https://github.com/serras/emacs-haskell-tutorial/blob/master/tutorial.md
;; for more information
