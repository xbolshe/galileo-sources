FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${PV}:"

# Clanton Hill has 2 physical ethernet ports.
# This updated interfaces file will make sure eth1 automatically pick up an address from DHCP.
SRC_URI += "file://interfaces"
