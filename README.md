## pactl-mute - Pulseaudio console application mute script

Linux Bash Pulseaudio/Pipewire Mute Application script

Simple bash script to mute applications

For instance using Elgato Streamdeck button to mute an application in linux

### Usage

./pactl-mute.sh Firefox

### To see list of current sinks and associated application name
> pactl list sink-inputs | grep application.name


