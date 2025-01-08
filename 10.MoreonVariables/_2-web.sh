#!/bin/bash

# Initialize an array to store the last 10 URLs
declare -a url_history
history_index=0

# Function to display a URL using links -dump
display_url() {
    local url=$1
    echo "Fetching and displaying: $url" 
    # fetches its content using wget, 
    #displays it in text format using links -dump
    wget -q -O - "$url" | links -dump -
}

# Main loop
while true; do
    echo "Enter a URL, 'b' for back, or 'q' to quit:"
    read -r input

    if [[ $input == "q" ]]; then
        echo "Quitting the browser."
        break
    elif [[ $input == "b" ]]; then
        if (( history_index > 0 )); then
            ((history_index--))
            display_url "${url_history[history_index]}"
        else
            echo "No previous URL to go back to."
        fi
    else
        # Add the URL to the history
        url_history[history_index]=$input
        ((history_index++))
        
        # Keep only the last 10 URLs
        if (( history_index > 10 )); then
            url_history=("${url_history[@]:1}")
            ((history_index--))
        fi
{
  "features": {
    "buildkit": true
  }
}{
  "features": {
    "buildkit": true
  }
}
        display_url "$input"
    fi
done