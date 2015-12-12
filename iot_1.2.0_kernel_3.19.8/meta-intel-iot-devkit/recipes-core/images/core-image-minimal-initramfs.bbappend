FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PACKAGE_INSTALL = "initramfs-live-boot busybox base-passwd udev"

PACKAGE_INSTALL += "kernel-module-usb-storage"
PACKAGE_INSTALL += "kernel-module-ehci-hcd kernel-module-ehci-pci kernel-module-ohci-hcd"
PACKAGE_INSTALL += "kernel-module-stmmac"
PACKAGE_INSTALL += "kernel-module-sdhci kernel-module-sdhci-pci kernel-module-mmc-block"
