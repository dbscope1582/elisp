(require 'mu4e)

;; use mu4e for e-mail in emacs
(setq mail-user-agent 'mu4e-user-agent)

;; integrated below
;; (setq mu4e-drafts-folder "/[dieter].Drafts")
;; (setq mu4e-sent-folder   "/[dieter].Sent Mail")
;; (setq mu4e-trash-folder  "/[dieter].Trash")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)


;; (See the documentation for `mu4e-sent-messages-behavior' if you have
;; additional non-Gmail addresses and want assign them different
;; behavior.)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

;; db: commented for the moment
;; (setq mu4e-maildir-shortcuts
;;     '( (:maildir "/INBOX"              :key ?i)
;;        (:maildir "/hotmail.Sent Mail"  :key ?s)
;;        (:maildir "/[dieter].Trash"      :key ?t)
;;       (:maildir "/[dieter].All Mail"   :key ?a)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")
(setq  mu4e-update-interval 600)


;; something about ourselves
;; db: should probably go into the one at the end
(setq
;;   user-mail-address "papageno68@hotmail.com"
   user-full-name  "Dieter Binkert"
   ;; mu4e-compose-signature
   ;;  (concat
   ;;    "Foo X. Bar\n"
   ;;    "http://www.example.com\n")
    )

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
   starttls-use-gnutls t
   smtpmail-starttls-credentials '(("smtp-mail.outlook.com" 587 nil nil))
   smtpmail-auth-credentials
     '(("smtp-mail.outlook.com" 587 "papageno68@hotmail.com" nil))
   smtpmail-default-smtp-server "smtp-mail.outlook.com"
   smtpmail-smtp-server "smtp-mail.outlook.com"
   smtpmail-smtp-service 587)

;; alternatively, for emacs-24 you can use:
;;(setq message-send-mail-function 'smtpmail-send-it
;;     smtpmail-stream-type 'starttls
;;     smtpmail-default-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-service 587)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)


;; from http://cachestocaches.com/2017/3/complete-guide-email-emacs-using-mu-and-/
(setq mu4e-contexts
      `( ,(make-mu4e-context
	   :name "hotmail"
	   :match-func (lambda (msg) (when msg
				       (string-prefix-p "/hotmail" (mu4e-message-field msg :maildir))))
	   :vars '(
		   (mu4e-trash-folder . "/hotmail.Deleted")
		   (mu4e-refile-folder . "/hotmail.Archive")
		   (mu4e-drafts-folder .  "/hotmail.Drafts")
		   (mu4e-sent-folder .   "/hotmail.Sent Mail")
		   (user-mail-address . "papageno68@hotmail.com")
		   ))
	 ,(make-mu4e-context
	   :name "casadesus"
	   :match-func (lambda (msg) (when msg
				       (string-prefix-p "/casadesus" (mu4e-message-field msg :maildir))))
	   :vars '(
		   (mu4e-trash-folder . "/local/casadesus.Deleted")
		   (mu4e-refile-folder . "/local/casadesus.Archive")
		   (mu4e-drafts-folder . "/local/casadesus.Drafts")
		   (mu4e-sent-folder . "/local/casadesus.Sent Mail")
		   (user-mail-address . "damorecasadesus@gmail.com")
		   ))
	 ,(make-mu4e-context
	   :name "bluewin"
	   :match-func (lambda (msg) (when msg
				       (string-prefix-p "/bluewin" (mu4e-message-field msg :maildir))))
	   :vars '(
		   (mu4e-trash-folder . "/local/bluewin.Deleted")
		   (mu4e-refile-folder . "/local/bluewin.Archive")
		   (mu4e-drafts-folder .  "/local/bluewin.Drafts")
		   (mu4e-sent-folder .   "/local/bluewin.Sent Mail")
		   (user-mail-address . "dbinkert@bluewin.ch")
		   (smptmail-stream-type . "ssl")
		   ( smtpmail-default-smtp-server . "smtpauths.bluewin.ch" )
                   ( smtpmail-smtp-server         . "smtpauths.bluewin.ch" )
                   ( smtpmail-smtp-service        .  465)
		   (smtpmail-auth-supported . "login") ; cram-md5, plain, login
		   ))
	 ,(make-mu4e-context
	   :name "vtxmail"
	   :match-func (lambda (msg) (when msg
				       (string-prefix-p "/vtx" (mu4e-message-field msg :maildir))))
	   :vars '(
		   (mu4e-trash-folder . "/local/vtx.Deleted")
		   (mu4e-refile-folder . "/local/vtx.Archive")
		   (mu4e-drafts-folder .  "/local/vtx.Drafts")
		   (mu4e-sent-folder .   "/local/vtx.Sent Mail")
		   (user-mail-address . "dbinkert@vtxmail.ch")
		   ( smtpmail-default-smtp-server . "smtp.vtxmail.ch" )
                   ( smtpmail-smtp-server         . "smtp.vtxmail.ch" )
                   ( smtpmail-smtp-service        .  587)
		   ))
	 ))
