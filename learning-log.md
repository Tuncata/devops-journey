# Learning Log

## 2026-09-23 — Day 1
- Installed WSL2 + Ubuntu 24.04
- Connected VS Code to WSL
- Configured Git and an SSH key for GitHub
- Learned: pwd, cd, mkdir -p, sudo, apt, the difference between /mnt/c and /home
Proceeding with lesson 3
## 2026-09-23 — Module 01, Lessons 1–2
- Filesystem: /etc = config, /var/log = logs, /home = users, /mnt/c = Windows C: drive
- Paths: relative (`cd ../..`) vs absolute (`/home/teodor/...`, `~/...`)
- Reading files: cat, less, head, `tail -n 50`, `tail -f` (Ctrl+C to stop)
- Editors: nano (Ctrl+O save, Ctrl+X exit) and vim (`i`, `Esc :wq`, `Esc :q!`)
- Installed nginx and changed its homepage; back up configs and run `nginx -t` before reloading

## 2026-09-24 — Module 01, Lessons 3–5
### Lesson 3: pipes & text tools
- `>` overwrite, `>>` append, `2>` errors, `2>/dev/null` discard
- Top-N pattern: `awk '{print $X}' file | sort | uniq -c | sort -nr | head -n N`
- awk filter: `awk '$9 == 404 {print $1}'` (pattern outside braces, action inside)
- Built scripts/top-ips.sh to analyse an Apache log (213 × 404s; top 404 IP = bot scanner)

### Lesson 4: users, groups, permissions
- r=4 w=2 x=1, one digit per group: `rw-r-----` = 640
- 600 for secrets (SSH keys), 755 for scripts, never 777 (least privilege)
- `usermod -aG` APPENDS a group; `-G` alone REPLACES all groups
- Group changes need a new session (`newgrp`); setgid (`chmod g+s`) on shared folders
- Gotcha: pasting multiple lines broke `newgrp`/`su`. Run commands one at a time

### Lesson 5: processes & resources
- `ps aux`, `pgrep`, `top`/`htop`, load average vs `nproc`
- `kill` (SIGTERM, try first) vs `kill -9` (SIGKILL, last resort)
- `free -h`: watch `available`, not `free` (cache is good)
- Ctrl+Z + `bg` to background a running command; `jobs`, `fg`
- `df -h`, `du -sh`, `ss -tulpn` / `lsof -i :80` to find who holds a port

## 2026-09-28 — Module 01, Lessons 6–7
### Lesson 6: packages & services
- `apt update` refreshes the package list; `apt upgrade` installs the updates. Run them together
- `systemctl start` = now, `enable` = at boot, `enable --now` = both
- After editing a .service file: `systemctl daemon-reload`, then restart
- `Restart=always` gives self-healing: I killed heartbeat.service with -9 and systemd brought it back
- Service won't start? `systemctl status`, then `journalctl -u <svc> -n 50`, then the app's config test (`nginx -t`)
- Built services/heartbeat.service (runs as `nobody`, least privilege)

### Lesson 7: archives, SSH, cron
- `tar -czf out.tar.gz dir/` to create, `tar -xzf out.tar.gz` to extract, `tar -tzf` to list (never c + x together)
- SSH keys over passwords: unguessable, the private key never leaves my machine, works for automation, easy to revoke
- `ssh-copy-id user@host` for passwordless login; `ssh host "cmd"` runs remote commands
- `scp` for one-off copies; `rsync -avz` for backups (only sends changes; mind the trailing slash)
- Cron: `min hour day month weekday`, e.g. `0 3 * * 0` = Sundays 03:00; `*/2` = minutes divisible by 2
- Cron has a minimal environment: use full paths and log output with `>> file.log 2>&1`
- Built scripts/backup.sh (timestamped tar.gz, keeps the last 5) and ran it from cron every 2 min
- Gotcha: closing the editor before saving means `crontab -e` changes are lost
