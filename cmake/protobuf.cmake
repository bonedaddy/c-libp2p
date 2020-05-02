find_path(PROTOBUF_ROOT_DIR
        NAMES protobuf.h
        PATHS ../c-protobuf
        NO_DEFAULT_PATH
        )

find_path(PROTOBUF_DIR
        NAMES protobuf.h
        PATHS ../c-protobuf
        NO_DEFAULT_PATH
        )

find_path(PROTOBUF_INCLUDE_DIR
        NAMES protobuf.h
        PATHS ${PROTOBUF_ROOT_DIR}
        NO_DEFAULT_PATH
        )

find_library(PROTOBUF_LIBRARY
        NAMES PROTOBUF
        PATHS ${PROTOBUF_ROOT_DIR}
        NO_DEFAULT_PATH
        )

if(PROTOBUF_INCLUDE_DIR AND PROTOBUF_LIBRARY)
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