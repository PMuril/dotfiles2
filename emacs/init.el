;; (add-to-list 'load-path "~/.config/emacs/init.el")

;; silences the default Emacs startup message
(setq inhibit-startup-message t)

;;(scroll-bar-mode -1)
;;(tool-bar-mode -1)
;;(tooltip-mode -1)

(indent-for-tab-command)

(menu-bar-mode -1)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; enables material color theme
(load-theme 'wombat )

;; Initialize package sources
(require 'package)

(setq package-archives '(("org" . "http://orgmode.org/elpa/")
			 ("melpa" . "http://melpa.org/packages/")
			 ("melpa-stable" . "http://stable.melpa.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platform
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; logs the command run inside emacs
(use-package command-log-mode)

;; enables file-system navigation via ivy
;; (use-package ivy
;;   :diminish
;;   :bind (("C-s" . swiper)
;; 	 :map ivy-minibuffer-map))



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
 '(package-selected-packages
   '(command-log-mode material-theme magit evil-surround evil-matchit evil-commentary org-evil monitor dash evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; evil-mode plugins
(add-to-list 'load-path "/path/to/org-evil/directory")
(require 'org-evil)

;; Disables the double prompt when trying to quit an emacs file
(setq confirm-kill-emacs nil)

;; Enables colored marker to distinguish between the different VIM modes
(setq evil-normal-state-cursor '(box "light blue")
      evil-insert-state-cursor '(bar "medium sea green")
      evil-visual-state-cursor '(hollow "orange"))

;; vim sorround
;; (use-package evil-surround
;; 	     :ensure t
;; 	     :config
;; 	     (global-evil-sorround-mode 1))

;; vim commentary
(evil-commentary-mode)

;; vim matchit
(require 'evil-matchit)
(global-evil-matchit-mode 1)


(setq backup-directory-alist '(("." . "~/.config/emacs/backups")))
