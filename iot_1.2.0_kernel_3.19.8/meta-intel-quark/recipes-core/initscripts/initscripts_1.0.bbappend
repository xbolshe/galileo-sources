FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${PV}:"

# The time and date format used in Busybox is %Y%m%d%H%M%S
# This is to make sure systemV able to execute the time/date
# setting script during init time.
SRC_URI += "file://bootmisc.sh \
	    file://save-rtc.sh \
	   "
