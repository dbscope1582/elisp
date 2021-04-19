;; define some variables we will need

;; WO IST WOKR-DIR DEFINIERT? 
  (setq
   db-vars (list
	    'elisp-dir "initialize me with db-init-vars"
	    'dropbox-dir "~/Dropbox")
   db-org-vars (list
		'const-diaries "diaries"
		'const-org "org"
		'path-word-separator "_"
		'text-word-separator " "))

(defun db-dropbox-dir () (interactive) (db-var-path 'dropbox-dir))
(defun db-org-work-dir () (interactive) (db-org-path 'work-dir))
;;probaly not dead. It is used for mobile.org
(defun org-directory () "org-direcgtory is an old name for 'work-dir'" (db-org-path 'work-dir))


       
(defun db-var-path (key)
  (interactive)
  (file-name-as-directory (plist-get db-vars key)))

(defun db-org-path (key)
  "return the value for the provided key as path"
  (interactive)
  (file-name-as-directory (plist-get db-org-vars key)))

(defun db-org-string (key)
  "return the value for the provided key"
  (interactive "")
  (format "%s" (plist-get db-org-vars key)))

(defun db-org-sub-path (&rest folders)
  (defun inner (acc folders)
    (if folders
	(inner
	 (concat (file-name-as-directory acc) (car folders))
	 (cdr folders))
      acc))
  (inner (db-org-path 'work-dir) folders))

(defun db-org-child-of (parent child)
  "concatenates the items parent - child to a directory"
  (concat (file-name-as-directory parent) child ))


(defun db-init-vars (elisp-root-dir)
  ;; (setq my-plist (plist-put my-plist 'foo 69))
;;  (setq db-org-vars (plist-put db-org-vars
;;			       'org-directory
;;			       (db-org-concat-path 'work-dir  db-dropbox-dir) "org")))
  (setq db-vars (plist-put db-vars 'elisp-dir elisp-root-dir))
  ;; provide a mean to overwrite everything
  (db-init-load-machine-file-if-exists "initVars.el")
)



