# Settings for GCC compiler to omit LOCK prefix
do_install_append () {
  cd ${D}
  cd ..
  # Replace line 2 in specs to include "-momit-lock-prefix=yes"
  sed -i -e '2 c %{m64|mx32:;:--32}  %{m64:--64}  %{mx32:--x32}  %{!mno-sse2avx:%{mavx:-msse2avx}} %{msse2avx:%{!mavx:-msse2avx}} -momit-lock-prefix=yes' gcc-4.*/build.${TARGET_SYS}.${TARGET_SYS}/gcc/specs

  # Standard GCC installation will not install specs files by default.
  # Build specs was embedded in gcc executable during gcc software compilation.
  # We install the modified specs file into rootfs to enforce GCC to use the new specs.
  install -d 0755 ${D}/usr/lib/gcc/${TARGET_SYS}/
  install -m 0755 gcc-4.*/build.${TARGET_SYS}.${TARGET_SYS}/gcc/specs ${D}/usr/lib/gcc/${TARGET_SYS}/
}

FILES_${PN}_append = "/usr/lib/gcc/${TARGET_SYS}/"
