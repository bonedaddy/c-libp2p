find_path(MULTIADDR_ROOT_DIR
        NAMES multiaddr/multiaddr.h
        PATHS c-multiaddr/include
        NO_DEFAULT_PATH
        )
message("MULTIADDR_ROOT_DIR = ${MULTIADDR_ROOT_DIR}")

find_path(MULTIADDR_DIR
        NAMES multiaddr/multiaddr.h
        PATHS c-multiaddr/include
        NO_DEFAULT_PATH
        )
message("MULTIADDR_DIR = ${MULTIADDR_DIR}")

find_path(MULTIADDR_INCLUDE_DIR
        NAMES multiaddr/multiaddr.h
        PATHS c-multiaddr/include
        NO_DEFAULT_PATH
        )
message("MULTIADDR_INCLUDE_DIR = ${MULTIADDR_INCLUDE_DIR}")

find_library(MULTIADDR_LIBRARY
        NAMES libmultiaddr.a
        PATHS c-multiaddr
        NO_DEFAULT_PATH
        )
message("MULTIADDR_LIBRARY = ${MULTIADDR_LIBRARY}")

if(MULTIADDR_INCLUDE_DIR AND MULTIADDR_LIBRARY)
    set(MULTIADDR_FOUND TRUE)
else()
    set(MULTIADDR_FOUND FALSE)
endif()
message("MULTIADDR_FOUND = ${MULTIADDR_FOUND}")

mark_as_advanced(
        MULTIADDR_ROOT_DIR
        MULTIADDR_INCLUDE_DIR
        MULTIADDR_LIBRARY
)

set(CMAKE_REQUIRED_INCLUDES ${MULTIADDR_INCLUDE_DIR})
set(CMAKE_REQUIRED_LIBRARIES ${MULTIADDR_LIBRARY})

