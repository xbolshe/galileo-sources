FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# These patches will break uclibc generally as they will force the loader to
# only look in lib32:/usr/lib32 and nowhere else.  If you are planning on using
# only uclibc you are highly recommended to remove them. These hacks are in
# place to let a binary think the image is a full uclibc image by using the
# loader /lib/ld-uClibc.so.0 which will then look in a completely different dir
# for libs. This is probably not what YOU want to do but it allows the running
# of modified uclibc compiled applications provided the libs are available in
# the lib32 folders.

SRC_URI_append_virtclass-multilib-lib32 += " \
  file://0001-dl-elf.c-force-ldso-to-look-in-lib32-usr-lib32.patch \
  file://0002-dl-elf.c-never-look-in-shared-library-loader-for-lib.patch"
