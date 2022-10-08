#!/bin/sh
retries=100
echo "Checking every 2s for active VPD parsers..."
while [ $retries -ne 0 ]
do
    sleep 2
    systemctl -q is-active ibm-vpd-parser@*.service
    active=$?
    if [ $active -ne 0 ]
    then
        echo "Done wait for active VPD parsers. Exit success"
        exit 0
    fi
    retries=`expr $retries - 1`
    echo "VPD parsers still running. Retries remaining: $retries"
done
echo "Exit wait for VPD services to finish with timeout"
exit 1
