
(let ()
  (add-hook
   'adoc-mode-hook
   '(lambda ()
      (display-line-numbers-mode)
      (auto-fill-mode -42 )
      ))
  (add-hook
   'sql-mode-hook
   '(lambda ()
      (display-line-numbers-mode)))
  (add-to-list 'auto-mode-alist '("\\.asciidoc\\'" . adoc-mode))
  (add-to-list 'auto-mode-alist '("\\.adoc\\'" . adoc-mode))
  (add-to-list 'auto-mode-alist '("\\.cs\\'" . c-mode))
  (add-to-list 'auto-mode-alist '("\\.dot\\'" . graphviz-dot-mode))
;; from https://emacs.stackexchange.com/questions/17431/how-do-i-change-portions-of-a-custom-theme
  
(mapcar (lambda (x)
	  (unless (package-installed-p x)
	    (package-install x)
	    (require x))
	  )
	'( restclient
	   sr-speedbar
	   graphviz-dot-mode
	   openwith
	   jenkins
	   oauth2
	   json
	   yaml-mode
	   magit
	   ))
;; auto revert mode (files modified on disk)
(global-auto-revert-mode 1)
)

;; allows to define the system application with which a file is shown when opened from within dired-mode
( progn
(require 'openwith)
(openwith-mode t)
(setq
 openwith-associations
 '(("\\.svg'" "brave" (file)))
 ))

;; sr-speedbar-open	Open sr-speedbar window.
;; sr-speedbar-close	Close sr-speedbar window.
;; sr-speedbar-toggle	Toggle sr-speedbar window.
;; sr-speedbar-select-window	select sr-speedbar window.
;; sr-speedbar-refresh-turn-on	Turn on refresh speedbar content.
;; sr-speedbar-refresh-turn-off	Turn off refresh speedbar content.
;; sr-speedbar-refresh-toggle	Toggle refresh speedbar content.


;;(load-theme 'misterioso)  auch OK
;;(load-theme 'tango-dark) modeline ist übel
;; (list-colors-display) für namen (und preview)
;;; section to set my individual theme. After some playing around and for now, I go for
;;; tsdh-dark. 
(progn
  ;; see https://github.com/emacs-jp/replace-colorthemes/
  ;; https://github.com/emacs-jp/replace-colorthemes/blob/master/screenshots.md#digital-ofs1
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



(defun cygwin-shell ()
  "Run cygwin bash in shell mode."
  (interactive)
  (let ((explicit-shell-file-name "C:/cygwin/bin/bash"))
    (call-interactively 'shell)))


;; configure dired
( progn
  ;; enable zip/unip (Z)
  (eval-after-load "dired-aux"
    '(add-to-list 'dired-compress-file-suffixes 
		  '("\\.zip\\'" ".zip" "unzip")))
  ;; turn details off by default 
  (add-hook 'dired-mode-hook
      (lambda ()
        (dired-hide-details-mode)
	(auto-revert-mode)))
  ;; auto refresh dired when file changes
  ;;(add-hook 'dired-mode-hook 'auto-revert-mode)
  )


;; seems not to work
;; (progn
;;   ;; https://emacs.stackexchange.com/questions/19037/org-babel-invoking-cmd-exe
;;   (require 'ob-sh)
;;   (defadvice org-babel-sh-evaluate (around set-shell activate)
;;     "Add header argument :shcmd that determines the shell to be called."
;;     (let* ((org-babel-sh-command (or (cdr (assoc :shcmd params)) org-babel-sh-command)))
;;       ad-do-it
;;       )))
