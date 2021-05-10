;; define some variables we will need

(setq
 db-vars (list
	  ;; will be set in db-init-vars
	  'elisp-dir "initialize me with db-init-vars"
	  'dropbox-dir "initialize me"
	  'diary-dir "initialize me"
	  'light-theme 'infodoc
	  'dark-theme 'tsdh-dark
	  'console-theme 'wheatgrass
	  'packages '( magit
		       org-noter
		       which-key)
	  )
 db-org-vars (list
	      'work-dir "iniitialize me"
	      'path-word-separator "_"
	      'text-word-separator " "))

(defun db-property (property) (plist-get db-vars property))

(defun db-org-property (property) (plist-get db-org-vars property))

(defun db-var-path (key)
  (interactive)
  (file-name-as-directory (db-property key)))


(defun db-org-work-dir () (interactive) (db-org-path 'work-dir))
(defun db-diaries-path-word-separator () (interactive) (db-org-string 'path-word-separator))
(defun db-diaries-dir () (interactive) (db-var-path 'diary-dir))
;;probaly not dead. It is used for mobile.org
(defun org-directory () "org-direcgtory is an old name for 'work-dir'" (db-org-path 'work-dir))

(defun db-default-themes ()
  (interactive)
  (cons
   (db-property 'light-theme)
   (db-property 'dark-theme))
  )

(defun db-default-console-theme()
  (interactive)
  (db-property 'console-theme))


(defun db-org-child-of (parent child)
  "concatenates the items parent - child to a directory"
  (concat (file-name-as-directory parent) child ))


(defun db-org-path (key)
  "return the value for the provided key as path"
  (interactive)
  (file-name-as-directory (db-org-property key)))


(defun db-org-string (key)
  "return the value for the provided key"
  (interactive "")
  (format "%s" (db-org-property key)))

(defun db-org-sub-path (&rest folders)
  (defun inner (acc folders)
    (if folders
	(inner
	 (concat (file-name-as-directory acc) (car folders))
	 (cdr folders))
      acc))
  (inner (db-org-path 'work-dir) folders))



(defun db-init-vars (elisp-root-dir)
  
  (setq db-vars (plist-put db-vars 'elisp-dir elisp-root-dir))
  (setq db-vars (plist-put db-vars 'dropbox-dir "~/Dropbox"))
  (setq db-vars (plist-put db-vars
			   'diary-dir
			   (db-org-child-of (db-var-path 'dropbox-dir) "diaries")))

  ;; not really convinced/sure that this directory is of any use
  (setq db-org-vars (plist-put db-org-vars
			       'work-dir
			       (db-org-child-of (db-var-path 'dropbox-dir) "org")))


  ;; provide a mean to overwrite everything
  (db-init-load-machine-file-if-exists "initVars.el")
)



