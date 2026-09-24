#!/usr/bin/env bash
# Log analysis one-liners from Module 01, Lesson 3
# Usage: bash top-ips.sh <logfile>

LOG="$1"

echo "== Top 10 IPs =="
awk '{print $1}' "$LOG" | sort | uniq -c | sort -nr | head -n 10

echo "== Requests per status code =="
# ...your pipeline here...

echo "== Top 5 URLs =="
# ...your pipeline here...

echo "== IPs with the most 404s =="
# ...your pipeline here...
