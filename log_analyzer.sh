#!/bin/bash


# Options
usage() {
    echo "Usage: $0 [-f <log_file>] [-e <error_keyword>] [-c]"
    echo "Options:"
    echo "  -f <log_file>       Specify the log file to analyze (default: /var/log/syslog)"
    echo "  -e <error_keyword>  Specify the keyword to search for in logs"
    echo "  -c                  Display the count of occurrences"
    echo "  -h                  Display this help message"
    exit 1
}


log_file="/var/log/syslog"
error_keyword=""
count_only=false


while getopts ":f:e:ch" opt; do
    case $opt in
        f)
            log_file=$OPTARG
            ;;
        e)
            error_keyword=$OPTARG
            ;;
        c)
            count_only=true
            ;;
        h)
            usage
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done


if [ ! -f "$log_file" ]; then
    echo "Error: Log file not found: $log_file"
    exit 1
fi


if [ -n "$error_keyword" ]; then
    regex="\\b$error_keyword\\b"
else
    regex=""
fi


if $count_only; then
    error_count=$(grep -c "$regex" "$log_file")
    echo "Count of occurrences for '$error_keyword' in '$log_file': $error_count"
else
    echo "Searching for '$error_keyword' in '$log_file':"
    grep "$regex" "$log_file"
fi


