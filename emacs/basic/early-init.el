;;; early-init.el --- Emacs configuration entry point (since Emacs v27). -*- lexical-binding: t; -*-


;; Don't init  `package.el', will use `straight.el' instead
(setq package-enable-at-startup nil)

;; we want the =org-plus-contrib= version of org mode.
;; removing the emacs bundled version from the load-path *should* prevent loading mixed org versions.
;; e.g. after updating org mode.

;;(when-let (orglib (locate-library "org" nil load-path))
;;  (setq-default load-path (delete (substring (file-name-directory orglib) 0 -1)
;;                                  load-path)))


;; skipping a bunch of regular expression searching in the =file-name-handler-alist= should improve start time.
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; FrameResize
(setq frame-inhibit-implied-resize t)
;; -FrameResize

;; DisableUI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)


;; gc threshold
;; emacs collect garbage every 800kb.
;; this is overly aggressive on a modern machine during our init.
;; temporarily turning it off should decrease startup times.
;; resetting it afterward will ensure that normal operations don't suffer from a large gc period.

;; i'm still not sure on the optimal gc-cons-threshold value. the following is a
;; table of values from popular emacs configurations.

;; | distribution | gc-cons-threshold |
;; |--------------+-------------------|
;; | default      |            800000 |
;; | doom         |          16777216 |
;; | spacemacs    |    
;; garbage collector
(setq gc-cons-threshold most-positive-fixnum)

(defun my/gc-after-focus-change ()
  (unless (frame-focus-state) (garbage-collect)))


(defun my/reset-init-values ()
  (run-with-idle-timer
   5 nil
   (lambda ()
     (setq file-name-handler-alist default-file-name-handler-alist
           gc-cons-threshold 100000000)
     (message "gc-cons-threshold & file-name-handler-alist restored")
     (if (boundp 'after-focus-change-function)
         (advice-add #'after-focus-change-function
                     :after #'my/gc-after-focus-change)))))

(add-hook 'emacs-startup-hook 'my/reset-init-values)



;; Package repos
;; Melpa is the big package repo that nearly /everything/ can be
;; found. It's a must for emacs configs.
(setq package-archives
      '(;("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa"        . "https://melpa.org/packages/")
        ;;("elpa"         . "https://elpa.gnu.org/packages/")
        ;;("org"          . "https://orgmode.org/elpa/")
        )
      package-archive-priorities
      '(;("melpa-stable" . 50)
        ("melpa"        . 30)
        ;;("org"          . 15)
        ;;("elpa"         . 0)
        )
      )

;; references
;; https://github.com/vdemeester/emacs-config/blob/master/early-init.el
;; https://github.com/vsemyonoff/emacsrc/blob/14649a5bafea99cc7e13e7d048e9d15aed7926ce/early-init.el
;; https://github.com/progfolio/.emacs.d/blob/master/init.org
