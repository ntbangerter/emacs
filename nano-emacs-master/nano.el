;; ---------------------------------------------------------------------
;; GNU Emacs / N Λ N O - Emacs made simple
;; Copyright (C) 2020 - N Λ N O developers
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.
;; ---------------------------------------------------------------------
(package-initialize)

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
    ;; themes
    base16-theme
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

;; switch-window setup
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

;; enable line numbers globally
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

;; change list-buffers to buffer-menu
(global-set-key "\C-x\C-b" 'buffer-menu)

;; Path to nano emacs modules (mandatory)
(add-to-list 'load-path "/home/tanner/Downloads/nano-emacs-master")
;; (add-to-list 'load-path ".")

;; Default layout (optional)
(require 'nano-layout)

;; Theming Command line options (this will cancel warning messages)
;; (add-to-list 'command-switch-alist '("-dark"   . (lambda (args))))
;; (add-to-list 'command-switch-alist '("-light"  . (lambda (args))))
;; (add-to-list 'command-switch-alist '("-default"  . (lambda (args))))
;; (add-to-list 'command-switch-alist '("-no-splash" . (lambda (args))))
;; (add-to-list 'command-switch-alist '("-no-help" . (lambda (args))))
;; (add-to-list 'command-switch-alist '("-compact" . (lambda (args))))


;; (cond
;;  ((member "-default" command-line-args) t)
;;  ((member "-dark" command-line-args) (require 'nano-theme-dark))
;;  (t (require 'nano-theme-light)))

;; (require 'nano-theme-light)
(require 'nano-theme-dark)

;; Customize support for 'emacs -q' (Optional)
;; You can enable customizations by creating the nano-custom.el file
;; with e.g. `touch nano-custom.el` in the folder containing this file.
;; (let* ((this-file  (or load-file-name (buffer-file-name)))
;;        (this-dir  (file-name-directory this-file))
;;        (custom-path  (concat this-dir "nano-custom.el")))
;;   (when (and (eq nil user-init-file)
;;              (eq nil custom-file)
;;              (file-exists-p custom-path))
;;     (setq user-init-file this-file)
;;     (setq custom-file custom-path)
;;     (load custom-file)))

(setq nano-font-size 12)

;; Theme
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

;; disable tool and menu bars
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

