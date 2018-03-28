;; initialisation for computers in the context of scope


(setq org-link-abbrev-alist
	  '(("axosoftDefect"  . "http://vserver31/Axosoft/viewitem?id=%s&type=defects&force_use_number=true")
	    ("axosoftStory" . "http://vserver31/Axosoft/viewitem?id=%s&type=features&force_use_number=true"))
	  org-agenda-custom-commands
	  '(("j" "open jourFix "
	     ((tags-todo "jourFixe+TODO=\"TODO\"")
	      )))
	  org-agenda-files (list org-directory)
	  )
