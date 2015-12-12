DESCRIPTION = "Native Border Router for IPv6"
SECTION = "applications"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD;md5=3775480a712fc46a69647678acb234cb"

S = "${WORKDIR}"

SRC_URI = "file://netcontiki-binary_v1.2.tar.bz2;name=netcontiki"
SRC_URI[netcontiki.md5sum] = "d5a325022b6ec48afd55c0f265fe70da"
SRC_URI[netcontiki.sha256sum] = "9cba7b4f0e6614f08349e1754b999f0917f2375dc47808b892fb0e7c6a104c0e"

RDEPENDS_${PN} = "bash python"

INHIBIT_PACKAGE_STRIP = "1"

INSTALL_ROOT = "/opt/netcontiki"
SBINDIR = "${INSTALL_ROOT}/sbin"
NETCONTIKI = "/netcontiki-bin/netcontiki"
TOOLDIR = "/tools/yanzi"
DEMODIR = "/examples/galileo/demo"

do_install() {
	install -m 0755 -d	${D}${INSTALL_ROOT} \
				${D}${SBINDIR} \
				${D}${SBINDIR}${DEMODIR}/www \
				${D}${SBINDIR}/examples/galileo/tests \
				${D}${SBINDIR}${TOOLDIR}/tlvscripts

	# Installation of border router binary and platform shell scripts
	install -m 0755 ${S}/netcontiki-bin/border-router.native	${D}${SBINDIR}
	install -m 0774 ${S}/netcontiki-bin/*.sh			${D}${SBINDIR}
	install -m 0755 ${S}/netcontiki-bin/bootstrap_server*           ${D}${SBINDIR}
	install -m 0755 ${S}/netcontiki-bin/lwm2mserver*                ${D}${SBINDIR}

	# Installation of Netcontiki demo scripts and web files for demo
	install -m 0774 ${S}${NETCONTIKI}${DEMODIR}/*.py		${D}${SBINDIR}${DEMODIR}
	install -m 0664 ${S}${NETCONTIKI}${DEMODIR}/www/*		${D}${SBINDIR}${DEMODIR}/www

	# Installation of Netcontiki test scripts
	install -m 0774 ${S}${NETCONTIKI}/examples/galileo/tests/*	${D}${SBINDIR}/examples/galileo/tests

	# Installation of Netcontiki tool scripts and files
	install -m 0774 ${S}${NETCONTIKI}${TOOLDIR}/*.py		${D}${SBINDIR}${TOOLDIR}
	install -m 0774 ${S}${NETCONTIKI}${TOOLDIR}/*.sh		${D}${SBINDIR}${TOOLDIR}
	install -m 0664 ${S}${NETCONTIKI}${TOOLDIR}/*.jar		${D}${SBINDIR}${TOOLDIR}
	install -m 0774 ${S}${NETCONTIKI}${TOOLDIR}/tlvscripts/*.py	${D}${SBINDIR}${TOOLDIR}/tlvscripts
	install -m 0664 ${S}${NETCONTIKI}${TOOLDIR}/tlvscripts/README	${D}${SBINDIR}${TOOLDIR}/tlvscripts
}

FILES_${PN} = "${SBINDIR}"
