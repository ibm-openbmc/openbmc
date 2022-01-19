SFCLIENT_SIGN_ENABLE ?= "0"
PACKAGECONFIG:append:class-native = "${@oe.utils.conditional('SFCLIENT_SIGN_ENABLE', '1', ' libssh2', '', d)}"
