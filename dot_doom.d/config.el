;; Set PATH variable
(setenv "PATH" (concat (getenv "PATH") ":/home/nick/.local/bin" ":/home/nick/go/bin" ":/usr/local/go/bin"))
(setq exec-path (append exec-path '("/home/nick/.local/bin") '("/home/nick/go/bin") '("/usr/local/go/bin")))
(setq shell-file-name "bash")

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Nick")
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Source Code Pro" :size 14)
       doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to relative.
(setq display-line-numbers-type 'relative)

;; Set projectile configuration
(setq projectile-project-search-path '("~/code/"))

;; Set doom logo
(setq +doom-dashboard-banner-file (expand-file-name "doom.png" doom-private-dir))

;; Switch to the new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Remove format with lsp
(setq +format-with-lsp nil)

;; Remove lsp diasgnostics
(use-package! lsp-mode
  :ensure t
  :custom
  (lsp-diagnostics-provider :none))

;; Exit insert mode by pressing j and then j quickly
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)

;; gdscript configuration
(setq gdscript-gdformat-save-and-format t)
(setq gdscript-indent-offset 4)
(setq gdscript-use-tab-indents t)
(setq gdscript-godot-executable "/usr/bin/godot-mono")
(defun gdscript-custom-settings ()
  (setq tab-width 4))

(add-hook 'gdscript-mode-hook 'gdscript-custom-settings)

;; Ignore errors related to the gdscript language server
(defun lsp--gdscript-ignore-errors (original-function &rest args)
  "Ignore the error message resulting from Godot not replying to the `JSONRPC' request."
  (if (string-equal major-mode "gdscript-mode")
      (let ((json-data (nth 0 args)))
        (if (and (string= (gethash "jsonrpc" json-data "") "2.0")
                 (not (gethash "id" json-data nil))
                 (not (gethash "method" json-data nil)))
            nil ; (message "Method not found")
          (apply original-function args)))
    (apply original-function args)))

;; Runs the function `lsp--gdscript-ignore-errors` around `lsp--get-message-type` to suppress unknown notification errors.
(advice-add #'lsp--get-message-type :around #'lsp--gdscript-ignore-errors)

;; Delete trailing whitespace
(add-hook! 'before-save-hook #'delete-trailing-whitespace)

;; Disable comment continuation with the o/O keys
;; (setq +evil-want-o/O-to-continue-comments nil)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
