SUMMARY = "Hardware Diagnostics for POWER Systems (PEL parser data support)"

DESCRIPTION = \
    "The PEL parsers for openpower-hw-diags are dependent on the Chip Data \
    files that are currently stored in openpower-libhei. This recipe is used \
    to extract that data and any supporting python modules that may exist."

HOMEPAGE = "https://github.com/openbmc/openpower-libhei/tree/master/xml"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://../LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

include openpower-libhei-rev.inc

S = "${WORKDIR}/git/xml"

inherit setuptools3
inherit perlnative

DEPENDS += "openpower-pel-parsers"
DEPENDS += "libxml2-native libxml-simple-perl-native libjson-perl-native"

