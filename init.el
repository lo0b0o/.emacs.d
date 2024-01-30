(require 'package)
(add-to-list 'package-archives (cons "melpa" "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'proof-general)
  (package-refresh-contents)
  (package-install 'proof-general))

(pcase system-type
 ('darwin
  (pcase (file-expand-wildcards "/Applications/CoqIDE_*.app/Contents/Resources/bin/coqtop.opt")
    (`(,path) (progn
		(setq coq-prog-name path)
		(setq coq-compiler (concat (file-name-directory path) "coqc"))
		(setq coq-dependency-analyzer (concat (file-name-directory path) "coqdep"))))
    (`() (warn "I couldn't find any CoqIDE installations in /Applications. If you used homebrew, things should be fine."))
    (paths (warn (concat "I found more than one CoqIDE installation in /Applications. Please uninstall all but one. Paths:\n  " (mapconcat 'identity paths "\n  "))))))
 ('windows-nt (progn
		(setq coq-prog-name "D:/Coq/bin/coqtop.opt.exe")
		(setq coq-compiler "D:/Coq/bin/coqc.exe")
		(setq coq-dependency-analyzer "D:/Coq/bin/coqdep.exe"))))

(setq proof-electric-terminator-enable nil
      proof-next-command-insert-space nil
      proof-next-command-on-new-line nil
      coq-one-command-per-line nil
      coq-symbol-highlight-enable t
      coq-compile-before-require t
      proof-full-annotation t
      proof-script-fly-past-comments t
      proof-splash-enable nil
      proof-mode-abbrev-table '()
      coq-mode-abbrev-table '()
      proof-three-window-mode-policy 'hybrid)
(require 'proof-general)
(add-hook 'proof-mode-hook
          (lambda ()
            (define-key proof-mode-map (kbd "C-z") 'pg-protected-undo)))

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(global-set-key (kbd "C-z") 'undo)

(auto-revert-mode 1)
(delete-selection-mode 1)
(tool-bar-mode -1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("123a8dabd1a0eff6e0c48a03dc6fb2c5e03ebc7062ba531543dfbce587e86f2a" "4cf9ed30ea575fb0ca3cff6ef34b1b87192965245776afa9e9e20c17d115f3fb" default))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(yasnippet use-package spacemacs-theme sml-mode proof-general pdf-tools latex-preview-pane highlight-parentheses gruvbox-theme ess-smart-underscore cdlatex auctex ac-math))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro Medium" :foundry "outline" :slant normal :weight normal :height 102 :width normal)))))

(load-theme 'gruvbox-light-hard t)
