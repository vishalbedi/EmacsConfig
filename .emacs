;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Package repos;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))(require 'package)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Auto complete;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; autocomplete
(require 'auto-complete-config)
(ac-config-default)
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)
; case sensitivity is important when finding matches
(setq ac-ignore-case nil)


;; autopair and yas in all modes
(autopair-global-mode)

;-----------;
;;; Modes ;;;
;-----------;

;; Ido mode
(require 'ido)
(ido-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Haskell Mode;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

;; hslint on the command line only likes this indentation mode;
;; alternatives commented out below.
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; Ignore compiled Haskell files in filename completions
(add-to-list 'completion-ignored-extensions ".hi")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;UI;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;linum mode
(global-linum-mode 1)
;; Linum-Mode and add space after the number
(setq linum-format "%d ")
;;Theme
(load-theme 'deeper-blue)

;;cursor type
(set-default 'cursor-type 'hbar)

;; ===== Set the highlight current line minor mode =====

;; In every buffer, the line which contains the cursor will be fully
;; highlighted

(global-hl-line-mode 1)
(set-face-background hl-line-face "gray12")
;; ===== Turn on Auto Fill mode automatically in all modes =====

;; Auto-fill-mode the the automatic wrapping of lines and insertion of
;; newlines when the cursor goes over the column limit.

;; This should actually turn on auto-fill-mode by default in all major
;; modes. The other way to do this is to turn on the fill for specific modes
;; via hooks.

(setq auto-fill-mode 1)

;;Set global font mode
(global-font-lock-mode 1)

(show-paren-mode t)
(setq show-paren-style 'expression)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Js2mode;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook '(lambda ()
                           (local-set-key "\C-x\C-e" 'eval-last-sexp)
                           (local-set-key "\C-cb" 'js-send-buffer)
                           (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
                           (local-set-key "\C-cl" 'js-load-file-and-go)
                           (local-set-key "\C-c!" 'run-js)
                           (local-set-key "\C-c\C-r" 'js-send-region)
                           (local-set-key "\C-c\C-j" 'js-send-line)
                           (local-set-key "\C-c\C-u" 'whitespace-clean-and-compile)
                           ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;Js-comnit;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'js-comint)
;; Use node as our repl
(setq inferior-js-program-command "node --interactive")
(setenv "NODE_NO_READLINE" "1")

(setq inferior-js-mode-hook
      (lambda ()
        ;; We like nice colors
        (ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        (add-to-list 'comint-preoutput-filter-functions
                     (lambda (output)
                       (replace-regexp-in-string ".*1G\.\.\..*5G" "..."
                     (replace-regexp-in-string ".*1G.*3G" "&gt;" output))))))

(setq inferior-js-mode-hook
      (lambda ()
        ;; We like nice colors
        (ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        (add-to-list
         'comint-preoutput-filter-functions
         (lambda (output)
           (replace-regexp-in-string "\033\\[[0-9]+[GKCJ]" "" output)))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Customizations;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;dont create annoying files
(setq make-backup-files nil)
;;Get Rid of Menubar
 ;;never have a retarded tool-bar at top
(tool-bar-mode -1)
 ;;never have a retarded menu-bar at top
(menu-bar-mode -1)
(scroll-bar-mode -1)
;;no extra whitespace after lines
(add-hook 'before-save-hook 'delete-trailing-whitespace)
