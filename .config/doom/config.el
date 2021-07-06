;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "klu"
      user-mail-address "k_foreign@outlook.com")

(setq doom-font (font-spec :family "source code pro" :size 24)
      doom-variable-pitch-font (font-spec :family "Source Code Variable" :size 18)
      doom-unicode-font (font-spec :family "思源黑体 CN")
      )

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8-unix)
(set-file-name-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-next-selection-coding-system 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(setq locale-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; (setq locale-coding-system 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (prefer-coding-system 'utf-8)

(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)

(map! :leader "w d" #'kill-buffer-and-window
              "w D" #'delete-window)         ; doom原本使用这个快捷键关闭窗口，现在加上杀死缓冲区的功能。
(fringe-mode 8)                                       ; 窗口边缘宽度设为8

(setq mouse-wheel-croll-amount
      '(2
        ((shift) . hscroll)
        ((meta))
        ((control) . text-scale)
        ))

(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
        ("http" . "127.0.0.1:8889")
        ("https" . "127.0.0.1:8889")))
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("org-cn". "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

;; (setq ivy-read-action-function 'ivy-hydra-read-action)

(setq ivy-height 12)

(use-package! ivy-rich
  :config
  (setq ivy-rich-path-style 'relative)
  (plist-delete! ivy-rich-display-transformers-list :counsel-M-x)
  (plist-put! ivy-rich-display-transformers-list
              'ivy-switch-buffer
              '(:columns
                ((ivy-switch-buffer-transformer (:width 0.25))
                 (ivy-rich-switch-buffer-size (:width 7))
                 (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
                 (ivy-rich-switch-buffer-major-mode (:width 0.1 :face warning))
                 (ivy-rich-switch-buffer-project (:width 0.1 :face success))
                 (ivy-rich-switch-buffer-path
                  (:width (lambda (x)
                            (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.1))))))
                :predicate
                (lambda (cand) (get-buffer cand)))
              )
  (progn
    (ivy-rich-mode -1)
    (ivy-rich-mode 1))
  )

(add-hook 'org-mode-hook
          (lambda nil
            (setq word-wrap nil))
          )

(setq reb-re-syntax 'string)

(setq doom-theme 'modus-operandi
      undo-limit 8000000              ; 提高 undo-limit 到 80Mb
      evil-want-fine-undo t            ; 默认在插入模式下，所有更改都是一大块。这里改成更加颗粒化。
      auto-save-default t              ; 自动保存，保存为临时文件
      inhibit-compacting-font-caches t ; 如果有大量字符，将他们保存在内存中。
      delete-by-moving-to-trash t      ; 删除时使用系统回收站
      tab-width 4
      uniquify-buffer-name-style 'forward
      window-combination-resize t ; take new window space from all other windows (not just current)
      x-stretch-cursor t ; 把光标宽度拉到字符宽度
      large-file-warning-threshold 100000000
      +latex-viewers '(pdf-tools okular)
      doom-localleader-key ","
      ;; https://stackoverflow.com/questions/24196020/how-to-stop-emacs-from-contaminating-the-clipboard
      save-interprogram-paste-before-kill t
      display-line-numbers-type nil ; 默认关闭行号
)
(setq-default line-spacing 0.2)                ; 行间距
(delete-selection-mode 1)              ; 选择文字并插入文字时替换文本
;; (global-subword-mode 1) ; CamelCase单词也认作单词
(tooltip-mode 1)
;; (auto-save-visited-mode 1) ; 自动保存，这个是能存到浏览中文件里的自动保存

(setq org-directory "~/org_notebooks/")

(add-hook 'org-mode-hook (lambda () (org-cycle-hide-drawers 'all)))

(setq org-html-head
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"src/readtheorg_theme/css/htmlize.css\"/>
<link rel=\"stylesheet\" type=\"text/css\" href=\"src/readtheorg_theme/css/readtheorg.css\"/>
<script type=\"text/javascript\" src=\"src/lib/js/jquery.min.js\"></script>
<script type=\"text/javascript\" src=\"src/lib/js/bootstrap.min.js\"></script>
<script type=\"text/javascript\" src=\"src/lib/js/jquery.stickytableheaders.min.js\"></script>
<script type=\"text/javascript\" src=\"src/readtheorg_theme/js/readtheorg.js\"></script>
")

(after! org
  (map! :map org-agenda-mode-map
        :nm "F" #'org-agenda-follow-mode)
  )

(after! org
  (setq org-file-apps
        '((remote . emacs)
         (auto-mode . emacs)
         (directory . emacs)
         ("\\.mm\\'" . default)
         ("\\.x?html?\\'" . "/usr/bin/firefox %s")
         ("\\.pdf\\'" . default))
        )
  )

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("org-plain-latex"
                 "\\documentclass{ctexart}
           [NO-DEFAULT-PACKAGES]
           [PACKAGES]
           [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(use-package! org
  :init
  (remove-hook 'org-mode-hook 'org-cdlatex-mode) ;默认不使用cdlatex，我现在用auto-activating-snippets
  )

(after! org
  (plist-put! org-format-latex-options
              :scale 2.2
              ;; :background "Transparent"
              ;; :html-background "Transparent"
              ;; :foreground "White"
              )
  (setq org-preview-latex-default-process 'dvipng)
  (setq-default org-startup-with-latex-preview nil) ; 是否启动时就预览latex.

  ;; 修复 `org-preview-latex-fragment' 中的颜色处理
  ;; https://github.com/hlissner/doom-emacs/issues/4023#issuecomment-735390477
  ;; (let ((dvipng--plist (alist-get 'dvipng org-preview-latex-process-alist)))
  ;;   ;; (plist-put dvipng--plist :use-xcolor t)
  ;;   (plist-put dvipng--plist :image-converter '("dvipng -D %D -T tight -o %O %f"))
  )

(defvar my-org-latex-delimiter-list '("inline" "display" "equation" "gather" "align")
  "几种常见的 latex 分隔符样式，用于 `my-expand-yasnippet-org-latex-inline'。")
(defvar my-org-latex-last-delimiter "inline"
  "上一个分隔符样式")

(defun my-org-latex-replace-delimiter (last-delimiter-list this-delimiter-list)
  (let* ((last-search-cons (elt last-delimiter-list 0))
         (this-replace-cons (elt this-delimiter-list 1))
         (last-search-str-b (car last-search-cons))
         (last-search-str-f (cdr last-search-cons))
         (this-replace-str-b (car this-replace-cons))
         (this-replace-str-f (cdr this-replace-cons))
         )
    (save-excursion
      (search-backward last-search-str-b)
      (replace-match this-replace-str-b)
      )
    (save-excursion
      (search-forward last-search-str-f)
      (replace-match this-replace-str-f)))
  )

(defun my-org-latex-get-delimiter-cons (delimiter-name)
  "返回每种分隔符对应的搜索cons和替换cons（二者可能不同）。"
  (cond ((equal delimiter-name "inline") (list (cons "\\(" "\\)") (cons "\\\\(" "\\\\)")))
        ((equal delimiter-name "display") (list (cons "\\[" "\\]") (cons "\\\\[" "\\\\]")))
        ((equal delimiter-name "equation") (list (cons "\\begin{equation}
"
                                                     "\\end{equation}")
                                               (cons "\\\\begin{equation}
"
                                                     "\\\\end{equation}")))
        ((equal delimiter-name "gather") (list (cons "\\begin{gather*}
"
                                                     "\\end{gather*}")
                                               (cons "\\\\begin{gather*}
"
                                                     "\\\\end{gather*}")))
        ((equal delimiter-name "align") (list (cons "\\begin{align*}
"
                                                    "\\end{align*}")
                                              (cons "\\\\begin{align*}
"
                                                    "\\\\end{align*}")))
        )
  )

;;;###autoload
(defun my-org-latex-start-math ()
  "首先检查当前点到行首的字符串，判断要不要插入空格，然后进入`sis-inline-mode'并插入latex分隔符
如果重复命令，会替换分隔符为 `my-org-latex-delimiter-list' 中的元素。"
  (interactive)

  (let* ((repeating-p (if (eq this-command last-command) t nil))
         (last-index (seq-position my-org-latex-delimiter-list my-org-latex-last-delimiter))
         (this-delimiter
          (if repeating-p
              ;; last-index 就是上一个分隔符在分隔符列表中的索引
              (or
               (when (eq (1- (length my-org-latex-delimiter-list)) last-index)
                 (car my-org-latex-delimiter-list))
               (elt my-org-latex-delimiter-list (1+ last-index)))
            (car my-org-latex-delimiter-list)))
         (str (buffer-substring (line-beginning-position) (point))))

    (if (not repeating-p)
        ;; 判断如果位于行首或者列表项目的起始，就不插入首空格
        (progn
          (if (or (equal str "")
                  (string-match-p "\\(^\\(- \\|+ \\|[0-9]\\. \\| *\\)$\\)\\|\\(.*[。？：；，（\\ ]$\\)" str))
              (progn (insert "\\")
                     ;; 使用sis的英语模式
                     (sis--inline-activate 'english (1- (point)))
                     (insert "(\\) "))
            (progn (insert " ")
                   (sis--inline-activate 'english (1- (point)))
                   (insert "\\(\\) ")))
          (backward-char 3)
          )
      ;; 如果在重复命令，那么就替换分隔符
      (my-org-latex-replace-delimiter
       (my-org-latex-get-delimiter-cons my-org-latex-last-delimiter)
       (my-org-latex-get-delimiter-cons this-delimiter)))
    ;; 设置上一个分隔符，可用于下一次
    (setq my-org-latex-last-delimiter this-delimiter)
    )
  )

(dolist (hook '(org-mode-hook LaTeX-mode-hook))
  (add-hook hook
            (lambda ()
              (define-key input-decode-map [?\C-m] [C-m])
              (local-set-key (kbd "<C-m>") #'my-org-latex-start-math)))
  )

;; (add-to-list 'org-tab-first-hook 'org-try-cdlatex-tab)

(setq org-image-actual-width '(450))

(map! :leader
      :prefix "f"
      :desc "find article" "a" #'ivy-bibtex
      )
(setq ivy-bibtex-default-action 'ivy-bibtex-insert-citation)

(setq! +biblio-pdf-library-dir "/home/klu/Downloads/_Literature/"
       +biblio-default-bibliography-files '("~/mybibliography/bibliography.bib")
       +biblio-notes-path "~/org_notebooks/roam/public/")

(use-package! org-roam
  :commands (org-roam-find-file)
  :init
  (setq org-roam-directory "~/org_notebooks/roam")
  (map! :leader
        :prefix "n"
        "l" #'org-roam
        "i" #'org-roam-insert
        "I" #'org-roam-insert-immediate
        "f" #'org-roam-find-file
        "c" #'org-roam-capture
        )
  (map! :leader
        :prefix "i"
        "b" #'orb-insert)
  :config
  ;; 在 roam buffer 中不显示 tab、行号，开启 latex 预览。buffer 不自动打开。
  (add-hook 'org-roam-buffer-prepare-hook
            (lambda nil
              (display-line-numbers-mode 0)
              (centaur-tabs-local-mode)
              (org-latex-preview '(16)))
            100)
  (setq +org-roam-open-buffer-on-find-file nil)
  )

(setq my-org-roam-public-file-name "./public/%<%Y%m%d%H%M%S>-${slug}")
(setq my-org-roam-private-file-name "%<%Y%m%d%H%M%S>-${slug}")
(setq org-roam-capture-immediate-template
      `(:key "d"
        :description "默认公共笔记"
        :body "* 概括\n* 主要内容\n%?\n\n* 联系\n"
        :file-name ,my-org-roam-public-file-name))

(defvar my-org-roam-capture-format-list
  `(
    (
     :key "d"
     :description "默认公共笔记"
     :body #'my-org-roam-capture-template
     :file-name ,my-org-roam-public-file-name
     )
    (
     :key "p"
     :description "私有笔记"
     :body #'my-org-roam-capture-template
     :file-name ,my-org-roam-private-file-name
     )
    )
  "org-roam capture的默认格式")

(defun my-org-roam-capture-template ()
  "template for my note"
  (concat 
   "%?\n"
   "* 参考\n"
   "%a"
   "\n"
   ))

(setq org-roam-capture-templates
      (let (templates)
        (dolist (singlelist my-org-roam-capture-format-list templates)
          (let ((template
                 `(
                   ,(plist-get singlelist :key) ,(plist-get singlelist :description)
                   plain #'org-roam-capture--get-point
                   ,(plist-get singlelist :body)
                   :file-name ,(plist-get singlelist :file-name)
                   :head ,(concat
                           "#+title: ${title}\n#+roam_tags: "
                           (plist-get singlelist :tags)
                           "\n#+roam_alias: \n\n"
                           )
                   :unnarrowed t)))
            ;; 在 templates 的后面添加
            (setq templates (append templates `(,template)))
            )
          )
        )
      )

(defun prompt-for-roam-tags-and-alias ()
  (org-roam-tag-add)
  (org-roam-alias-add)
  nil)

(use-package! org-roam-server
  :after org-roam
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 9090
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        ;; org-roam-server-serve-files nil
        ;; org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        ;; org-roam-server-network-poll t
        ;; org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20)
  )
(org-roam-server-mode)

(defun my-orb-latex-note-to-org (citekey)
  (let* ((entry (bibtex-completion-get-entry citekey))
         (note (bibtex-completion-get-value "note" entry ""))
         (pandoc-command "pandoc --from latex --to org")
         result)
    (with-temp-buffer
      (shell-command (format "echo \"%s\" | %s" note pandoc-command)
                     (current-buffer))
      (setq result (buffer-substring-no-properties (point-min) (point-max))))))

(setq orb-preformat-keywords '(
                               ("citekey" . "=key=")
                               "note"
                               "title"
                               "url"
                               "file"
                               "author-or-editor"
                               "keywords"))
(setq orb-templates
      '(("r" "ref" plain (function org-roam-capture--get-point)
         ""
         :file-name "./public/${=key=}_${title}"
         :head "#+TITLE: ${=key=}: ${title}
#+roam_key: ${ref}
#+roam_tags: lit
- tags ::
- keywords :: ${keywords}

* ${title}
:PROPERTIES:
:Custom_ID: ${=key=}
:URL: ${url}
:AUTHOR: ${author-or-editor}
:NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")
:NOTER_PAGE:
:END:

* Annotations (zotero)

%(my-orb-latex-note-to-org \"${citekey}\")
"
         :unnarrowed t)))

(setq orb-insert-link-description 'citation)

(use-package! delve
  :bind (("<f12>" . delve-open-or-select))
  :config
  (evil-define-key* '(normal insert) delve-mode-map
    (kbd "<return>") #'lister-key-action
    (kbd "<tab>") #'delve-expand-toggle-sublist
    (kbd "gr") #'delve-revert
    (kbd "s") #'delve-sort-sublist
    (kbd "<right>") #'delve-expand-insert-tolinks
    (kbd "<left>")  #'delve-expand-insert-backlinks
    (kbd "c") #'delve-collect
    (kbd "q") #'delve-kill-buffer)
  )
(use-package! delve-minor-mode
  :config
  (add-hook 'org-mode-hook #'delve-minor-mode-maybe-activate)
  )

(set-popup-rule! "^CAPTURE-.*\\.org$" :side 'left :size 0.5 :quit nil :select t :autosave t)

(use-package! org-journal
  :init
  (setq
   org-journal-time-format "IDEA %Y%m%d "
   org-journal-date-prefix "#+TITLE: "
   org-journal-dir "~/org_notebooks/journal/"
   org-journal-file-format "%Y-%m-%d.org"
   org-journal-date-format "%A, %x"
   org-journal-carryover-delete-empty-journal 'ask
   )
  :config
  (setq org-journal-find-file #'find-file-other-window)
  ;; 创建新条目的时候进入插入模式
  (add-hook 'org-journal-after-entry-create-hook (lambda nil (evil-append 1)))
  (setq org-journal-carryover-items "TODO=\"TODO\"|TODO=\"PROJ\"|TODO=\"IDEA\"")
  )
;; (setq org-journal-enable-agenda-integration t)

(setq org-log-done 'time
      org-log-into-drawer t
      org-log-state-notes-insert-after-drawers nil
      org-agenda-start-with-log-mode t)

(defvar jethro/org-current-effort "1:00"
  "Current effort for agenda items.")

(defun jethro/my-org-agenda-set-effort (effort)
  "Set the effort property for the current headline."
  (interactive
   (list (read-string (format "Effort [%s]: " jethro/org-current-effort) nil nil jethro/org-current-effort)))
  (setq jethro/org-current-effort effort)
  (org-agenda-check-no-diary)
  (let* ((hdmarker (or (org-get-at-bol 'org-hd-marker)
                       (org-agenda-error)))
         (buffer (marker-buffer hdmarker))
         (pos (marker-position hdmarker))
         (inhibit-read-only t)
         newhead)
    (org-with-remote-undo buffer
      (with-current-buffer buffer
        (widen)
        (goto-char pos)
        (org-show-context 'agenda)
        (funcall-interactively 'org-set-effort nil jethro/org-current-effort)
        (end-of-line 1)
        (setq newhead (org-get-heading)))
      (org-agenda-change-all-lines newhead hdmarker))))

(defun jethro/org-agenda-process-inbox-item ()
  "处理agenda中的各项，只处理优先级就够了"
  (org-with-wide-buffer
   ;; (org-agenda-set-tags)
   (org-agenda-priority-up)
   (org-agenda-priority-up)
   ;; (call-interactively 'jethro/my-org-agenda-set-effort)
   ))

;; (defvar jethro/org-agenda-bulk-process-key ?f
;;   "Default key for bulk processing inbox items.")

(setq org-agenda-bulk-custom-functions '((?b jethro/org-agenda-process-inbox-item)))

(use-package! org-super-agenda
  :commands (org-super-agenda-mode))
(after! org-agenda
  (org-super-agenda-mode))
;; header 中使用 evil 快捷键问题https://github.com/alphapapa/org-super-agenda/issues/112#issuecomment-548224512
(setq org-super-agenda-header-map nil)
(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-block-separator nil
      org-agenda-tags-column 100 ;; from testing this seems to be a good value
      org-agenda-compact-blocks t)
(setq org-agenda-files '("~/org_notebooks/journal/"))
(setq org-agenda-custom-commands
      '(("o" "全局概览"
         ((agenda "" ((org-agenda-span 1)
                      (org-agenda-start-day "+0")
                      ;; 注意这里，doom 对开始日期做了自定义，所以需要改回来
                      (org-super-agenda-groups
                       '((:name "今日时间表" :time-grid t :date today :scheduled today :log (close clock) :order 1)
                         (:name "已超期" :deadline past :face error :order 2)
                         (:name "快到期了" :deadline today :deadline future :order 3)
                         ))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '((:name "进行中" :todo "TODO" :order 1)
                          (:name "优先级A" :priority "A" :order 2)
                          (:name "优先级B" :priority "B" :order 3)
                          (:name "优先级C" :priority "C" :order 4)
                          ;; (:name "当前上课和工作" :tag "当前上课和工作" :order 5)
                          (:name "项目" :todo "PROJ" :order 6)
                          ;; (:name "Essay 1" :tag "Essay1" :order 2)
                          ;; (:name "Reading List" :tag "Read" :order 8)
                          ;; (:name "Work In Progress" :tag "WIP" :order 5)
                          ;; (:name "Blog" :tag "Blog" :order 12)
                          ;; (:name "Essay 2" :tag "Essay2" :order 3)
                          ;; (:name "Trivial" :priority<= "E" :tag ("Trivial" "Unimportant") :todo ("SOMEDAY" ) :order 90)
                          ;; (:discard (:tag ("Chore" "Routine" "Daily")))
                          ))))))))
;; 使用 =SPC o o= 打开全局概览
(map! :leader
      :prefix "o"
      :desc "agenda overview" "o" (lambda nil (interactive) (org-agenda nil "o")))

(setq
      ;; org-noter-notes-window-location 'other-frame
      org-noter-always-create-frame nil
      org-noter-hide-other t
      org-noter-notes-search-path (list "~/org_notebooks/roam/public/"))

(setq org-babel-default-header-args:python '((:session . "my_py_session") (:results . "output")))

(defun org-emphasize-bold ()
  "加粗。"
  (interactive)
  (org-emphasize ?\*))
(map! :map org-mode-map
      :v "C-b" 'org-emphasize-bold)

(add-hook 'org-mode-hook (lambda nil (ws-butler-mode -1)))

(use-package! org-download
  :config
  (setq org-download-screenshot-method "flameshot"))

(require 'ox-rst)
(require 'xref-rst)

(use-package! evil-pinyin
  :after evil
  :init
  (setq-default evil-pinyin-scheme 'simplified-xiaohe-all)
  (setq-default evil-pinyin-with-search-rule 'always)
  :config
  (global-evil-pinyin-mode t))

(use-package! evil-textobj-line
  :after evil)

(setq evil-escape-delay 0.4)
(setq evil-escape-unordered-key-sequence t)

(after! evil-snipe
  (evil-snipe-mode -1))

(setq evil-org-special-o/O '(table-row item))

(map! :map evil-visual-state-map
      "s" 'evil-surround-region)

(map! :i "C-v" 'yank)

(defhydra my-mc-hydra (:color pink
                       :hint nil
                       :pre (evil-mc-pause-cursors))
  "
^Match^            ^Line-wise^           ^Manual^
^^^^^^----------------------------------------------------
_Z_: match all     _J_: make & go down   _z_: toggle here
_m_: make & next   _K_: make & go up     _r_: remove last
_M_: make & prev   ^ ^                   _R_: remove all
_n_: skip & next   ^ ^                   _p_: pause/resume
_N_: skip & prev

Current pattern: %`evil-mc-pattern

"
  ("Z" #'evil-mc-make-all-cursors)
  ("m" #'evil-mc-make-and-goto-next-match)
  ("M" #'evil-mc-make-and-goto-prev-match)
  ("n" #'evil-mc-skip-and-goto-next-match)
  ("N" #'evil-mc-skip-and-goto-prev-match)
  ("J" #'evil-mc-make-cursor-move-next-line)
  ("K" #'evil-mc-make-cursor-move-prev-line)
  ("z" #'+multiple-cursors/evil-mc-toggle-cursor-here)
  ("r" #'+multiple-cursors/evil-mc-undo-cursor)
  ("R" #'evil-mc-undo-all-cursors)
  ("p" #'+multiple-cursors/evil-mc-toggle-cursors)
  ("q" #'evil-mc-resume-cursors "quit" :color blue)
  ("<escape>" #'evil-mc-resume-cursors "quit" :color blue))
(map!
 (:when (featurep! :editor multiple-cursors)
  :prefix "g"
  :nv "z" #'my-mc-hydra/body))

(use-package! laas
  :hook (org-mode . laas-mode)
  :config
  (setq laas-enable-auto-space nil)
  (aas-set-snippets 'laas-mode
                    :cond (lambda ()
                            (or (org-inside-LaTeX-fragment-p))
                            )
                    ";e" "\\varepsilon"
                    "tan" "\\tan"
                    ;; 范数
                    "norm" (lambda () (interactive)
                             (yas-expand-snippet "\\lVert $1 \\rVert $0"))
                    ;; 内积
                    "i*" (lambda () (interactive)
                           (yas-expand-snippet "\\langle$1\\rangle$0"))
                    "sum" (lambda () (interactive)
                            (yas-expand-snippet "\\sum_{${1:i=1}}^${2:\\infty} $0"))
                    "int" (lambda () (interactive)
                            (yas-expand-snippet (yas-lookup-snippet "int_^" 'org-mode)))
                    "sr" "^2"
                    "pw" (lambda () (interactive)
                           (yas-expand-snippet "^\{$1} $0"))
                    "lim" (lambda () (interactive)
                            (yas-expand-snippet "\\lim\\limits\_{${1:n \\to \\infty}} $0"))
                    "lrb" (lambda () (interactive)
                            (yas-expand-snippet "\\left($1\\right)$0"))
                    "lrlr" (lambda () (interactive)
                             (yas-expand-snippet "\\left${1:|}$2\\right$1$0"))
                    "sset" "\\subset "
                    "too" "\\to"
                    "noteq" "\\not= "
                    "part" (lambda () (interactive)
                             (yas-expand-snippet "\\frac{\\partial $1}{\\partial $2} $0"))
                    "deri" (lambda () (interactive)
                             (yas-expand-snippet "\\frac{d $1}{d $2} $0"))
                    ;; bind to functions!
                    :cond #'laas-object-on-left-condition
                    ",." (lambda () (interactive) (laas-wrap-previous-object "bm"))
                    ".," (lambda () (interactive) (laas-wrap-previous-object "bm"))
                    )
  )

(use-package! centaur-tabs
  :hook (doom-first-file . centaur-tabs-mode)
  :init
  (setq
        centaur-tabs-set-icons nil
        ;; centaur-tabs-gray-out-icons 'buffer
        ;; centaur-tabs-close-button "✕"
        centaur-tabs-set-close-button nil
        centaur-tabs-set-modified-marker t
        centaur-tabs-modified-marker "•")
  :config
  (centaur-tabs-change-fonts "Source Code Variable" 0.7)
  ;; 模仿火狐中 VimiumC 的标签相关行为
  (map! :nm "J" 'centaur-tabs-backward
        :nm "K" 'centaur-tabs-forward
        :nm "C-S-j" 'centaur-tabs-forward-group
        :nm "C-S-k" 'centaur-tabs-backward-group
        :nm "C-j" 'evil-join
        :nmv "C-k" '+lookup/documentation
        )
  ;; (add-hook '+doom-dashboard-mode-hook #'centaur-tabs-local-mode)
  (add-hook '+popup-buffer-mode-hook #'centaur-tabs-local-mode)
  (add-hook 'org-src-mode-hook #'centaur-tabs-local-mode)
  (add-hook 'pdf-view-mode-hook #'centaur-tabs-local-mode)
  (centaur-tabs-group-by-projectile-project)
  )

(map! :leader
      :prefix "o"
      :desc "open buf-file externally" "x" 'centaur-tabs-open-in-external-application
      :desc "open buf-folder externally" "d" 'centaur-tabs-open-directory-in-external-application)

(use-package! tex
  :config
  (setq-default TeX-engine 'xetex))

(use-package! pangu-spacing
  :config
  (add-to-list 'pangu-spacing-inhibit-mode-alist 'helm-major-mode)
  (global-pangu-spacing-mode 1)
  )

(setq +format-on-save-enabled-modes
      '(python-mode
        emacs-lisp-mode)
      )

(setq lsp-pyright-venv-path "/home/klu/.virtualenvs/")

(add-hook 'org-mode-hook 'hl-todo-mode)

(map! :leader
      :prefix "s"
      :desc "query-replace-regexp" "q" 'anzu-query-replace-regexp)

(use-package! anki-editor
  :init
  (setq anki-editor-use-math-jax t)
  :commands (anki-editor-mode)
  )

(use-package! keyfreq
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1)
  (setq keyfreq-excluded-commands
      '(
        ;; 最常用的命令：插入和上下左右移动命令、滚轮、删除
        self-insert-command
        org-self-insert-command
        forward-char
        backward-char
        evil-backward-char
        evil-forward-word-end
        previous-line
        next-line
        evil-previous-line
        evil-next-line
        dired-next-line
        dired-previous-line
        evil-previous-visual-line
        evil-next-visual-line
        evil-forward-char
        ivy-next-line
        ivy-previous-line
        mwheel-scroll
        backward-delete-char-untabify
        ivy-backward-delete-char
        
        +popup/quit-window
        sis-set-english
        right-char
        abort-recursive-edit
        ivy-done
        scroll-up-command
        company-select-next
        ;; evil 的经典命令 
        evil-scroll-down
        evil-scroll-page-down
        evil-scroll-page-up
        evil-normal-state
        evil-delete-backward-char-and-join
        evil-undo
        evil-visual-char
        evil-insert
        evil-backward-word-begin)))

(add-hook 'org-mode-hook (lambda () (smartparens-mode -1)))

(after! ccls
  (setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t)))
  (set-lsp-priority! 'ccls 2)) ; optional as ccls is the default in Doom

(map! "C-;" 'hippie-expand)

(setq org-emphasis-regexp-components '("-[:multibyte:][:space:]('\"{" "-[:multibyte:][:space:].,:!?;'\")}\\[" "[:space:]" "." 1))
(org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
(org-element-update-syntax)

(add-hook 'org-mode-hook #'valign-mode)
(setq valign-fancy-bar t)

(push '("ctexbeamer" "\\documentclass{ctexbeamer}"
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
      org-latex-classes)

(push '("ctexart" "\\documentclass{ctexart}"
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
      org-latex-classes)

(push '("beamerarticle" ""
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
      org-latex-classes)

(setq org-startup-with-latex-preview t)

(let* (
      (default-header (eval (car (get 'org-format-latex-header 'standard-value))))
      (newcommand "
\\usepackage{bm}
")
      (new-header (concat default-header newcommand)))
  (setq org-format-latex-header new-header))

(add-hook 'org-mode-hook (lambda () (org-fragtog-mode 1)))

(setq org-startup-with-inline-images t)

(advice-add 'org-agenda-quit :before 'org-save-all-org-buffers)

(add-hook 'evil-org-mode-hook
          (lambda nil
            (map! :map evil-org-mode-map
                  :n "O" '+evil/insert-newline-below)))

(setq ispell-program-name "aspell")
;; You could add extra option "--camel-case" for since Aspell 0.60.8 
;; @see https://github.com/redguardtoo/emacs.d/issues/796
(setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US" "--run-together" "--run-together-limit=16"))

(use-package! auto-save
  :config
  (setq auto-save-idle 5)
  (setq auto-save-silent t)
  (auto-save-enable))

(use-package! pyim
  :after ivy
  :config
  (setq ivy-re-builders-alist
        '(
          (counsel-rg . pyim-cregexp-ivy)
          (swiper . pyim-cregexp-ivy)
          (swiper-isearch . pyim-cregexp-ivy)
          (org-roam-tag-add . pyim-cregexp-ivy)
          (org-roam-alias-add . pyim-cregexp-ivy)
          (t . ivy--regex-ignore-order)
          )
        ))
