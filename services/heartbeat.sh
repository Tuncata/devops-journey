#!/usr/bin/env bash
# Prints a heartbeat every 5 seconds — a stand-in for a real app
count=0
while true; do
  count=$((count + 1))
  echo "heartbeat #$count from $(hostname) at $(date +%T)"
  sleep 5
done
