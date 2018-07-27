;; initialisation for computers in the context of scope


(setq org-link-abbrev-alist
      '(("axosoftDefect"  . "http://vserver31/Axosoft/viewitem?id=%s&type=defects&force_use_number=true")
	("axosoftStory" . "http://vserver31/Axosoft/viewitem?id=%s&type=features&force_use_number=true")
	("screenshot" . "~/org/screenshots/%s"))
      org-agenda-custom-commands
      '(("j" "open jourFix "
	 ((tags-todo "jourFixe+TODO=\"TODO\"")
	  ))
	("J" "open Sam "
	 ((tags-todo "sam+TODO=\"TODO\"")
	  ))
	)
      org-agenda-files (list org-directory)
      org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "todos.org") "Tasks")
	 "* TODO %?\n %i\n %a")
	("s" "Scorpio" entry (file+headline (concat org-directory "todos.org") "Scorpio")
	 "* TODO %?\n %i\n %a")
	("d" "Documentation" entry (file+headline (concat org-directory "todos.org") "Documentation")
	 "* TODO %?\n %i\n %a")
	("i" "idea" entry (file+datetree (concat org-directory "ideas.org"))
	 "* TODO  %?\n %i\n %a")
	("j" "jour fixe reminder" entry (file+headline (concat org-directory "todos.org") "JourFixe")
	 "* TODO %?\n %i\n %a")
	("p" "Products (maybe later with lookup?)" entry (file+headline (concat org-directory "products.org") "other")))
	  )
