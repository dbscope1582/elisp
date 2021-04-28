(defun db-theme-dark ()
  "switch to a dark theme"
  (interactive)
  (db-theme-load (cdr (db-default-themes)) ))

(defun db-theme-light ()
  (interactive)
  (db-theme-load (car (db-default-themes)) ))
(defun db-theme-console ()
  (interactive)
  (db-theme-load (db-default-console-theme)))

(defun db-theme-load (theme)
  (add-to-list 'custom-theme-load-path
             (file-name-as-directory "~/.emacs.d/replace-colorthemes"))
  (progn
    (load-theme theme t t)
    (enable-theme theme)
    (custom-theme-set-faces theme )
    )
  )


