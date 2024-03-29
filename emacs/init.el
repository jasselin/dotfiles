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
;;(tool-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1)
(global-visual-line-mode t)
(set-frame-font "DejaVu Sans Mono-11" t)

;; Disable prompt for:
;; Symbolic link to Git-controlled source file; follow link?
(setq vc-follow-symlinks nil)

;; Zoom in/out
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Paragraph movements
(global-set-key (kbd "C-j") 'forward-paragraph)
(global-set-key (kbd "C-k") 'backward-paragraph)

;; orgmode
(setq org-return-follows-link t)

;; general keybindings
(use-package general
  :ensure t
  :config
  (general-evil-setup t))

(nvmap
  "é"             'evil-search-forward   ; cf layout fix for /
  "É"             'evil-search-backward  ; cf layout fix for ?
  ;"C-j"           'org-next-link
  ;"C-k"           'org-previous-link
  "C-<backspace>" '(switch-to-prev-buffer :which-key "previous buffer")
  "C-é"           'comment-region
  )

(nvmap :prefix "SPC"
  ;; "f"           '(helm-projectile-rg :which-key "ripgrep")
  ;; "SPC"         '(helm-M-x :which-key "M-x")

  ;; projectile
  ;; "p f"         '(helm-projectile-find-file :which-key "find files")
  ;; "p p"         '(helm-projectile-switch-project :which-key "switch project")
  ;; "p b"         '(helm-projectile-switch-to-buffer :which-key "switch buffer")
  ;; "p r"         '(helm-show-kill-ring :which-key "show kill ring")

  "s" 'split-window-below :which-key "Horizontal split"
  "v" 'split-window-right :which-key "Vertical split"

  "f" 'counsel-projectile-rg
  "p" 'projectile-switch-project

  ;; NeoTree
  "q"  '(neotree-toggle :which-key "toggle neotree")

  ;; init.el reload
  "h r r" '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :which-key "Reload emacs config")
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

(use-package evil-org
  :commands evil-org-mode
  :after org
  :init
  (add-hook 'org-mode-hook 'evil-org-mode)
  :config
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading)))))

;; remap ; to :
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "RET") nil)     ; remaps RET to nothing to allow it to open links in org mode
  (define-key evil-motion-state-map (kbd ";") 'evil-ex)) ; remaps ; to :

;; (use-package anzu
;;   :ensure t
;;   :config
;;   (global-anzu-mode 1)
;;   (global-set-key [remap query-replace-regex] 'anzu-query-replace-regexp)
;;   (global-set-key [remap query-replace] 'anzu-query-replace))

;; which-key
(use-package which-key
  :ensure t
  :init (which-key-mode))

(use-package org-superstar
  :ensure t
  :hook (org-mode . org-superstar-mode))

;; all-the-icons
;; must run before: M-x all-the-icons-install-fonts
(use-package all-the-icons
  :ensure t)

;; NeoTree
(use-package neotree
  :ensure t
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

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
  (doom-themes-neotree-config)
  ;; or for treemacs users
  ;;(setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  ;;(doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; doom-modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; dashboard
(use-package dashboard
  ;:init
  :ensure t
  :init
  (setq dashboard-set-heading-icons t
	dashboard-set-file-icons t
	dashboard-banner-logo-title "Welcome to Emacs Dashboard"
	dashboard-startup-banner 'logo
	dashboard-items '((projects . 5)
			  (recents . 5)
			  (agenda . 5)
			  (bookmarks . 5)
			  (registers . 5)))
  :config
  (dashboard-setup-startup-hook))

;; projectile
(use-package projectile
  :ensure t
  :config
  (projectile-mode 1))

;; ivy, counsel, swiper
(use-package counsel
  :ensure t
  :after ivy
  :config (counsel-mode))

(use-package ivy :demand
  :ensure t
  :defer 0.1
  :init
  (setq ivy-initial-inputs-alist nil)
  :custom
  (setq ivy-use-virtual-buffers t
	ivy-count-format "%d/%ddd ")
  :config
  (ivy-mode))

(use-package ivy-rich
  :ensure t
  :after ivy
  :custom
  (ivy-virtual-abbreviate 'full
   ivy-rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
			       'ivy-rich-switch-buffer-transformer)
  (ivy-rich-mode 1))
			  
(use-package swiper
  :ensure t
  :after ivy)
  

;; ;; helm
;; (use-package helm
;;   :ensure t
;;   :config
;;   (helm-mode 1))

;; (use-package helm-rg
;;   :ensure t)

;; (use-package helm-projectile
;;   :ensure t
;;   :init
;;   (setq helm-projectile-fuzzy-match t)
;;   :config
;;   (helm-projectile-on))

;; Flycheck
;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode))

;; LSP
(use-package lsp-mode
  :ensure t
  :init
  (add-hook 'prog-major-mode #'lsp-prog-major-mode-enable))

(use-package lsp-ui
  :ensure t
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; Company mode
(use-package company
  :ensure t
  :init
  (setq company-minimum-prefix-length 3)
  (setq company-auto-commit nil)
  (setq company-idle-delay 0)
  (setq company-require-match 'never)
  (setq company-frontends
	'(company-pseudo-tooltip-unless-just-one-frontend
	  company-preview-frontend
	  company-echo-metadata-frontend))
  (setq tab-always-indent 'complete)
  (defvar completion-at-point-functions-saved nil)
  :config
  (global-company-mode 1)
  (setq lsp-completion-provider :capf)
  (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
  (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
  (define-key company-mode-map [remap indent-for-tab-command] 'company-indent-for-tab-command)
  (defun company-indent-for-tab-command (&optional arg)
    (interactive "P")
    (let ((completion-at-point-functions-saved completion-at-point-functions)
	  (completion-at-point-functions '(company-complete-common-wrapper)))
      (indent-for-tab-command arg)))

  (defun company-complete-common-wrapper ()
    (let ((completion-at-point-functions completion-at-point-functions-saved))
      (company-complete-common))))

;; Default directory
(cd "~/")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ivy org-bullets company-lsp company lsp-ui lsp-mode flycheck projectile dashboard doom-modeline doom-themes all-the-icons which-key evil-collection evil general use-package)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
