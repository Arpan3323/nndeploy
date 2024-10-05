
include(ExternalProject)

if(ENABLE_NNDEPLOY_INFERENCE_ASCEND_CL STREQUAL "OFF")
elseif(ENABLE_NNDEPLOY_INFERENCE_ASCEND_CL STREQUAL "ON")
else()
  include_directories(${ENABLE_NNDEPLOY_INFERENCE_ASCEND_CL}/include)
  include_directories(${ENABLE_NNDEPLOY_INFERENCE_ASCEND_CL}/include/aclnn)

  # include_directories(${ENABLE_NNDEPLOY_INFERENCE_ASCEND_CL}/include/experiment/platform)
  set(LIB_PATH ${ENABLE_NNDEPLOY_INFERENCE_ASCEND_CL}/lib64)
  set(LIBS "ascendcl" "nnopbase" "opapi")

  foreach(LIB ${LIBS})
    set(LIB_NAME ${NNDEPLOY_LIB_PREFIX}${LIB}${NNDEPLOY_LIB_SUFFIX})
    set(FULL_LIB_NAME ${LIB_PATH}/${LIB_NAME})
    set(NNDEPLOY_THIRD_PARTY_LIBRARY ${NNDEPLOY_THIRD_PARTY_LIBRARY} ${FULL_LIB_NAME})
  endforeach()

  file(GLOB_RECURSE INSTALL_LIBS "${LIB_PATH}/*")

  foreach(INSTALL_LIB ${INSTALL_LIBS})
    install(FILES ${INSTALL_LIB} DESTINATION ${NNDEPLOY_INSTALL_LIB_PATH})
  endforeach()

  if(SYSTEM.Windows)
    set(BIN_PATH ${ENABLE_NNDEPLOY_INFERENCE_ASCEND_CL}/bin)
    link_directories(${BIN_PATH})
    file(GLOB_RECURSE INSTALL_BINS "${BIN_PATH}/*.dll")

    foreach(INSTALL_BIN ${INSTALL_BINS})
      install(FILES ${INSTALL_BIN} DESTINATION ${NNDEPLOY_INSTALL_BIN_PATH})
      file(COPY ${INSTALL_BIN} DESTINATION ${EXECUTABLE_OUTPUT_PATH})
    endforeach()
  endif()
endif()