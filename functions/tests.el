
(defun db-show-setup ()
  (interactive)
  (message "test")
;;  (message (format "db-diaries-dir: %s" (db-diaries-dir)))
  (mapcar (lambda (pair)
	     (let ( (fun (car pair))
		    (hint (cdr pair)))
	     (message (format "%s -> %s%s"
			      fun
			      (funcall fun)
			      (if (stringp hint)
				  (format " (%s)" hint)
				"")))))
	  '((db-diaries-dir . nil)
	    (db-org-work-dir . nil)
	    (org-directory . "should be the same as db-org-work-dir")
	    (db-diaries-path-word-separator . nil )))
  )


