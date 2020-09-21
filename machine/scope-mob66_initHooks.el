
(let ()
  (add-hook
   'adoc-mode-hook
   '(lambda ()
      (display-line-numbers-mode)
      (auto-fill-mode -42 )
      ))
  (add-to-list 'auto-mode-alist '("\\.asciidoc\\'" . adoc-mode))
  (add-to-list 'auto-mode-alist '("\\.cs\\'" . c-mode))
  (unless (package-installed-p 'sr-speedbar)
    ;; see https://www.emacswiki.org/emacs/SrSpeedbar
    (package-install 'sr-speedbar)
    (require 'sr-speedbar))
  (unless (package-installed-p 'restclient)
    (package-install 'restclient)
    (require 'restclient))
  )

;; sr-speedbar-open	Open sr-speedbar window.
;; sr-speedbar-close	Close sr-speedbar window.
;; sr-speedbar-toggle	Toggle sr-speedbar window.
;; sr-speedbar-select-window	select sr-speedbar window.
;; sr-speedbar-refresh-turn-on	Turn on refresh speedbar content.
;; sr-speedbar-refresh-turn-off	Turn off refresh speedbar content.
;; sr-speedbar-refresh-toggle	Toggle refresh speedbar content.
