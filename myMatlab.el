;;;;;;;;;;;;;;;;;;
;; Matlab
;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/matlab")
(load-library "/Applications/Emacs.app/Contents/Resources/lisp/emacs-lisp/eieio.elc")
(load-library "matlab-load")
(setq matlab-show-mlint-warnings t)
(setq mlint-programs '("/Applications/MATLAB_R2016a.app/bin/maci64/mlint"))
