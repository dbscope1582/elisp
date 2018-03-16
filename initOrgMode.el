;; initialization stuff for org-mode

(defun db-init-org-mode ()
  (let ()
    (message "db-init-org-mode start")
    (setq
     db-org-work-dir "~/Documents/org/"
     org-directory db-org-work-dir
     org-enforce-todo-dependencies t
     ;; does it work?
     org-agenda-dim-blocked-tasks t
     org-log-done 'note
     org-log-into-drawer t     
     org-archive-location "archive/%s::2018"
     org-default-notes-file (concat db-org-work-dir "generalNotes.org")
     ;; the physical directory created by dropbox for its syncing
     org-mobile-directory "~/Dropbox/MobileOrg"
     ;; just an arbitrary file name: org-mode creates it and uses it
     org-mobile-inbox-for-pull "~/OrgMobileInboxForPull"
     )
    (define-key global-map "\C-cc" 'org-capture)
    (global-set-key "\C-ca" 'org-agenda)
    (db-init-load-machine-file-if-exists "initOrgMode.el")
    (message "db-init-org-mode done")))



(defun db-book-org-summary-todo (n-done n-not-done)
  "switch entry to DONE when all subentires are done, otehrwise switch to TODO"
  (let (org-log-done org-log-states)
    (org-todo
     (if (= n-not-done 0)
	 "DONE"
       "TODO"))))
