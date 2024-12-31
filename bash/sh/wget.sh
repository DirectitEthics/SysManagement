 #!/bin/bash

# --- Configuration ---
URL="https://example.com/file.zip"  # URL of the file to download
OUTPUT_FILE="downloaded_file.zip"  # Local filename for the downloaded file
LOG_FILE="wget.log"                # Log file for wget output
TIMEOUT=30                         # Timeout for the download in seconds
RETRIES=3                          # Number of retries if the download fails
# --- End Configuration ---

# --- Functions ---

# Function to check if a command was successful
check_command() {
  if [ $? -ne 0 ]; then
    echo "Error: Command '$1' failed." >> "$LOG_FILE"
    exit 1
  fi
}

# Function to download the file with wget
download_file() {
  wget \
    --timeout="$TIMEOUT" \
    --tries="$RETRIES" \
    --output-document="$OUTPUT_FILE" \
    --user-agent="SecureWgetScript/1.0" \
    --secure-protocol=TLSv1_3 \  # Enforce TLSv1.3
    --https-only \              # Only allow HTTPS connections
    --progress=bar:force \
    "$URL" >> "$LOG_FILE" 2>&1
  check_command "wget"
}

# --- Main Script ---

# Create a log file with timestamp
echo "Starting download at $(date)" > "$LOG_FILE"

# Download the file
download_file

# Verify the downloaded file (optional)
# You can add checksum verification here, e.g., using sha256sum

# Log the success
echo "Download completed successfully at $(date)" >> "$LOG_FILE"

exit 0
