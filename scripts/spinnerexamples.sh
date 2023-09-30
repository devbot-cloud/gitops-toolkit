#!/bin/bash

# Function to hide cursor
hide_cursor() {
    echo -ne "\033[?25l"
}

# Function to show cursor
show_cursor() {
    echo -ne "\033[?25h"
}

trap show_cursor EXIT INT TERM

hide_cursor


# Spinner function
spin() {
   local executable="$1"
   local -a spinner=("$@")
   local duration=2  # Run each spinner for 2 seconds for demonstration purposes

   local end=$((SECONDS+$duration))
   while [ $SECONDS -lt $end ]; do
     for i in "${spinner[@]:1}"  # Skip the first element, which is the executable name
     do
       echo -ne "\r$executable $i"
       sleep 0.1
     done
   done

   # Clear spinner and print completion message
   echo -e "\r$executable completed with ${spinner[1]} spinner."
}

EXECUTABLE_NAME="my_program  "

# Classic Spinner
spin "$EXECUTABLE_NAME" '|' '/' '-' '\\'

# Dot Spinner
spin "$EXECUTABLE_NAME" '.' 'o' 'O' 'o'

# Arrow Spinner
spin "$EXECUTABLE_NAME" '↑' '→' '↓' '←'

# Block Spinner
spin "$EXECUTABLE_NAME" '▁' '▂' '▃' '▄' '▅' '▆' '▇' '█' '▇' '▆' '▅' '▄' '▃' '▁'

# Star Spinner
spin "$EXECUTABLE_NAME" '☆' '★'

# Brackets Spinner
spin "$EXECUTABLE_NAME" '<' '>'

# Pulse Spinner
spin "$EXECUTABLE_NAME" '□' '■'

# Bouncing Bar
spin "$EXECUTABLE_NAME" '▐|▌'

# Clock Spinner
spin "$EXECUTABLE_NAME" '🕛' '🕐' '🕑' '🕒' '🕓' '🕔' '🕕' '🕖' '🕗' '🕘' '🕙' '🕚'

# Moon Phase Spinner
spin "$EXECUTABLE_NAME" '🌑' '🌒' '🌓' '🌔' '🌕' '🌖' '🌗' '🌘'

echo "All spinner demonstrations complete."

# Show the cursor again
show_cursor