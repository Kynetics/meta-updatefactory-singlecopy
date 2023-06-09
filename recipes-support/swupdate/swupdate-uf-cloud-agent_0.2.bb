SUMMARY = "SWUpdate Update Factory configuration files for Cloud Agent"

require swupdate-uf-agent.inc

SRC_URI += "\
	file://update.env \
	file://post_download.sh \
	file://reboot_for_update.sh \
	file://patch_uenv_with_recovery \
	file://update_setup.uenv \
	file://distro_bootcmd_prepend.uenv \
"

do_install:append() {
	install -d ${D}${bindir}/
	install -m 0755 ${WORKDIR}/post_download.sh ${D}${bindir}/
	install -m 0755 ${WORKDIR}/reboot_for_update.sh ${D}${bindir}/
	install -m 0755 ${WORKDIR}/patch_uenv_with_recovery ${D}${bindir}/
	install -d ${D}${sysconfdir}/swupdate/uboot
	install -m 0644 ${WORKDIR}/update.env ${D}${sysconfdir}/swupdate/
	install -m 0644 ${WORKDIR}/update_setup.uenv ${D}${sysconfdir}/swupdate/uboot/
	install -m 0644 ${WORKDIR}/distro_bootcmd_prepend.uenv ${D}${sysconfdir}/swupdate/uboot/
	install -d ${D}/updates
}

FILES:${PN} += " ${bindir}/* ${sysconfdir}/* /updates"
