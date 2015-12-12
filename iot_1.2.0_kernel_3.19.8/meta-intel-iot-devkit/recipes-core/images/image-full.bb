DESCRIPTION = "A fully functional image to be placed on an SD card"

IMAGE_INSTALL = "packagegroup-core-boot ${ROOTFS_PKGMANAGE_BOOTSTRAP} ${CORE_IMAGE_EXTRA_INSTALL}"

IMAGE_LINGUAS = " "

LICENSE = "GPLv2"

IMAGE_FSTYPES = "ext3 live"

inherit core-image

#IMAGE_FSTYPES_remove = "cpio.lzma"
NOISO = "1"
NOHDD = "1"
IMAGE_ROOTFS_SIZE = "307200"

EXTRA_IMAGECMD_append_ext2 = " -N 2000"

IMAGE_FEATURES += "package-management"
IMAGE_INSTALL += "kernel-modules"
IMAGE_INSTALL += "ethtool"
IMAGE_INSTALL += "strace"
IMAGE_INSTALL += "ppp"
IMAGE_INSTALL += "linuxptp"
IMAGE_INSTALL += "libstdc++"
IMAGE_INSTALL += "sysstat"
IMAGE_INSTALL += "dmidecode"

IMAGE_INSTALL += "python python-modules python-numpy"
IMAGE_INSTALL += "alsa-lib alsa-utils"
IMAGE_INSTALL += "wireless-tools"
IMAGE_INSTALL += "wpa-supplicant"
IMAGE_INSTALL += "openssh"

IMAGE_INSTALL += "linux-firmware-iwlwifi-6000g2a-6"
IMAGE_INSTALL += "linux-firmware-iwlwifi-135-6"
IMAGE_INSTALL += "bluez4"
IMAGE_INSTALL += "connman connman-client connman-tests"
IMAGE_INSTALL += "ca-certificates"
#IMAGE_INSTALL += "lighttpd"

IMAGE_INSTALL += "packagegroup-core-eclipse-debug"

IMAGE_INSTALL += "e2fsprogs-mke2fs e2fsprogs-e2fsck"
IMAGE_INSTALL += "dosfstools util-linux-mkfs"

IMAGE_INSTALL += "timedate-scripts"

# these are the only lib32-* libs we want on our image
IMAGE_INSTALL += "lib32-uclibc lib32-uclibc-libm lib32-libstdc++ lib32-uclibc-libpthread"
# make sure no lib32-* libs get chosen by IMAGE_FEATURES
PACKAGE_EXCLUDE_COMPLEMENTARY = "lib32-.*"

ROOTFS_POSTPROCESS_COMMAND += "simlink_ld_uclibc ; modules_ld_sequence ;"

simlink_ld_uclibc() {
  # This allows uclibc compiled binaries to find the uclibc loader note that
  # binaries will not run unless LD_LIBRARY_PATH is set correctly
  cd ${IMAGE_ROOTFS}/lib/; ln -s ../lib32/ld-uClibc.so.0
}

modules_ld_sequence() {
  # This will ensure pch_udc to load before g_serial
  echo "g_serial" >> ${IMAGE_ROOTFS}/etc/modules-load.d/pch_udc.conf
  # Remove g_serial.conf to avoid duplicate module loading
  cd ${IMAGE_ROOTFS}/etc/modules-load.d/; rm g_serial.conf
}

EXTRA_IMAGEDEPENDS = "grub-conf"
