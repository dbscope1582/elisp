
(let ()
  (add-hook
   'adoc-mode-hook
   '(lambda ()
      (display-line-numbers-mode)
      (auto-fill-mode -42 )
      )))
