FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

do_install_append_iot-devkit-spi() {
	install -d ${D}${sysconfdir}
	echo "kernel.hotplug = /sbin/mdev" >> ${D}${sysconfdir}/sysctl.conf
}

#remove udhcpc & syslog
RRECOMMENDS_${PN}_iot-devkit = ""
