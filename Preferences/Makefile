include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ConfirmWithCena
ConfirmWithCena_FILES = CWCRootListController.m
ConfirmWithCena_INSTALL_PATH = /Library/PreferenceBundles
ConfirmWithCena_FRAMEWORKS = UIKit
ConfirmWithCena_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ConfirmWithCena.plist$(ECHO_END)
