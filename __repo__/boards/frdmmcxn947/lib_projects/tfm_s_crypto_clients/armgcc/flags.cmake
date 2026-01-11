IF(NOT DEFINED FPU)  
    SET(FPU "-mfloat-abi=hard -mfpu=fpv5-sp-d16")  
ENDIF()  

IF(NOT DEFINED SPECS)  
    SET(SPECS "--specs=nano.specs")  
ENDIF()  

IF(NOT DEFINED DEBUG_CONSOLE_CONFIG)  
    SET(DEBUG_CONSOLE_CONFIG "-DSDK_DEBUGCONSOLE=1")  
ENDIF()  

SET(CMAKE_ASM_FLAGS_DEBUG " \
    ${CMAKE_ASM_FLAGS_DEBUG} \
    -include ${ProjDirPath}/../mcux_config.h \
    -D__STARTUP_CLEAR_BSS \
    -DCPU_MCXN947VDF_cm33_core0 \
    -DMCXN947_cm33_core0_SERIES \
    -mthumb \
    -mcpu=cortex-m33 \
    ${FPU} \
")
SET(CMAKE_ASM_FLAGS_RELEASE " \
    ${CMAKE_ASM_FLAGS_RELEASE} \
    -include ${ProjDirPath}/../mcux_config.h \
    -D__STARTUP_CLEAR_BSS \
    -DCPU_MCXN947VDF_cm33_core0 \
    -DMCXN947_cm33_core0_SERIES \
    -mthumb \
    -mcpu=cortex-m33 \
    ${FPU} \
")
SET(CMAKE_C_FLAGS_DEBUG " \
    ${CMAKE_C_FLAGS_DEBUG} \
    -include ${ProjDirPath}/../mcux_config.h \
    -DNDEBUG \
    -D__STARTUP_CLEAR_BSS \
    -DTFM_SPM_LOG_LEVEL=TFM_SPM_LOG_LEVEL_INFO \
    -DTFM_SP_LOG_RAW_ENABLED \
    -DTFM_PARTITION_LOG_LEVEL=TFM_PARTITION_LOG_LEVEL_INFO \
    -DDAUTH_CHIP_DEFAULT \
    -D__SEMIHOST_HARDFAULT_DISABLE \
    -DENABLE_HEAP \
    -DPLATFORM_DEFAULT_NV_COUNTERS \
    -DCPU_MCXN947VDF_cm33_core0 \
    -DMCXN947_cm33_core0_SERIES \
    -DTFM_PARTITION_INITIAL_ATTESTATION \
    -DT_COSE_USE_PSA_CRYPTO \
    -DATTEST_KEY_BITS=256 \
    -DT_COSE_DISABLE_MAC0 \
    -DT_COSE_DISABLE_ES384 \
    -DT_COSE_DISABLE_ES512 \
    -DQCBOR_DISABLE_FLOAT_HW_USE \
    -DUSEFULBUF_DISABLE_ALL_FLOAT \
    -DQCBOR_DISABLE_PREFERRED_FLOAT \
    -DTFM_PARTITION_PROTECTED_STORAGE \
    -DTFM_PARTITION_INTERNAL_TRUSTED_STORAGE \
    -DPLATFORM_DEFAULT_CRYPTO_KEYS \
    -DMBEDTLS_PSA_CRYPTO_DRIVERS \
    -DPS_ENCRYPTION \
    -DPS_ROLLBACK_PROTECTION \
    -DPS_CRYPTO_AEAD_ALG=PSA_ALG_CCM \
    -Os \
    -mcmse \
    -Wno-unused-variable \
    -Wno-unused-value \
    -Wno-unused-function \
    -Wno-unused-but-set-variable \
    -Wno-return-type \
    -Wno-bool-operation \
    -Wno-maybe-uninitialized \
    -Wno-format \
    -Wall \
    -fno-common \
    -ffunction-sections \
    -fdata-sections \
    -fno-builtin \
    -mthumb \
    -mapcs \
    -std=gnu99 \
    -mcpu=cortex-m33 \
    ${FPU} \
    ${DEBUG_CONSOLE_CONFIG} \
")
SET(CMAKE_C_FLAGS_RELEASE " \
    ${CMAKE_C_FLAGS_RELEASE} \
    -include ${ProjDirPath}/../mcux_config.h \
    -DNDEBUG \
    -D__STARTUP_CLEAR_BSS \
    -DTFM_SPM_LOG_LEVEL=TFM_SPM_LOG_LEVEL_INFO \
    -DTFM_SP_LOG_RAW_ENABLED \
    -DTFM_PARTITION_LOG_LEVEL=TFM_PARTITION_LOG_LEVEL_INFO \
    -DDAUTH_CHIP_DEFAULT \
    -D__SEMIHOST_HARDFAULT_DISABLE \
    -DENABLE_HEAP \
    -DPLATFORM_DEFAULT_NV_COUNTERS \
    -DCPU_MCXN947VDF_cm33_core0 \
    -DMCXN947_cm33_core0_SERIES \
    -DTFM_PARTITION_INITIAL_ATTESTATION \
    -DT_COSE_USE_PSA_CRYPTO \
    -DATTEST_KEY_BITS=256 \
    -DT_COSE_DISABLE_MAC0 \
    -DT_COSE_DISABLE_ES384 \
    -DT_COSE_DISABLE_ES512 \
    -DQCBOR_DISABLE_FLOAT_HW_USE \
    -DUSEFULBUF_DISABLE_ALL_FLOAT \
    -DQCBOR_DISABLE_PREFERRED_FLOAT \
    -DTFM_PARTITION_PROTECTED_STORAGE \
    -DTFM_PARTITION_INTERNAL_TRUSTED_STORAGE \
    -DPLATFORM_DEFAULT_CRYPTO_KEYS \
    -DMBEDTLS_PSA_CRYPTO_DRIVERS \
    -DPS_ENCRYPTION \
    -DPS_ROLLBACK_PROTECTION \
    -DPS_CRYPTO_AEAD_ALG=PSA_ALG_CCM \
    -mcmse \
    -Wno-unused-variable \
    -Wno-unused-value \
    -Wno-unused-function \
    -Wno-unused-but-set-variable \
    -Wno-return-type \
    -Wno-bool-operation \
    -Wno-maybe-uninitialized \
    -Wno-format \
    -Wall \
    -fno-common \
    -ffunction-sections \
    -fdata-sections \
    -fno-builtin \
    -mthumb \
    -mapcs \
    -std=gnu99 \
    -mcpu=cortex-m33 \
    ${FPU} \
    ${DEBUG_CONSOLE_CONFIG} \
")
SET(CMAKE_CXX_FLAGS_DEBUG " \
    ${CMAKE_CXX_FLAGS_DEBUG} \
    -include ${ProjDirPath}/../mcux_config.h \
    -DDEBUG \
    -DCPU_MCXN947VDF_cm33_core0 \
    -DMCXN947_cm33_core0_SERIES \
    -Os \
    -mcmse \
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
    -DCPU_MCXN947VDF_cm33_core0 \
    -DMCXN947_cm33_core0_SERIES \
    -mcmse \
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
