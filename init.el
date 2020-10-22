
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
     'db-book-org-summary-todo )
    (add-hook
     'text-mode-hook 'turn-on-auto-fill)
    ;;(add-hook 'text-mode-hook
    ;;(lambda ()
    ;;  (when (y-or-n-p "Auto Fill mode? ")
    ;;    (turn-on-auto-fill))))
    (load (concat db-elisp-dir "lorem-ipsum.el"))
    (db-init-load-machine-file-if-exists "initHooks.el")
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
    ;; the assumed dropbox dir is in the home dir
    db-dropbox-dir "~/Dropbox"
    )
  (let ()    
    (db-init-my-hooks)
    ;; add the recentfile list to the file menu
    (recentf-mode)
    (show-paren-mode)
    (linum-mode)
    (when (>= emacs-major-version 24)
      (require 'package)
      (add-to-list
       'package-archives
       ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
       '("melpa" . "http://melpa.milkbox.net/packages/")
       t))
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
