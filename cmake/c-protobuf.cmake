find_path(PROTOBUF_ROOT_DIR
        NAMES protobuf.h
        PATHS c-protobuf
        NO_DEFAULT_PATH
        )
message("PROTOBUF_ROOT_DIR = ${PROTOBUF_ROOT_DIR}")

find_path(PROTOBUF_DIR
        NAMES protobuf.h
        PATHS c-protobuf
        NO_DEFAULT_PATH
        )
message("PROTOBUF_DIR = ${PROTOBUF_DIR}")

find_path(PROTOBUF_INCLUDE_DIR
        NAMES protobuf.h
        PATHS c-protobuf
        NO_DEFAULT_PATH
        )
message("PROTOBUF_INCLUDE_DIR = ${PROTOBUF_INCLUDE_DIR}")

find_library(PROTOBUF_LIBRARY
        NAMES libprotobuf.a
        PATHS c-protobuf
        NO_DEFAULT_PATH
        )
message("PROTOBUF_LIBRARY = ${PROTOBUF_LIBRARY}")

if(PROTOBUF_INCLUDE_DIR)
    set(PROTOBUF_FOUND TRUE)
else()
    set(PROTOBUF_FOUND FALSE)
endif()

mark_as_advanced(
        PROTOBUF_ROOT_DIR
        PROTOBUF_INCLUDE_DIR
        PROTOBUF_LIBRARY
)

set(CMAKE_REQUIRED_INCLUDES ${PROTOBUF_INCLUDE_DIR})
set(CMAKE_REQUIRED_LIBRARIES ${PROTOBUF_LIBRARY})