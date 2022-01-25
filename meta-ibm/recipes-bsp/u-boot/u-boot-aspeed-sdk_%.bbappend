SFCLIENT_SIGN_ENABLE ?= "0"
SFCLIENT_SOCSEC_SIGN_HELPER ?= "sfclient-socsec-helper"

python __anonymous () {
    if d.getVar('SFCLIENT_SIGN_ENABLE') == '1':
        depends = d.getVar('DEPENDS')
        depends += ' sfclient-native'
        d.setVar('DEPENDS', depends)
        helper = d.getVar('SFCLIENT_SOCSEC_SIGN_HELPER')
        d.setVar('SOCSEC_SIGN_HELPER', helper)
}
