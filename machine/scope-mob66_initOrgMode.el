;; initialisation specific for scope-mob39


(load-file (concat (file-name-directory load-file-name) "scope_initOrgMode.el"))

;;(setq org-link-abbrev-alist
;;	  '(("axosoftDefect"  . "http://vserver31/Axosoft/viewitem?id=%s&type=defects&force_use_number=true")
;;	    ("axosoftStory" . "http://vserver31/Axosoft/viewitem?id=%s&type=features&force_use_number=true")))



(setq exec-path (append exec-path '(
				     "C:/Program Files/MiKTeX 2.9/miktex/bin/x64"
				     "C:/Program Files/PostgreSQL/12/bin ")
			 )
      )


(setq sql-postgres-login-params
      '((user :default "postgres")
        (database :default "scorpio")
        (server :default "192.168.1.110")
        (port :default 54010)))
