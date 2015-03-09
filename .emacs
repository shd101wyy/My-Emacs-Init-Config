(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("4e262566c3d57706c70e403d440146a5440de056dfaeb3062f004da1711d83fc" default))))
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
(load-theme 'monokai t)

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
