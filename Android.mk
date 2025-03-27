ifeq ($(TARGET_DEVICE),golden)
    LOCAL_PATH := $(call my-dir)
    include $(call first-makefiles-under,$(LOCAL_PATH))
endif
