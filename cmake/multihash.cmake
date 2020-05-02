find_path(MULTIHASH_ROOT_DIR
        NAMES mh/multihash.h
        PATHS ../c-multihash/include
        NO_DEFAULT_PATH
        )

find_path(MULTIHASH_DIR
        NAMES mh/multihash.h
        PATHS ../c-multihash/include
        NO_DEFAULT_PATH
        )

find_path(MULTIHASH_INCLUDE_DIR
        NAMES mh/multihash.h
        PATHS ${MULTIADDR_ROOT_DIR}/include
        NO_DEFAULT_PATH
        )

find_library(MULTIHASH_LIBRARY
        NAMES MULTIADDR
        PATHS ${MULTIADDR_ROOT_DIR}
        NO_DEFAULT_PATH
        )

if(MULTIHASH_INCLUDE_DIR AND MULTIHASH_LIBRARY)
    set(MULTIHASH_FOUND TRUE)
else()
    set(MULTIHASH_FOUND FALSE)
endif()

mark_as_advanced(
        MULTIHASH_ROOT_DIR
        MULTIHASH_INCLUDE_DIR
        MULTIHASH_LIBRARY
)

set(CMAKE_REQUIRED_INCLUDES ${MULTIHASH_INCLUDE_DIR})
set(CMAKE_REQUIRED_LIBRARIES ${MULTIHASH_LIBRARY})