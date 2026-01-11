# Add set(CONFIG_USE_middleware_metering_meterfft true) in config.cmake to use this component

include_guard(GLOBAL)
message("${CMAKE_CURRENT_LIST_FILE} component is included.")

      target_include_directories(${MCUX_SDK_PROJECT_NAME} PUBLIC
          ${CMAKE_CURRENT_LIST_DIR}/meterlibFFT/inc
          ${CMAKE_CURRENT_LIST_DIR}/meterlibFFT/inc/metering
          ${CMAKE_CURRENT_LIST_DIR}/meterlibFFT/inc/math
          ${CMAKE_CURRENT_LIST_DIR}/meterlibFFT/inc/FFT
        )

  
      if(CONFIG_TOOLCHAIN STREQUAL mdk AND CONFIG_CORE STREQUAL cm0p)
    target_link_libraries(${MCUX_SDK_PROJECT_NAME} PRIVATE
    -Wl,--start-group
          ${CMAKE_CURRENT_LIST_DIR}/meterlibFFT/meterlibFFT_cm0p_mmau_armcc.lib
        -Wl,--end-group
    )
    endif()

        if((CONFIG_TOOLCHAIN STREQUAL armgcc OR CONFIG_TOOLCHAIN STREQUAL mcux) AND CONFIG_CORE STREQUAL cm0p)
    target_link_libraries(${MCUX_SDK_PROJECT_NAME} PRIVATE
    -Wl,--start-group
          ${CMAKE_CURRENT_LIST_DIR}/meterlibFFT/libmeterFFT_cm0p_mmau_gcc.a
        -Wl,--end-group
    )
    endif()

        if(CONFIG_TOOLCHAIN STREQUAL iar AND CONFIG_CORE STREQUAL cm0p)
    target_link_libraries(${MCUX_SDK_PROJECT_NAME} PRIVATE
    -Wl,--start-group
          ${CMAKE_CURRENT_LIST_DIR}/meterlibFFT/meterlibFFT_cm0p_mmau_iar.a
        -Wl,--end-group
    )
    endif()

  