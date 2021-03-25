(require 'package)
 
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

 
;;(setq package-enable-at-startup nil)
(package-initialize)
(package-refresh-contents)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil-matchit evil-commentary org-evil monitor dash evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; evil-mode plugins
(add-to-list 'load-path "/path/to/org-evil/directory")
(require 'org-evil)

;; vim sorround
(use-package evil-surround
	     :ensure t
	     :config
	     (global-evil-sorround-mode 1))

;; vim commentary
(evil-commentary-mode)

;; vim matchit
(require 'evil-matchit)
(global-evil-matchit-mode 1)
