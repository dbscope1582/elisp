
(defun db-org-diaries-dir ()
  (db-diaries-dir))

(defun db-org-main-diary-dir ()
  "The main diary dir is the diary dir for the current year"
  (db-org-child-of (db-org-diaries-dir) (format-time-string "%Y")))

(defun db-org-main-index-file ()
  (db-org-child-of (db-org-main-diary-dir) "index.org"))

(defun db-org-diary-path-today ( title)
  (interactive "stitle")
     (format "%s/%s%s%s.org"
	     (db-org-main-diary-dir)
	     (format-time-string "%m%d")
	     (db-org-string 'path-word-separator)
	     title)
     )


(defun db-file-path-to-clipboard ()
  "Put the current file name on the clipboard
Thanks to scottfrazer (https://stackoverflow.com/questions/2416655/file-path-to-clipboard-in-emacs/53075288)"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))


;; TODO append the stuff from the dropbox dir
(defun db-org-diary-path-today ( title)
  "build the diary-path for today and add the given title string"
  (interactive "stitle")
  (concat (file-name-as-directory(db-org-main-diary-dir))
	  (format "%s%s%s" (format-time-string "%m%d")
		  (db-org-string 'path-word-separator)
		  title)))



(defun db-org-new-diary-entry (title)
  "create a diary file (=> file name contains date) according to the given title
and link it with the current file"
  (interactive "sTitle: ")
  (let* (
	 ;;let the user choose an absoulte path
	 (absolute-dir (file-name-as-directory
			(read-directory-name "target directory: "
					     (db-org-main-diary-dir)
					     ;; "."
					     )))
	 ;;however we transform it into a relative path
	 ;; relative paths allow us to copy the entire file structure elsewhere
	 (relative-dir (file-relative-name absolute-dir))
	 ;;build the new file name according to the current date and the provided title
	 (file-name (format "%s%s%s.org"
			    (format-time-string "%m%d")
			    (db-org-string 'path-word-separator)
			    (mapconcat
			     'identity
			     (split-string title
					   (db-org-string 'text-word-separator))
			     (db-org-string 'path-word-separator))))
	 (source-file (buffer-file-name))
	 )
    ;; link the file 
    (insert (format "file:%s\n" (concat relative-dir file-name)))
    ;; create a new file, initialize it with its name as a title
    ;; and activate it
    (progn
      (find-file (concat absolute-dir file-name))
      ;; add a link to the file where the new file originates
      (if source-file
	  (insert (format "created out of: file:%s\n\n" (file-relative-name source-file)))
	)
    (insert "* ")
    (db-org-refactor-title-from-buffer-name)
    )
    ))


(defun db-org-refactor-copy-buffer-name ()
  (interactive)
  (kill-new (buffer-name) nil ))

(defun db-org-refactor-title-from-buffer-name ()
  (interactive)
  (insert (mapconcat
	   'identity
	   (cdr (split-string (car (split-string (buffer-name) "\\."))
			      (db-org-string 'path-word-separator)))
	   (db-org-string 'text-word-separator))))

(defun db-org-new-src (name)
  (interactive
   (list
    (let ((default-name "main"))
      (read-string (format "block name (%s)" default-name) nil nil default-name))))
  (insert (format "#+NAME: %s\n" name))
  (insert (format "  #+begin_src emacs-lisp :dir ~/docker/temp/%s/%s :results value file :file %s.txt"
		  (format-time-string "%Y")
		  (file-name-sans-extension (buffer-name))
		  name))
  (insert "\n  #+end_src\n"))
 
