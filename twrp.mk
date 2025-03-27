LOCAL_PATH := device/samsung/golden

# DEVICE_ENABLE_SELINUX := true
# DEVICE_SDCARD_ON_SWIPE := true
DEVICE_ENABLE_RECOVERY_3 := true
DEVICE_WLAN_ON_NEW := true
DEVICE_UMS_ON_NEW := true

# TWRP
# TW_THEME := portrait_mdpi
DEVICE_RESOLUTION := 480x800
# BOARD_GLOBAL_CFLAGS += -DTW_USE_MINUI_CUSTOM_FONTS
#BOARD_GLOBAL_CFLAGS += -DTW_NO_SCREEN_BLANK
TW_NO_SCREEN_BLANK := true
TW_DISABLE_APK_INSTALL := true
TW_EXCLUDE_PARTED := true
# BOARD_HAS_NO_REAL_SDCARD := true
ifeq ($(DEVICE_ENABLE_RECOVERY_3),true)
TARGET_RECOVERY_PIXEL_FORMAT := "RGB_565"
TARGET_RECOVERY_FORCE_PIXEL_FORMAT := "RGB_565"
RECOVERY_GRAPHICS_FORCE_USE_LINELENGTH := true
# RECOVERY_GRAPHICS_FORCE_SINGLE_BUFFER := true
else
TW_BOARD_CUSTOM_GRAPHICS := ../../../device/samsung/golden/recovery/twrp-graphics.c
endif
TW_INTERNAL_STORAGE_PATH := "/storage/sdcard0"
TW_INTERNAL_STORAGE_MOUNT_POINT := "sdcard0"
TW_EXTERNAL_STORAGE_PATH := "/storage/sdcard1"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "sdcard1"
TW_HAS_NO_RECOVERY_PARTITION := true
TW_FLASH_FROM_STORAGE := true
TW_INCLUDE_FUSE_EXFAT := true
TW_BRIGHTNESS_PATH := /sys/class/backlight/panel/brightness
TW_MAX_BRIGHTNESS := 255
TW_NO_USB_STORAGE := true
TW_NO_REBOOT_BOOTLOADER := true
TW_HAS_DOWNLOAD_MODE := true
RECOVERY_SDCARD_ON_DATA := true
# TW_INCLUDE_CRYPTO := true
HAVE_SELINUX := false

# TW_USE_TOOLBOX := true

ifeq ($(DEVICE_ENABLE_SELINUX),true)
# TWRP flags
# TWHAVE_SELINUX := true
TW_INCLUDE_JB_CRYPTO := true
TW_CRYPTO_FS_TYPE := "ext4"
TW_CRYPTO_REAL_BLKDEV := "/dev/block/mmcblk0p5"
TW_CRYPTO_MNT_POINT := "/data"
TW_CRYPTO_FS_OPTIONS := "noatime,nosuid,nodev,discard,noauto_da_alloc,journal_async_commit,errors=panic wait,check"
TW_CRYPTO_FS_FLAGS := "0x00000406"
TW_CRYPTO_KEY_LOC := "/efs/metadata"
endif

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/device_tunables.rc:root/device_tunables.rc \
    $(LOCAL_PATH)/rootdir/init.kernel.rc:root/init.kernel.rc \
    $(LOCAL_PATH)/rootdir/init.recovery.samsunggolden.rc:root/init.recovery.samsunggolden.rc

ifeq ($(DEVICE_WLAN_ON_NEW),true)
# Init files new
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdirnew/init.samsunggolden.rc:root/init.samsunggolden.rc \
    $(LOCAL_PATH)/rootdirnew/ueventd.samsunggolden.rc:root/ueventd.samsunggolden.rc
else
# Init files old
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/init.samsunggolden.rc:root/init.samsunggolden.rc \
    $(LOCAL_PATH)/rootdir/ueventd.samsunggolden.rc:root/ueventd.samsunggolden.rc
endif

# fstab
ifeq ($(DEVICE_SDCARD_ON_SWIPE),true)
# fstab swipe
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdirnew/fstab.samsunggolden:root/fstab.samsunggolden
else
# fstab codina
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/fstab.samsunggolden:root/fstab.samsunggolden
endif

ifeq ($(DEVICE_UMS_ON_NEW),true)
# UMS config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdirnew/init.samsunggolden.usb.rc:root/init.samsunggolden.usb.rc \
    $(LOCAL_PATH)/rootdirnew/ums_init.sh:system/bin/ums_init.sh
else
# Old config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/init.samsunggolden.usb.rc:root/init.samsunggolden.usb.rc
endif

# TWRP
PRODUCT_COPY_FILES += $(LOCAL_PATH)/recovery/twrp.fstab:recovery/root/etc/twrp.fstab
