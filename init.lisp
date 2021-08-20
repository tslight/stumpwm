(in-package :stumpwm)

;; log everything to ~/.stumpwm.d/stumpwm.log
(redirect-all-output (merge-pathnames *data-dir* "stumpwm.log"))

;; add ~/.stumpwm-contrib as effectively and additional *module-dir*
(mapcar #'add-to-load-path (build-load-path
                            (concat (getenv "HOME") "/.stumpwm-contrib")))

;; load modules from both ~/.stumpwm-contrib and the default
;; ~/.stumpwm.d/modules directory
(mapcar #'load-module '("acpi"
                        "bind"
                        "brightness"
                        "clipboard-history"
                        "command-history"
                        "encouragement"
                        "global-windows"
                        "quitmenu"
                        "misc"
                        "modeline-click"
                        "move-group"
                        "ror-collection"
                        "rotate-windows"
                        "sensors"
                        "shell-command-history"
                        "theo"
                        "ttf-fonts"
                        "volume"
                        "xdgmenu"))

;; A nice insulting welcome message
(setf *startup-message* (concat "^B^5Welcome to StumpWM~%^n" (theo:random-quote)))

;; pretentious group names! The last 4 are floating by default.
(grename "Alpha")
(gnewbg "Beta")
(gnewbg "Tau")
(gnewbg "Pi")
(gnewbg "Zeta")
(gnewbg-float "Teta")
(gnewbg-float "Phi")
(gnewbg-float "Rho")
(gnewbg-float "Lambda")

;; define what windows go on what groups by default
(clear-window-placement-rules)
(define-frame-preference "Alpha"
  (0 t t :class "Emacs")
  (0 t t :class "Xfce4-terminal")
  (0 t t :class "st-256color")
  (0 t t :class "kitty")
  (0 t t :class "LilyTerm")
  (0 t t :instance "kitty")
  (0 t t :instance "lilyterm")
  (0 t t :instance "xterm"))

(define-frame-preference "Beta"
  (1 t t :role "browser")
  (1 t t :class "qBittorrent"))

(define-frame-preference "Tau"
  (2 t t :instance "libreoffice")
  (2 t t :role "file_manager")
  (2 t t :title "...File Manager"))

(define-frame-preference "Pi"
  (1 t t :class "Qemu-system-x86_64")
  (1 t t :class "Virt-manager"))

;; (xft:cache-fonts) ; slows down startup ALOT!
(set-font (make-instance 'xft:font
                         :family "DejaVu Sans Mono"
                         :subfamily "Bold"
                         :size 11))

(set-focus-color "green")
(set-unfocus-color "magenta")
(set-fg-color "#00AA00")
(set-bg-color "grey9")
(set-border-color "magenta")

(set-normal-gravity :bottom)
(setf *message-window-gravity* :center)
(setf *input-window-gravity* :center)

(setf *shell-program* (getenv "SHELL")) ;; getenv is not exported
(setf *mouse-focus-policy* :click)
(setf *frame-number-map* "asdfghjkl")
(setf *ignore-wm-inc-hints* t)
(setf *window-border-style* :tight)

(setf *mode-line-pad-x* 0)
(setf *mode-line-pad-y* 0)
(setf *mode-line-border-width* 0)
(setf *window-format* " [%n] [%s] [%m] %c ")
(setf *time-modeline-string* "^7*%H:%M %d/%m")
(setf *screen-mode-line-format* (list "^B^2*[%n]^n ^7*%v ^>^B%B %S %d"))

(setf clipboard-history:*clipboard-history-max-length* 100)
(clipboard-history:start-clipboard-manager)

;; put all my startup shell commands in a seperate file
(run-shell-command (namestring (merge-pathnames *data-dir* "init.sh")))

;; load all my custom keybindings
(load (merge-pathnames *data-dir* "keys.lisp"))
