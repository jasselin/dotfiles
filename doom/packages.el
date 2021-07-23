;; -*- no-byte-compile: t; -*-

(package! org-roam
  :recipe (:host github :repo "org-roam/org-roam" :branch "master"))

(package! vulpea
  :recipe (:type git :host github :repo "d12frosted/vulpea"))

(package! org-super-agenda)
