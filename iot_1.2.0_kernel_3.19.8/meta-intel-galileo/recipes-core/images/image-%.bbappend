IMAGE_INSTALL += "galileo-target"
IMAGE_INSTALL += "mtd-utils-jffs2"
IMAGE_INSTALL += "galileo-init"

ROOTFS_POSTPROCESS_COMMAND += "install_sketch ;"

install_sketch() {
  # Create /sketch directory required to run arduino sketches
  install -d ${IMAGE_ROOTFS}/sketch
}
