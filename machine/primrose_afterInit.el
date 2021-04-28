;; prepare mu4e
(let ((mu4e-dir "/usr/share/emacs/site-lisp/mu4e/"))
  (add-to-list 'load-path mu4e-dir)
  (load (concat mu4e-dir "mu4e.el"))
  (load (concat (db-var-path 'elisp-dir) "init-mu4e.el"))
  )


(if (display-graphic-p)
    (progn
      (message "graphic ui")
      ;; not really sure if this is good, but it is a 
;;      (load-theme 'tsdh-dark)
      (custom-set-variables
       '(custom-enabled-themes (quote (tsdh-dark)))
       '(initial-buffer-choice "~/Dropbox/family/2020_new"))
      )
  (progn
    ;; probably also set better colors
    (custom-set-variables
     '(custom-enabled-themes (quote (wheatgrass))))
    (mu4e)
    )
  )




