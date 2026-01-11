IF(NOT DEFINED FPU)  
    SET(FPU "-mfloat-abi=hard -mfpu=fpv5-sp-d16")  
ENDIF()  

IF(NOT DEFINED SPECS)  
    SET(SPECS "--specs=nano.specs --specs=nosys.specs")  
ENDIF()  

IF(NOT DEFINED DEBUG_CONSOLE_CONFIG)  
    SET(DEBUG_CONSOLE_CONFIG "-DSDK_DEBUGCONSOLE=1")  
ENDIF()  

SET(CMAKE_ASM_FLAGS_DEBUG " \
    ${CMAKE_ASM_FLAGS_DEBUG} \
    -include ${ProjDirPath}/../mcux_config.h \
    -D__STARTUP_CLEAR_BSS \
    -DMCUXPRESSO_SDK \
    -DCPU_MCXN947VDF_cm33_core0 \
    -DMCXN947_cm33_core0_SERIES \
    -g \
    -mthumb \
    -mcpu=cortex-m33 \
    ${FPU} \
")
SET(CMAKE_ASM_FLAGS_RELEASE " \
    ${CMAKE_ASM_FLAGS_RELEASE} \
    -include ${ProjDirPath}/../mcux_config.h \
    -D__STARTUP_CLEAR_BSS \
    -DMCUXPRESSO_SDK \
    -DCPU_MCXN947VDF_cm33_core0 \
    -DMCXN947_cm33_core0_SERIES \
    -mthumb \
    -mcpu=cortex-m33 \
    ${FPU} \
")
SET(CMAKE_C_FLAGS_DEBUG " \
    ${CMAKE_C_FLAGS_DEBUG} \
    -include ${ProjDirPath}/../mcux_config.h \
    -DDEBUG \
    -D__STARTUP_CLEAR_BSS \
    -DOCOTP_NV_COUNTERS_RAM_EMULATION=1 \
    -DPSA_WANT_ALG_GCM \
    -DPSA_WANT_ALG_SHA_1 \
    -DTFM_SPM_LOG_LEVEL=TFM_SPM_LOG_LEVEL_INFO \
    -DTFM_PARTITION_LOG_LEVEL=TFM_PARTITION_LOG_LEVEL_INFO \
    -DTFM_SP_LOG_RAW_ENABLED \
    -DDAUTH_CHIP_DEFAULT \
    -DENABLE_HEAP \
    -DTFM_EL2GO_DATA_IMPORT_REGION \
    -DMCUX_META_BUILD \
    -DMCUXPRESSO_SDK \
    -DCPU_MCXN947VDF_cm33_core0 \
    -DMCXN947_cm33_core0_SERIES \
    -DPSA_CRYPTO_DRIVER_ELS_PKC \
    -DCONFIG_TFM_BUILDING_SPE=1 \
    -DCONFIG_TFM_ENABLE_MEMORY_PROTECT \
    -DTFM_PARTITION_NS_AGENT_TZ \
    -DTFM_PARTITION_IDLE \
    -DPLATFORM_DEFAULT_OTP \
    -DPLATFORM_DEFAULT_PROVISIONING \
    -DOTP_WRITEABLE \
    -DTFM_DUMMY_PROVISIONING \
    -DCONFIG_TFM_PARTITION_META \
    -DCONFIG_TFM_FLOAT_ABI=2 \
    -DCONFIG_TFM_ENABLE_CP10CP11 \
    -DCONFIG_TFM_LAZY_STACKING \
    -DCONFIG_TFM_HALT_ON_CORE_PANIC \
    -DCONFIG_TFM_USE_TRUSTZONE \
    -DATTEST_TOKEN_PROFILE_PSA_IOT_1 \
    -DTEST_NS_ATTESTATION \
    -DTEST_S_ATTESTATION \
    -DPS_ENCRYPTION \
    -DPS_ROLLBACK_PROTECTION \
    -DTFM_PARTITION_INITIAL_ATTESTATION \
    -DTFM_PARTITION_PROTECTED_STORAGE \
    -DCRYPTO_HW_ACCELERATOR \
    -DPLATFORM_DEFAULT_NV_COUNTERS \
    -DTFM_PARTITION_PLATFORM \
    -DTFM_PARTITION_CRYPTO \
    -DPLATFORM_DEFAULT_CRYPTO_KEYS \
    -DMBEDTLS_PSA_CRYPTO_DRIVERS \
    -DPSA_CRYPTO_DRIVER_TFM_BUILTIN_KEY \
    -DPSA_CRYPTO_DRIVER_TFM_BUILTIN_KEY_LOADER \
    -DPS_CRYPTO_AEAD_ALG=PSA_ALG_CCM \
    -DTFM_PARTITION_INTERNAL_TRUSTED_STORAGE \
    -DTFM_LPUART_FEATRUE \
    -DTFM_ISOLATION_LEVEL=2 \
    -DPSA_WANT_ALG_SHA_384 \
    -DPSA_WANT_ALG_SHA_512 \
    -DPSA_WANT_ALG_SHA_512_224 \
    -DPSA_WANT_ALG_SHA_512_256 \
    -g \
    -O0 \
    -mcmse \
    -Wno-unused-but-set-variable \
    -Wno-unused-value \
    -Wall \
    -fno-common \
    -ffunction-sections \
    -fdata-sections \
    -fno-builtin \
    -mthumb \
    -mapcs \
    -std=gnu99 \
    -mcpu=cortex-m33 \
    -fomit-frame-pointer \
    ${FPU} \
    ${DEBUG_CONSOLE_CONFIG} \
")
SET(CMAKE_C_FLAGS_RELEASE " \
    ${CMAKE_C_FLAGS_RELEASE} \
    -include ${ProjDirPath}/../mcux_config.h \
    -DNDEBUG \
    -D__STARTUP_CLEAR_BSS \
    -DOCOTP_NV_COUNTERS_RAM_EMULATION=1 \
    -DPSA_WANT_ALG_GCM \
    -DPSA_WANT_ALG_SHA_1 \
    -DTFM_SPM_LOG_LEVEL=TFM_SPM_LOG_LEVEL_INFO \
    -DTFM_PARTITION_LOG_LEVEL=TFM_PARTITION_LOG_LEVEL_INFO \
    -DTFM_SP_LOG_RAW_ENABLED \
    -DDAUTH_CHIP_DEFAULT \
    -DENABLE_HEAP \
    -DTFM_EL2GO_DATA_IMPORT_REGION \
    -DMCUX_META_BUILD \
    -DMCUXPRESSO_SDK \
    -DCPU_MCXN947VDF_cm33_core0 \
    -DMCXN947_cm33_core0_SERIES \
    -DPSA_CRYPTO_DRIVER_ELS_PKC \
    -DCONFIG_TFM_BUILDING_SPE=1 \
    -DCONFIG_TFM_ENABLE_MEMORY_PROTECT \
    -DTFM_PARTITION_NS_AGENT_TZ \
    -DTFM_PARTITION_IDLE \
    -DPLATFORM_DEFAULT_OTP \
    -DPLATFORM_DEFAULT_PROVISIONING \
    -DOTP_WRITEABLE \
    -DTFM_DUMMY_PROVISIONING \
    -DCONFIG_TFM_PARTITION_META \
    -DCONFIG_TFM_FLOAT_ABI=2 \
    -DCONFIG_TFM_ENABLE_CP10CP11 \
    -DCONFIG_TFM_LAZY_STACKING \
    -DCONFIG_TFM_HALT_ON_CORE_PANIC \
    -DCONFIG_TFM_USE_TRUSTZONE \
    -DATTEST_TOKEN_PROFILE_PSA_IOT_1 \
    -DTEST_NS_ATTESTATION \
    -DTEST_S_ATTESTATION \
    -DPS_ENCRYPTION \
    -DPS_ROLLBACK_PROTECTION \
    -DTFM_PARTITION_INITIAL_ATTESTATION \
    -DTFM_PARTITION_PROTECTED_STORAGE \
    -DCRYPTO_HW_ACCELERATOR \
    -DPLATFORM_DEFAULT_NV_COUNTERS \
    -DTFM_PARTITION_PLATFORM \
    -DTFM_PARTITION_CRYPTO \
    -DPLATFORM_DEFAULT_CRYPTO_KEYS \
    -DMBEDTLS_PSA_CRYPTO_DRIVERS \
    -DPSA_CRYPTO_DRIVER_TFM_BUILTIN_KEY \
    -DPSA_CRYPTO_DRIVER_TFM_BUILTIN_KEY_LOADER \
    -DPS_CRYPTO_AEAD_ALG=PSA_ALG_CCM \
    -DTFM_PARTITION_INTERNAL_TRUSTED_STORAGE \
    -DTFM_LPUART_FEATRUE \
    -DTFM_ISOLATION_LEVEL=2 \
    -DPSA_WANT_ALG_SHA_384 \
    -DPSA_WANT_ALG_SHA_512 \
    -DPSA_WANT_ALG_SHA_512_224 \
    -DPSA_WANT_ALG_SHA_512_256 \
    -Os \
    -mcmse \
    -Wno-unused-but-set-variable \
    -Wno-unused-value \
    -Wall \
    -fno-common \
    -ffunction-sections \
    -fdata-sections \
    -fno-builtin \
    -mthumb \
    -mapcs \
    -std=gnu99 \
    -mcpu=cortex-m33 \
    -fomit-frame-pointer \
    ${FPU} \
    ${DEBUG_CONSOLE_CONFIG} \
")
SET(CMAKE_CXX_FLAGS_DEBUG " \
    ${CMAKE_CXX_FLAGS_DEBUG} \
    -include ${ProjDirPath}/../mcux_config.h \
    -DDEBUG \
    -DMCUX_META_BUILD \
    -DMCUXPRESSO_SDK \
    -DCPU_MCXN947VDF_cm33_core0 \
    -DMCXN947_cm33_core0_SERIES \
    -g \
    -O0 \
    -Wall \
    -fno-common \
    -ffunction-sections \
    -fdata-sections \
    -fno-builtin \
    -mthumb \
    -mapcs \
    -fno-rtti \
    -fno-exceptions \
    -mcpu=cortex-m33 \
    ${FPU} \
    ${DEBUG_CONSOLE_CONFIG} \
")
SET(CMAKE_CXX_FLAGS_RELEASE " \
    ${CMAKE_CXX_FLAGS_RELEASE} \
    -include ${ProjDirPath}/../mcux_config.h \
    -DNDEBUG \
    -DMCUX_META_BUILD \
    -DMCUXPRESSO_SDK \
    -DCPU_MCXN947VDF_cm33_core0 \
    -DMCXN947_cm33_core0_SERIES \
    -Os \
    -Wall \
    -fno-common \
    -ffunction-sections \
    -fdata-sections \
    -fno-builtin \
    -mthumb \
    -mapcs \
    -fno-rtti \
    -fno-exceptions \
    -mcpu=cortex-m33 \
    ${FPU} \
    ${DEBUG_CONSOLE_CONFIG} \
")
SET(CMAKE_EXE_LINKER_FLAGS_DEBUG " \
    ${CMAKE_EXE_LINKER_FLAGS_DEBUG} \
    -g \
    -Wl,--out-implib=${ProjDirPath}/${CMAKE_BUILD_TYPE}/el2go_blob_test_s_cm33_core0_CMSE_lib.o \
    -Wl,--cmse-implib \
    -Xlinker \
    -Map=output.map \
    -Wall \
    -fno-common \
    -ffunction-sections \
    -fdata-sections \
    -fno-builtin \
    -mthumb \
    -mapcs \
    -Wl,--gc-sections \
    -Wl,-static \
    -Wl,--print-memory-usage \
    -mcpu=cortex-m33 \
    ${FPU} \
    ${SPECS} \
    -T\"${SdkRootDirPath}/middleware/tfm/tf-m/platform/ext/target/nxp/common/armgcc/tfm_common_s_pre.ld\" -static \
")
SET(CMAKE_EXE_LINKER_FLAGS_RELEASE " \
    ${CMAKE_EXE_LINKER_FLAGS_RELEASE} \
    -Wl,--out-implib=${ProjDirPath}/${CMAKE_BUILD_TYPE}/el2go_blob_test_s_cm33_core0_CMSE_lib.o \
    -Wl,--cmse-implib \
    -Xlinker \
    -Map=output.map \
    -Wall \
    -fno-common \
    -ffunction-sections \
    -fdata-sections \
    -fno-builtin \
    -mthumb \
    -mapcs \
    -Wl,--gc-sections \
    -Wl,-static \
    -Wl,--print-memory-usage \
    -mcpu=cortex-m33 \
    ${FPU} \
    ${SPECS} \
    -T\"${SdkRootDirPath}/middleware/tfm/tf-m/platform/ext/target/nxp/common/armgcc/tfm_common_s_pre.ld\" -static \
")
