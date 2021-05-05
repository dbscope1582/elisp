
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
  "create an org-link for a new diary entry. 
The link includes the current day und a title. All blanks in the given title are replaced with underscores"
  (interactive "stitle:")
  (let ((file (db-org-diary-path-today
	       (mapconcat
		'identity
		(split-string title
			      (db-org-string 'text-word-separator))
			      (db-org-string 'path-word-separator)))))
    (insert (format "#+include: \"%s\"\n" file))
    (insert "#+begin_comment\n")
    (insert (format "file:%s\n" file))
    (insert "#+end_comment\n")
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
 
