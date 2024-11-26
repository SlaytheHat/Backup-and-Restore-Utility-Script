#!/bin/bash

# Configuration
BACKUP_DIR="./backups"  # Directory to store backups
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')  # Current timestamp
LOG_FILE="$BACKUP_DIR/backup.log"  # Log file

# Ensure the backup directory exists
mkdir -p "$BACKUP_DIR"

# Function to display usage instructions
usage() {
    echo "Usage: $0 {backup|restore} [source_directory] [backup_file]"
    echo
    echo "Commands:"
    echo "  backup <source_directory>       Back up the specified directory."
    echo "  restore <backup_file> <destination_directory> Restore the backup to the specified location."
    echo
    exit 1
}

# Function to perform a backup
backup() {
    local source_dir=$1
    if [[ -z "$source_dir" ]]; then
        echo "Error: No source directory specified for backup."
        usage
    fi

    if [[ ! -d "$source_dir" ]]; then
        echo "Error: Source directory does not exist: $source_dir"
        exit 1
    fi

    local backup_file="$BACKUP_DIR/$(basename "$source_dir")_$TIMESTAMP.tar.gz"
    echo "Backing up $source_dir to $backup_file..."
    tar -czf "$backup_file" -C "$(dirname "$source_dir")" "$(basename "$source_dir")"
    echo "Backup completed: $backup_file"
    echo "$(date): Backup of $source_dir created at $backup_file" >> "$LOG_FILE"
}

# Function to perform a restore
restore() {
    local backup_file=$1
    local destination_dir=$2

    if [[ -z "$backup_file" || -z "$destination_dir" ]]; then
        echo "Error: Both backup file and destination directory must be specified for restore."
        usage
    fi

    if [[ ! -f "$backup_file" ]]; then
        echo "Error: Backup file does not exist: $backup_file"
        exit 1
    fi

    mkdir -p "$destination_dir"
    echo "Restoring $backup_file to $destination_dir..."
    tar -xzf "$backup_file" -C "$destination_dir"
    echo "Restore completed."
    echo "$(date): $backup_file restored to $destination_dir" >> "$LOG_FILE"
}

# Main script logic
if [[ $# -lt 1 ]]; then
    usage
fi

case $1 in
    backup)
        backup "$2"
        ;;
    restore)
        restore "$2" "$3"
        ;;
    *)
        usage
        ;;
esac
