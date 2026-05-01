#!/bin/bash

IP=$1
LOG_FILE="ip_monitor.log"

if ping -c 3 $IP > /dev/null
then
    echo "$(date) - $IP is UP" >> $LOG_FILE
else
    echo "$(date) - $IP is DOWN" >> $LOG_FILE

    # Send alert using AWS SNS
    aws sns publish \
        --topic-arn arn:aws:sns:ap-south-1:377480205258:IPMonitoringTopic \
        --message "ALERT: $IP is DOWN" \
        --subject "IP Monitoring Alert"
fi
