# keyboard settings
xkbcomp ~/.config/keyboard/x11/lenovo-default-keymap $DISPLAY
xset r rate 200 30

# Terminate already running instances of the following programs
killall -q picom
killall -q sxhkd
killall -q polybar
pkill -f scratchpad

# Programs to launch on starting x
picom &
sxhkd &
polybar example >> /tmp/polybar.log &
alacritty --class scratchpad,scratchpad &

# Set wallpaper
hsetroot -full ~/images/wallpapers/game/7zm5e4zfkrgy.png &

exec bspwm
