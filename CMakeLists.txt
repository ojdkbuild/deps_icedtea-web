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

set ( ${PROJECT_NAME}_SRCDIR ${CMAKE_CURRENT_LIST_DIR}/../lookaside_icedtea-web )
file ( GLOB_RECURSE ${PROJECT_NAME}_JAVASRC ${${PROJECT_NAME}_SRCDIR}/netx/*.java )

set ( ${PROJECT_NAME}_JAVASRC_STR "" )
foreach ( _file ${${PROJECT_NAME}_JAVASRC} )
    set ( ${PROJECT_NAME}_JAVASRC_STR "${${PROJECT_NAME}_JAVASRC_STR} ${_file}\n" )
endforeach ( )

configure_file ( 
        ${CMAKE_CURRENT_LIST_DIR}/resources/netx_sources_list.txt
        ${CMAKE_CURRENT_BINARY_DIR}/netx_sources_list.txt )
    
add_custom_target ( ${PROJECT_NAME} ALL
        COMMAND javac -g -encoding utf-8 -source 8 -target 8
                -d ${CMAKE_CURRENT_BINARY_DIR}
                -sourcepath ${${PROJECT_NAME}_SRCDIR}/netx
                -classpath "${CMAKE_CURRENT_LIST_DIR}/../deps_rhino/build/js.jar;${CMAKE_CURRENT_LIST_DIR}/../deps_tagsoup/build/tagsoup.jar"
                @netx_sources_list.txt
        COMMAND ${CMAKE_COMMAND} -E copy_directory
                ${${PROJECT_NAME}_SRCDIR}/netx/net/sourceforge/jnlp/resources/
                net/sourceforge/jnlp/resources/
        COMMAND ${CMAKE_COMMAND} -E copy
                ${${PROJECT_NAME}_SRCDIR}/netx/net/sourceforge/jnlp/runtime/pac-funcs.js
                net/sourceforge/jnlp/runtime/pac-funcs.js
        COMMAND jar cvf netx.jar javax/* net/* sun/*
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Building netx jar ..." )    