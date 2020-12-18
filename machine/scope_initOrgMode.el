;; initialisation for computers in the context of scope


(let ((scorpio-documents-root (concat db-dropbox-dir "/diaries/2018/scorpio" )))
  (let ((scorpio-todo-file (concat scorpio-documents-root "/todo.org" ))
	(dummy-temp (concat scorpio-documents-root "/%s"))
	(current-year (format-time-string "%Y"))
	)
    (setq org-link-abbrev-alist
	  '(("axosoftDefect"  . "http://vserver31/Axosoft/viewitem?id=%s&type=defects&force_use_number=true")
	    ("axosoftStory" . "http://vserver31/Axosoft/viewitem?id=%s&type=features&force_use_number=true")
	    ("azureWorkitem" .  "https://dev.azure.com/scope-ch/scope%20solutions%20ag/_workitems/edit/%s")
	    ("screenshot" . "~/org/screenshots/%s")
	    ("scorpioLog" . "~/Dropbox/diaries/2018/scorpio/%s")
	    ("scorpioUod" . "http://scorpio-t-1:9080/scorpio-client/app/en-US/units-of-description/%s/details?view=form"))
	  org-agenda-custom-commands
	  '(("j" "open jourFixe "
	     ((tags-todo "jourFixe+TODO=\"TODO\"")
	      ))
	    ("J" "open Sam "
	     ((tags-todo "sam+TODO=\"TODO\"")
	      ))
	    )
	  org-tag-alist
	  '(
	    ("@daily" . ?d )
	    ("@urs" . ?u)
	    ("@scorpio" . ?3)
	    ("@scorpioClient" . ?4)
	    ("@ingestServer" . ?5)
	    ("@scopeXplore". ?2)
	    ("@scorpioIngest" . ?1)
					; ?6
	    )
	  ;; does not work (syntax)
;;	  org-tag-persistent-alist	  '(@sprint26 @sprint27 @sprint28 @sprint29 @sprint30)
	  ;; defined by custom - do not overwrite
	  ;;org-agenda-files (list org-directory scorpio-todo-file)
	  org-capture-templates
	  '(("t" "Todo" entry (file+headline (concat org-directory (file-name-as-directory current-year)  "todos.org") "Tasks")
	     "* TODO %?\n %i\n %a")
	    ("s" "Scorpio" entry (file+headline scorpio-todo-file "Scorpio")
	     "** TODO %?\n %i\n %a")
	    ("d" "Documentation" entry (file+headline (concat org-directory (file-name-as-directory current-year) "todos.org") "Documentation")
	     "* TODO %?\n %i\n %a")
	    ("i" "idea" entry (file+datetree (concat org-directory "ideas.org"))
	     "* TODO  %?\n %i\n %a")
	    ("j" "jour fixe reminder" entry (file+headline (concat org-directory ( file-name-as-directory current-year) "todos.org") "JourFixe")
	     "* TODO %?\n %i\n %a")
	    ("p" "Products (maybe later with lookup?)" entry (file+headline (concat org-directory (file-name-as-directory current-year) "products.org") "other")))
	  )))


(setq sql-postgres-login-params
      '((user :default "postgres")
        (database :default "scorpio")
        (server :default "192.168.1.110")
        (port :default 54010)))

(defun db-org-new-diary-entry (title)
  (interactive "stitle:")
  (let ( (file-name   (format "%s_%s.org"
			      (format-time-string "%Y/%m%d")
			      (mapconcat 'identity (split-string title " ") "_"))
		      )
	 (year (format-time-string "%y")))
    (insert (format "#+include: \"%s/diaries/%s\"\n" db-dropbox-dir file-name))
    (insert "#+begin_comment\n")
    (insert (format "file:%s/diaries/%s\n" db-dropbox-dir file-name))
    (insert "#+end_comment\n")
    ;; for later:
    ;; create the file, open it and insert the original title as heading
    ))

(defun db-org-new-docker-dir (title)
  "Create a working directory in the docker temp dir" 
					;  (interactive "stitle:" )
  (interactive
   (list
    (let ((default (mapconcat 'identity (split-string (file-name-sans-extension (buffer-name))"_") " ")))
      (read-string
       (format "title (%s)" default) nil nil default)))
   )
  (let* (
	 (docker-root-dir "c:/Users/dbinkert/home/docker/temp")
	 (dir-name (format "%s/%s%s"
			   docker-root-dir
			   ;;			   (format-time-string "%Y/%m%d")
			   (format-time-string "%Y/")
			   (mapconcat 'identity (split-string title " ") "_")))
	 )
    (unless (file-directory-p  dir-name)
      (make-directory dir-name))
    (insert (format "file:/%s" dir-name))
    ))

(defun db-org-refactor-copy-buffer-name ()
  (interactive)
  (kill-new (buffer-name) nil ))


;; under construction
;; den buffer in einen Titel zurückführen
;; _ nach blank
;; timestamp weg
 (defun db-org-refactor-title-from-buffer-name ()
   (interactive)
   (insert (mapconcat
	    'identity
	    (cdr (split-string (car (split-string (buffer-name) "\\."))
			  "_"))
	    " ")))


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

