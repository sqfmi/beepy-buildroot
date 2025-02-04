BBQX0KBD_VERSION = 1.0
BBQX0KBD_SITE = $(BR2_EXTERNAL_BB_DRIVERS_PATH)/package/bbqX0kbd
BBQX0KBD_SITE_METHOD = local

BBQX0KBD_INSTALL_IMAGES = YES
BBQX0KBD_MODULE_SUBDIRS = .

define BBQX0KBD_BUILD_CMDS
	for dts in $(@D)/*.dts; do \
		$(HOST_DIR)/bin/dtc -@ -I dts -O dtb -W no-unit_address_vs_reg -o $${dts%.dts}.dtbo $${dts}; \
	done
endef

define BBQX0KBD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/src/source/mod_src/bbqX0kbd.map $(TARGET_DIR)/usr/share/keymaps/;
	$(INSTALL) -D -m 0755 $(@D)/S01bbqX0kbd $(TARGET_DIR)/etc/init.d/;
endef

define BBQX0KBD_INSTALL_IMAGES_CMDS
	for dtbo in $(@D)/*.dtbo; do \
		$(INSTALL) -D -m 0644 $${dtbo} $(BINARIES_DIR)/rpi-firmware/overlays; \
	done
endef

$(eval $(kernel-module))
$(eval $(generic-package))
