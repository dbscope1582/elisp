

(if (display-graphic-p)
    (progn
      (message "graphic ui")
      (custom-set-variables
;;       '(custom-enabled-themes (quote (tsdh-dark)))
       '(initial-buffer-choice "~/Dropbox/family/2020_new"))
      (db-theme-dark)
      )
  (progn
    ;; probably also set better colors
;;    (custom-set-variables
;;     '(custom-enabled-themes (quote (wheatgrass))))
    (db-theme-console)
    (mu4e)
    )
  )

;; auto revert mode (files modified on disk)
(global-auto-revert-mode 1)
;; auto refresh dired when file changes
(add-hook 'dired-mode-hook 'auto-revert-mode)



