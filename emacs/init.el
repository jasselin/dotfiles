;; Package manager
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"          . "http://orgmode.org/elpa/")
			 ("gnu"          . "http://elpa.gnu.org/packages/")
			 ("melpa"        . "http://melpa.org/packages/")
			 ("melpa-stable" . "http://stable.melpa.org/packages/")))
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; disable backups and auto-save
(setq make-backup-files nil)
(setq auto-save-default nil)

;; disable splash screen and startup message
(setq inhibit-startup-message t) 
(setq initial-scratch-message nil)

;; show matching parentheses
(setq show-paren-delay 0)
(show-paren-mode 1)

;; UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1)
(global-visual-line-mode t)
(set-frame-font "DejaVu Sans Mono-10" t)

;; Disable prompt for:
;; Symbolic link to Git-controlled source file; follow link?
(setq vc-follow-symlinks nil)

;; Zoom in/out
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Paragraph movements
(global-set-key (kbd "s-j") 'forward-paragraph)
(global-set-key (kbd "s-k") 'backward-paragraph)

;; general keybindings
(use-package general
  :ensure t
  :config
  (general-evil-setup t))

(nvmap :prefix "SPC"
  "h r r" '((lambda () (interactive) (load-file "~/.emacs")) :which-key "Reload emacs config")
)

;; evil-mode
(unless (package-installed-p 'evil)
  (package-install 'evil))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

;; remap ; to :
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd ";") 'evil-ex))
;;(define-key evil-motion-state-map (kbd ":") 'evil-repeat-find-char)

;; which-key
(use-package which-key
  :ensure t
  :init (which-key-mode))

;; all-the-icons
;; must run before: M-x all-the-icons-install-fonts
(use-package all-the-icons
  :ensure t)

;; doom-themes
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-dracula t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;;(doom-themes-neotree-config)
  ;; or for treemacs users
  ;;(setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  ;;(doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)) 

; doom-modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; dashboard
(use-package dashboard
  :ensure t
  :init
  (setq dashboard-set-heading-icons t
	dashboard-set-file-icons t)
  :config
  (dashboard-setup-startup-hook))

;; projectile
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode 1))

;;(projectile-mode +1)
;; Recommended keymap prefix on macOS
;;(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;; Recommended keymap prefix on Windows/Linux
;;(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Default directory
(cd "~/")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(projectile dashboard doom-modeline doom-themes all-the-icons which-key evil-collection evil general use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
