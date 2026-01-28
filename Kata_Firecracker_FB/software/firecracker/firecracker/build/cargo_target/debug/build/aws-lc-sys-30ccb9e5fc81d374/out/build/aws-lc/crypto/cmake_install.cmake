# Install script for directory: /home/ubuntu/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/aws-lc-sys-0.29.0/aws-lc/crypto

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/ubuntu/fivos_workdir/firecracker/firecracker/build/cargo_target/debug/build/aws-lc-sys-30ccb9e5fc81d374/out")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/ubuntu/fivos_workdir/firecracker/firecracker/build/cargo_target/debug/build/aws-lc-sys-30ccb9e5fc81d374/out/build/artifacts/libaws_lc_0_29_0_crypto.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Development" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/crypto/cmake" TYPE FILE FILES "/home/ubuntu/fivos_workdir/firecracker/firecracker/build/cargo_target/debug/build/aws-lc-sys-30ccb9e5fc81d374/out/build/aws-lc/crypto/crypto-config.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Development" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/crypto/cmake/static/crypto-targets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/crypto/cmake/static/crypto-targets.cmake"
         "/home/ubuntu/fivos_workdir/firecracker/firecracker/build/cargo_target/debug/build/aws-lc-sys-30ccb9e5fc81d374/out/build/aws-lc/crypto/CMakeFiles/Export/b7a05eb6ae5ecdee26676a84881cbc5e/crypto-targets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/crypto/cmake/static/crypto-targets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/crypto/cmake/static/crypto-targets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/crypto/cmake/static" TYPE FILE FILES "/home/ubuntu/fivos_workdir/firecracker/firecracker/build/cargo_target/debug/build/aws-lc-sys-30ccb9e5fc81d374/out/build/aws-lc/crypto/CMakeFiles/Export/b7a05eb6ae5ecdee26676a84881cbc5e/crypto-targets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/crypto/cmake/static" TYPE FILE FILES "/home/ubuntu/fivos_workdir/firecracker/firecracker/build/cargo_target/debug/build/aws-lc-sys-30ccb9e5fc81d374/out/build/aws-lc/crypto/CMakeFiles/Export/b7a05eb6ae5ecdee26676a84881cbc5e/crypto-targets-debug.cmake")
  endif()
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/ubuntu/fivos_workdir/firecracker/firecracker/build/cargo_target/debug/build/aws-lc-sys-30ccb9e5fc81d374/out/build/aws-lc/crypto/fipsmodule/cmake_install.cmake")

endif()

