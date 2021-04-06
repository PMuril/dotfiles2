;; FUNCTIONAL SPECIFICATIONS

;; silences the default Emacs startup message
(setq inhibit-startup-message t)

;; scroll-bar-mode -1)
;; (tool-bar-mode -1)
;; (tooltip-mode -1)
(menu-bar-mode -1)

(indent-for-tab-command)

;; Disables the double prompt when trying to quit an emacs file
(setq confirm-kill-emacs nil)

;; copy to system clipboard
;;works both on MacOs and Linux
(xclip-mode 1)

(setq backup-directory-alist `(("." . "~/.config/emacs/backups")))

(setq delete-old-versions t ;; Don't ask to delete excess backup versions.
      backup-by-copying t   ;; Copy all files, don't rename them.
      kept-new-versions 6   ;; Number of newest versions to keep.
      kept-old-versions 2   ;; Number of oldest versions to keep.
      version-control t)    ;; Use version numbers for backups. 

;; Initialize package sources
(require 'package)

(setq package-archives '(("org" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")
			 ("melpa-stable" . "http://stable.melpa.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platform
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
;;enforces package manager to download a package
;;whenever this is require but not already installed
(setq use-package-always-ensure t)

;; APPEARENCE
(cond
 ((string-equal system-type "darwin") 
  (progn 
    ;; if system is MacOs enables doom-dracula color theme
    ;; otherwise load the default theme
    (use-package doom-themes
    :init (load-theme 'doom-dracula t)))))


;;Display relative line numbers
(global-display-line-numbers-mode)
(setq display-line-numbers 'relative)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 12)))
;; UTILITIES PLUGINS and settings
;; remaps Caps Lock to METa
(setq mac-caps-modifier 'meta)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; logs the command run inside emacs
(use-package command-log-mode)

;; IVY - file-system navigation tool
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; IVY-RICH - additional customization for IVY
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;;COUNSEL
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	  ("C-x b" . counsel-ibuffer)
	  ("C-x C-f" . counsel-find-file)
	  :map minibuffer-local-map
	  ("C-r" . 'counsel-minibuffer-history)))

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
  (when (file-directory-p "~/Dropbox/myannotations")
    (setq projectile-project-search-path '("~/Dropbox/myannotations")))
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
;;binds the value of the agenda path to that of the orgFolder and makes
;;and renders both in a system-independent way

;; org-mode keybindings
(global-set-key (kbd "C-c l")   'org-store-link)
(global-set-key (kbd "C-c C-l") 'org-insert-link)


(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))

(use-package org
  :config
  ;;(setq org-ellipsis " ▾")    ;;not required at the moment
  ;;(efs/org-font-setup)
  ;; Here it would probably be necessary to setup an environment specific folder
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-tag-alist '(
			;; ("@parisi" . ?gp) ("@geotsek" . ?gt)
			("@amerigo" . ?a) ("@macchioni" . ?m) ("@grazzini" . ?g)
			("@numeric" . ?n) ("@jamming" . ?j) ("DOS" . ?d) ("MFT" . ?m)))
)


(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "PowerLine" :weight 'regular :height (cdr face)))

;; Configure custom agenda views
  (setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Next Tasks"
     ((todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))))

    ("W" "Work Tasks" tags-todo "+work-email")

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ("w" "Workflow Status"
     ((todo "WAIT"
            ((org-agenda-overriding-header "Waiting on External")
             (org-agenda-files org-agenda-files)))
      (todo "REVIEW"
            ((org-agenda-overriding-header "In Review")
             (org-agenda-files org-agenda-files)))
      (todo "PLAN"
            ((org-agenda-overriding-header "In Planning")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "BACKLOG"
            ((org-agenda-overriding-header "Project Backlog")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "READY"
            ((org-agenda-overriding-header "Ready for Work")
             (org-agenda-files org-agenda-files)))
      (todo "ACTIVE"
            ((org-agenda-overriding-header "Active Projects")
             (org-agenda-files org-agenda-files)))
      (todo "COMPLETED"
            ((org-agenda-overriding-header "Completed Projects")
             (org-agenda-files org-agenda-files)))
      (todo "CANC"
            ((org-agenda-overriding-header "Cancelled Projects")
             (org-agenda-files org-agenda-files)))))))


;;fill-column mode
(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

;;ORG-ROAM
;;finding ORG-ROAM dependency: sqlite3
(executable-find "sqlite3")
(add-to-list 'exec-path "path/to/sqlite")

(setq org-roam-directory "/Users/paolobaldan/Dropbox/myannotations/org-roam")
(add-hook 'after-init-hook 'org-roam-mode)

;;GENERAL - Keybindings manager
(use-package general)

(general-define-key
 "C-M-j" 'counsel-switch-buffer
 "C-c t" 'counsel-org-tag
 "C-c c" 'counsel-org-capture
 )

;;CUSTOM

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-minibuffer-history-key "M-p")
 '(org-export-backends '(ascii html icalendar latex md odt))
 '(package-selected-packages
   '(doom-modeline xclip ivy-rich which-key visual-fill-column use-package rainbow-delimiters org-web-tools org-roam org-evil org-bullets material-theme magit general evil-matchit evil-embrace evil-commentary evil-collection doom-themes counsel-projectile command-log-mode badger-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
