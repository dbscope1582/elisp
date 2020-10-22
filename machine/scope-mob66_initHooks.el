
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
	   ))
;; auto revert mode (files modified on disk)
(global-auto-revert-mode 1)
;; auto refresh dired when file changes
(add-hook 'dired-mode-hook 'auto-revert-mode)
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
	;;	( name 'digital-ofs1)
	(name 'tsdh-dark)
	)
    (load-theme name t t)
    (enable-theme name)
    ;; allows to overwrite just a given option of the standard theme
    ;; see also the themes defined in ~/.emacs.d/elpa/color-theme-modern-20200729.921/
    ;; for a better idea of what is possible
    (custom-theme-set-faces
     name
     ;; Blanched Almond is sligthly darker than the default.
     ;; gray20 is the default fro tsdh-dark (https://github.com/jwiegley/emacs-release/blob/master/etc/themes/tsdh-dark-theme.el)
     '(default ((t (:foreground "Blanched Almond" :background "gray20"))))
     ;;     '(font-lock-comment-face ((t (:foreground "#DFAF8F"))))   
     )
    )
  ;;    (load-theme 'tsdh-dark) ;ziemlich gut00
  ;;   (set-background-color "bisque4")
  ;;   (set-foreground-color "black")
  )



(defun cygwin-shell ()
  "Run cygwin bash in shell mode."
  (interactive)
  (let ((explicit-shell-file-name "C:/cygwin/bin/bash"))
    (call-interactively 'shell)))
