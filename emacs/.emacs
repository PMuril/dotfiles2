(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode)) ;;CUDA files are highlighted with c++mode
(add-to-list 'auto-mode-alist '("\\.h\\'" .  c++-mode)) ;;*.h files are interpreted as cpp files
(setq backup-directory-alist `(("." . "~/.saves")))     ;;redirect all the backup files to ~/.saves
(setq column-number-mode t) ;;display column numbers in editor

(setq x-select-enable-clipboard t)   ;;;;copy from emacs to clipboard and vice-versa
(show-paren-mode 1)  ;;shows in blinking text a pair of matching parenthesis
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (wombat))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
