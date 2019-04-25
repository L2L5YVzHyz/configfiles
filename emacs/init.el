(set-fringe-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)

(global-unset-key [(control z)])
(global-unset-key [(control x)(control z)])

(global-visual-line-mode 1)
(size-indication-mode 1)

(set-frame-parameter (selected-frame) 'internal-border-width 0)

(add-to-list 'exec-path "/usr/local/bin/")

(setq make-backup-files nil)
(global-display-line-numbers-mode)

(require 'package)

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections."))
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(load-theme 'cyberpunk t)
(defun yank-pop-forwards (arg)
      (interactive "p")
      (yank-pop (- arg)))
(global-set-key "\M-Y" 'yank-pop-forwards)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)
(add-to-list 'default-frame-alist '(font . "Hack-11"))
(setq c-default-style "linux"
          c-basicj-offset 8)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#000000" "#8b0000" "#00ff00" "#ffa500" "#7b68ee" "#dc8cc3" "#93e0e3" "#dcdccc"])
 '(custom-safe-themes
   (quote
    ("2aa073a18b2ba860d24d2cd857bcce34d7107b6967099be646d9c95f53ef3643" "a77735fe0193d57476298d982de95c51f1625da7aa4a07473be8143cf3326dc2" "fe349b21bb978bb1f1f2db05bc87b2c6d02f1a7fe3f27584cd7b6fbf8e53391a" "43180189de000382b2a8a91fd904860a71905292ff86ee54c1710ef053a80de3" "addfaf4c6f76ef957189d86b1515e9cf9fcd603ab6da795b82b79830eed0b284" "dd2346baba899fa7eee2bba4936cfcdf30ca55cdc2df0a1a4c9808320c4d4b22" default)))
 '(fci-rule-color "#383838")
 '(package-selected-packages
   (quote
    (win-switch flycheck-rust xclip exec-path-from-shell py-autopep8 rope-read-mode elpy jedi fish-mode rust-mode fish-completion python-mode abyss-theme ## green-is-the-new-black-theme pdf-tools magit datetime helm highlight-parentheses flycheck cyberpunk-theme))))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(require 'org)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(require 'win-switch)
(win-switch-setup-keys-ijkl "\C-xo" "\C-x\C-o")

(setq org-log-done t)
(setq dired-listing-switches "-alh")

(global-flycheck-mode 1)

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(provide 'init)
