;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

;; disable nose
(package! nose :disable t)
;; (package! anaconda-mode :disable t)
;; (package! company-anaconda :disable t)

(package! vue-mode)

(package! blacken)

(package! dockerfile-mode)

;; (package! dap-mode)
;; (package! realgud-ipdb)

(package! company-box)

(package! symon)

(package! slack)

(package! org-fancy-priorities)

;;(package! alert)
(package! mu4e-alert)
(package! evil-mu4e)

(when (package! lsp-mode)
  (package! lsp-ui)
  (package! company-lsp)
  (package! dap-mode))

;; (when (package! realgud)
;;       (package! realgud-ipdb)
;;       (def-package! realgud
;;         :commands realgud:pdb)
;;       )

;; (when (package! lsp-mode)
;;    (package! lsp-python)
;;    (package! lsp-ui)
;;    (package! company-lsp)
;;    (package! dap-mode)
;; )
 ;; (when (featurep! +python)
 ;;    (packages! lsp-python))

;; (when (featurep! +sh)
;;     (package! company-shell :disable t))
