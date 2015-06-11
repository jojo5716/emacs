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
(setq make-backup-files t)
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

; Config plugins
; ===============================================================

; Helm
(global-set-key (kbd "C-x p") 'helm-locate)
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

; Emmet mode
;(require 'emmet-mode)
;(require 'init-recentf)
;; Themes
; ===========================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("726dd9a188747664fbbff1cd9ab3c29a3f690a7b861f6e6a1c64462b64b306de" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )