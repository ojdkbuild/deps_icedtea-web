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
project ( itw_netx NONE )
set ( ${PROJECT_NAME}_SRCDIR ${OJDKBUILD_DIR}/lookaside/icedtea-web )
file ( GLOB_RECURSE ${PROJECT_NAME}_JAVASRC_NETX ${${PROJECT_NAME}_SRCDIR}/netx/*.java )
file ( GLOB_RECURSE ${PROJECT_NAME}_JAVASRC_PLUGIN ${${PROJECT_NAME}_SRCDIR}/plugin/icedteanp/java/*.java )
set ( ${PROJECT_NAME}_JAVASRC ${${PROJECT_NAME}_JAVASRC_NETX} ${${PROJECT_NAME}_JAVASRC_PLUGIN} )

set ( ${PROJECT_NAME}_JAVASRC_STR "" )
foreach ( _file ${${PROJECT_NAME}_JAVASRC} )
    set ( ${PROJECT_NAME}_JAVASRC_STR "${${PROJECT_NAME}_JAVASRC_STR} ${_file}\n" )
endforeach ( )

set ( ${PROJECT_NAME}_JAVASRC_PLUGIN_STR "" )
foreach ( _file ${${PROJECT_NAME}_JAVASRC_PLUGIN} )
    set ( ${PROJECT_NAME}_JAVASRC_PLUGIN_STR "${${PROJECT_NAME}_JAVASRC_PLUGIN_STR} ${_file}\n" )
endforeach ( )

configure_file ( 
        ${CMAKE_CURRENT_LIST_DIR}/../netx_sources_list.txt
        ${CMAKE_CURRENT_BINARY_DIR}/netx_sources_list.txt )
configure_file (
        ${CMAKE_CURRENT_LIST_DIR}/../plugin_sources_list.txt
        ${CMAKE_CURRENT_BINARY_DIR}/plugin_sources_list.txt )

add_custom_target ( ${PROJECT_NAME}_build_jdk )
if ( NOT icedtea_web_ENABLE_STANDALONE )
    add_dependencies ( ${PROJECT_NAME}_build_jdk image )
endif ( )

add_custom_command ( OUTPUT netx.jar
        COMMAND ${icedtea_web_ITW_JAVA_HOME}/bin/javac -g -encoding utf-8 -source 8 -target 8
                -d ${CMAKE_CURRENT_BINARY_DIR}
                -sourcepath ${${PROJECT_NAME}_SRCDIR}/netx
                -classpath "${CMAKE_CURRENT_BINARY_DIR}/../itw_rhino/js.jar;${CMAKE_CURRENT_BINARY_DIR}/../itw_tagsoup/tagsoup.jar;${CMAKE_CURRENT_BINARY_DIR}/../itw_mslinks/mslinks.jar"
                @netx_sources_list.txt
        COMMAND (robocopy ${${PROJECT_NAME}_SRCDIR}/netx/net/sourceforge/jnlp/resources/ net/sourceforge/jnlp/resources/ /e /nfl ${openjdk_RBCFLAGS} ) ${openjdk_RBCPOSTFIX}
        COMMAND (robocopy ${${PROJECT_NAME}_SRCDIR}/netx/net/sourceforge/jnlp/runtime/ net/sourceforge/jnlp/runtime/ pac-funcs.js /nfl ${openjdk_RBCFLAGS} ) ${openjdk_RBCPOSTFIX}
        COMMAND (robocopy ${${PROJECT_NAME}_SRCDIR}/netx/net/sourceforge/jnlp// net/sourceforge/jnlp/ build.properties /nfl ${openjdk_RBCFLAGS} ) ${openjdk_RBCPOSTFIX}
        COMMAND ${icedtea_web_ITW_JAVA_HOME}/bin/jar -cf netx.jar javax/* net/* netscape/* sun/*
        DEPENDS ${PROJECT_NAME}_build_jdk itw_tagsoup itw_rhino itw_mslinks
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Building plugin.jar ..." )

add_custom_command ( OUTPUT plugin.jar
        COMMAND ${icedtea_web_ITW_JAVA_HOME}/bin/javac -g -encoding utf-8 -source 8 -target 8
                -d ${CMAKE_CURRENT_BINARY_DIR}
                -sourcepath ${${PROJECT_NAME}_SRCDIR}/plugin/icedteanp/java
                @plugin_sources_list.txt
        COMMAND ${icedtea_web_ITW_JAVA_HOME}/bin/jar -cf plugin.jar netscape/* sun/*
        DEPENDS ${PROJECT_NAME}_build_jdk
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Building plugin.jar ..." )

add_custom_target ( ${PROJECT_NAME} DEPENDS netx.jar plugin.jar )
