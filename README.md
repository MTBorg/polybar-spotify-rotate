# polybar-spotify-rotate
A polybar module for spotify (with text-rotation) written in shell script.

![](/spotify_rotate.gif)

## Dependencies
- dbus (Used to communicate with spotify)

## Usage
Place the [script](/spotify_rotate.sh) where you want and add the following module in your polybar config
```dosini
[module/spotify]
type = custom/script
exec = </path/to/script>
tail = true
```
The distance (length) of the string as well as the interval length can be set via environment variables DISTANCE and INTERVAL, when calling the script, for example:
```dosini
[module/spotify]
...
exec = DISTANCE=<distance> INTERVAL=<interval> </path/to/script>
...
```
