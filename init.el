;; .emacs.d/init.el

;; ===============================
;; MELPA Package Support
;; ===============================
;; Enables basic package support
(require 'package)

;; Adds the MELPA archive to the list of available repositories
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(better-defaults
    ace-window
    flycheck
    ess
    ado-mode
    switch-window
    pdf-tools
    elpy
    ein
    magit
    xkcd
    pyvenv
    vlf
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)


;; ===============================
;; Basic Customization
;; ===============================
(setq inhibit-startup-message t)
;; (global-set-key (kbd "M-o") 'ace-window)

;; switch-window setup
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

;; vlf setup
(require 'vlf-setup)
;; (custom-set-variables
;;  '(vlf-application 'dont-ask))

;; change list-buffers to buffer-menu
(global-set-key "\C-x\C-b" 'buffer-menu)

;; only use a single buffer when navigating using dired
(require 'dired)
;; was dired-advertised-find-file
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
;; was dired-up-directory
(define-key dired-mode-map (kbd "^") (lambda() (interactive)
				       (find-alternate-file "..")))

;; enable line numbers globally
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))


;; ===============================
;; NANO Setup
;; ===============================

;; Path to nano emacs modules (mandatory)
(add-to-list 'load-path "~/.emacs.d/nano-emacs-master")

;; Default layout (optional)
(require 'nano-layout)

;; set font size
(setq nano-font-size 12)

;; Theme
;; (require 'nano-theme-light)
(require 'nano-theme-dark)

(require 'nano-faces)
(nano-faces)

(require 'nano-theme)
(nano-theme)

;; Nano default settings (optional)
(require 'nano-defaults)

;; Nano session saving (optional)
(require 'nano-session)

;; Nano header & mode lines (optional)
(require 'nano-modeline)

;; Nano key bindings modification (optional)
(require 'nano-bindings)

;; Compact layout (need to be loaded after nano-modeline)
(when (member "-compact" command-line-args)
  (require 'nano-compact))
  
;; Nano counsel configuration (optional)
;; Needs "counsel" package to be installed (M-x: package-install)
;; (require 'nano-counsel)

;; Welcome message (optional)
(let ((inhibit-message t))
  (message "Welcome to GNU Emacs / N Λ N O edition")
  (message (format "Initialization time: %s" (emacs-init-time))))

;; Splash (optional)
(unless (member "-no-splash" command-line-args)
  (require 'nano-splash))

;; Help (optional)
(unless (member "-no-help" command-line-args)
  (require 'nano-help))

(provide 'nano)


;; ===============================
;; Additional Setup
;; ===============================

;; disable tool and menu bars
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; disable chime sound
(setq ring-bell-function 'ignore)


;; ===============================
;; Development Setup
;; ===============================
(elpy-enable)

;; (setq elpy-rpc-python-command "python3")

;; use flycheck instead of flymake in elpy
(when (load "flycheck" t t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; autoformat code on save in elpy
(add-hook 'elpy-mode-hook (lambda()
			    (add-hook 'before-save-hook
				      'elpy-format-code nil t)))

;; Use ado-mode for Stata .do files
(require 'ado-mode)

;; set EIN default jupyter server
(setq ein:jupyter-default-server-command "/home/tanner/anaconda3/bin/jupyter")


;; ===============================
;; Custom Functions
;; ===============================
;; ssh into NBER servers
(defun ssh (server_number path)
  (interactive "sServer: \nsPath: ")
  (find-file (concat "/ssh:tannerb@"
		     server_number
		     ".nber.org:"
		     (if (string= path "")
			 "/disk/genetics/data/fhs/private/latest/scripts/"
		       path))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8cf1002c7f805360115700144c0031b9cfa4d03edc6a0f38718cef7b7cabe382" "78c1c89192e172436dbf892bd90562bc89e2cc3811b5f9506226e735a953a9c6" default)))
 '(package-selected-packages
   (quote
    (switch-window pdf-tools flycheck better-defaults ado-mode ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
