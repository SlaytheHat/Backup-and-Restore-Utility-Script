# Backup-and-Restore-Utility-Script
Script that automates backing up and restoring files or directories.

### How to Use the Script
1. **Save the script** as `backup_restore.sh` and make it executable:
   ```bash
   chmod +x backup_restore.sh
   ```

2. **Backup a directory**:
   ```bash
   ./backup_restore.sh backup /path/to/source_directory
   ```
   - This creates a compressed backup of `/path/to/source_directory` in the `./backups` directory with a timestamped filename.

3. **Restore a backup**:
   ```bash
   ./backup_restore.sh restore /path/to/backup_file.tar.gz /path/to/destination_directory
   ```
   - This restores the specified backup file to the `/path/to/destination_directory`.

---

### Features
1. **Automatic Compression**: Uses `tar` and `gzip` to compress backups.
2. **Timestamped Backups**: Ensures unique backup file names.
3. **Restore Functionality**: Extracts the backup to the specified destination.
4. **Logging**: Logs all backup and restore actions in `backup.log`.
5. **Customizable Paths**: Change the `BACKUP_DIR` variable to store backups in a preferred location.
