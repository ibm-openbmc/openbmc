SFCLIENT_SIGN_ENABLE ?= "0"

do_install:append () {
    if [ "${SFCLIENT_SIGN_ENABLE}" = "1" ]; then
        create_wrapper ${D}${bindir}/socsec \
            SF_PKCS11_CONFIG=${SF_PKCS11_CONFIG} \
            SSH_AUTH_SOCK=${SSH_AUTH_SOCK} \
            SSH_AGENT_PID=${SSH_AGENT_PID}
    fi
}
