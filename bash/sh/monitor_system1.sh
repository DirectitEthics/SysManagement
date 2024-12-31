#!/bin/bash

# Log Paths
cpu_log="~/logs/cpu_trkr.log"
memory_log="~/logs/memory_trkr.log"
process_log="~/logs/process_trkr.log"

# Threshold values
cpu_threshold=98
spike_threshold=55

# Initialize previous CPU load
previous_cpu_load=0

# Set error handling
set -e

# gather current CPU load
cpu_load=$(mpstat 1 1 | grep '%idle' | awk '{print 100 - $5}')

# Check for CPU spike
if [[ $((cpu_load - previous_cpu_load)) -gt $spike_threshold ]]; then
  echo "CPU spike detected on $(date +%m-%d-%Y\ %H:%M:%S) by user $(whoami): CPU load increased by $((cpu_load - previous_cpu_load))%" >> $cpu_log
fi

# Check for CPU load exceeding threshold
if [[ $cpu_load -gt $cpu_threshold ]]; then
  echo "CPU load is at or above threshold (98%) on $(date +%m-%d-%Y\ %H:%M:%S) by user $(whoami):" >> $cpu_log
fi

# Update previous CPU load
previous_cpu_load=$cpu_load
