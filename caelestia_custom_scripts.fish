#!/usr/bin/env fish

set CONFIG "$HOME/.config/caelestia/shell.json"
set DECORATION_FILE "$HOME/.config/caelestia/hypr-user.conf"
set WALLPAPERS "$HOME/Pictures/Wallpapers"
set VIDEOS_WALLPAPERS "$HOME/Videos/Wallpapers"
set VIDEOS_PNG "$VIDEOS_WALLPAPERS/.convert"

# Chemin EXACTEMENT comme dans ton fichier (avec $HOME non expansé)
set BLACK_WHITE_TARGET 'screen_shader = $HOME/.config/hypr/custom/BWshader.glsl'

switch $argv[1]
case mpvpaper
    if test "$argv[2]" = stop
        pkill -9 mpvpaper
        notify-send "Live Wallpaper stopped"
    else
        if test -f "$argv[2]"
            mkdir -p "$VIDEOS_PNG"
            set filename (basename "$argv[2]")
            set CONVERTED_JPG "$VIDEOS_PNG/$filename.jpg"
            if not test -f "$CONVERTED_JPG"
                echo "le fichier $CONVERTED_JPG était pas là "
                ffmpeg -i "$argv[2]" -frames:v 1 "$CONVERTED_JPG" >/dev/null 2>/dev/null
            end
            pkill mpvpaper
            pkill swww
            set REALVIDEO (realpath -P "$argv[2]")
            mpvpaper -f -o "no-audio --loop-playlist" '*' "$REALVIDEO"
            echo "real video $REALVIDEO"
            /usr/bin/caelestia wallpaper -f "$CONVERTED_JPG"
        else
            notify-send "Error" "This file does not exist"
        end
    end
case wallpaper
    set cursor (hyprctl cursorpos | tr -d ' ')
    swww img "$argv[2]" --transition-type grow --transition-duration 2 --transition-fps 60 --transition-pos $cursor --invert-y
case black_white
    if grep -q "^[[:space:]]*#${BLACK_WHITE_TARGET}" "$DECORATION_FILE"
        sed -i "s|^[[:space:]]*#${BLACK_WHITE_TARGET}|    ${BLACK_WHITE_TARGET}|" "$DECORATION_FILE"
        sleep 0.5
        jq '(.launcher.actions[] | select(.name=="B & W") | .icon) = "contrast_rtl_off"' \
            "$CONFIG" > "$CONFIG.tmp"; and mv "$CONFIG.tmp" "$CONFIG"
    else if grep -q "^[[:space:]]*${BLACK_WHITE_TARGET}" "$DECORATION_FILE"
        sed -i "s|^[[:space:]]*${BLACK_WHITE_TARGET}|    #${BLACK_WHITE_TARGET}|" "$DECORATION_FILE"
        sleep 0.5
        jq '(.launcher.actions[] | select(.name=="B & W") | .icon) = "contrast"' \
            "$CONFIG" > "$CONFIG.tmp"; and mv "$CONFIG.tmp" "$CONFIG"
    else
        echo "❌ Impossible de trouver la ligne du shader !"
    end
case transp
    set current (jq '.appearance.transparency.enabled' "$CONFIG")
    if test "$current" = true
        jq '.appearance.transparency.enabled = false' "$CONFIG" > "$CONFIG.tmp"; and mv "$CONFIG.tmp" "$CONFIG"
        sleep 0.5
        jq '(.launcher.actions[] | select(.name=="Transparency") | .icon) = "invert_colors_off"' \
            "$CONFIG" > "$CONFIG.tmp"; and mv "$CONFIG.tmp" "$CONFIG"
    else
        jq '.appearance.transparency.enabled = true' "$CONFIG" > "$CONFIG.tmp"; and mv "$CONFIG.tmp" "$CONFIG"
        sleep 0.5
        jq '(.launcher.actions[] | select(.name=="Transparency") | .icon) = "invert_colors"' \
            "$CONFIG" > "$CONFIG.tmp"; and mv "$CONFIG.tmp" "$CONFIG"
    end
case bar
    set current (jq '.bar.persistent' "$CONFIG")
    if test "$current" = true
        jq '.bar.persistent = false' "$CONFIG" > "$CONFIG.tmp"; and mv "$CONFIG.tmp" "$CONFIG"
        sleep 0.5
        jq '(.launcher.actions[] | select(.name=="Bar") | .icon) = "left_panel_open"' \
            "$CONFIG" > "$CONFIG.tmp"; and mv "$CONFIG.tmp" "$CONFIG"
    else
        jq '.bar.persistent = true' "$CONFIG" > "$CONFIG.tmp"; and mv "$CONFIG.tmp" "$CONFIG"
        sleep 0.5
        jq '(.launcher.actions[] | select(.name=="Bar") | .icon) = "right_panel_open"' \
            "$CONFIG" > "$CONFIG.tmp"; and mv "$CONFIG.tmp" "$CONFIG"
    end
case '*'
    echo "Usage : caelestia_custom_scripts.fish [mpvpaper|wallpaper|black_white|transp|bar]"
end
