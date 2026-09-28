#!/usr/bin/env bash
# Backs up a folder into a timestamped .tar.gz and keeps only the last 5 backups
# Usage: backup.sh <source-dir> <backup-dir>
set -euo pipefail

SRC="$1"
DEST="$2"
STAMP=$(date +%F_%H-%M-%S)

mkdir -p "$DEST"
tar -czf "$DEST/backup_$STAMP.tar.gz" -C "$(dirname "$SRC")" "$(basename "$SRC")"
echo "$(date +'%F %T') created backup_$STAMP.tar.gz"

# keep only the 5 newest backups
ls -1t "$DEST"/backup_*.tar.gz | tail -n +6 | xargs -r rm --
