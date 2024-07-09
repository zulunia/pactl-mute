#!/bin/bash

# Application name to search for
app_name="Firefox"

# Run pactl list sink-inputs command and capture output
input_text=$(pactl list sink-inputs)

# Find Sink Input number for the specified application
sink_input=$(echo "$input_text" | awk -v app="$app_name" '/Sink Input #/{sink=$3} $0 ~ "application.name = \""app"\""{gsub(/#/, "", sink); print sink}')

if [ -n "$sink_input" ]; then
    echo "Toggling mute for Sink Input $sink_input for $app_name..."
    pactl set-sink-input-mute "$sink_input" toggle
else
    echo "Sink Input for $app_name not found."
fi
