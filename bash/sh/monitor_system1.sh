#!/bin/bash

# Log Paths
cpu_log="~/logs/cpu_trkr.log"
memory_log="~/logs/memory_trkr.log"
process_log="~/logs/process_trkr.log"

# Threshold values
cpu_threshold=98
spike_threshold=55
min_previous_load=10  # Minimum previous load to consider for spike calculation

# Initialize previous CPU load
previous_cpu_load=0

# Set error handling
set -e

# Gather current CPU load (using top as an alternative)
cpu_load=$(top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\([0-9.]*\)%id.*/\1/' | awk '{print 100 - $1}')

# Check for CPU spike (with minimum previous load check)
if (( previous_cpu_load > min_previous_load )) && (( cpu_load - previous_cpu_load > spike_threshold )); then
  echo "CPU spike detected on $(date +%m-%d-%Y\ %H:%M:%S) by user $(whoami): CPU load increased by $((cpu_load - previous_cpu_load))%" >> $cpu_log
fi

# Check for CPU load exceeding threshold
if (( cpu_load > cpu_threshold )); then
  echo "CPU load is at or above threshold ($cpu_threshold%) on $(date +%m-%d-%Y\ %H:%M:%S) by user $(whoami):" >> $cpu_log
fi

# Update previous CPU load
previous_cpu_load=$cpu_load


# Add memory and process monitoring logic here...

# Example for memory monitoring with formatted output:
free -h | grep 'Mem:' | awk '{printf "Memory Usage: %.2f%%\n", $3/$2 * 100}' >> $memory_log

# Example for process monitoring with formatted output:
echo "Top CPU Consuming Processes:" >> $process_log
ps -eo pcpu,pid,user,comm | sort -k 1 -r | head -5 | awk '{printf "%.2f%% %d %s %s\n", $1, $2, $3, $4}' >> $process_log

# Log rotation (using logrotate - requires configuration)
# Create a logrotate configuration file (e.g., /etc/logrotate.d/cpu_monitor)
# with settings to rotate the logs daily, weekly, etc. 
