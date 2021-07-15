;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jason Asselin"
      user-mail-address "asselin.jason@gmail.com")

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(map!
 :nv ";" #'evil-ex
 :nv "é" #'evil-search-forward
 :nv "É" #'evil-search-backward
 (:leader
  "#" #'previous-buffer
  )
 )

(map! :map general-override-mode-map
      :n "C-j" #'forward-paragraph
      :n "C-k" #'backward-paragraph
      )

(remove-hook 'doom-first-input-hook #'evil-snipe-mode)

(after! org
  (setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))

  (setq org-log-done 'time) ; CLOSED timestamp

  (setq org-agenda-prefix-format '((agenda . " %i %-20:c%?-12t% s")
                                   (todo   . " %i %-20:c") ;; Plus de caractères pour afficher la catégorie
                                   (tags   . " %i %-20:c")
                                   (search . " %i %-20:c")))
  ;; (setq org-agenda-custom-commands
  ;;              '(("W" "Weekly review"
  ;;                agenda ""
  ;;                ((org-agenda-start-day nil)
  ;;                 (org-agenda-span 14)
  ;;                 (org-agenda-start-on-weekday 1)
  ;;                 (org-agenda-start-with-log-mode '(closed clock state))
  ;;                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp "^\\*\\* DONE "))))))

  (setq org-agenda-custom-commands
        '(("n" "Agenda"
           (
            (agenda ""
                    ((org-agenda-span 1)
                     (org-agenda-start-day nil)
                     (org-agenda-start-with-log-mode t)
                     (org-agenda-log-mode-items '(closed clock state))))

            ;; (todo "" ((org-agenda-overriding-header "Terminé")
            ;;           ))

            (todo "TODO" ((org-agenda-overriding-header "Inbox")
                          (org-agenda-files '("~/org/inbox.org"))))

            (todo "WAIT" ((org-agenda-overriding-header "En attente")))

            (todo "PROG" ((org-agenda-overriding-header "En cours")))

            (todo "NEXT" ((org-agenda-overriding-header "Next")))
            )
           nil))

        )

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "PROG(r)" "WAIT(w@)" "HOLD(h@)" "PROJ(p)"
                    "|"
                    "DONE(d)" "KILL(k@)")))

  (setq org-todo-keyword-faces
        '(("NEXT" . +org-todo-active)
          ("PROG" . +org-todo-active)
          ("WAIT" . +org-todo-onhold)
          ("HOLD" . +org-todo-onhold)
          ("PROJ" . +org-todo-project)
          ("KILL" . +org-todo-cancel)))

  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/org/inbox.org" "Tâches")
           "* TODO %?\n  %i")))
  )

(use-package! org-journal
  :after org
  :config
  ;; (customize-set-variable 'org-journal-dir (concat org-roam-directory "journal"))
  (customize-set-variable 'org-journal-file-format "%Y-%m-%d.org")
  (customize-set-variable 'org-journal-date-prefix "#+TITLE: ")
  (customize-set-variable 'org-journal-time-prefix "* ")
  (customize-set-variable 'org-journal-time-format "")
  ;; (customize-set-variable 'org-journal-carryover-items "TODO=\"TODO\"")
  (customize-set-variable 'org-journal-date-format "%Y-%m-%d")

  (map! :leader
        (:prefix-map ("n" . "notes")
         (:prefix ("j" . "journal")
          :desc "Today" "t" #'org-journal-today)))

  (defun org-journal-today ()
    (interactive)
    (org-journal-new-entry t)))
