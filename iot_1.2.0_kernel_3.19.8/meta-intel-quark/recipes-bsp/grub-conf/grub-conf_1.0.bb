DESCRIPTION = "grub.conf"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit deploy

GRUB_CONF = "grub.conf"
GRUB_PATH = "boot/grub/"
SRC_URI = "file://${GRUB_CONF}"

do_deploy() {
  install -d ${DEPLOYDIR}/${GRUB_PATH}
  install -m 0755 ${WORKDIR}/${GRUB_CONF} ${DEPLOYDIR}/${GRUB_PATH}/${GRUB_CONF}
}

addtask deploy after do_install before do_build
