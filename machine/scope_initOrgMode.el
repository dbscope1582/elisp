;; initialisation for computers in the context of scope


(let ((scorpio-documents-root (concat db-dropbox-dir "/diaries/2018/scorpio" )))
  (let ((scorpio-todo-file (concat scorpio-documents-root "/todo.org" ))
	(dummy-temp (concat scorpio-documents-root "/%s")))
    (setq org-link-abbrev-alist
	  '(("axosoftDefect"  . "http://vserver31/Axosoft/viewitem?id=%s&type=defects&force_use_number=true")
	    ("axosoftStory" . "http://vserver31/Axosoft/viewitem?id=%s&type=features&force_use_number=true")
	    ("azureWorkitem" .  "https://dev.azure.com/scope-ch/scope%20solutions%20ag/_workitems/edit/%s")
	    ("screenshot" . "~/org/screenshots/%s")
	    ("scorpioLog" . "~/Dropbox/diaries/2018/scorpio/%s"))
	  org-agenda-custom-commands
	  '(("j" "open jourFix "
	     ((tags-todo "jourFixe+TODO=\"TODO\"")
	      ))
	    ("J" "open Sam "
	     ((tags-todo "sam+TODO=\"TODO\"")
	      ))
	  )
	  org-agenda-files (list org-directory scorpio-todo-file)
	  org-capture-templates
	  '(("t" "Todo" entry (file+headline (concat org-directory "todos.org") "Tasks")
	     "* TODO %?\n %i\n %a")
	    ("s" "Scorpio" entry (file+headline scorpio-todo-file "Scorpio")
	     "** TODO %?\n %i\n %a")
	    ("d" "Documentation" entry (file+headline (concat org-directory "todos.org") "Documentation")
	     "* TODO %?\n %i\n %a")
	    ("i" "idea" entry (file+datetree (concat org-directory "ideas.org"))
	     "* TODO  %?\n %i\n %a")
	    ("j" "jour fixe reminder" entry (file+headline (concat org-directory "todos.org") "JourFixe")
	     "* TODO %?\n %i\n %a")
	    ("p" "Products (maybe later with lookup?)" entry (file+headline (concat org-directory "products.org") "other")))
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
    (insert (format "#+include:%s/diaries/%s" db-dropbox-dir file-name))
    (insert "\n#+begin_comment")
    (insert (format "\nfile:%s/diaries/%s" db-dropbox-dir file-name))
    (insert "\n#+end_comment")
    ;; for later:
    ;; create the file, open it and insert the original title as heading
    ))
