(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#839496"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "4e262566c3d57706c70e403d440146a5440de056dfaeb3062f004da1711d83fc" default)))
 '(fci-rule-color "#eee8d5")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(magit-diff-use-overlays nil)
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c37300")
     (60 . "#b97d00")
     (80 . "#b58900")
     (100 . "#a18700")
     (120 . "#9b8700")
     (140 . "#948700")
     (160 . "#8d8700")
     (180 . "#859900")
     (200 . "#5a942c")
     (220 . "#439b43")
     (240 . "#2da159")
     (260 . "#16a870")
     (280 . "#2aa198")
     (300 . "#009fa7")
     (320 . "#0097b7")
     (340 . "#008fc7")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line


;; The code below is added by yiyi
;; load monokai theme
; (load-theme 'monokai t)
(load-theme 'tsdh-dark t)

;; init auto-complete-mode at start
(global-auto-complete-mode t)

;; init show-paren-mode
(show-paren-mode 1)

;; use js2-mode as initial mode for javascript file editing
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js-mode-hook 'js2-mode)
;; init paredit-mode for js2-mode
;(add-hook 'js2-mode-hook 'paredit-mode)

;; init ac-js2 for js2-mode
;; 这个启动后会出错。
;;(add-hook 'js2-mode-hook 'ac-js2-mode)

;; add tern.js
(add-hook 'js2-mode-hook 'tern-mode)
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))

;; get nth element of list
(defun nth (list i)
  (if (eq list '())
      '()
      (if (eq i 0)
	  (car list)
	(nth (cdr list)
	     (- i 1)))))

(defun init-startup-layout ()
  "
   by shd101wyy Yiyi Wang
   Split windows 

   (window-list) will return all available windows now
   (set-window-buffer (cadr (window-list)) \"*Messages*\") will set *Messages* buffer to selected buffer
   (select-buffer (car (window-list))) will select first window
   (current-buffer) will return current buffer for chosen window


        |  
    dir |    code
        |
   -------------------------
          shell      

"
  (interactive)

  ;; remove all other windows
  (delete-other-windows)
  ;;  (print (current-buffer))
  ;;  (print (window-list))

  ;; split windows
  (split-window-vertically) ;; create view for directory and files
  ;;(split-window-horizontally) ;; create view for terminal
  (enlarge-window 15)  ;; shrink below terminal window 
  ;;(shrink-window-horizontally 55)   ;; shrink left dir window
  
  ;;; display shell
  (shell "*shd101wyy-shell*")  ; create shell
  (set-window-buffer (cadr (window-list)) "*shd101wyy-shell*") ;; display shell

  ;;; display dir
  ;;(dired "./")

  ;; move cursor to the panel on right side.
  ;;(other-window 1)

  ;; done
  (message "Finish initializing working layout")
  )

(init-startup-layout)
