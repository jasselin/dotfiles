;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Jason Asselin"
      user-mail-address "asselin.jason@gmail.com")

(setq doom-theme 'doom-dracula)

(setq doom-font (font-spec :family "Source Code Pro" :size 14)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 14)
      doom-big-font (font-spec :family "Source Code Pro" :size 24))

(after! org
  (custom-set-faces!
    '(org-document-title :height 1.4)))

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.2))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
 )

(setq display-line-numbers-type 'relative)
(setq company-idle-delay nil)

(setq org-directory "~/vault/")
(setq org-hide-emphasis-markers t) ; Enlève les /,*,= autour du texte stylé
(setq org-ellipsis " ▼")

(map!
 :nv ";" #'evil-ex
 :nv "é" #'evil-search-forward  ;; /
 :nv "É" #'evil-search-backward ;; Shift + / => ?
 (:leader
  "#" #'previous-buffer
  )
 )

(map! :map general-override-mode-map
      :n "C-j" #'forward-paragraph
      :n "C-k" #'backward-paragraph)

(remove-hook 'doom-first-input-hook #'evil-snipe-mode)

(use-package! vulpea
  :after org)

(load! "agenda.el")

(after! (org vulpea)
  (setq org-agenda-files (directory-files-recursively "~/vault/" "\\.org$"))
  (setq org-log-done 'time) ; CLOSED timestamp
  (add-to-list 'org-tags-exclude-from-inheritance "project")

  (setq org-agenda-prefix-format
        '((agenda . " %i %(vulpea-agenda-category 20)%?-20t% s")
          (todo . " %i %(vulpea-agenda-category 20) ")
          (tags . " %i %(vulpea-agenda-category 20) ")
          (search . " %i %(vaulpea-agenda-category 20) ")))

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
                          (org-agenda-files '("~/vault/inbox.org"))))

            (todo "WAIT" ((org-agenda-overriding-header "En attente")))

            (todo "PROG" ((org-agenda-overriding-header "En cours")))

            (todo "NEXT" ((org-agenda-overriding-header "Next")))
            )
           nil))
        )

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "PROG(r)" "WAIT(w@)" "HOLD(h@)"
                    "|"
                    "DONE(d)" "KILL(k@)")))

  (setq org-todo-keyword-faces
        '(("NEXT" . +org-todo-active)
          ("PROG" . +org-todo-active)
          ("WAIT" . +org-todo-onhold)
          ("HOLD" . +org-todo-onhold)
          ("KILL" . +org-todo-cancel)))

  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/vault/inbox.org" "Tâches")
           "* TODO %?\n  %i"))))

(use-package! org-roam
  :init
  (map! :leader
        :prefix "n"
        :desc "org-roam" "l" #'org-roam-buffer-toggle
        :desc "org-roam-node-insert" "i" #'org-roam-node-insert
        :desc "org-roam-node-find" "f" #'org-roam-node-find
        :desc "org-roam-ref-find" "r" #'org-roam-ref-find
        :desc "org-roam-show-graph" "g" #'org-roam-show-graph
        :desc "org-roam-capture" "c" #'org-roam-capture
        :desc "org-roam-dailies-goto-today" "j" #'org-roam-dailies-goto-today
        :desc "org-roam-dailies-goto-date" "d" #'org-roam-dailies-goto-date
        :desc "org-roam Index" "h" (lambda () (interactive) (find-file "~/vault/_index.org")))

  (setq org-roam-directory (file-truename "~/vault/")
        org-roam-db-gc-threshold most-positive-fixnum
        org-roam-v2-ack t)

  (add-to-list 'display-buffer-alist
               '(("\\*org-roam\\*"
                  (display-buffer-in-direction)
                  (direction . right)
                  (window-width . 0.33)
                  (window-height . fit-window-to-buffer))))

  :config
  (setq org-roam-mode-sections
        (list #'org-roam-backlinks-insert-section
              #'org-roam-reflinks-insert-section
              ;; #'org-roam-unlinked-references-insert-section
              ))
  (org-roam-setup)
  (setq org-roam-capture-templates
        '(("d" "default" plain
           "%?"
           :if-new (file+head "${slug}.org"
                              "#+title: ${title}\n")
           :immediate-finish t
           :unnarrowed t)))
  (setq org-roam-capture-ref-templates
        '(("r" "ref" plain
           "%?"
           :if-new (file+head "${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t))))
