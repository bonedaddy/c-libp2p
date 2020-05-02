cmake_minimum_required(VERSION 3.10)
project(libp2p C CXX)
enable_language(C ASM)

#[1]set c/c++ standard and compile flags & definitions
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_FLAGS "-O0 -g -Wall -Wmissing-prototypes -Wno-unused-result -Wno-unused-function -Wno-unused-variable")
#set gnu compiler c flags
if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        set(CMAKE_C_FLAGS "-O0 -g -Wall -Wmissing-prototypes -Wno-unused-result -Wno-unused-function -Wno-unused-variable -Wno-unused-but-set-variable")
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
include(cmake/multiaddr.cmake)
include(cmake/multihash.cmake)
include(cmake/protobuf.cmake)
#[2]end

#[3]download and compile projects in hunter
find_package(MULTIADDR QUIET)
#if(MULTIADDR_FOUND)
#        message("-- Found multiaddr: include ${MULTIADDR_INCLUDE_DIR}  libraries ${MULTIADDR_LIBRARY}")
#else()
#        message(FATAL_ERROR "Failed to find MULTIADDR dependency!")
#endif()

find_package(MUTIHASH QUIET)
#if(MUTIHASH_FOUND)
#        message("-- Found multihash: include ${MUTIHASH_INCLUDE_DIR}  libraries ${MUTIHASH_LIBRARY}")
#else()
#        message(FATAL_ERROR "Failed to find MUTIHASH dependency!")
#endif()

find_package(PROTOBUF QUIET)
if(PROTOBUF_FOUND)
        message("-- Found protobuf: include ${PROTOBUF_INCLUDE_DIR}  libraries ${PROTOBUF_LIBRARY}")
else()
        message(FATAL_ERROR "Failed to find PROTOBUF dependency!")
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
include_directories(${MUTIHASH_INCLUDE_DIR})
include_directories(${PROTOBUF_INCLUDE_DIR})
#[5]end

#[6]add source file start
file(GLOB_RECURSE LIBP2P_HEADERS
        include/libp2p/conn/*.h
        include/libp2p/crypto/*.h
        include/libp2p/db/*.h
        include/libp2p/hashmap/*.h
        include/libp2p/identify/*.h
        include/libp2p/net/*.h
        include/libp2p/nodeio/*.h
        include/libp2p/os/*.h
        include/libp2p/peer/*.h
        include/libp2p/record/*.h
        include/libp2p/routing/*.h
        include/libp2p/secio/*.h
        include/libp2p/swarm/*.h
        include/libp2p/utils/*.h
        include/libp2p/yamux/*.h
        )

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
#[6]end

#[7]ignore sources that we do not intend to include when building the executable...
list(FILTER LIBP2P_SOURCES EXCLUDE REGEX ".*.txt$")
#[7]end

#[8]compile executable object start
add_library(libp2p SHARED ${LIBP2P_SOURCES})
#[8]end

#[9]link libraries start
target_include_directories(
        ${PROJECT_NAME}
        PUBLIC
        ${MULTIADDR_INCLUDE_DIR}
        ${MUTIHASH_INCLUDE_DIR}
        ${PROTOBUF_INCLUDE_DIR}
)
target_link_libraries(
        ${PROJECT_NAME}
        PUBLIC
        ${CMAKE_THREAD_LIBS_INIT}
        ${MULTIADDR_LIBRARY}
        ${MUTIHASH_LIBRARY}
        ${PROTOBUF_LIBRARY}
        m
        dl
)
#[9]end