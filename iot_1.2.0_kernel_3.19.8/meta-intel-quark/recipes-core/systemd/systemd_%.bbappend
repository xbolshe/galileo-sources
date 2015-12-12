FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_quark = " \
	file://wired-dhcp.network \
	file://0001-add-option-to-disable-LTO.patch"

do_install_append_quark () {
        install -d ${D}${sysconfdir}/systemd/network/
        install -m 0644 ${WORKDIR}/wired-dhcp.network ${D}${sysconfdir}/systemd/network/wired-dhcp.network
}

FILES_${PN} += " ${sysconfdir}/systemd/network"

PACKAGECONFIG[resolved] = ""
PACKAGECONFIG[networkd] = ""

EXTRA_OECONF_append = " \
--disable-lto"
