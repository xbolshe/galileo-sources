DESCRIPTION = "List of drivers to be auto-loaded"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "file://galileo-init.sh \
           file://galileo.conf \
           file://galileo_gen2.conf \
           file://galileo-init.service"

INSTALLDIR = "/etc/modules-load.galileo"
FILES_${PN} += "${INSTALLDIR} \
                ${sbindir}/galileo-init.sh"
FILES_${PN}-dbg += "${INSTALLDIR}/.debug"

do_install() {
        install -d ${D}${INSTALLDIR}
        install -m 0755 ${WORKDIR}/galileo.conf ${D}${INSTALLDIR}/
        install -m 0755 ${WORKDIR}/galileo_gen2.conf ${D}${INSTALLDIR}/
        install -d ${D}${sysconfdir}/init.d
        install -m 0755 ${WORKDIR}/galileo-init.sh ${D}${sysconfdir}/init.d

        install -d ${D}${systemd_unitdir}/system/
        install -m 0644 ${WORKDIR}/galileo-init.service ${D}${systemd_unitdir}/system/
        install -d ${D}${sbindir}
        install -m 0755 ${WORKDIR}/galileo-init.sh ${D}${sbindir}
}

inherit update-rc.d systemd

INITSCRIPT_NAME = "galileo-init.sh"
INITSCRIPT_PARAMS = "start 75 5 ."

SYSTEMD_SERVICE_${PN} = "galileo-init.service"
