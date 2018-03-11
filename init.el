;; repair the mac-keys
;; (setq
;;    mac-option-key-is-meta nil
;;    mac-command-key-is-meta t
;;    mac-command-modifier 'meta
;;    mac-option-modifier 'none
;;    calendar-week-start-day 1)

(defun db-init-my-hooks ()
  "create diverse hooks"
  (let ()
    (add-hook
     'org-mode-hook
     '(lambda ()
	(load "~/myElisp/initOrgMode.el")
	(db-init-org-mode)))
    (add-hook
     'org-after-todo-statistics-hook
     'db-book-org-summary-todo)
    ))

  
(defun db-init-emacs ()
  "some basic overall initialisation stuff"
  (setq
    mac-option-key-is-meta nil
    mac-command-key-is-meta t
    mac-command-modifier 'meta
    mac-option-modifier 'none
    calendar-week-start-day 1)
  (let ()    
    (db-init-my-hooks)
    (message "db-init-emacs done")
    ))



;; this is whre things start
(db-init-emacs)
(message "my stuff has been initialized")
