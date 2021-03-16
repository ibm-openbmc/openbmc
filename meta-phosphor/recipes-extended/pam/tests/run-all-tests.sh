#!/bin/sh
# Test the OpenBMC PAM module conversion script
#
# This is intended to run from its parent directory so it can find the
# pieces it needs:
#  - conversion tool under ./files/
#  - test case data under ./tests/original-source
# This create a directory: ./workdir
#
# Test the following scenarios:
# if common-password uses pam_cracklib:
#     Ensure common-password is changed to use pam_pwquality.
#     if pam_pwquality has default arguments:
#         Ensure pwquality.conf is not changed.
#     else
#         Ensure pwquality.conf is updated.
# else:
#     Ensure common-password is not changed.
#
# if common-auth uses pam_tally2:
#     Ensure common-auth is changed to use pam_faillock.
#     if both pam_tally2 arguments deny & unlock_time are default:
#         Ensure pwquality.conf is not changed.
#     else
#         Ensure pwquality.conf parms deny & unlock_time are updated.
# else
#      Ensure common-auth is not changed.
#
# Note: "file is not changed" means the file was not opened for writing even
# if the same content is written.  This is important for the overlay files.

# Variables:
#   original_source_dir - path to the source code needed for test input
#   workdir - path to a throwaway work directory
#   convert_pam_configs - path to the conversion tool
original_source_dir=./tests/original-source
workdir=./workdir
convert_pam_configs=./files/convert-pam-configs.sh

# Prepare testcase input files and environment variables
function testcase_setup()
{
  mkdir -p ${workdir}
  cp -R ${original_source_dir}/* ${workdir}
  export pamconfdir=${workdir}/pam.d
  export securityconfdir=${workdir}/security
}

function validate_pam_configs_are_in_new_format()
{
  if grep pam_cracklib.so ${workdir}/pam.d/common-password >/dev/null; then
      echo "Error: common-password still uses cracklib"
  fi
  if test `grep -c pam_pwquality.so ${workdir}/pam.d/common-password` != 1; then
      echo "Error: common-password does not use pwquality.so"
  fi
  if grep pam_tally2.so ${workdir}/pam.d/common-auth >/dev/null; then
      echo "Error: common-auth still uses tally2"
  fi
  if test `grep -c pam_faillock.so ${workdir}/pam.d/common-auth` != 2; then
      echo "Error: common-auth does not use faillock"
  fi
}

cat <<END_OF_DESCRIPTION
Test 1: default config
  In this state the BMC has old format config files with default values.
  For example, the files were never changed by any phosphor-user-manager
  D-Bus API, REST API, or hand-edits.
END_OF_DESCRIPTION
testcase_setup
${convert_pam_configs}
echo "Validate PAM config files are in the new format"
validate_pam_configs_are_in_new_format
echo "TODO: validate files under security/ were not opened for update."

cat <<END_OF_DESCRIPTION
Test 2: no conversion needed
  In this state the BMC has the new format config files, so no conversion
  is needed.  This can be because either:
   - The files were previously updated by the conversion tool, or
   - The BMC was installed with the new format files.
END_OF_DESCRIPTION
${convert_pam_configs}
echo "Validate PAM config files are in the new format"
validate_pam_configs_are_in_new_format
echo "TODO: validate files under pam.d/ were not opened for update."

# No testcase is needed for new format with modified parameters; this is
# covered by the previous test case.

cat <<END_OF_DESCRIPTION
Test 3: non-default config
  In this state the BMC has old format config files with non-default
  values.  For example, the files were changed by a phosphor-user-manager
  D-Bus API, REST API, or hand-edits.
END_OF_DESCRIPTION
testcase_setup
sed -i "" -e "s@minlen=8@minlen=15@" ${workdir}/pam.d/common-password
sed -i "" -e "s@deny=0@deny=5@" ${workdir}/pam.d/common-auth
sed -i "" -e "s@unlock_time=0@unlock_time=123@" ${workdir}/pam.d/common-auth
${convert_pam_configs}
validate_pam_configs_are_in_new_format
echo "TODO: Validate parm values in files under security/ are correct."
