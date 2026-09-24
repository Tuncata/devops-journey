#!/usr/bin/env bash
# Log analysis one-liners from Module 01, Lesson 3
# Usage: bash top-ips.sh <logfile>

LOG="$1"

echo "== Top 10 IPs =="
awk '{print $1}' "$LOG" | sort | uniq -c | sort -nr | head -n 10

echo "== Requests per status code =="
awk '{print $9}' "$LOG" | sort | uniq -c | sort -nr

echo "== Top 5 URLs =="
awk '{print $7}' "$LOG" | sort | uniq -c | sort -nr | head -n 5

echo "== IPs with the most 404s =="
 awk '$9 == 404 {print $1}' $LOG | sort | uniq -c | sort -nr | head -n 5
