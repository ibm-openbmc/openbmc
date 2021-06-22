SERVICE_ENABLED = "${@bb.utils.contains('DISTRO_FEATURES', 'ibm-service-account-policy', 'true', '', d)}"
#Seach patterns within /etc/pam.d/common-* files
COMMON_AUTH_PATTERN = "^auth.*success=3.*pam_unix.*"
COMMON_ACCOUNT_PATTERN = "^account.*success=2.*pam_unix.*"
COMMON_SESSION_PATTERN = "^session.*default.*pam_permit.*"
#Intended to break if pam config has unexpected changes on referenced lines/files
do_install_append() {
    err="0"
    #If ibm-service-account-policy is enabled then make pam config
    #file changes otherwise do nothing
    if [ -n "${SERVICE_ENABLED}" ]; then
        echo "ibm-service-account-policy enabled"
        #Check for patterns in config files before inserting lines in file
        #and fail if the pattern doesn't match
        grep -q ${COMMON_AUTH_PATTERN}  ${D}${sysconfdir}/pam.d/common-auth || err=$?
        if [ "$err" != "0" ]; then
            echo "ERROR: command-auth file changed, breaking to ensure pam config is intended..."
            echo "exit $err"
            exit $err
        else
            #increment pam_tally2.so default=n+1 as we are inserting pam_ibmacf after it
            sed -i.bak "s/auth.*default.*pam_tally2.*/auth [success=ok user_unknown=ignore default=3] pam_tally2.so deny=0 unlock_time=0/g" ${D}${sysconfdir}/pam.d/common-auth
            sed -i.bak "/${COMMON_AUTH_PATTERN}/i auth [success=3 default=die ignore=ignore] pam_ibmacf.so" ${D}${sysconfdir}/pam.d/common-auth
        fi

        grep -q ${COMMON_ACCOUNT_PATTERN} ${D}${sysconfdir}/pam.d/common-account || err=$?
        if [ "$err" != "0" ]; then
            echo "ERROR: command-account file changed, breaking to ensure pam config is intended..."
            echo "exit $err"
            exit $err
        else
            sed -i.bak "/pam_unix.*/i account [success=3 default=die ignore=ignore] pam_ibmacf.so" ${D}${sysconfdir}/pam.d/common-account
        fi

        grep -q ${COMMON_SESSION_PATTERN} ${D}${sysconfdir}/pam.d/common-session || err=$?
        if [ "$err" != "0" ]; then
            echo "ERROR: command-session file changed, breaking to ensure pam config is intended..."
            echo "exit $err"
            exit $err
        else
            sed -i.bak "/${COMMON_SESSION_PATTERN}/i session required pam_ibmacf.so" ${D}${sysconfdir}/pam.d/common-session
        fi
    fi

}
