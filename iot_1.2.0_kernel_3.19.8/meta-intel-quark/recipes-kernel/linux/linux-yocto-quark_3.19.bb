inherit kernel
require recipes-kernel/linux/linux-yocto.inc

# Override SRC_URI in a bbappend file to point at a different source
# tree if you do not want to build from Linus' tree.

SRC_URI = "git://LINUX_YOCTO_REPO;protocol=file;bareclone=1;branch=LINUX_YOCTO_BRANCH"

SRC_URI += "file://quark_3.19.cfg"
SRC_URI += "file://quark-standard_3.19.scc"
SRC_URI_append_quark_iot-devkit = " file://kernel-perf-tool.scc"
SRC_URI += "${@base_contains('PACKAGECONFIG','quark-tpm','file://tpm.cfg','',d)}"

LINUX_VERSION ?= "3.19"
LINUX_VERSION_EXTENSION ?= "-quark"

# Override SRCREV to point to a different commit in a bbappend file to
# build a different release of the Linux kernel.
SRCREV = "${AUTOREV}"
SRCREV_machine_quark = "${AUTOREV}"

PR = "r0"
PV = "${LINUX_VERSION}"

# Override COMPATIBLE_MACHINE to include your machine in a bbappend
# file. Leaving it empty here ensures an early explicit build failure.
COMPATIBLE_MACHINE = "quark"

RDEPENDS_kernel-base=""

# Minimum set of defence based compiler and linker flags enabled
# as per SDL 4.0 requirement.
KERNEL_EXTRA_ARGS += 'EXTRA_CFLAGS="-D_FORTIFY_SOURCE=2 -Wformat -O2 -Wformat-security" EXTRA_LDFLAGS="-z relro -z now -z noexecstack"'

# list of kernel modules that will be auto-loaded for Quark X1000-based
# platforms.
# For platform specific kernel module, please define the list at respective
# platform-specific recipes-kernel/linux/linux-yocto-quark_3.8.bbappend
# e.g. meta-galileo/recipes-kernel/linux/linux-yocto-quark_3.8.bbappend
# Be extra careful on the kernel module naming as some use '-' and '_' as
# character seperator.

# USB Host
KERNEL_MODULE_AUTOLOAD_append_quark = " ehci-hcd"
KERNEL_MODULE_AUTOLOAD_append_quark = " ehci-pci"
KERNEL_MODULE_AUTOLOAD_append_quark = " ohci-hcd"
KERNEL_MODULE_AUTOLOAD_append_quark = " usb-storage"
KERNEL_MODULE_AUTOLOAD_append_quark = " usbhid"
KERNEL_MODULE_AUTOLOAD_append_quark = " evdev"
# USB Device (pch_udc is required for g_serial to load)
KERNEL_MODULE_AUTOLOAD_append_quark = " pch_udc g_serial"
KERNEL_MODULE_PROBECONF += " g_serial"
module_conf_g_serial = " options g_serial vendor=0x8086 product=0xBABE"

# SDHC
KERNEL_MODULE_AUTOLOAD_append_quark = " sdhci-pci"
KERNEL_MODULE_AUTOLOAD_append_quark = " mmc_block"
# SPI
KERNEL_MODULE_AUTOLOAD_append_quark = " spidev"
KERNEL_MODULE_AUTOLOAD_append_quark = " spi-pxa2xx-platform"
KERNEL_MODULE_AUTOLOAD_append_quark = " spi-pxa2xx-pci"
# GPIO
KERNEL_MODULE_AUTOLOAD_append_quark = " gpio-sch"
# Ethernet
KERNEL_MODULE_AUTOLOAD_append_quark = " stmmac"
KERNEL_MODULE_AUTOLOAD_append_quark = " stmmac-pci"
# EEPROM Access
KERNEL_MODULE_AUTOLOAD_append_quark = " at24"
# EFIVARS
KERNEL_MODULE_AUTOLOAD_append_quark = " efivars"
# MFD CORE
KERNEL_MODULE_AUTOLOAD_append_quark = " mfd-core"
# LPC SCH
KERNEL_MODULE_AUTOLOAD_append_quark = " lpc_sch"
