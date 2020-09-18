
(let ()
  (add-hook
   'adoc-mode-hook
   '(lambda ()
      (display-line-numbers-mode)
      (auto-fill-mode -42 )
      ))
  (add-to-list 'auto-mode-alist '("\\.asciidoc\\'" . adoc-mode))
  (add-to-list 'auto-mode-alist '("\\.cs\\'" . c-mode))
  )
