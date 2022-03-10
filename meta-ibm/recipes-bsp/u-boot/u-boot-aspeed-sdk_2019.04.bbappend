FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:p10bmc = " file://ibm.json file://ips.json file://keys/"

OTPTOOL_CONFIGS:p10bmc = "${WORKDIR}/ibm.json ${WORKDIR}/ips.json"
OTPTOOL_KEY_DIR:p10bmc = "${WORKDIR}/keys/"

# !!! Do not copy p10bmc's use of little-endian key ordering !!!
#
# The prefered order for production silicon is big-endian. Little-endian is necessary for p10bmc
# platforms due to development history involving pre-production AST2600 silicon. More discussion
# here:
#
# https://gerrit.openbmc-project.xyz/c/openbmc/openbmc/+/50716
SOCSEC_SIGN_EXTRA_OPTS = "--rsa_key_order=little"

do_deploy:prepend:p10bmc() {

	pubkey="${WORKDIR}/keys/rsa_pub_oem_dss_key.pem"
	# When secureboot signing with a signing server, SOCSEC_SIGN_KEY is the name of the
	# signing server project and not a local private key.
	if [ "${SFCLIENT_SIGN_ENABLE}" = "1" ]
	then
		url=`jq -r '.url' "${SF_PKCS11_CONFIG}"`
		epwd=`jq -r '.epwd' "${SF_PKCS11_CONFIG}"`
		pkey=`jq -r '."private-key"' "${SF_PKCS11_CONFIG}"`
		SSH_AGENT_PID=${SSH_AGENT_PID} SSH_AUTH_SOCK=${SSH_AUTH_SOCK} sf_client \
			-project  "getpubkey" \
			-param    "-signproject ${SOCSEC_SIGN_KEY} -format pem" \
			-epwd     "${epwd}" \
			-comments "obtain pubkey" \
			-url      "${url}" \
			-pkey     "${pkey}" \
			-output   "${pubkey}"
	else
		# otptool needs access to the public and private socsec signing keys in the keys/ directory
		openssl rsa -in ${SOCSEC_SIGN_KEY} -pubout > ${pubkey}
	fi
}
