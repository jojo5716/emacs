;; Python environment config
; ==================================================================
;; Indent
(setq standard-indent 4)

;; Line-by-Line Scrolling
(setq scroll-step 1)

;; Turn Off Tab Character
(setq-default indent-tabs-mode nil)

;; Delete trailing spaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Extra configuration
; =================================================================

;; Creating backup files in specific directory
(setq make-backup-files nil)
(setq version-control t)
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))

;; Show line-number in the mode line
(line-number-mode 1)

;; Show column-number in the mode line
(column-number-mode 1)

;; Set cursor and mouse-pointer colours
(set-cursor-color "red")
(set-mouse-color "goldenrod")

;; Set region background colour
(set-face-background 'region "blue")

;; Set emacs background colour
(set-background-color "black")

;; yes or no
(defalias 'yes-or-no-p 'y-or-n-p)

; Column number mode
(setq column-number-mode t)
;; Show number line
(global-linum-mode 1)
(eval-after-load 'linum
  '(progn
     (defface linum-leading-zero
       `((t :inherit 'linum
            :foreground ,(face-attribute 'linum :background nil)))
       "Face for displaying leading zeroes for line numbers in display margin."
       :group 'linum)

      (defun linum-format-func (line)
        (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
           (propertize (format (format " %%%dd\u2506 " w) line) 'face 'linum)))
      (setq linum-format 'linum-format-func)
     (setq linum-format 'linum-format-func)))
 (set-face-attribute 'linum nil :background "#ddd")

;; Show trailing spaces
(defun show-ws-and-linum-on-files ()
  "Show trailing whitespace and line numbers on files only"
  (interactive)
  (when (not (eq buffer-file-name nil))
    (setq show-trailing-whitespace t)
    (linum-mode 1)))
(add-hook 'after-change-major-mode-hook 'show-ws-and-linum-on-files)

;; Show parentheses
(show-paren-mode 1)

;; Move windows around
(add-to-list 'load-path "~/.emacs.d/elpa/buffer-move-20150523.513/")
(require 'buffer-move)
(global-set-key (kbd "<C-s up>")     'buf-move-up)
(global-set-key (kbd "<C-s down>")   'buf-move-down)
(global-set-key (kbd "<C-s left>")   'buf-move-left)
(global-set-key (kbd "<C-s right>")  'buf-move-right)

;; Key binding
; =================================================================
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-c C-k") 'compile)
(global-set-key (kbd "C-x g") 'magit-status)

;; BREAKPOINT
(defun python-add-breakpoint ()
  "Insertamos un breakpoint"
  (interactive)
  (newline-and-indent)
  (insert "#breakpoint")
  )
(eval-after-load "python"
  '(define-key python-mode-map (kbd "<f9>") 'python-add-breakpoint))

;; Delete current line
(defvar previous-column nil "Save the column position")
(defun nuke-line()
  "Kill an entire line, including the trailing newline characte"
  (interactive)
  (setq previous-column (current-column))
  (end-of-line)
  (if (= (current-column) 0)
    (delete-char 1)
    (progn
      (beginning-of-line)
      (kill-line)
      (delete-char 1)
      (move-to-column previous-column))))

(global-set-key [f8] 'nuke-line)


;; New blank buffer
(defun my/new-scratch ()
    ; Returns the existing *scratch* buffer or creates a new one
    (interactive)
    (switch-to-buffer (get-buffer-create "*scratch*")))
(global-set-key (kbd "C-x C-n") 'my/new-scratch)


; Config plugins
; ===============================================================
; Helm
(global-set-key (kbd "C-x p") 'helm-projectile-find-file-dwim)
(add-to-list 'load-path "~/.emacs.d/helm/")
(require 'helm-config)

; IDO
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

;Anaconda
(add-hook 'python-mode-hook 'anaconda-mode)

;; Indent guide
(add-to-list 'load-path "~/.emacs.d/elpa/indent-guide-20150610.2322/")
(require 'indent-guide)
(indent-guide-global-mode)
(set-face-background 'indent-guide-face "dimgray")


;; Flycheck
(add-to-list 'load-path "~/.emacs.d/elpa/indent-guide-20150610.2322/")
(add-hook 'after-init-hook #'global-flycheck-mode)
;; Themes
; ===========================================================
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/boron-theme-20150117.952/")
(load-theme 'boron t)
;(load-theme 'boron-theme t)


;; ORG Config
; =============================================================
(setq org-log-done t
      org-todo-keywords '((sequence "TODO" "INPROGRESS" "DONE"))
      org-todo-keyword-faces '(("INPROGRESS" . (:foreground "blue" :weight bold))))
(add-hook 'org-mode-hook
          (lambda ()
            (flyspell-mode)))
(add-hook 'org-mode-hook
          (lambda ()
            (writegood-mode)))

(global-set-key (kbd "C-c C") 'org-capture)
; ORG Agenda
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-show-log t
      org-agenda-todo-ignore-scheduled t
      org-agenda-todo-ignore-deadlines t)
(setq org-agenda-files (list "~/org/personal.org"
                             "~/org/roiback.org"))

;; ORG Habit
(require 'org)
(require 'org-install)
(require 'org-habit)
(add-to-list 'org-modules "org-habit")
(setq org-habit-preceding-days 7
      org-habit-following-days 1
      org-habit-graph-column 80
      org-habit-show-habits-only-for-today t
      org-habit-show-all-today t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("c3232d379e847938857ca0408b8ccb9d0aca348ace6f36a78f0f7b4c5df0115c" "726dd9a188747664fbbff1cd9ab3c29a3f690a7b861f6e6a1c64462b64b306de" default)))
 '(indent-guide-global-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
