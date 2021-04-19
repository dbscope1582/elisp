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
    db-dropbox-diaries-dir (format "%s/diaries" db-dropbox-dir)
    ;; the separator between words in diray file names
    db-dropbox-path-word-separator "_"
    ;; replace beep with a visual clue (experimental maybe remove again
    visible-bell 1
    ;; completely remove any bell (probably the good one
    ;;ring-bell-function 'ignore 
    )
  (let ()    
    (db-init-my-hooks)
    ;; add the recentfile list to the file menu
    (recentf-mode)
    (show-paren-mode)
    (linum-mode)
    (when (>= emacs-major-version 24)
      (require 'package)
      ;; (add-to-list
      ;;  'package-archives
      ;;  '("melpa-milkbox" . "http://melpa.milkbox.net/packages/"))
      (add-to-list
       'package-archives
       '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
       )
      ;; do not call it always
       ;;(package-refresh-contents)
       )
    (db-install-package
     '( magit
	))
    (message "db-init-emacs done")
    ))

(defun db-init-my-hooks ()
  "create diverse hooks"
  (let ()
    (message "db-init-my-hooks start")
    ;; customization of org mode
    (add-hook
     'org-mode-hook
     '(lambda ()
	;;not needed anymore it will be preloaded
	(db-init-org-mode)))
    (add-hook
     'org-after-todo-statistics-hook
     'db-book-org-summary-todo )
    (add-hook
     'text-mode-hook 'turn-on-auto-fill)
    ;; configure dired
    ;; turn details off by default 
    (add-hook 'dired-mode-hook
	      (lambda ()
		(dired-hide-details-mode)
		(auto-revert-mode)))
    (db-init-load-machine-file-if-exists "initHooks.el")
    (message "db-init-my-hooks end")
    ))


(defun db-machine-file-name (file-name)
  "check if a machine specific file exists"
  (format "%s/machine/%s_%s"
	  (db-var-path 'elisp-dir)
	  (car (split-string (downcase (system-name)) "\\."))
	  file-name))

(defun db-init-load-machine-file-if-exists (file-name)
  "load an additional (machine dependent) initialisation file. 
because my current elisp skills are almost dead, we hardcode the full path
Finally it should be in a subdirectory of this file named 'machine'"
  (let ((machine-file-name (db-machine-file-name file-name)))
    (if (file-exists-p machine-file-name)
	(progn
	  (message (format "load file: %s - begin" machine-file-name))
	  (load-file machine-file-name)
	  (message (format "load file: %s - end" machine-file-name)))
      (message (concat machine-file-name " does not exist"))
      )))

(defun db-install-package (packages)
  "make sure an (emacs) package is available"
  (mapcar (lambda (package)
	    (unless (package-installed-p package)
	      (package-install package)
	      (package-install package)
	      (require package )))
	  packages
    ))

