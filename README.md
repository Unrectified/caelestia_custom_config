# My custom [Calestia-shell](https://github.com/caelestia-dots/shell) config

## How to use
- clone the repo in Caelestia config folder 
 `git clone https://github.com/Unrectified/caelestia_custom_config.git ~/.config/caelestia && cd ~/.config/caelestia`
- for easy acces to the main script symlink it to /usr/local/bin (fish version is not working):
  `ln -s ~/.config/caelestia/caelestia_custom_scripts /usr/local/bin/caelestia_custom_scripts`
- download swww (default wallpaper displayer)
  `sudo pacman -S swww`
  + disable wallpaper in Contrl center>appaerence>background

## Features and tweaks

Script commands :
- mpvpaper [video file]
- wallpaper [wallpaper file] (can use gifs and animated webp thx to swww)
- black_white (toogle black & white filter)
- transp (toogle shell transparency)
- bar (toogle bar)

Global tweaks :
- Set swwww as default wallpaper engine (PLS DISABLE WALLPAPER IN CONTROL CENTER>APPAERANCE>BACKGROUND)
- usage of foot-server & foot-client to for less memory usage

Launcher Actions :
- Toogle left sidebar
- Toogle shell transparency
- Toogle Black & White mode
(edit file: shell.json)

Keybinds :
- Super + D : open Equibop within communication vanilla special worksape
- Ctrl + Super + D : open beeper within Beeper special workspace
- Super + M : open Deezer within Music vanilla special workspace
- Super + R : open my To-Do Obsidian page within TO DO vanilla special workspace
(edit file: cli.json)
- Ctrl + Super + up : set random wallpaper
- Ctrl + Super + down : toogle transparency
- Override some keybind to feat french (AZERTY) keyboards  
(edit file: hypr-user.conf)

Login executions:
- Set a random wallpaper
(edit file: hypr-user.conf)


To Do:
- give my readme a better looking?
