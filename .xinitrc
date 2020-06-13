# keyboard settings
xkbcomp ~/.config/keyboard/lenovo.keymap.xkb $DISPLAY
xset r rate 200 30

# Terminate already running instances of the following programs
killall -q picom
killall -q sxhkd
killall -q polybar
killall -q brave
pkill -f scratchpad

# Programs to launch on starting x
picom &
sxhkd &
polybar example >> /tmp/polybar.log &
$BROWSER &
alacritty --class scratchpad,scratchpad & 

# Set wallpaper
hsetroot -full ~/images/wallpapers/game/7zm5e4zfkrgy.png &

exec bspwm
