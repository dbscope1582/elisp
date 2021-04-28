

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

;; auto revert mode (files modified on disk)
(global-auto-revert-mode 1)
;; auto refresh dired when file changes
(add-hook 'dired-mode-hook 'auto-revert-mode)



