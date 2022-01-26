FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:append:ibm-ac-server = " file://witherspoon.cfg"
SRC_URI:append:p10bmc = " file://p10bmc.cfg"
SRC_URI:append:mihawk = " file://mihawk.cfg"
SFCLIENT_SIGN_ENABLE ?= "0"

python __anonymous() {
    if d.getVar('SFCLIENT_SIGN_ENABLE') == '1':
        check_var_names = [
            'SF_PKCS11_CONFIG',
            'SSH_AUTH_SOCK',
            'SSH_AGENT_PID',
        ]
        check_vars = []
        for name in check_var_names:
            check_vars.append(d.getVar(name))
        if not all(check_vars):
            bb.fatal('Signing with sfclient but one of {} is unset'.format(
                ', '.join(check_var_names)))

        spl_sign_key = d.getVar('SPL_SIGN_KEYNAME')
        uboot_sign_key = d.getVar('UBOOT_SIGN_KEYNAME')
        d.setVar('SPL_SIGN_KEYDIR', 'object={}'.format(spl_sign_key))
        d.setVar('SPL_MKIMAGE_SIGN_ARGS', '-N pkcs11')
        d.setVar('UBOOT_SIGN_KEYDIR', 'object={}'.format(uboot_sign_key))
        d.setVar('UBOOT_MKIMAGE_SIGN_ARGS', '-N pkcs11')
        depends = d.getVar('DEPENDS')
        depends += ' sfclient-native libp11-native'
        d.setVar('DEPENDS', depends)
}
