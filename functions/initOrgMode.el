;; Initialization stuff for org-mode


(defun db-init-org-mode ()
  (let ()
    (message (format-time-string "**** db-init-org-mode start at: %H:%M:%S"))
    (setq
     ;; our 'official' stuff for org is directly inside the dropbox. so we
     ;; can rely on its up-to-date-ness
     ;;db-org-work-dir (concat db-dropbox-dir "/org")
     ;; TODO REMOVE     
     ;;org-directory (concat db-org-work-dir "/")
     org-enforce-todo-dependencies t
     ;; does it work?
     org-agenda-dim-blocked-tasks t
     org-log-done 'note
     org-log-into-drawer t     
;;     org-archive-location (concat db-dropbox-dir "~/org/archive/%s::2018")
     org-default-notes-file (db-org-child-of (db-org-work-dir) "generalNotes.org")
     org-agenda-files (list (eval (db-org-main-diary-dir) ))
     )
    (define-key global-map "\C-cc" 'org-capture)
    (global-set-key "\C-ca" 'org-agenda)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((sql . t)
       (emacs-lisp . t)
       (shell . t)
       ))
    ;; add additional languages with '((language . t)))
    ;; open directories in dired instead of the file explorer
    (add-to-list 'org-file-apps '(directory . emacs))
    ;; load all elisp files found in elisp folder of the dropbox org-mode root folder.
    ;; this allows to  have functions matching to the dropbox dir (if such a thing as a
    ;; dropbox-org-mode exists
    (let ((dropbox-init-dir (db-org-child-of (db-org-work-dir) "elisp" )))
      (if (file-exists-p dropbox-init-dir )
	  (progn
	    (message "init Dropbox code")	
	    (let ((load-it (lambda (f)
			     (message (format "load %s" f))
			     (load-file (concat (file-name-as-directory dropbox-init-dir) f)))
			   ))
	      (mapc load-it (directory-files dropbox-init-dir nil "\\.el$")))
	    ))
      )
    (db-init-load-machine-file-if-exists "initOrgMode.el")
    (message (format-time-string "**** db-init-org-mode done at %H:%M:%S"))))

