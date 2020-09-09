;; ===================================
;; ORG MODE SETUP START
;; ===================================

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done 'time)
(setq org-use-speed-commands t)
(setq ns-function-modifier 'hyper)  ; make Fn key do Hyper

(setq org-startup-indented t)
(setq org-indent-indentation-per-level 2)

(setq org-goto-interface 'outline-path-completion
      org-goto-max-level 10)

;; Set fontsize
(set-face-attribute 'default nil :height 150)

(setq org-todo-keyword-faces
  '(("TODO" . (:foreground "#ff39a3" :weight bold))
))


;; Go to end of subtree
(defun goto-last-heading ()
  (interactive)
  (org-end-of-subtree))

(define-key org-mode-map (kbd "C-c g") 'goto-last-heading)

;; Auto saving configurations
;; (setq make-backup-files t               ; backup of a file the first time it is saved.
;;      version-control t                 ; version numbers for backup files
;;      delete-old-versions t             ; delete excess backup files silently
;;      delete-by-moving-to-trash t
;;      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
;;      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
(setq auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout t   ; number of seconds idle time before auto-save (default: 30)
;;      auto-save-interval 200  ; number of keystrokes between auto-saves (default: 300)
      )

;; Copy formatted content from emacs
(defun formatted-copy ()
  "Export region to HTML, and copy it to the clipboard."
  (interactive)
  (save-window-excursion
    (let* ((buf (org-export-to-buffer 'html "*Formatted Copy*" nil nil t t))
           (html (with-current-buffer buf (buffer-string))))
      (with-current-buffer buf
        (shell-command-on-region
         (point-min)
         (point-max)
         "textutil -stdin -format html -convert rtf -stdout | pbcopy"))
      (kill-buffer buf))))

(global-set-key (kbd "H-w") 'formatted-copy)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode agenda options                                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;open agenda in current window
(setq org-agenda-window-setup (quote current-window))
;;warn me of any deadlines in next 7 days
(setq org-deadline-warning-days 7)
;;show me tasks scheduled or due in next fortnight
(setq org-agenda-span (quote fortnight))
;;don't show tasks as scheduled if they are already shown as a deadline
(setq org-agenda-skip-scheduled-if-deadline-is-shown t)
;;don't give awarning colour to tasks with impending deadlines
;;if they are scheduled to be done
(setq org-agenda-skip-deadline-prewarning-if-scheduled (quote pre-scheduled))
;;don't show tasks that are scheduled or have deadlines in the
;;normal todo list
(setq org-agenda-todo-ignore-deadlines (quote all))
(setq org-agenda-todo-ignore-scheduled (quote all))
;;sort tasks in order of when they are due and then by priority
(setq org-agenda-sorting-strategy
  (quote
   ((agenda deadline-up priority-down)
    (todo priority-down category-keep)
    (tags priority-down category-keep)
    (search category-keep))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/org/todos/work.org"))
 '(package-selected-packages '(ox-hugo csv-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; ===================================
;; Org Mode Setup ends here
;; ===================================

;; ===================================
;; IDE Setup Starts here
;; ===================================
 
;; Enables basic packaging support - melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(with-eval-after-load 'ox
  (require 'ox-hugo))
;; ===================================
;; Basic Customization
;; ===================================

(setq inhibit-startup-message t)    ;; Hide the startup message
;; (global-linum-mode t)               ;; Enable line numbers globally
(setq python-shell-interpreter "python3")
;; Configuring spell check
(setq ispell-program-name "/usr/local/bin/aspell")
