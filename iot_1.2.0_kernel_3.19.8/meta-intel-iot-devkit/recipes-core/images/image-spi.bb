DESCRIPTION = "A small image capable of fitting into the on-board SPI flash"

IMAGE_INSTALL = "packagegroup-core-boot ${ROOTFS_PKGMANAGE_BOOTSTRAP} ${CORE_IMAGE_EXTRA_INSTALL}"

IMAGE_LINGUAS = " "

LICENSE = "GPLv2"

inherit core-image

IMAGE_FSTYPES = "${INITRAMFS_TYPES}"
IMAGE_ROOTFS_SIZE = "2048"
EXTRA_IMAGECMD_append_ext2 = " -N 2000"

IMAGE_FEATURES += "package-management"

IMAGE_INSTALL += "kernel-modules"
IMAGE_INSTALL += "ethtool"
IMAGE_INSTALL += "strace"
IMAGE_INSTALL += "ppp"
IMAGE_INSTALL += "linuxptp"
IMAGE_INSTALL += "libstdc++"
IMAGE_INSTALL += "dmidecode"

ROOTFS_POSTPROCESS_COMMAND += "modules_ld_sequence ; "

modules_ld_sequence() {
  # This will ensure pch_udc to load before g_serial
  echo "g_serial" >> ${IMAGE_ROOTFS}/etc/modules-load.d/pch_udc.conf
  # Remove g_serial.conf to avoid duplicate module loading
  cd ${IMAGE_ROOTFS}/etc/modules-load.d/; rm g_serial.conf
}
