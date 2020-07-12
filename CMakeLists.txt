cmake_minimum_required(VERSION 3.15)
project(libp2p C CXX)
enable_language(C ASM)

#[1]set c/c++ standard and compile flags & definitions
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_FLAGS "-std=gnu11 -O0 -g -Wall -Wmissing-prototypes -Wno-unused-result -Wno-unused-function -Wno-unused-variable")
#set gnu compiler c flags
if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        set(CMAKE_C_FLAGS "-std=gnu11 -O0 -g -Wall -Wmissing-prototypes -Wno-unused-result -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable")
endif()

OPTION(DEBUG "Build the project using debugging code" OFF)
OPTION(BUILD_TEST "Build Test Cases" OFF)
OPTION(RUN_TEST "Run Test Cases" OFF)

if(DEBUG)
        MESSAGE("Adding Debug flag...")
        SET(CMAKE_BUILD_TYPE Debug)
        MESSAGE("Build type is " ${CMAKE_BUILD_TYPE})
else()
        add_definitions(-DNDEBUG)
endif(DEBUG)
#[1]end

#[2]download and compile external project start
set(PROTOBUF_LIBRARY ${CMAKE_SOURCE_DIR}/c-protobuf)
include(cmake/c-multiaddr.cmake)
include(cmake/c-multihash.cmake)
include(cmake/c-protobuf.cmake)

#[2]end

#[3]download and compile projects in hunter
find_package(c-multiaddr CONFIG)
if(MULTIADDR_FOUND)
        message("-- Found c-multiaddr: include ${MULTIADDR_INCLUDE_DIR}  libraries ${MULTIADDR_LIBRARY}")
else()
        message(FATAL_ERROR "Failed to find c-multiaddr dependency!")
endif()

find_package(c-multihash CONFIG)
if(MULTIHASH_FOUND)
        message("-- Found c-multihash: include ${MUTIHASH_INCLUDE_DIR}  libraries ${MULTIHASH_FOUND}")
else()
        message(FATAL_ERROR "Failed to find c-multihash dependency!")
endif()

find_package(c-protobuf CONFIG)
if(PROTOBUF_FOUND)
        message("-- Found c-protobuf: include ${PROTOBUF_INCLUDE_DIR}  libraries ${PROTOBUF_LIBRARY}")
else()
        message(FATAL_ERROR "Failed to find c-protobuf dependency!")
endif()
#[3]end

#[4]find original libraries in system start
find_package(Threads QUIET)
if(NOT Threads_FOUND)
        message(FATAL_ERROR "Failed to find pthreads dependency!")
endif()
#[4]end

#[5]include directories of external libraries
include_directories(${MULTIADDR_INCLUDE_DIR})
include_directories(${MULTIHASH_INCLUDE_DIR})
include_directories(${PROTOBUF_INCLUDE_DIR})

include_directories("${PROJECT_SOURCE_DIR}/include")
#[5]end

#[6]add source file start
file(GLOB_RECURSE LIBP2P_SOURCES
        conn/*.c
        crypto/*.c
        db/*.c
        hashmap/*.c
        identify/*.c
        net/*.c
        nodeio/*.c
        os/*.c
        peer/*.c
        record/*.c
        routing/*.c
        secio/*.c
        swarm/*.c
        thirdparty/mbedtls/*.c
        utils/*.c
        yamux/*.c
        )
#[7]ignore sources that we do not intend to include when building the executable...
list(FILTER LIBP2P_SOURCES EXCLUDE REGEX ".main.c$")
list(FILTER LIBP2P_SOURCES EXCLUDE REGEX ".test.c$")
list(FILTER LIBP2P_SOURCES EXCLUDE REGEX ".testing.c$")
list(FILTER LIBP2P_SOURCES EXCLUDE REGEX ".testit.c$")
#[7]end

#[8]compile executable object start
add_executable(libp2p-demo main.c ${LIBP2P_SOURCES})
#add_library(p2p_static STATIC ${LIBP2P_SOURCES})
#add_library(p2p SHARED ${LIBP2P_SOURCES})
#
#set_target_properties(p2p_static PROPERTIES OUTPUT_NAME "p2p")
#set_target_properties(p2p PROPERTIES CLEAN_DIRECT_OUTPUT 1)
#set_target_properties(p2p_static PROPERTIES CLEAN_DIRECT_OUTPUT 1)
#[8]end

#[9]link libraries start
target_link_libraries(
        libp2p-demo
        ${CMAKE_THREAD_LIBS_INIT}
        ${MULTIADDR_LIBRARY}
        ${MULTIHASH_LIBRARY}
        ${PROTOBUF_LIBRARY}
        m # math library
)

#target_link_libraries(
#        p2p_static
#        ${CMAKE_THREAD_LIBS_INIT}
#        ${MULTIADDR_LIBRARY}
#        ${MULTIHASH_LIBRARY}
#        ${PROTOBUF_LIBRARY}
#)
#
#target_link_libraries(
#        p2p
#        ${CMAKE_THREAD_LIBS_INIT}
#        ${MULTIADDR_LIBRARY}
#        ${MULTIHASH_LIBRARY}
#        ${PROTOBUF_LIBRARY}
#)
#[9]end