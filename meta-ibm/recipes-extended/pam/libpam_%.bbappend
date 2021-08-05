FAILLOCK_DENY_MATCH="deny=0"
FAILLOCK_UNLOCK_TIME_MATCH="unlock_time=0"
do_install:append() {
    #ibm-defaults for maximun failed tries are 5 with locking the account for 300 seconds
	grep -q ${FAILLOCK_DENY_MATCH} ${D}${sysconfdir}/security/faillock.conf && \
    grep -q ${FAILLOCK_UNLOCK_TIME_MATCH} ${D}${sysconfdir}/security/faillock.conf ; \
    err=$?
    if [ "$err" != "0" ]; then
        echo "ERROR: faillock.conf file changed, breaking to ensure config is intended..."
            echo "exit $err"
            exit $err
    else
            sed -i.bak 's/deny=0/deny=5/ ; s/unlock_time=0/unlock_time=300/' \
            ${D}${sysconfdir}/security/faillock.conf
            rm ${D}${sysconfdir}/security/faillock.conf.bak
    fi
}
