FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	file://0001-fbmem.c-fix-formula-for-centered-logo-margins.patch \
"

inherit custom-kernel-logo
KERNEL_LOGO_PNG = "uf_kernel_logo.png"