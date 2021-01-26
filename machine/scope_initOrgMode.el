;; initialisation for computers in the context of scope



(let (
      (current-year (format-time-string "%Y"))
      )
  (setq org-link-abbrev-alist
	  '(("axosoftDefect"  . "http://vserver31/Axosoft/viewitem?id=%s&type=defects&force_use_number=true")
	    ("axosoftStory" . "http://vserver31/Axosoft/viewitem?id=%s&type=features&force_use_number=true")
	    ("azureWorkitem" .  "https://dev.azure.com/scope-ch/scope%20solutions%20ag/_workitems/edit/%(db-org-parse-link-tag)")
	    ("screenshot" . "~/org/screenshots/%s")
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
	    ("userDocu" . ?d)
	    ("sprint" . ?s)
	    ("scorpio" . ?3)
	    ("scorpioClient" . ?4)
	    ("ingestServer" . ?5)
	    ("scopeXplore". ?2)
	    ("scorpioIngest" . ?1)
					; ?6
	    )
	  org-agenda-files '( "~/Dropbox/diaries/2021" "~/Dropbox/diaries/domain")
	  ;; org-capture-templates
	  ;; '(("t" "Todo" entry (file+headline (concat org-directory (file-name-as-directory current-year)  "todos.org") "Tasks")
	  ;;    "* TODO %?\n %i\n %a")
	  ;;   ("d" "Documentation" entry (file+headline (concat org-directory (file-name-as-directory current-year) "todos.org") "Documentation")
	  ;;    "* TODO %?\n %i\n %a")
	  ;;   ("i" "idea" entry (file+datetree (concat org-directory "ideas.org"))
	  ;;    "* TODO  %?\n %i\n %a")
	  ;;   ("j" "jour fixe reminder" entry (file+headline (concat org-directory ( file-name-as-directory current-year) "todos.org") "JourFixe")
	  ;;    "* TODO %?\n %i\n %a")
	  ;;   ("p" "Products (maybe later with lookup?)" entry (file+headline (concat org-directory (file-name-as-directory current-year) "products.org") "other")))
	  ))


(setq sql-postgres-login-params
      '((user :default "postgres")
        (database :default "scorpio")
        (server :default "192.168.1.110")
        (port :default 54010)))

(defun db-org-diary-path-today ( title)
  (interactive "stitle")
     (format "%s/%s%s%s.org"
	     db-dropbox-diaries-dir
	     (format-time-string "%Y/%m%d")
	     db-dropbox-path-word-separator
	     title)
     )

(defun db-org-new-diary-entry (title)
  (interactive "stitle:")
  (let ((file (db-org-diary-path-today (mapconcat 'identity (split-string title " ") db-dropbox-path-word-separator))))
    (insert (format "#+include: \"%s\"\n" file))
    (insert "#+begin_comment\n")
    (insert (format "file:%s\n" file))
    (insert "#+end_comment\n")
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
      (make-directory dir-name t))
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

(defun db-org-parse-link-tag (tag)
  "remove everything after the first colon. This allows to write clearer links to azure like so:
azureWorkItem:1318:Transfer term of protection - without a descriptiive text"
  (car (split-string tag " ")))
