#!/bin/sh

# Get the mtd device number (mtdX)
findmtd() {
  m="$(grep -xl "$1" /sys/class/mtd/*/name)"
  m="${m%/name}"
  m="${m##*/}"
  echo "${m}"
}

pnormtd="$(findmtd pnor)"
pnor="${pnormtd#mtd}"
pnordev="/dev/mtd${pnor}"

if [[ ! "$(dd if=${pnordev} bs=1 count=3 2> /dev/null)" = "UBI" ]]; then
  # Check if the pnor is blank (all 0xFs), if it is then format it as UBI to
  # support patch files. This is a workaround to use single image on simics.
  if [[ "$(hexdump -n 4 ${pnordev})" = *"ffff ffff"* ]]; then
    echo "${pnordev} is blank, formatting as UBI"
    ubiformat "${pnordev}" -y -q
    exit 0
  else
    echo "${pnordev} is not formatted UBI"
    exit 1
  fi
fi
