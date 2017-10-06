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

set ( ${PROJECT_NAME}_INSTALLER_FEATURE_LEVEL "1" CACHE STRING "MSI Feature 'Level' for 'icedtea_web' component" )
set ( ${PROJECT_NAME}_INSTALLER_FEATURE_TITLE "Web Start" CACHE STRING "MSI Feature title for 'icedtea_web' component" )
# set ( ${PROJECT_NAME}_ITW_JAVA_HOME ${openjdk_TOOLS}/bootjdk8 CACHE STRING "Path to jdk to use for building IcedTea-Web" )
set ( ${PROJECT_NAME}_ITW_JAVA_HOME ${CMAKE_CURRENT_BINARY_DIR}/../${openjdk_IMAGE} CACHE STRING "Path to jdk to use for building IcedTea-Web" )

add_subdirectory ( ${OJDKBUILD_DIR}/deps/tagsoup ${CMAKE_CURRENT_BINARY_DIR}/itw_tagsoup )
add_subdirectory ( ${OJDKBUILD_DIR}/deps/rhino ${CMAKE_CURRENT_BINARY_DIR}/itw_rhino )
add_subdirectory ( ${CMAKE_CURRENT_LIST_DIR}/resources/itw_netx_cmake ${CMAKE_CURRENT_BINARY_DIR}/itw_netx )
add_subdirectory ( ${OJDKBUILD_DIR}/contrib/itw-launcher ${CMAKE_CURRENT_BINARY_DIR}/itw_launcher )

add_custom_target ( ${PROJECT_NAME}
        COMMAND ${CMAKE_COMMAND} -E remove javaws.jar
        COMMAND ${CMAKE_COMMAND} -E remove_directory lib
        COMMAND ${CMAKE_COMMAND} -E make_directory lib
        COMMAND ${openjdk_TOOLS}/zip/unzip.exe -o -d lib ${CMAKE_CURRENT_BINARY_DIR}/itw_rhino/js.jar
        COMMAND ${openjdk_TOOLS}/zip/unzip.exe -o -d lib ${CMAKE_CURRENT_BINARY_DIR}/itw_tagsoup/tagsoup.jar
        COMMAND ${openjdk_TOOLS}/zip/unzip.exe -o -d lib ${CMAKE_CURRENT_BINARY_DIR}/itw_netx/netx.jar
        COMMAND ${${PROJECT_NAME}_ITW_JAVA_HOME}/bin/jar -cvf javaws.jar -C lib .
        COMMAND ${CMAKE_COMMAND} -E remove_directory dist
        COMMAND ${CMAKE_COMMAND} -E make_directory dist
        COMMAND ${CMAKE_COMMAND} -E copy javaws.jar dist
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/javaws.exe dist
        COMMAND ${CMAKE_COMMAND} -E copy ${OJDKBUILD_DIR}/lookaside/icedtea-web/netx/javaws_splash.png dist
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Creating ${PROJECT_NAME} distribution, path: [${CMAKE_CURRENT_BINARY_DIR}/dist] ..." )
add_dependencies ( itw_netx image itw_tagsoup itw_rhino )
add_dependencies ( ${PROJECT_NAME} itw_netx javaws )

# installer
configure_file ( ${CMAKE_CURRENT_LIST_DIR}/resources/installer.xsl
        ${CMAKE_CURRENT_BINARY_DIR}/installer.xsl )