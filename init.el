
(defun db-init-my-hooks ()
  "create diverse hooks"
  (let ()
    (message "db-init-my-hooks start")
    (add-hook
     'org-mode-hook
     '(lambda ()
	(load (concat db-elisp-dir "initOrgMode.el"))
	(db-init-org-mode)))
    (add-hook
     'org-after-todo-statistics-hook
     'db-book-org-summary-todo)
    (message "db-init-my-hooks end")
    ))

  
(defun db-init-emacs ()
  "some basic overall initialisation stuff"
  (setq
    mac-option-key-is-meta nil
    mac-command-key-is-meta t
    mac-command-modifier 'meta
    mac-option-modifier 'none
    calendar-week-start-day 1
    calendar-latitude 47.5394
    calendar-longitude 7.59
    )
  (let ()    
    (db-init-my-hooks)
    (message "db-init-emacs done")
    ))



(defun db-init-load-machine-file-if-exists (file-name)
  "load an additional (machine dependent) initialisation file. 
because my current elisp skills are almost dead, we hardcode the full path
Finally it should be in a subdirectory of this file named 'machine'"
  (let ((machine-file-name (concat db-elisp-dir "machine/" (car (split-string (downcase (system-name)) "\\.")) "_" file-name)))
    (if (file-exists-p machine-file-name)
	(load-file machine-file-name)
      (message (concat machine-file-name " does not exist"))
      )))

;; this is whre things start
(db-init-emacs)
(message "my stuff has been initialized")
