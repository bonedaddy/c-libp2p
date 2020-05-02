find_path(MULTIHASH_ROOT_DIR
        NAMES include/mh/multihash.h
        PATHS c-multihash
        NO_DEFAULT_PATH
        )
message("MULTIHASH_ROOT_DIR = ${MULTIHASH_ROOT_DIR}")

find_path(MULTIHASH_DIR
        NAMES multihash.c
        PATHS c-multihash/src
        NO_DEFAULT_PATH
        )
message("MULTIHASH_DIR = ${MULTIHASH_DIR}")

find_path(MULTIHASH_INCLUDE_DIR
        NAMES mh/multihash.h
        PATHS c-multihash/include
        NO_DEFAULT_PATH
        )
message("MULTIHASH_INCLUDE_DIR = ${MULTIHASH_INCLUDE_DIR}")

find_library(MULTIHASH_LIBRARY
        NAMES libmultihash.a
        PATHS c-multihash
        NO_DEFAULT_PATH
        )
message("MULTIHASH_LIBRARY = ${MULTIHASH_LIBRARY}")

if(MULTIHASH_INCLUDE_DIR AND MULTIHASH_LIBRARY)
    set(MULTIHASH_FOUND TRUE)
else()
    set(MULTIHASH_FOUND FALSE)
endif()
message("MULTIHASH_FOUND = ${MULTIHASH_FOUND}")

mark_as_advanced(
        MULTIHASH_ROOT_DIR
        MULTIHASH_INCLUDE_DIR
        MULTIHASH_LIBRARY
)

set(CMAKE_REQUIRED_INCLUDES ${MULTIHASH_INCLUDE_DIR})
set(CMAKE_REQUIRED_LIBRARIES ${MULTIHASH_LIBRARY})