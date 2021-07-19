;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Jason Asselin"
      user-mail-address "asselin.jason@gmail.com")

(setq doom-theme 'doom-one)

(setq doom-font (font-spec :family "Source Code Pro" :size 15)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
      doom-big-font (font-spec :family "Source Code Pro" :size 24))

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.2))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
 )

(after! org
  (custom-set-faces!
    '(org-document-title :height 1.4)))

(setq display-line-numbers-type 'relative)
(setq company-idle-delay nil)

(setq org-directory "~/org/")
(setq org-hide-emphasis-markers t)

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
          :desc "Today" "t" #'org-journal-today)
         :desc "Home" "h" (lambda () (interactive) (find-file "~/org/_index.org"))))

(defun org-journal-today ()
  (interactive)
  (org-journal-new-entry t)))
