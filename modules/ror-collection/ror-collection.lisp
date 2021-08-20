;;;; ror-collection.lisp

(in-package #:ror-collection)

(defcommand ror-emacs () ()
  "run-or-raise emacs"
  (run-or-raise "emacsclient -c -a ''" '(:class "Emacs")))

(defcommand ror-lilyterm-with-tmux () ()
  "run-or-raise lilyterm with tmux"
  (run-or-raise
   "lilyterm -x bash -c 'tmux -q has-session && tmux attach -d || tmux -u'"
   '(:class "LilyTerm")))

(defcommand ror-kitty-with-tmux () ()
  "run-or-raise kitty with tmux"
  (run-or-raise
   "kitty -e bash -c 'tmux -q has-session && tmux attach -d || tmux -u'"
   '(:class "kitty")))

(defcommand ror-urxvt-with-tmux () ()
  "run-or-raise urxvt with tmux"
  (run-or-raise
   "urxvt -e bash -c 'tmux -q has-session && tmux attach -d || tmux -u'"
   '(:class "URxvt")))

(defcommand ror-tabbed-st () ()
  "run-or-raise a tabbed suckless terminal"
  (run-or-raise "tabbed -c -r 2 st -w ''" '(:class "tabbed")))

(defcommand ror-st () ()
  "run-or-raise suckless terminal"
  (run-or-raise "st" '(:class "st-256color")))

(defcommand ror-web-browser () ()
  "run-or-raise a web browser"
  (run-or-raise "x-www-browser" '(:role "browser")))

(defcommand ror-file-manager () ()
  "run-or-raise a graphical file manager"
  (run-or-raise "spacefm" '(:role "file_manager")))
