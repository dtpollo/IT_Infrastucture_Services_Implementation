#!/usr/bin/bash
# Daniel Troya

# In this part, we verify if the number of arguments is correct.
if [ $# -ne 2 ] && [ $# -ne 4 ]; then
    echo "Usage schema:"
    echo "./FTP_access.sh <username> <password> # JUST list files"
    echo "./FTP_access.sh <username> <password> download <file>"
    echo "./FTP_access.sh <username> <password> upload <file>"
    exit 1
fi

# Here, we assign the position of the arguments entered into variables to use in the program
USER="$1"
PASS="$2"
CMD="$3"
FILE="$4"

# IP of the FTP server
SERVER="192.168.40.3"

# Here, we verify the entered command and write the functionality for each one. If the command is wrong, we return an error message.
if [ $# -eq 2 ]; then
    echo "Listing files on FTP-server ($SERVER) as $USER:"
    curl -u "$USER:$PASS" ftp://$SERVER/
else
    case "$CMD" in
        download)
            echo "Downloading $FILE from FTP-server ($SERVER)"
            curl -u "$USER:$PASS" ftp://$SERVER/$FILE -O
            ;;
        upload)
            if [ ! -f "$FILE" ]; then
                echo "Error: File '$FILE' does not exist locally."
                exit 1
            fi
            echo "Uploading $FILE to FTP server ($SERVER)..."
            curl -T "$FILE" -u "$USER:$PASS" ftp://$SERVER/
            ;;
        *)
            echo "Invalid command: $CMD"
            echo "Use: download or upload"
            ;;
    esac
fi

