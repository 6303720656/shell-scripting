#/bin/bash
if [[ "$#" -ne 1 ]]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

log_file="$1"

# Define regular expressions for IP addresses, URLs, and status codes
ip_pattern='\b([0-9]{1,3}\.){3}[0-9]{1,3}\b'
url_pattern='\"(?:GET|POST|PUT|DELETE)\s([^"]+)\"'
status_code_pattern='\s([0-9]{3})\s'

# Containers to store extracted information
ip_addresses=()
request_urls=()
status_codes=()

# Check if the log file exists
if if [[ ! -f "$log_file" ]]; then
; then
    echo "Error: File not found - $log_file"
    exit 1
fi

# Read and analyze the log file
while IFS= read -r line; do
    # Extract IP addresses
    if [[ $line =~ $ip_pattern ]]; then
        ip_addresses+=("${BASH_REMATCH[0]}")
    fi

    # Extract request URLs
    if [[ $line =~ $url_pattern ]]; then
        request_urls+=("${BASH_REMATCH[1]}")
    fi

    # Extract status codes
    if [[ $line =~ $status_code_pattern ]]; then
        status_codes+=("${BASH_REMATCH[1]}")
    fi
done < "$log_file"

# Analyze and print results
echo "Most frequent IP addresses:"
printf "%s\n" "${ip_addresses[@]}" | sort | uniq -c | sort -nr | head -5

echo -e "\nMost frequent request URLs:"
printf "%s\n" "${request_urls[@]}" | sort | uniq -c | sort -nr | head -5

echo -e "\nMost frequent status codes:"
printf "%s\n" "${status_codes[@]}" | sort | uniq -c | sort -nr | head -5