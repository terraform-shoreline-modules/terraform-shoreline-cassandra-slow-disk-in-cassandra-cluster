
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Slow Disk in Cassandra Cluster
---

In this incident type, there is an issue with a Cassandra cluster where one or more disks are running slow. This can cause performance issues and potentially lead to data loss or downtime. The goal is to identify and address the specific disk(s) causing the problem in order to restore normal cluster operations.

### Parameters
```shell
export DISK_NAME="PLACEHOLDER"

export INTERVAL="PLACEHOLDER"

export COUNT="PLACEHOLDER"

export THRESHOLD="PLACEHOLDER"
```

## Debug

### Check disk usage and identify high usage disks
```shell
df -h
```

### Check disk I/O and identify slow disks
```shell
iostat -x ${DISK_NAME} ${INTERVAL} ${COUNT}
```

### Check disk read and write performance
```shell
hdparm -Tt ${DISK_NAME}
```

### Check for errors in the system log related to disk I/O
```shell
dmesg | grep ${DISK_NAME}
```

### Check for disk errors and bad sectors
```shell
smartctl -a /dev/${DISK_NAME}
```

### Check for file system errors and corruption
```shell
fsck /dev/${DISK_NAME}
```

## Repair

### Identify the specific disk(s) causing the issue by monitoring disk usage and performance metrics.
```shell


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


```