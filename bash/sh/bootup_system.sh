#!/bin/bash

# Set up logging
LOG_FILE="/var/log/startup_script.log"
exec &> >(tee -a "$LOG_FILE")  # Redirect stdout and stderr to log file

# Log the start time
echo "$(date) - Startup script started"

sudo apt full-upgrade -y

if [ $? -ne 0 ]; then
    echo "Error: apt full-upgrade failed, logging... Retry." >&2 #stderr logs
    sleep 3
    sudo apt full-upgrade -y
    if [ $? -ne 0 ]; then 
        echo "apt full-upgrade failed 2x. Continuing."
    fi
fi

# Clean package cache
sudo apt clean -y

if [ $? -ne 0 ]; then
    echo "Warning: apt clean failed, logging, retry..." >&2 #stderr logs
    sleep 1

    while true; do
        read -p "retry apt clean, with sudo permissions? (y/N): " retry
        if [[ "$retry =~ ^[Yy]$" ]] then
            sudo apt clean -y
            if [ $? -ne 0 ]; then
                echo "apt clean buggggin. skrt."
            else
                echo "apt clean successful on retry :)"
            fi
            break
        elif [[ "$retry" =~ ^ [Nn]$ ]]; then
            echo "Skipping apt clean."
            break
        else
            echo "Invalid input. Please enter 'y' or 'N'."
        fi
    done

    # Logging user's input
    echo "User chose to... : $retry" >> /var/log/user_input_startup.log

    sudo apt clean -y
    if [ $? -ne 0 ]; then
        echo "apt clean buggin, moving on." 
    fi
fi

directory=$(dirname "$LOG_FILE")
echo "Please check ($directory)"

echo "$(date) - Startup script finished..."
