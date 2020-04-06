; list the repositories containing them

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

; list the repositories containing them
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; list the packages you want
(setq package-list '(better-defaults
                     solarized-theme
                     helm
                     helm-projectile
                     helm-ag
                     ruby-electric
                     ruby-test-mode
                     rbenv
                     robe
                     org-journal
                     magit))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'better-defaults)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-journal-file-type (quote weekly))
 '(package-selected-packages
   (quote
    (yari markdown-mode wanderlust yaml-mode org-journal magit helm-rg ag rbenv ruby-test-mode ruby-electric helm-ag helm-projectile helm better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


; (setq org-default-notes-file (concat org-directory "/notes.org"))
; (define-key global-map "\C-cc" 'org-capture)
(require 'ido)
(ido-mode t)

(global-set-key (kbd "C-c g") 'magit)

(require 'org-journal)

(load-theme 'solarized-light t)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "s-f") #'helm-projectile-ag)
(global-set-key (kbd "s-t") #'helm-projectile-find-file-dwim)
(global-set-key (kbd "C-C i") #'helm-imenu)

(require 'ruby-test-mode)
(add-hook 'ruby-mode-hook 'ruby-test-mode)
(add-hook 'ruby-mode-hook (lambda ()
                            (set 'compile-command "rake " )))
(add-hook 'ruby-mode-hook (lambda ()
                            (local-set-key (kbd "C-C C-C") 'recompile)))

(require 'robe)
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook 'ruby-electric-mode)
(add-hook 'ruby-mode-hook (lambda ()
                            (local-set-key (kbd "C-c C-d") 'yari)))
(require 'yaml-mode)
 (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(require 'rbenv)
(global-rbenv-mode)

(add-to-list 'exec-path "/usr/local/bin/")

(add-hook 'text-mode-hook #'visual-line-mode)
(global-set-key (kbd "C-x C-l") #'perfect-margin-mode)

(require 'ox-odt)
(setq org-odt-preferred-output-format "docx")

(defun eval-buffer-and-test ()
  (eval-buffer)
  (ert t))

(add-hook 'emacs-lisp-mode-hook (lambda ()
                            (local-set-key (kbd "C-c C-c") (lambda () (interactive) (eval-buffer-and-test)))))

(defun exercism-submit ()
  (shell-command (format "exercism submit %s" (buffer-file-name))))

(global-set-key (kbd "C-c C-s") (lambda () (interactive) (exercism-submit)))

(autoload 'wl "wl" "Wanderlust" t)
