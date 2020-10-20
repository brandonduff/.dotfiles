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
                     auto-complete
                     solarized-theme
                     helm
                     helm-projectile
                     helm-ag
                     ruby-electric
                     ruby-test-mode
                     rbenv
                     robe
                     ruby-refactor
                     forge
                     github-review
                     git-gutter
                     projectile
                     org-journal
                     ripgrep
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
    (yari markdown-mode wanderlust org-journal magit helm-rg ag rbenv ruby-test-mode ruby-electric helm-ag helm-projectile helm better-defaults))))
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

; Default auto-complete config
(ac-config-default)

(require 'org-journal)
(setq org-agenda-file-regexp "\\`\\\([^.].*\\.org\\\|[0-9]\\\{8\\\}\\\(\\.gpg\\\)?\\\)\\'")
(setq org-agenda-files (list org-journal-dir))

(require 'git-gutter)
(global-git-gutter-mode +1)

(load-theme 'solarized-light t)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "s-f") #'helm-projectile-ag)
(global-set-key (kbd "s-t") #'helm-projectile-find-file-dwim)
(global-set-key (kbd "C-C i") #'helm-imenu)

(require 'ruby-test-mode)
(add-hook 'ruby-mode-hook 'ruby-test-mode)
(add-hook 'ruby-mode-hook (lambda ()
                            (set 'compile-command "bundle exec rake " )))
(add-hook 'ruby-mode-hook (lambda ()
                            (local-set-key (kbd "C-C C-C") 'recompile)))

(require 'robe)
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook 'ruby-electric-mode)
(add-hook 'ruby-mode-hook (lambda ()
                            (local-set-key (kbd "C-c C-d") 'yari)))
(add-hook 'robe-mode-hook 'ac-robe-setup)

(require 'ruby-refactor)
(add-hook 'ruby-mode-hook 'ruby-refactor-mode-launch)

(setq ruby-insert-encoding-magic-comment nil)
(require 'rbenv)
(global-rbenv-mode)

(add-to-list 'exec-path "/usr/local/bin/")

(add-hook 'text-mode-hook #'visual-line-mode)
(add-hook 'text-mode-hook #'flyspell-mode)
(global-set-key (kbd "C-x C-l") #'perfect-margin-mode)

; Enable Projectile
(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)

(with-eval-after-load 'magit
  (require 'forge))

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

(add-hook 'org-mode-hook 'org-indent-mode)
(global-set-key (kbd "C-c C-M-j") 'org-journal-open-current-journal-file)
(global-set-key (kbd "C-c s l") 'org-store-link)
; Make terminal colors work when running tests with Projectile
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
