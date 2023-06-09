FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}-uf:"

SRC_URI += "\
	file://swupdate-updates.env \
	file://sign_pub.pem \
	file://0001-Log-save_state.patch \
	file://0002-Revert-Don-t-run-pre-post-update-commands-in-dry-run.patch \
"

RDEPENDS:${PN} = "libgcc"

do_install:append() {
  install -d ${D}${sysconfdir}/swupdate
  install -m 0644 ${WORKDIR}/swupdate-updates.env ${D}${sysconfdir}/swupdate/swupdate.env
  install -m 0644 ${WORKDIR}/sign_pub.pem ${D}${sysconfdir}/swupdate/sign_pub.pem
}

python __anonymous () {
    distro_ufcloudagent_support = d.getVar('DISTRO_UFCLOUDAGENT_SUPPORT', True)
    if bb.utils.contains('DISTRO_FEATURES','systemd',True,False,d):
        if distro_ufcloudagent_support == "enabled" :
            d.setVar("SYSTEMD_AUTO_ENABLE:${PN}", "enable")
        elif distro_ufcloudagent_support == "disabled" :
            d.setVar("SYSTEMD_AUTO_ENABLE:${PN}", "disable")
    elif bb.utils.contains('DISTRO_FEATURES','sysvinit',True,False,d):
        if distro_ufcloudagent_support == "disabled" :
            d.setVar("INITSCRIPT_PARAMS", "stop 70 .")
}
