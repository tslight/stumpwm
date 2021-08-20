;; unbind all the default bindings
(setf *root-map* (make-sparse-keymap))
(setf *groups-map* (make-sparse-keymap))
(setf *group-root-map* (make-sparse-keymap))
(setf *tile-group-root-map* (make-sparse-keymap))
(setf *float-group-root-map* (make-sparse-keymap))

(defvar *frame-map* (make-sparse-keymap))
(defvar *screen-map* (make-sparse-keymap))

;; the top-map is the map that requires no prefix. pI use the Super key for
;; most of this bindings so that they don't clobber other application bindings
;; (mainly Emacs!)
(bind:key
 *top-map*
 ;; laptop function keys
 ("XF86AudioLowerVolume" "volume Master 5%-")
 ("XF86AudioRaiseVolume" "volume Master 5%+")
 ("XF86AudioMute" "volume Master toggle")
 ("XF86MonBrightnessDown" "brightness 10%-")
 ("XF86MonBrightnessUp" "brightness 10%+")
 ;; application launching on keyboards that have these keys
 ("XF86Launch5" "ror-emacs")
 ("XF86Launch6" "ror-st")
 ("XF86Launch7" "ror-web-browser")
 ("XF86Launch8" "ror-file-manager")
 ("XF86Search" "xdgmenu")
 ("XF86Favorites" "xdgmenu categories")
 ;; application launching with super
 ("s-r" "exec")
 ("s-e" "ror-emacs")
 ("s-t" "ror-kitty-with-tmux")
 ("s-c" "ror-tabbed-st")
 ("s-b" "ror-web-browser")
 ("s-f" "ror-file-manager")
 ("s-SPC" "xdgmenu")
 ("s-." "xdgmenu categories")
 ;; screenshots
 ("SunPrint_Screen" "exec maim -u -m 1 ~/Pictures/$(date '+%Y%m%d.%H%M%S').png")
 ("C-SunPrint_Screen" "exec maim -s -u -m 1 ~/Pictures/$(date '+%Y%m%d.%H%M%S').png")
 ;; windows
 ("M-Tab" "next")
 ("M-ISO_Left_Tab" "prev")
 ("s-Escape" "global-other")
 ("C-F4" "delete")
 ("M-F4" "kill")
 ("s-q" "delete")
 ("C-F11" "fullscreen")
 ("C-F12" "expose")
 ("C-s-w" "windowlist")
 ("s-w" "global-windowlist")
 ("C-s-f" "float-this")
 ("M-s-f" "unfloat-this")
 ;; access other key maps
 ("C-s-s" '*screen-map*)
 ("C-F1" '*help-map*)
 ;; groups
 ("s-g" "grouplist")
 ("C-s-g" "vgroups")
 ("s-n" "gnext")
 ("s-p" "gprev")
 ("C-s-n" "gnext-with-window")
 ("C-s-p" "gprev-with-window")
 ;; frames
 ("s-o" "fother")
 ("C-s-r" "iresize")
 ("M-F10" "only")
 ("C-F10" "toggle-only")
 ("s-s" "vsplit")
 ("C-s-v" "toggle-split")
 ("s-v" "hsplit")
 ("s-S-x" '*exchange-window-map*)
 ;; misc
 ("s-m" "mode-line")
 ("s-x" "colon")
 ("C-s-x" "eval")
 ("M-s-r" "reload++")
 ("C-s-XF86Eject" "exec slock")
 ("C-s-Delete" "exec slock")
 ("C-s-q" "quitmenu")
 ("C-M-S-q" "quit"))
;; use vi keys to switch focus or move windows
(loop for (vi-key name) in '(("k" "up")
                             ("j" "down")
                             ("h" "left")
                             ("l" "right"))
      do (let ((super-key (format nil "s-~A" vi-key))
               (ctrl-super-key (format nil "C-s-~A" vi-key)))
           (bind:key
            *top-map*
            (super-key (format nil "move-focus ~A" name))
            (ctrl-super-key (format nil "move-window ~A" name)))))
;; numbers 1-9 to select or move to groups
(dotimes (i 10)
  (unless (eq i 0)
    (bind:key
     *top-map*
     ((format nil "s-~a" i) (format nil "gselect ~a" i))
     ((format nil "C-s-~a" i) (format nil "gmove-and-follow ~a" i))
     ((format nil "M-s-~a" i) (format nil "gmove ~a" i)))))

;; this is the default, keeping this as a reference
(set-prefix-key (kbd "C-t"))
;; this is the main C-t prefix
(bind:key
 *root-map*
 ;; applications
 ("r" "exec")
 ("SPC" "xdgmenu")
 ("." "xdgmenu categories")
 ("c" "ror-kitty-with-tmux")
 ("C-c" "ror-tabbed-st")
 ("e" "ror-emacs")
 ("C-e" "exec emacs")
 ("b" "ror-web-browser")
 ("C-b" "exec chromium")
 ("f" "ror-file-manager")
 ("y" "show-clipboard-history")
 ("M-g" "google")
 ("M-y" "youtube")
 ("M-u" "prompt exec x-www-browser https://")
 ("M-s" "prompt exec x-terminal-emulator -e ssh ")
 ;; maps
 ("f" '*frame-map*)
 ("g" '*groups-map*)
 ("h" '*help-map*)
 ("C-s" '*screen-map*)
 ;; windows
 ("C-t" "global-other")
 ("t" "send-escape")
 ("n" "next")
 ("p" "previous")
 ("M-n" "pull-hidden-next")
 ("M-p" "pull-hidden-previous")
 ("o" "pull-hidden-other")
 ("v" "expose")
 ("s" "select")
 ("w" "global-windowlist")
 ("C-w" "global-pull-windowlist")
 ("M-w" "windowlist")
 ("S-w" "pull-from-windowlist")
 ("C-f" "float-this")
 ("M-f" "unfloat-this")
 ("u" "next-urgent")
 ("m" "mark")
 ("C-m" "pull-marked")
 ("F" "fullscreen")
 ("d" "delete")
 ("k" "kill")
 ("z" "toggle-only")
 ("C-o" "fother")
 ("Delete" "repack-window-numbers")
 ("M-i" "show-window-properties")
 ;; misc
 ("E" "encouragement")
 ("T" "theo")
 ("I" "info")
 ("x" "colon")
 ("C-x" "eval")
 (";" "colon")
 (":" "eval")
 ("M-m" "lastmsg")
 ("m" "mode-line")
 ("S" "swank")
 ("C-S-t" "title")
 ("M-t" "time")
 ("Escape" "abort")
 ("C-g" "abort")
 ("C-l" "exec slock")
 ("l" "exec slock")
 ("C-r" "loadrc")
 ("M-r" "reload++")
 ("M-q" "quit")
 ("q" "quitmenu")
 ("C-q" "send-raw-key")
 ;; displays
 ("C-d" "redisplay")
 ("C-h" "refresh-heads"))
;; change windows with numbers
(dotimes (i 10)
  (bind:key
   *root-map*
   ((format nil "~a" i) (format nil "select-window-by-number ~a" i))
   ((format nil "C-~a" i) (format nil "pull ~a" i))))

;; accessible via C-t f
(bind:key
 *frame-map*
 ("o" "fother")
 ("m" "send-escape")
 ("f" "fselect")
 ("n" "fnext")
 ("p" "fprev")
 ("c" "fclear")
 ("d" "remove")
 ("q" "only")
 ("z" "toggle-only")
 ("x" '*exchange-window-map*)
 ("v" "hsplit")
 ("s" "vsplit")
 ("=" "balance-frames")
 ("SPC" "toggle-split")
 ("r" "iresize")
 ("o" "rotate-windows")
 ("C-g" "abort")
 ("Escape" "abort"))
;; use vi keys to move focus and move windows
(loop for (vi-key name) in '(("k" "up")
                             ("j" "down")
                             ("h" "left")
                             ("l" "right"))
      do (let ((key-combo (format nil "~A" vi-key))
               (ctrl-key-combo (format nil "C-~A" vi-key)))
           (bind:key
            *frame-map*
            (key-combo (format nil "move-focus ~A" name))
            (ctrl-key-combo (format nil "move-window ~A" name)))))

;; accessible via C-t f x
(bind:key
 *exchange-window-map*
 ("C-g" "abort")
 ("Escape" "abort"))
;; use vi keys to exchange windows in frames
(loop for (vi-key name) in '(("k" "up")
                             ("j" "down")
                             ("h" "left")
                             ("l" "right"))
      do (let ((key-combo (format nil "~A" vi-key)))
           (bind:key
            *exchange-window-map*
            (key-combo (format nil "exchange-direction ~A" name)))))

;; accessible via C-t g
(bind:key
 *groups-map*
 ("c" "gnew")
 ("o" "gother")
 ("n" "gnext")
 ("p" "gprev")
 ("C-n" "gnext-with-window")
 ("C-p" "gprev-with-window")
 ("g" "vgroups")
 ("l" "grouplist")
 ("m" "gmove")
 ("M-m" "gmove-marked")
 ("r" "grename")
 ("s" "gselect")
 ("k" "gkill")
 ("C-g" "abort")
 ("Escape" "abort"))
;; numbers 1-9 to select, move and move with window
(dotimes (i 10)
  (unless (eq i 0)
    (bind:key
     *groups-map*
     ((format nil "~a" i) (format nil "gselect ~a" i))
     ((format nil "M-~a" i) (format nil "gmove ~a" i))
     ((format nil "C-~a" i) (format nil "gmove-and-follow ~a" i)))))

;; accessible via C-t C-s
(bind:key
 *screen-map*
 ("n" "snext")
 ("p" "sprev")
 ("C-s" "sother")
 ("r" "refresh-heads")
 ("C-g" "abort")
 ("Escape" "abort"))

;; menu bindings
(bind:key
 *menu-map*
 ("TAB" 'menu-down)
 ("ISO_Left_Tab" 'menu-up))

;; rebind keys within the applications classes defined at the top
(define-remapped-keys
    '(("(Firefox|Chrome|Chromium|libreoffice-writer|libreoffice-calc|Spacefm|Thunar)"
       ("C-n" . "Down")
       ("C-p" . "Up")
       ("C-f" . "Right")
       ("C-b" . "Left")
       ("C-<" . "Home")
       ("C->" . "End")
       ("M-b" . "C-Left")
       ("M-f" . "C-Right")
       ("C-M-b" . "M-Left")
       ("C-M-f" . "M-Right"))))
