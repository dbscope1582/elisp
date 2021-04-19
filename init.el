;;should be in the .emacs file
(package-initialize)

;; this is where things start
(progn
  ;; load the files in my subirectory "functions"
  (mapcar
   (lambda (file)
     (load-file file))
   (directory-files
    ;;(concat (file-name-directory (buffer-file-name)) "functions")
    (concat (file-name-directory load-file-name) "functions")
    t "^[a-zA-Z]+.el$")
   )  
  (db-init-vars (file-name-directory load-file-name) )
  (db-init-emacs)
  (message "my stuff has been initialized"))


