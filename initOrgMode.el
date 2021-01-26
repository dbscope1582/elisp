;; initialization stuff for org-mode

(defun db-init-org-mode ()
  (let ()
    (message "db-init-org-mode start")
    (setq
     ;; our 'official' stuff for org is directly inside the dropbox. so we
     ;; can rely on its up-to-date-ness
     db-org-work-dir (concat db-dropbox-dir "/org")
     org-directory (concat db-org-work-dir "/")
     org-enforce-todo-dependencies t
     ;; does it work?
     org-agenda-dim-blocked-tasks t
     org-log-done 'note
     org-log-into-drawer t     
     org-archive-location (concat db-dropbox-dir "~/org/archive/%s::2018")
     org-default-notes-file (concat db-org-work-dir "generalNotes.org")
     )
    (define-key global-map "\C-cc" 'org-capture)
    (global-set-key "\C-ca" 'org-agenda)
    ;; open directories in dired instead of the file explorer
    (add-to-list 'org-file-apps '(directory . emacs)) 
    (db-init-load-machine-file-if-exists "initOrgMode.el")
    (message "db-init-org-mode done")))

