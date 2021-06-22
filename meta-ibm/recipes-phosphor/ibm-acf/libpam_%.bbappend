SERVICE_ENABLED = "${@bb.utils.contains('DISTRO_FEATURES', 'ibm-service-account-policy', 'true', '', d)}"
#Seach patterns within /etc/pam.d/common-* files
COMMON_AUTH_PATTERN = "^auth.*success=3.*pam_unix.*"
COMMON_ACCOUNT_PATTERN = "^account.*success=2.*pam_unix.*"
COMMON_PASSWORD_PATTERN = "^password.*success=ok.*default=die.*pam_pwquality.so.*"
COMMON_SESSION_PATTERN = "^session.*default.*pam_permit.*"
#Intended to break if pam config has unexpected changes on referenced lines/files
do_install:append() {
    err="0"
    #If ibm-service-account-policy is enabled then make pam config
    #file changes otherwise do nothing
    if [ -n "${SERVICE_ENABLED}" ]; then
        echo "ibm-service-account-policy enabled"
        #Check for patterns in config files before inserting lines in file
        #and fail if the pattern doesn't match
        grep -q ${COMMON_AUTH_PATTERN}  ${D}${sysconfdir}/pam.d/common-auth || err=$?
        if [ "$err" != "0" ]; then
            echo "ERROR: common-auth file changed, breaking to ensure pam config is intended..."
            echo "exit $err"
            exit $err
        else
            #increment pam_tally2.so default=n+1 as we are inserting pam_ibmacf after it
            sed -i.bak "/${COMMON_AUTH_PATTERN}/i auth [success=4 default=2 ignore=ignore] pam_ibmacf.so" ${D}${sysconfdir}/pam.d/common-auth
        fi

        # The service account "account" checks (expired account, etc.) are
        # performed by pam_unix, so no changes are needed to common-account.

        grep -q ${COMMON_SESSION_PATTERN} ${D}${sysconfdir}/pam.d/common-session || err=$?
        if [ "$err" != "0" ]; then
            echo "ERROR: common-session file changed, breaking to ensure pam config is intended..."
            echo "exit $err"
            exit $err
        else
            sed -i.bak "/${COMMON_SESSION_PATTERN}/i session required pam_ibmacf.so" ${D}${sysconfdir}/pam.d/common-session
        fi
        grep -q ${COMMON_PASSWORD_PATTERN} ${D}${sysconfdir}/pam.d/common-password || err=$?
        if [ "$err" != "0" ]; then
            echo "ERROR: common-password file changed, breaking to ensure pam config is intended..."
            echo "exit $err"
            exit $err
        else
            sed -i.bak "/${COMMON_PASSWORD_PATTERN}/i password [success=ignore default=die] pam_ibmacf.so" ${D}${sysconfdir}/pam.d/common-password
        fi
        rm ${D}${sysconfdir}/pam.d/common-*.bak
    fi

}
