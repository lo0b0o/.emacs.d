(require 'package)


(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("melpa-stable" . "https://mirrors.ustc.edu.cn/elpa/melpa-stable/")
                         ("org" . "https://mirrors.ustc.edu.cn/elpa/org/")))


 	
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
;; cdlatex
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-cdlatex)   ; with Emacs latex mode


;; Use pdf-tools to open PDF files
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)

;; Update PDF buffers after successful LaTeX runs
(add-hook 'TeX-after-compilation-finished-functions
           #'TeX-revert-document-buffer)

(add-hook 'LaTeX-mode-hook
      (lambda()
        (local-set-key [C-tab] 'TeX-complete-symbol)))

(package-initialize)

;;auto-complete
(ac-config-default)

(require 'auto-complete-config)
(ac-config-default)

;; Activate auto-complete for latex modes (AUCTeX or Emacs' builtin one).
(add-to-list 'ac-modes 'latex-mode)

;; Activate ac-math.
(eval-after-load "latex"
  '(when (featurep 'auto-complete)
     ;; See https://github.com/vspinu/ac-math
     (require 'ac-math)
     (defun ac-latex-mode-setup ()       ; add ac-sources to default ac-sources
       (setq ac-sources
         (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
             ac-sources)))
     (add-hook 'LaTeX-mode-hook 'ac-latex-mode-setup)))
(ac-set-trigger-key "TAB")

;;highlight latex in orgmode
(eval-after-load 'org
  '(setf org-highlight-latex-and-related '(latex)))

;; xetex
(setq-default TeX-engine 'xetex)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("123a8dabd1a0eff6e0c48a03dc6fb2c5e03ebc7062ba531543dfbce587e86f2a" "a06658a45f043cd95549d6845454ad1c1d6e24a99271676ae56157619952394a" "aded61687237d1dff6325edb492bde536f40b048eab7246c61d5c6643c696b7f" "8f97d5ec8a774485296e366fdde6ff5589cf9e319a584b845b6f7fa788c9fa9a" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(org-agenda-files '("d:/OneDrive - mail.ustc.edu.cn/schedule.org"))
 '(package-selected-packages
   '(ess gruvbox-theme cdlatex ac-math auto-complete pdf-tools yasnippet auctex spacemacs-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; Parentheses
(use-package highlight-parentheses
  :ensure t
  :config
  (progn
    (highlight-parentheses-mode)
    (global-highlight-parentheses-mode))
  )
;; ess mode
(require 'ess-smart-underscore)

(setq-default ispell-program-name "aspell")

(load-theme 'gruvbox-light-soft)

(put 'upcase-region 'disabled nil)
