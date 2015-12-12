DESCRIPTION = "libcoap: C Implementation of CoAP"
SECTION = "applications"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://LICENSE.BSD;md5=59ed1e22363e3c110c1e7929684ddb4e"

SRC_URI = "http://downloads.sourceforge.net/project/libcoap/coap-18/libcoap-4.1.1.tar.gz"
SRC_URI[md5sum] = "2ab6daf1f187f02d25b77c39c2ecc56b"
SRC_URI[sha256sum] = "20cd0f58434480aa7e97e93a66ffef4076921de9687b14bd29fbbf18621bd394"

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

inherit autotools

INSTALL_ROOT="/usr/local"
BINDIR="${INSTALL_ROOT}/bin"

S = "${WORKDIR}/libcoap-4.1.1"
B = "${S}"

CONFIGUREOPTS_remove = " --disable-silent-rules \
			 --disable-dependency-tracking \
			 --with-libtool-sysroot=${STAGING_DIR_HOST}"

PARALLEL_MAKE = ""

EXTRA_OEMAKE = "'CC=${CC}' 'LD=${CC}' \
		'-I${S}' \
		'-I${S}/doc' \
		'-I${S}/examples' \
		'-I${S}/tests'"

do_install() {
    install -d 0755 ${D}${INSTALL_ROOT}
    install -d 0755 ${D}${BINDIR}
    install -m 0755 ${S}/examples/coap-server ${D}${BINDIR}/
    install -m 0755 ${S}/examples/coap-client ${D}${BINDIR}/
}

PACKAGES = "${PN}"

FILES_${PN} = "${BINDIR}"
