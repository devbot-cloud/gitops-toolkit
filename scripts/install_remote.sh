#!/bin/bash

# Check if the right number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <download_url> <executable_name>"
    exit 1
fi

DOWNLOAD_URL="$1"
EXECUTABLE_NAME="$2"
LOCAL_BIN_PATH="$HOME/.local/bin"
LOCAL_PATH="$LOCAL_BIN_PATH/$EXECUTABLE_NAME"

if [ -f "$LOCAL_PATH" ]; then
    echo -e "$EXECUTABLE_NAME ✔"
    exit 0
fi

hide_cursor() {
    echo -ne "\033[?25l"
}

# Function to show cursor
show_cursor() {
    echo -ne "\033[?25h"
}

spin() {
   local executable="$1"
   local -a spinner
   spinner=('🌑' '🌒' '🌓' '🌔' '🌕' '🌖' '🌗' '🌘')
   local index=0
   while :
   do
     for i in "${spinner[@]}"
     do
       # Print executable name followed by the spinner character
       echo -ne "\r$executable $i"
       sleep 0.1
       ((index=(index+1)%${#spinner[@]}))  # Move to the next moon phase
     done
   done
}

cleanup() {
    local exit_status=$?
    local signal_name=$(kill -l $exit_status)
    show_cursor
    if [[ "$signal_name" == "INT" || "$signal_name" == "TERM" ]]; then
        exit 1
    fi
    if kill -0 "$SPIN_PID" 2>/dev/null; then
        kill $SPIN_PID
    fi
    if [[ $exit_status -eq 0 ]]; then
        echo -e "\r$EXECUTABLE_NAME ✔"
    else
        echo -e "\r$EXECUTABLE_NAME ❌"
    fi
}

trap cleanup EXIT INT TERM
hide_cursor
spin $EXECUTABLE_NAME &
SPIN_PID=$!

# Step 1: Download the executable
curl -s -LO "$DOWNLOAD_URL" 
# Step 2: Make the downloaded file executable
chmod +x "./$EXECUTABLE_NAME" 
# Step 3: Move the executable to a directory included in the PATH
mv "./$EXECUTABLE_NAME" "$LOCAL_BIN_PATH"
