;; TODO:
;; - Change font to cascadia.

(setq inhibit-startup-message t)

;; Use spaces for indentation
(setq-default indent-tabs-mode nil)
(setq tab-width 4) ; or any other preferred value

;; Few configurations to make Emacs compact.
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

;; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; use-package
;; https://github.com/jwiegley/use-package#installing-use-package
(eval-when-compile
  (require 'use-package))
;; Apply :ensure globally to make sure packages are installed automatically if
;; not already present on the system.
(setq use-package-always-ensure t)

;; Use Evil mode for vim bindings.
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-insert-state-cursor '((bar . 5) "yellow"))
  (setq evil-normal-state-cursor '(box "purple"))
  (setq evil-shift-width 4)
  :config
  (evil-mode 1)

  (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  ;; Make double C-c (as close to Vim's C-c as possible) go back to normal mode.
  (define-key evil-insert-state-map (kbd "C-c C-c") 'evil-normal-state)
  (define-key evil-normal-state-map (kbd "C-c C-c") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

;; "A collection of Evil bindings for the parts of Emacs that Evil does not cover porperly by default"
;; https://github.com/emacs-evil/evil-collection
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; change theme to a VSCode-like theme.
(use-package doom-themes
  :init (load-theme 'doom-dark+ t))
;; borrow doom-modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1))


;; Custom-related stuff.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-command-log-mode t)
 '(package-selected-packages
   '(ivy-prescient ivy-rich command-log-mode counsel doom-modeline doom-themes evil evil-collection ivy lsp-ivy lsp-mode lsp-python-ms lsp-treemacs use-package which-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Enable line and column numbers.
(column-number-mode)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

