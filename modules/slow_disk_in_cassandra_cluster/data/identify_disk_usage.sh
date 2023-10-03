

#!/bin/bash



# Set the threshold for high I/O usage

threshold=${THRESHOLD}



# Get a list of disks in use

disks=$(iostat -d | awk '/^sd/ {print $1}')



# Loop through the disks and check their I/O usage

for disk in $disks; do

    usage=$(iostat -d -p $disk | awk '/^sd/ {print $12}')

    if [ $usage -gt $threshold ]; then

        echo "Disk $disk is experiencing high I/O usage"

    fi

done





chmod +x identify_disk_usage.sh

./identify_disk_usage.sh