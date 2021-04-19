(message "init priomrose orgmode")

(let (
      (resources-root "http://www.ysaye.org/family/resources/")
      )
  ( message resources-root)
  ;; maybe not needed. Can be defined directly in the org file where it is used.
  ;; so no magic background configuration needed here.
  ;; already done for persons and couples
  (setq org-link-abbrev-alist
	'(
	  ("image" . ( concat resources-root "%s.png"))
	  ("thumbnail" .  "http://www.ysaye.org/family/resources/%s.png")
	  ("resource". (concat resources-root %s "%s.png") )))
  ;;seems not to work. What I wanted to achieve: add a link from a person to all couples it belongs too. Also cool would be to find other persons with the same parents
  (setq org-link-search-must-match-exact-headline 'query-to-create)


  ;; mobile.org
  (setq
   org-directory  "~/Documents/org"
   org-mobile-directory (concat org-directory "/mobile-org")
   org-mobile-inbox-for-pull (concat org-directory "/inbox-for-pull")
   )
;;  (org-directory)
  )

