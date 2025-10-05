(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))


(use-package emacs
  :init
  (setq inhibit-startup-message t)
  (setq ring-bell-function 'ignore)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (global-visual-line-mode 1)
  (global-display-line-numbers-mode)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode)
  ;; (set-frame-font "Iosevka Fixed 13")
  (set-frame-font "Iosevka Nerd Font")
  (setq initial-scratch-message ";; How perfect is this\n;; How lucky are we\n\n")
  (setq initial-buffer-choice t)
  (setq backup-directory-alist '(("." . "~/.emacs.d/backup")))
  (setq exec-path (append exec-path '("~/.local/bin/")))
  
  :bind
  ("M-p" . beginning-of-defun)
  ("M-n" . end-of-defun)
  ("<backtab>" . indent-rigidly-left)
  
  :hook
  (after-init . toggle-frame-fullscreen))


;; close completions minibuffer on exit
(add-hook 'minibuffer-exit-hook 
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
            (kill-buffer buffer)))))


;; add spacing between windows
(add-to-list 'default-frame-alist '(internal-border-width . 16))
;; (set-fringe-mode 5)
(setq-default right-fringe-width 0)
(setq-default left-fringe-width 10)
(setq window-divider-default-right-width 16)
(setq window-divider-default-bottom-width 16)
(setq window-divider-default-places t)
(window-divider-mode)

;; change how buffers with the same name are identified 
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; (setq text-scale-mode-step 1.1)

;; disable this on MacOS, throws an error otherwise
(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

(setq-default fringes-outside-margins nil)
(setq-default indicate-buffer-boundaries nil) ;; Otherwise shows a corner icon on the edge
(setq-default indicate-empty-lines nil)       ;; Otherwise there are weird fringes on blank lines

(set-face-attribute 'header-line t :inherit 'default)

(column-number-mode t) ;; Show current column number in mode line

;; custom mode line
(setq-default mode-line-format
  '("%e"
	(:propertize " " display (raise +0.2)) ;; Top padding
	(:propertize " " display (raise -0.2)) ;; Bottom padding

	(:propertize "λ  " face font-lock-comment-face)
	mode-line-modified
	mode-line-frame-identification
	mode-line-buffer-identification

	;; Version control info
	(:eval (when-let (vc vc-mode)
			 ;; Use a pretty branch symbol in front of the branch name
			 (list (propertize "   " 'face 'font-lock-comment-face)
                   ;; Truncate branch name to 50 characters
				   (propertize (truncate-string-to-width
                                (substring vc 5) 50)
							   'face 'font-lock-comment-face))))

	;; Add space to align to the right
	(:eval (propertize
			 " " 'display
			 `((space :align-to
					  (-  (+ right right-fringe right-margin)
						 ,(+ 3
                             (string-width "%4l:3%c")))))))
	
	;; Line and column numbers
	(:propertize "%4l:%c" face mode-line-buffer-id)))


(use-package paren
  :ensure nil
  :init
  (electric-pair-mode t)
  (setq show-paren-delay 0)
  
  :config
  (show-paren-mode +1))


(use-package dired
  :ensure nil
  :bind
  (:map dired-mode-map
    ("RET" . dired-find-alternate-file)
    ("^" . (lambda() (interactive) (find-alternate-file "..")))))


(use-package eshell
  :ensure nil
  
  :bind
  ("C-c t" . eshell))


(use-package ace-window)


(use-package switch-window
  :bind
  (("C-x o" . switch-window)
   ("C-x C-b" . buffer-menu)))


(use-package nerd-icons)


;; (use-package modus-themes
;;   :config
;;   (load-theme 'modus-operandi t)
;;   (set-face-attribute 'fringe nil :background 'unspecified)
;;   (set-face-attribute 'line-number nil :slant 'italic :background 'unspecified)
;;   (set-face-attribute 'window-divider nil :foreground "white")
;;   (set-face-attribute 'window-divider-first-pixel nil :foreground "white")
;;   (set-face-attribute 'window-divider-last-pixel nil :foreground "white")
;;   (set-face-attribute 'mode-line nil :box nil)
;;   (set-face-attribute 'mode-line-inactive nil :box nil)
;;   )

;; (use-package nord-theme
;;   :ensure t
;;   :config
;;   (load-theme 'nord t)
;;   (set-face-attribute 'fringe nil :background 'unspecified)
;;   (set-face-attribute 'line-number nil :slant 'italic :background 'unspecified)
;;   (set-face-attribute 'window-divider nil :foreground "#2e3440")
;;   (set-face-attribute 'window-divider-first-pixel nil :foreground "#2e3440")
;;   (set-face-attribute 'window-divider-last-pixel nil :foreground "#2e3440")
;;   (set-face-attribute 'mode-line nil :box nil)
;;   (set-face-attribute 'mode-line-inactive nil :box nil)
;;   )

(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t)
  (set-face-attribute 'fringe nil :background 'unspecified)
  (set-face-attribute 'line-number nil :slant 'italic :background 'unspecified)
  (set-face-attribute 'window-divider nil :foreground "#3f3f3f")
  (set-face-attribute 'window-divider-first-pixel nil :foreground "#3f3f3f")
  (set-face-attribute 'window-divider-last-pixel nil :foreground "#3f3f3f")
  (set-face-attribute 'mode-line nil :box nil)
  (set-face-attribute 'mode-line-inactive nil :box nil)
  ;; (set-face-attribute 'git-gutter-fr:modified nil :foreground "#E0CF9F")
  )


(use-package hungry-delete
  :bind
  (("C-c DEL" . hungry-delete-backward)))


(use-package gptel
  :init
  (load "~/.emacs.d/gptel-config.el")
  :config
  (add-hook 'gptel-post-response-functions 'gptel-end-of-response)
  :bind
  (("C-c c" . gptel))
  )


(use-package magit
  :config
  (setq magit-display-buffer-function
      (lambda (buffer)
        (display-buffer
         buffer (if (and (derived-mode-p 'magit-mode)
                         (memq (with-current-buffer buffer major-mode)
                               '(magit-process-mode
                                 magit-revision-mode
                                 magit-diff-mode
                                 magit-stash-mode
                                 magit-status-mode)))
                    nil
                  '(display-buffer-same-window))))))


;; (use-package aider
;;   :config
;;   ;; For latest claude sonnet model
;;   ;; (setq aider-args '("--model" "sonnet" "--no-auto-accept-architect"))
;;   ;; (setenv "ANTHROPIC_API_KEY" anthropic-api-key)
;;   ;; Or gemini model
;;   ;; (setq aider-args '("--model" "gemini"))
;;   ;; (setenv "GEMINI_API_KEY" <your-gemini-api-key>)
;;   ;; Or chatgpt model
;;   ;; (setq aider-args '("--model" "o4-mini"))
;;   ;; (setenv "OPENAI_API_KEY" <your-openai-api-key>)
;;   ;; Or use your personal config file
;;   ;; (setq aider-args `("--config" ,(expand-file-name "~/.aider.conf.yml")))
;;   ;; ;;
;;   ;; Optional: Set a key binding for the transient menu
;;   (global-set-key (kbd "C-c a") 'aider-transient-menu) ;; for wider screen
;;   ;; or use aider-transient-menu-2cols / aider-transient-menu-1col, for narrow screen
;;   (aider-magit-setup-transients)) ;; add aider magit function to magit menu


(use-package aidermacs
  :bind (("C-c a" . aidermacs-transient-menu))
  ;; :config
  ;; (load-file (expand-file-name "aider-config.el" user-emacs-directory))
  )


(use-package git-gutter
  :ensure t
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02))


(use-package git-gutter-fringe
  :ensure t
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  ;; (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom)
  (set-face-foreground 'git-gutter-fr:modified "#D0BF8F")
  ;; (define-fringe-bitmap 'git-gutter-fr:deleted [224] nil nil '(center repeated))
  )


(use-package eglot
  :ensure t
  :config
  (add-to-list 'eglot-server-programs '(
    (python-mode python-ts-mode)
    "uv" "run" "basedpyright-langserver" "--stdio"
  ))
  :hook
  (go-mode . eglot-ensure)
  (python-mode . eglot-ensure))


(defun uv-python-shell-calculate-command ()
  "Calculate the string used to execute the inferior Python process."
  (format "%s %s"
          ;; `python-shell-make-comint' expects to be able to
          ;; `split-string-and-unquote' the result of this function.
          "uv run python"
          python-shell-interpreter-args))

(advice-add 'python-shell-calculate-command :override #'uv-python-shell-calculate-command)

(setq python-shell-dedicated 'project)
(setq python-shell-prompt-detect-failure-warning nil)
(setq python-shell-completion-native-enable nil)


(use-package company
  :hook
  (after-init . global-company-mode))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("fbf73690320aa26f8daffdd1210ef234ed1b0c59f3d001f342b9c0bbf49f531c" default))
 '(package-selected-packages nil)
 '(warning-suppress-types
   '(((python python-shell-completion-native-turn-on-maybe))
     ((python python-shell-completion-native-turn-on-maybe))
     ((python python-shell-completion-native-turn-on-maybe)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
