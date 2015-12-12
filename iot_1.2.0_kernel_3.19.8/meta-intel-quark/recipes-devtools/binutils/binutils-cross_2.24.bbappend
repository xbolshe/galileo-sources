FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

#Quark errata - strip all lock prefixes from target binaries
SRC_URI += "file://0001-Add-momit_lock_prefix-no-yes-option.patch"
