#!/bin/sh
# Convert OpenBMC linux-PAM config files
set -e

# Location of config files this script modifies:
#   pamconfdir - path to the PAM config files
#   securityconfdir - path to the security config files
: ${pamconfdir:=/etc/pam.d}
: ${securityconfdir:=/etc/security}

# Default parameter values
# These are the parameter values in the read-only config files installed
# into OpenBMC's file system.  Some values are customized away from the
# original source project defaults.
minlen_default=8
deny_default=0
unlock_time_default=0

# Handle common-password:
#   Change cracklib to pwquality and handle the minlen parm.
pam_cracklib=`grep "^password.*pam_cracklib.so" <${pamconfdir}/common-password` || true
if [ -n "${pam_cracklib}" ]
then
    echo "Changing ${pamconfdir}/common-password to use pam_pwquality.so (was pam_cracklib.so)" >&2
    minlen=`echo ${pam_cracklib} | sed -e 's/.*minlen=\([[:alnum:]]*\).*/\1/'`
    if [ "${minlen}" != ${minlen_default} ]
    then
        echo "  Converting parm minlen=${minlen} to ${securityconfdir}/pwquality.conf minlen." >&2
        sed -i.bak -e 's/^minlen=.*/minlen='${minlen}'/' ${securityconfdir}/pwquality.conf
    fi
    pattern='^password.*pam_cracklib.so.*'
    replacement='password        [success=ok default=die]        pam_pwquality.so debug # see /etc/security/pwquality.conf'
    sed -i.bak -e "s@${pattern}@${replacement}@" ${pamconfdir}/common-password
    echo "# This file was converted by $0" >>${pamconfdir}/common-password
fi

# Handle common-auth:
#   Change tally2 to faillock and handle the deny & unlock_time parms.
pam_tally2=`grep "^auth.*pam_tally2.so" <${pamconfdir}/common-auth` || true
if [ -n "${pam_tally2}" ]
then
    echo "Changing ${pamconfdir}/common-auth to use pam_faillock.so (was pam_tally2.so)" >&2
    deny=`echo ${pam_tally2} | sed -e 's/.*deny=\([[:alnum:]]*\).*/\1/'`
    unlock_time=`echo ${pam_tally2} | sed -e 's/.*unlock_time=\([[:alnum:]]*\).*/\1/'`
    if [ "${deny}" != ${deny_default} -o \
         "${unlock_time}" != ${unlock_time_default} ]
    then
        # Change faillock.conf parameters
        echo "  Converting parm deny=${deny} to ${securityconfdir}/faillock.conf deny." >&2
        echo "  Converting parm unlock_time=${unlock_time} to ${securityconfdir}/faillock.conf unlock_time." >&2
        sed -i.bak \
            -e 's/^deny=.*/deny='${deny}'/' \
            -e 's/^unlock_time=.*/unlock_time='${unlock_time}'/' \
            ${securityconfdir}/faillock.conf
    fi
    # Change pam_tally2 to pam_faillock (changes the overall auth stack)
    sed -i.bak \
        -e 's@^auth.*pam_tally2.so.*$@@' \
        -e 's@^auth.*pam_deny.so@auth    [default=die]                   pam_faillock.so authfail@' \
        -e 's@^auth.*pam_permit.so@auth    sufficient                      pam_faillock.so authsucc@' \
        ${pamconfdir}/common-auth
    echo "# This file was converted by $0" >>${pamconfdir}/common-auth
fi

exit 0
