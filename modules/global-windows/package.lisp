;;;; package.lisp

(defpackage #:global-windows
  (:use #:cl #:stumpwm)
  (:import-from #:stumpwm
                *focus-window-hook*
                *window-format*
                add-hook
                completing-read
                current-group
                current-screen
                current-window
                focus-all
                frame-raise-window
                group-windows
                move-window-to-group
                pull-window
                select-window-from-menu
                show-frame-indicator
                sort-groups
                sort-windows
                sort1
                switch-to-group
                tile-group-current-frame
                window-frame
                window-group
                window-name)
  (:export #:global-pull-windowlist
           #:global-windowlist
           #:global-windows
           #:goto-window
           #:with-global-windowlist))
