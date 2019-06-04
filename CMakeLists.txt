# Copyright 2017, akashche at redhat.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

cmake_minimum_required ( VERSION 2.8.12 )

# project
project ( icedtea_web NONE )

set ( ${PROJECT_NAME}_INSTALLER_FEATURE_TITLE "Web Start" CACHE STRING "MSI Feature title for 'webstart' component" )
set ( ${PROJECT_NAME}_INSTALLER_FEATURE_LEVEL "2" CACHE STRING "MSI Feature 'Level' for 'webstart' component" )
set ( ${PROJECT_NAME}_INSTALLER_FEATURE_LEVEL_REGISTRY ${${PROJECT_NAME}_INSTALLER_FEATURE_LEVEL} CACHE STRING "MSI Feature 'Level' for 'webstart_registry' component" )
set ( ${PROJECT_NAME}_INSTALLER_FEATURE_LEVEL_ENV ${${PROJECT_NAME}_INSTALLER_FEATURE_LEVEL} CACHE STRING "MSI Feature 'Level' for 'webstart_env' component" )
set ( ${PROJECT_NAME}_INSTALLER_FEATURE_LEVEL_MIGRATE ${${PROJECT_NAME}_INSTALLER_FEATURE_LEVEL} CACHE STRING "MSI Feature 'Level' for 'webstart_migrate' component" )

option ( ${PROJECT_NAME}_ENABLE_STANDALONE "Build ITW without building JDK" OFF )

add_subdirectory ( ${OJDKBUILD_DIR}/deps/tagsoup ${CMAKE_CURRENT_BINARY_DIR}/itw_tagsoup )
add_subdirectory ( ${OJDKBUILD_DIR}/deps/rhino ${CMAKE_CURRENT_BINARY_DIR}/itw_rhino )
add_subdirectory ( ${OJDKBUILD_DIR}/deps/mslinks ${CMAKE_CURRENT_BINARY_DIR}/itw_mslinks )
add_subdirectory ( ${CMAKE_CURRENT_LIST_DIR}/resources/itw_netx_cmake ${CMAKE_CURRENT_BINARY_DIR}/itw_netx )
add_subdirectory ( ${OJDKBUILD_DIR}/contrib/itw-launcher ${CMAKE_CURRENT_BINARY_DIR}/itw_launcher )

add_custom_target ( ${PROJECT_NAME}
        COMMAND if exist javaws.jar del javaws.jar
        COMMAND if exist lib rd /s /q lib
        COMMAND mkdir lib
        COMMAND ${OJDKBUILD_DIR}/tools/zip/unzip.exe -q -o -d lib ${CMAKE_CURRENT_BINARY_DIR}/itw_rhino/js.jar
        COMMAND ${OJDKBUILD_DIR}/tools/zip/unzip.exe -q -o -d lib ${CMAKE_CURRENT_BINARY_DIR}/itw_tagsoup/tagsoup.jar
        COMMAND ${OJDKBUILD_DIR}/tools/zip/unzip.exe -q -o -d lib ${CMAKE_CURRENT_BINARY_DIR}/itw_mslinks/mslinks.jar
        COMMAND ${OJDKBUILD_DIR}/tools/zip/unzip.exe -q -o -d lib ${CMAKE_CURRENT_BINARY_DIR}/itw_netx/netx.jar
        COMMAND ${${PROJECT_NAME}_ITW_JAVA_HOME}/bin/jar -cf javaws.jar -C lib .
        COMMAND if exist dist rd /s /q dist
        COMMAND mkdir dist
        COMMAND (robocopy ${CMAKE_CURRENT_BINARY_DIR} dist/ javaws.jar ${openjdk_RBCFLAGS} ) ${openjdk_RBCPOSTFIX}
        COMMAND (robocopy ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/ dist/ javaws.exe ${openjdk_RBCFLAGS} ) ${openjdk_RBCPOSTFIX}
        COMMAND (robocopy ${CMAKE_CURRENT_BINARY_DIR}/itw_launcher/ dist/ javaws_options.txt ${openjdk_RBCFLAGS} ) ${openjdk_RBCPOSTFIX}
        COMMAND (robocopy ${OJDKBUILD_DIR}/lookaside/icedtea-web/netx/ dist/ javaws_splash.png ${openjdk_RBCFLAGS} ) ${openjdk_RBCPOSTFIX}
        DEPENDS itw_netx javaws
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Creating ${PROJECT_NAME} distribution, path: [${CMAKE_CURRENT_BINARY_DIR}/dist] ..." )

# installer
configure_file ( ${CMAKE_CURRENT_LIST_DIR}/resources/installer.xsl
        ${CMAKE_CURRENT_BINARY_DIR}/installer.xsl )