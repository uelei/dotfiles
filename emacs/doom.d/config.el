;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(load-file "~/personal_scripts/secrets.el")

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Wesley"
      user-mail-address "ueleiww@gmail.com")

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
(setq doom-font (font-spec :family "monospace" :size 14))

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


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.


;; ;; black for python files
;; (def-package! blacken
;;    :hook
;;    (python-mode . blacken-mode)
;;    (before-save . blacken-buffer))

;; pytest custom config
(def-package! python-pytest
  :custom
  (python-pytest-arguments
   '("-v"
     "--color"          ;; colored output in the buffer
     "--failed-first"   ;; run the previous failed tests first
     "--maxfail=5")))

;;  org stuffs
(def-package! org
  :config
  (setq
   org-directory (expand-file-name "~/Dropbox/org/")
   org-agenda-files (expand-file-name "~/Dropbox/org/work_todo.org")
   org-log-done 'time
   org-adapt-indentation nil

  ;; set color in priorities
  org-priority-faces '((?A . (:foreground "red" :background "yellow" :weight 'bold))
                      (?B . (:foreground "yellow" :weight 'bold))
                      (?C . (:foreground "green" :weight 'bold)))
  )

  (setq org-agenda-files
      (append
       (file-expand-wildcards "~/Dropbox/org/*.org")
       (file-expand-wildcards "~/Dropbox/org/*/*.org")))

  (defun my/generate-org-filename-for-week-number ()
    ;; (setq my-org-note--time (format-time-string "%Y_%U"))
    (expand-file-name (format "%s/%s.org" (plist-get org-capture-plist :subfolder) (format-time-string "%Y_%V") ) org-directory))

    (setq org-capture-templates '(
                              ("w" "work week todo"
                               plain (file my/generate-org-filename-for-week-number)
                               "* TODO %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n"
                               :empty-lines 1
                               :subfolder "work"
                               )
                              ("b" "work backlog todo"
                               plain (file "~/Dropbox/org/work_backlog.org")
                               "* TODO %?\n  Entered on: %U - %a\n"
                               :empty-lines 1)
                              ("n" "work notes"
                               plain (file "~/Dropbox/org/work_notes.org")
                               "* %?\n  Entered on: %U - %a\n"
                               )
                              ("t" "home todo"
                               plain (file "~/Dropbox/org/home_todo.org")
                               "* TODO %?\nSCHEDULE: %(org-insert-time-stamp (org-read-date nil t \"+7d\"))\nentered on: %u - %a\n"
                               :empty-lines 1)
                              ("h" "home notes"
                               plain (file "~/Dropbox/org/home_notes.org")
                               "* %?\n  Entered on: %U - %a\n"
                               )
                              ))

  )

;; editor config
;; (def-package! editorconfig
;;   :config
;;   (editorconfig-mode 1))


;; comment line like pycharm
(map! :ne "C-/" #'comment-line)

;; ;; emoji
(def-package! emojify
  :config
  (add-hook 'after-init-hook #'global-emojify-mode)
  (setq emojify-company-tooltips-p t)
  )

;; (def-package! company-emoji)
;; (after! company
;;    (add-to-list 'company-backends 'company-emoji))

;; (use-package! markdown-mode
;;   :hook
;;   (git-commit-mode . markdown-mode))


(when (featurep! :lang markdown)
  (after! markdown-mode
    (setq markdown-header-scaling t)
    (set-company-backend! '(markdown-mode gfm-mode) '(company-emoji))))


(after! text-mode
    (set-company-backend! '(text-mode) '(company-emoji)))


;; (after! git-commit-mode
;;   (set-company-backend! '(git-commit-mode gfm-mode) '(company-emoji)))


  ;; (after! mode
  ;;   (setq markdown-header-scaling t)

  ;;   (set-company-backend! '(markdown-mode gfm-mode) '(company-emoji))))



(when (and (featurep! :lang python +lsp)
           (featurep! :checkers syntax))
  (set-next-checker! 'python-mode 'lsp 'python-mypy))


;; (def-package! poetry)



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


(use-package! terraform-mode
  :config
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))


(use-package! mu4e-maildirs-extension
  :defer t
  :init (with-eval-after-load 'mu4e (mu4e-maildirs-extension-load)))

(use-package! mu4e-alert
    :after mu4e
    :hook ((after-init . mu4e-alert-enable-mode-line-display)
           (after-init . mu4e-alert-enable-notifications))
    :config (mu4e-alert-set-default-style 'libnotify))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (poetry))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package! poetry)
