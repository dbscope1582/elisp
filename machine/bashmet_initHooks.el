(message (format "hello from %s" (system-name)))


(progn
  (add-to-list 'custom-theme-load-path
             (file-name-as-directory "~/.emacs.d/replace-colorthemes"))
  (let (
	;;	( theme 'digital-ofs1)
	;;(theme 'tsdh-dark)
	(theme 'infodoc) ;; wheat:#f5deb3 bisque:#ffe4c4 
	)
    (load-theme theme t t)
    (enable-theme theme)
    ;; allows to overwrite just a given option of the standard theme
    ;; see also the themes defined in ~/.emacs.d/elpa/color-theme-modern-20200729.921/
    ;; for a better idea of what is possible
    ;; !! 20201127
    ;; !! the if statement does not work. its puprose (now) is ony to 
    ;; avoid the custome face. this face is good for tsdh-dark but not for infodoc    
	(custom-theme-set-faces
	 theme
	 ;; Blanched Almond is sligthly darker than the default.
	 ;; gray20 is the default fro tsdh-dark (https://github.com/jwiegley/emacs-release/blob/master/etc/themes/tsdh-dark-theme.el)
	 ;; bisque
;	 '(default ((t (:foreground "Blanched Almond" :background "gray20"))))
;	 '(default ((t (:foreground "black" :background "bisque")))) ;;was:: wheat
	 ;;     '(font-lock-comment-face ((t (:foreground "#DFAF8F"))))   
	 )
    )
  )
