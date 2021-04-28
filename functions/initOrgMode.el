;; Initialization stuff for org-mode


(defun db-init-org-mode ()
  (let ()
    (message (format-time-string "**** db-init-org-mode start at: %H:%M:%S"))
    (setq
     org-enforce-todo-dependencies t
     ;; does it work?
     org-agenda-dim-blocked-tasks t
     org-log-done 'note
     org-log-into-drawer t     
     org-default-notes-file (db-org-child-of (db-org-work-dir) "generalNotes.org")
     org-agenda-files (list (eval (db-org-main-diary-dir) ))
     )
    (setq org-use-property-inheritance t)
    (define-key global-map "\C-cc" 'org-capture)
    (global-set-key "\C-ca" 'org-agenda)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((sql . t)
       (emacs-lisp . t)
       (shell . t)
       (awk . t)
       (sed . t)
       ))
    ;; add additional languages with '((language . t)))
    ;; open directories in dired instead of the file explorer
    (add-to-list 'org-file-apps '(directory . emacs))
    ;; load all elisp files found in elisp folder of the diaries folder.
    ;; this allows to  have functions matching to the dropbox dir (if such a thing as a
    ;; dropbox-org-mode exists
    (let ((dropbox-init-dir (db-org-child-of (db-diaries-dir) "elisp" )))
      (if (file-exists-p dropbox-init-dir )
	  (progn
	    (message "init diaries code")	
	    (let ((load-it (lambda (f)
			     (message (format "load %s" f))
			     (load-file (concat (file-name-as-directory dropbox-init-dir) f)))
			   ))
	      (mapc load-it (directory-files dropbox-init-dir nil "\\.el$")))
	    )
	(message (format "%s does not exist" dropbox-init-dir)))
      )
    (db-init-load-machine-file-if-exists "initOrgMode.el")
    (message (format-time-string "**** db-init-org-mode done at %H:%M:%S"))))

