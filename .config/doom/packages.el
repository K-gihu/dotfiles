;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! sis)
(package! evil-pinyin)
(package! evil-textobj-line)
(package! org-noter-pdftools)
(package! org-fragtog)
(package! pangu-spacing)
(package! org-roam-server)
(package! command-log-mode)
(package! auto-activating-snippets
  :recipe (:host github :repo "ymarco/auto-activating-snippets"))
(package! latex-auto-activating-snippets
  :recipe (:host github :repo "tecosaur/LaTeX-auto-activating-snippets"))
(package! org-super-agenda)
(package! valign)
(package! keyfreq)
(package! lister
  :recipe (:host github :repo "publicimageltd/lister"))
(package! delve
  :recipe (:host github :repo "publicimageltd/delve"))
(package! color-rg
  :recipe (:host github :repo "manateelazycat/color-rg"))
(package! centaur-tabs)
(package! auto-save
  :recipe (:host github :repo "manateelazycat/auto-save"))
(package! wucuo)
;; (package! pdf-continuous-scroll-mode
;;   :recipe (:host github :repo "dalanicolai/pdf-continuous-scroll-mode.el"))

(package! eaf
  :recipe (:host github
           :repo  "manateelazycat/emacs-application-framework"
           :files ("*")))
(package! ctable
  :recipe (:host github :repo "kiwanami/emacs-ctable"))
(package! epc)

;; (package! rime)
;; (package! eaf
;;   :recipe (:host github
;;                        :repo "manateelazycat/emacs-application-framework"
;;                        :files ("*.el" "*.py" "core" "app"))
;;   :pin "c302d16c3840fb2bc655041b130ead0494662779")

;; (package! zotxt)
;; Translate chinese function names to english ones.
;; (package! insert-translated-name
;;   :recipe (:host github :repo "manateelazycat/insert-translated-name"))
;; (package! anki-editor)
