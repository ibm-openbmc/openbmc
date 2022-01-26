SFCLIENT_SIGN_ENABLE ?= "0"

do_install:append () {
    if [ "${SFCLIENT_SIGN_ENABLE}" = "1" ]; then
        create_wrapper ${D}${bindir}/uboot-mkimage \
            OPENSSL_ENGINES=${libdir}/engines-1.1 \
            PKCS11_MODULE_PATH=${libdir}/libsf_pkcs11.so \
            SF_PKCS11_CONFIG=${SF_PKCS11_CONFIG} \
            SSH_AUTH_SOCK=${SSH_AUTH_SOCK} \
            SSH_AGENT_PID=${SSH_AGENT_PID}
    fi
}
