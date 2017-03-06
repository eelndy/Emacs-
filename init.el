;; init.el

;; INSTALL PACKAGES

;;-----------------------------------------------------------------
(require 'package)
(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.emacs-china.org/gnu/")
			 ("melpa" . "http://elpa.emacs-china.org/melpa/")))
(require 'cl)
      
(defvar eelndyPackages
  '(company
    hungry-delete
    swiper
    monokai-theme
    smartparens
    counsel
    popwin
    elpy
    flycheck
    py-autopep8
    ))

(setq package-selected-packages eelndyPackages)

(defun eelndyPackages-installed-p ()
  (loop for pkg in eelndyPackages
	when (not (package-installed-p pkg))
	do (return nil)
	finally (return t)))

(unless (eelndyPackages-installed-p)
  (message "%s" "Refreshinf package database...")
  (package-refresh-contents)
  (dolist (pkg eelndyPackages)
    (when (not (package-installed-p pkg))
	       (package-install pkg))))

;; BETTER-DEFAULTS
;; ------------------------------------------------------------

(setq inhibit-startup-message t)
(global-linum-mode t)
(global-company-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq-default make-backup-files nil)
(global-hl-line-mode t)
(menu-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)

;; PACKAGES CONFIG
;; --------------------------------------------------------------
(require 'hungry-delete)
(global-hungry-delete-mode)

(load-theme 'monokai t)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

(require 'smartparens-config)
(smartparens-global-mode t)

(require 'popwin)
(popwin-mode t)


;; PYTHON CONFIGURE
;; --------------------------------------------------------------
(elpy-enable)



(add-hook 'after-init-hook #'global-flycheck-mode)
 
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(require 'python)
(defun python-shell-parse-command ()
  "Return the string used to execute the inferior Python process."
  "/usr/bin/python3 -i")
