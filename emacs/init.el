;; (add-to-list 'load-path "~/.config/emacs/init.el")

;; silences the default Emacs startup message
(setq inhibit-startup-message t)

;; scroll-bar-mode -1)
;; (tool-bar-mode -1)
;; (tooltip-mode -1)

(indent-for-tab-command)

(menu-bar-mode -1)

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

;; APPEARENCE
;; enables material color theme
(use-package doom-themes
  :init (load-theme 'doom-dracula t))

;;Display relative line numbers
(column-number-mode)
(setq display-line-numbers 'relative)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))

;; UTILITIES PLUGINS and settings
;; remaps Caps Lock to METa
(setq mac-caps-modifier 'meta)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; logs the command run inside emacs
(use-package command-log-mode)

;; enables file-system navigation via ivy
;; (use-package ivy
;;   :diminish
;;   :bind (("C-s" . swiper)
;; 	 :map ivy-minibuffer-map
;; 	 ("TAB" . ivy-alt-done)
;; 	 ("C-l" . ivy-alt-done)

	
;; Enables which-key: Display informations on the full-keybindings
;; that are compatible with 
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; UndoTree had to be installed manually and the syntax to load the
;; package is therefore slightly different from the packages
;; that are hosted on official repositories (elpa, melpa, ecc. )
;; (add-to-list 'load-path "~/.config/emacs/not-elpa/")
;; (require 'undo-tree)
;; (use-package undotree
;;   :ensure t
;;   :init
;;   (global-undo-tree-mode 1))

;; EVIL MODE
;; N.B. Due to the structure of the operations memory structure
;; in order to undo a previous operation it is needed first to
;; execute a non-editing command. E.g. To undo a previous operation
;; it is possible to use the keybinding C-g u.
(defun rune/evil-hook ()
  (dolist (mode '(custom-mode
		  eshell-mode
		  git-rebase-mode
		  erc-mode
		  circe-server-mode
		  circe-chat-mode
		  circed-query-mode
		  sauron-mode
		  term-mode))
    (add-to-list 'evil-emacs-state-modes mode)))


(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-want-fine-undo 'fine)
  (setq evil-normal-state-cursor '("light blue" box))         ;;setting still not applicable in Alacritty
  (setq evil-insert-state-cursor '("medium sea green" box))   ;;setting still not applicable in Alacritty
  (setq evil-visual-state-cursor '("orange" box))             ;;setting still not applicable in Alacritty
  :hook(evil-mode . rune/evil-hook)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))
  
;; evil-mode plugins
(add-to-list 'load-path "/path/to/org-evil/directory")
(require 'org-evil)

;; vim commentary
(evil-commentary-mode)

;; vim matchit
(require 'evil-matchit)
(global-evil-matchit-mode 1)

;; vim surround
(use-package evil-surround
	     :ensure t
	     :config
	     (global-evil-surround-mode 1))


;;PROJECTILE
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

;;MAGIT
(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))
;; The package evil-magit no longer needs to be included separately
;; as it is now part of the package evil-colleciton

;; ORGMODE


;; Disables the double prompt when trying to quit an emacs file
(setq confirm-kill-emacs nil)

(setq backup-directory-alist '(("." . "~/.config/emacs/backups")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("43f03c7bf52ec64cdf9f2c5956852be18c69b41c38ab5525d0bedfbd73619b6a" default))
 '(package-selected-packages
   '(evil-embrace rainbow-delimiters evil-collection counsel which-key doom-themes badger-theme command-log-mode material-theme magit evil-surround evil-matchit evil-commentary org-evil monitor dash evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
