#!/bin/bash

# Check if application name is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <application_name>"
    exit 1
fi


# Application name to search for
app_name="$1"

# Run pactl list sink-inputs command and capture output
input_text=$(pactl list sink-inputs)

# Find all Sink Input numbers for the specified application
sink_inputs=$(echo "$input_text" | awk -v app="$app_name" '
    /Sink Input #/ {sink=$3}
    $0 ~ "application.name = \""app"\"" {
        gsub(/#/, "", sink)
        print sink
    }')

# Check if any sink inputs were found and toggle mute for each one
if [ -n "$sink_inputs" ]; then
    echo "Toggling mute for Sink Inputs for $app_name..."
    for sink_input in $sink_inputs; do
        echo "Toggling mute for Sink Input $sink_input..."
        pactl set-sink-input-mute "$sink_input" toggle
    done
else
    echo "Sink Input for $app_name not found."
fi