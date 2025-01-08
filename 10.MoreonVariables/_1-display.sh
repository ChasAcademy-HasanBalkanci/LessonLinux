#!/bin/bash

# Display the name of the script being executed
echo "Script name: $0"

# Display the first, third, and tenth argument given to the script
echo "First argument: ${1:-None}" # use the first argument if it exists; otherwise, use 'None'.
echo "Third argument: ${3:-None}"
echo "Tenth argument: ${10:-None}"

# Display the total number of arguments passed to the script
echo "Total number of arguments: $#"

# If there are more than three positional parameters, shift them
if [ $# -gt 3 ]; then
    shift 3
fi

# Print all the values of the remaining arguments
echo "Remaining arguments: $@"

# Print the number of remaining arguments
echo "Number of remaining arguments: $#"