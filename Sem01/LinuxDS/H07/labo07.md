Hier zijn de uitwerkingen van de beschreven scripts en cron-job:

---

### **1. passphrase.sh**
Generates a random passphrase using a wordlist.

```bash
#!/bin/bash

## Usage: ./passphrase.sh [N] [WORDLIST]
##        ./passphrase.sh -h|--help
## Generate a random passphrase using N words from the WORDLIST.

set -o errexit
set -o nounset

# Default values
DEFAULT_WORDLIST="/usr/share/dict/words"
DEFAULT_WORD_COUNT=4
WORDLIST=$DEFAULT_WORDLIST
WORD_COUNT=$DEFAULT_WORD_COUNT

# Functions

# Print usage
usage() {
    grep "^##" "$0" | sed 's/^## //'
    exit 0
}

# Process command-line arguments
process_cli_args() {
    if [[ "$#" -gt 2 ]]; then
        echo "Error: At most two arguments expected, got $#" >&2
        usage
    fi

    for arg in "$@"; do
        case "$arg" in
            -h|--help)
                usage
                ;;
            -*)
                echo "Error: Unknown option '$arg'" >&2
                usage
                ;;
            *)
                if [[ -f "$arg" ]]; then
                    WORDLIST="$arg"
                elif [[ "$arg" =~ ^[0-9]+$ ]]; then
                    WORD_COUNT="$arg"
                else
                    echo "Error: Invalid argument '$arg'" >&2
                    usage
                fi
                ;;
        esac
    done
}

# Generate passphrase
generate_passphrase() {
    if [[ ! -f "$WORDLIST" ]]; then
        echo "Error: Wordlist file '$WORDLIST' not found!" >&2
        exit 1
    fi

    shuf -n "$WORD_COUNT" "$WORDLIST" | tr '\n' ' ' | sed 's/ $/\n/'
}

# Main
main() {
    process_cli_args "$@"
    generate_passphrase
}

main "$@"
```

---

### **2. backup.sh**
Creates a backup of a directory as a compressed tar archive.

```bash
#!/bin/bash

## Usage: ./backup.sh [OPTIONS] [DIR]
##        ./backup.sh -h|--help
## Create a tar.bz2 backup of the specified directory.

set -o errexit
set -o nounset

# Default values
DEFAULT_DESTINATION="/tmp"
DEFAULT_SOURCE="$HOME"
DEST_DIR=$DEFAULT_DESTINATION
SOURCE_DIR=$DEFAULT_SOURCE

# Print usage
usage() {
    grep "^##" "$0" | sed 's/^## //'
    exit 0
}

# Process command-line arguments
process_cli_args() {
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -h|--help)
                usage
                ;;
            -d|--destination)
                if [[ -z "${2:-}" ]]; then
                    echo "Error: Missing argument for $1" >&2
                    exit 1
                fi
                DEST_DIR="$2"
                shift
                ;;
            -*)
                echo "Error: Unknown option '$1'" >&2
                usage
                ;;
            *)
                SOURCE_DIR="$1"
                ;;
        esac
        shift
    done
}

# Create backup
create_backup() {
    if [[ ! -d "$SOURCE_DIR" ]]; then
        echo "Error: Source directory '$SOURCE_DIR' does not exist!" >&2
        exit 1
    fi

    if [[ ! -d "$DEST_DIR" ]]; then
        echo "Error: Destination directory '$DEST_DIR' does not exist!" >&2
        exit 1
    fi

    TIMESTAMP=$(date +"%Y%m%d%H%M")
    BACKUP_NAME="$(basename "$SOURCE_DIR")-$TIMESTAMP.tar.bz2"
    LOG_FILE="$DEST_DIR/backup-$TIMESTAMP.log"

    tar -cvjf "$DEST_DIR/$BACKUP_NAME" "$SOURCE_DIR" > "$LOG_FILE" 2>&1
    echo "Backup completed: $DEST_DIR/$BACKUP_NAME"
    echo "Log saved: $LOG_FILE"
}

# Main
main() {
    process_cli_args "$@"
    create_backup
}

main "$@"
```

---

### **3. Cron Job**

#### **Setup the cron-job**
The cron-job will execute a script every 15 minutes to collect data and write logs.

1. Open the crontab for editing:
   ```bash
   crontab -e
   ```

2. Add the following line to execute the data collection script every 15 minutes:
   ```bash
   */15 * * * * /path/to/data-collection.sh >> /path/to/data-collection.log 2>&1
   ```

---

### Example: `data-collection.sh`
A script to collect data from an API.

```bash
#!/bin/bash

## Script to collect data from an API and log the result.

set -o errexit
set -o nounset

API_URL="https://api.example.com/data"
LOGFILE="/path/to/data-collection.log"

echo "$(date): Starting data collection" >> "$LOGFILE"
curl -s "$API_URL" >> "$LOGFILE"
echo "$(date): Data collection completed" >> "$LOGFILE"
```

### Key Notes:
- **Cron-job output** is redirected to a log file for both standard output and error streams.
- The `backup.sh` script checks directory existence and handles errors gracefully.
- The `passphrase.sh` script ensures flexibility with arguments and robust error handling.