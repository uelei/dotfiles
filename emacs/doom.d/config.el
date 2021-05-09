;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Uelei"
      user-mail-address "emacs@uelei.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq
 projectile-project-search-path '("~/code/" "~/code/pontotel/"))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; ;; python formater
;; (setq-default dotspacemacs-configuration-layers '(
;;   (python :variables python-formatter 'black)))

;; (def-package! dap-mode
;;   :after lsp-mode
;;   :config
;;   (dap-mode t)
;;   (dap-ui-mode t))

;; (def-package! poetry
;; :config
;;          (poetry-tracking-mode 1)
;;          )

;; comment line like pycharm
(map! "C-/" #'comment-line)

;; emoji
(after! emojify
  :config
  (add-hook 'after-init-hook #'global-emojify-mode)
  (setq emojify-company-tooltips-p t)
  )

(after! text-mode
  (set-company-backend! '(text-mode) '(company-emoji)))

;; emoji + markdown
(when (featurep! :lang markdown)
  (after! markdown-mode
    (setq markdown-header-scaling t)
    (set-company-backend! '(markdown-mode gfm-mode) '(company-emoji))))


;; ;;  org stuffs
(after! org
  :config
  (setq
   org-directory (expand-file-name "~/Dropbox/notes/org/")
   org-log-done 'time
   org-adapt-indentation nil
   ;; ;; set color in priorities
   ;; org-priority-faces '((?A . (:foreground "red" :background "yellow" :weight 'bold))
   ;;                     (?B . (:foreground "yellow" :weight 'bold))
   ;;                     (?C . (:foreground "green" :weight 'bold)))
   org-agenda-files
   (append
    (file-expand-wildcards "~/Dropbox/notes/org/*.org")
    (file-expand-wildcards "~/Dropbox/notes/org/*/*.org")))

  ;; (defun my/generate-org-filename-for-week-number ()
  ;;   ;; (setq my-org-note--time (format-time-string "%Y_%U"))
  ;;   (expand-file-name (format "%s/%s.org" (plist-get org-capture-plist :subfolder) (format-time-string "%Y_%V") ) org-directory))

  ;; Old org-capture-template
  ;; (setq org-capture-templates '(
  ;;                               ("w" "work week todo"
  ;;                                plain (file my/generate-org-filename-for-week-number)
  ;;                                "* TODO %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n"
  ;;                                :empty-lines 1
  ;;                                :subfolder "work"
  ;;                                )
  ;;                               ("b" "work backlog todo"
  ;;                                plain (file "~/Dropbox/org/work_backlog.org")
  ;;                                "* TODO %?\n  Entered on: %U - %a\n"
  ;;                                :empty-lines 1)
  ;;                               ("n" "work notes"
  ;;                                plain (file "~/Dropbox/org/work_notes.org")
  ;;                                "* %?\n  Entered on: %U - %a\n"
  ;;                                )
  ;;                               ("t" "home todo"
  ;;                                plain (file "~/Dropbox/org/home_todo.org")
  ;;                                "* TODO %?\nSCHEDULE: %(org-insert-time-stamp (org-read-date nil t \"+7d\"))\nentered on: %u - %a\n"
  ;;                                :empty-lines 1)
  ;;                               ("h" "home notes"
  ;;                                plain (file "~/Dropbox/org/home_notes.org")
  ;;                                "* %?\n  Entered on: %U - %a\n"
  ;;                                )
  ;;                               ))



  )

;;;make org capture nice
;;;https://github.com/tecosaur/emacs-config/compare/6bcdbaa..49c790e
(after! org-capture
  (load! "org-capture-uelei")
  )
;; ;; black for python files
;; (def-package! blacken
;;    :hook
;;    (python-mode . blacken-mode)
;;    (before-save . blacken-buffer))

;; ;; pytest custom config
;; (def-package! python-pytest
;;   :custom
;;   (python-pytest-arguments
;;    '("-v"
;;      "--color"          ;; colored output in the buffer
;;      "--failed-first"   ;; run the previous failed tests first
;;      "--maxfail=5")))

;; lsp python
;; (when (and (featurep! :lang python +lsp)
;;            (featurep! :checkers syntax))
;;   (set-next-checker! 'python-mode 'lsp 'python-mypy))


;; (when (featurep! :tools lsp)
;;   (setq +lsp-company-backend 'company-capf
;;         gc-cons-threshold (* 1024 1024 1024))

;;   (after! lsp-mode
;;     (setq-hook! 'lsp-mode-hook
;;       company-idle-delay 0.0
;;       company-minimum-prefix-length 1))

;;   (after! lsp-ui
;;     (setq lsp-ui-sideline-show-diagnostics nil))

;;   ;; LSP + Doom Themes
;;   (defun +custom--pick-doom-color (key)
;;     (nth (if (display-graphic-p) 0 1) (alist-get key doom-themes--colors)))
;;   (after! (lsp-ui doom-themes)
;;     (setq lsp-ui-imenu-colors `(,(+custom--pick-doom-color 'dark-blue)
;;                                 ,(+custom--pick-doom-color 'cyan)))
;;     (set-face-foreground 'lsp-ui-sideline-code-action
;;                          (+custom--pick-doom-color 'yellow))))


(after! terraform-mode
  :config
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))


(after! mu4e
  :config

  (setq mu4e-root-maildir (expand-file-name "~/.mail")

        ;; Use mbsync for email sync
        ;; mu4e-get-mail-command "~/mbsync.sh"
        mu4e-get-mail-command "mbsync -a"
        mu4e-update-interval 3600

        ;; dont save sent messages gmail/imap do that
        mu4e-sent-messages-behavior 'delete

        ;; fix mbsync error UID
        mu4e-change-filenames-when-moving t

        mu4e-compose-signature-auto-include nil

        mu4e-headers-show-threads t
        mu4e-headers-include-related t

        mu4e-index-cleanup nil
        mu4e-index-lazy-check t
        mu4e-headers-results-limit 2500

        ;; show images and aatachment
        mu4e-view-show-images t
        mu4e-use-fancy-chars t

        mu4e-view-show-addresses t
        ;; mu4e-headers-include-related t
        mu4e-headers-skip-duplicates t
        mu4e-main-show-maildirs t
        )

  (let ((personal-settings "~/personal_scripts/emacs/email_settings.el"))
    (when (file-exists-p personal-settings)
      (load-file personal-settings))))

;; (after! mu4e-maildirs-extension
;;   :init (with-eval-after-load 'mu4e (mu4e-maildirs-extension-load)))


;; (after! magit-todos
;;   :config
;;   (setq magit-todos-exclude-globs '("*.map" "*.js" "*.py" "!*.org"))
;;   )

(after! magit-org-todos
  :config
  (magit-org-todos-autoinsert)
  )


;; (use-package! mu4e-views
;;   :after mu4e
;;   :config
;;   (setq mu4e-views-completion-method 'ivy)
;;   (setq mu4e-views-default-view-method "html")
;;   (setq mu4e-views-next-previous-message-behaviour 'stick-to-current-window) ;; when pressing n and p stay in the current window
;;   (setq mu4e-views-mu4e-html-email-header-style
;;         "<style type=\"text/css\">
;; .mu4e-mu4e-views-mail-headers { font-family: sans-serif; font-size: 10pt; margin-bottom: 30px; padding-bottom: 10px; border-bottom: 1px solid #ccc; color: #000;}
;; .mu4e-mu4e-views-header-row { display:block; padding: 1px 0 1px 0; }
;; .mu4e-mu4e-views-mail-header { display: inline-block; text-transform: capitalize; font-weight: bold; }
;; .mu4e-mu4e-views-header-content { display: inline-block; padding-right: 8px; }
;; .mu4e-mu4e-views-email { display: inline-block; padding-right: 8px; }
;; .mu4e-mu4e-views-attachment { display: inline-block; padding-right: 8px; }
;; </style>"
;;         )

;;   (add-hook! mu4e-headers-mode
;;     (mu4e-views-mu4e-use-view-msg-method "html")) ;; select the default

;;   ;; (map! :map mu4e-headers-mode-map
;;       :n "M-b" #'mu4e-views-cursor-msg-view-window-up
;;       :n "M-f" #'mu4e-views-cursor-msg-view-window-down
;;       :localleader
;;       :desc "Message action"        "a"   #'mu4e-views-mu4e-view-action
;;       :desc "Scoll message down"    "b"   #'mu4e-views-cursor-msg-view-window-up
;;       :desc "Scoll message up"      "f"   #'mu4e-views-cursor-msg-view-window-down
;;       :desc "Open attachment"       "o"   #'mu4e-views-mu4e-view-open-attachment
;;       :desc "Save attachment"       "s"   #'mu4e-views-mu4e-view-save-attachment
;;       :desc "Save all attachments"  "S"   #'mu4e-views-mu4e-view-save-all-attachments
;;       :desc "Set view method"       "v"   #'mu4e-views-mu4e-select-view-msg-method)) ;; select viewing method)


;; Evil bindings for xwidget webkit browsers
;; (map! :map xwidget-webkit-mode-map
;;       :n "Z Z" #'quit-window
;;       :n "gr"  #'xwidget-webkit-reload
;;       :n "y"   #'xwidget-webkit-copy-selection-as-kill
;;       :n "s-c" #'xwidget-webkit-copy-selection-as-kill
;;       :n "t"   #'xwidget-webkit-browse-url
;;       :n "TAB" #'xwidget-webkit-forward
;;       :n "C-o" #'xwidget-webkit-back
;;       :n "G"   #'xwidget-webkit-scroll-bottom
;;       :n "gg"  #'xwidget-webkit-scroll-top
;;       :n "C-b" #'xwidget-webkit-scroll-down
;;       :n "C-f" #'xwidget-webkit-scroll-up
;;       :n "M-=" #'xwidget-webkit-zoom-in
;;       :n "M--" #'xwidget-webkit-zoom-out
;;       :n "k"   #'xwidget-webkit-scroll-down-line
;;       :n "j"   #'xwidget-webkit-scroll-up-line)



;; (use-package! mu4e-maildirs-extension
;;   :after mu4e
;;   :config
;;   (mu4e-maildirs-extension)
;;   (setq mu4e-maildirs-extension-title nil))
