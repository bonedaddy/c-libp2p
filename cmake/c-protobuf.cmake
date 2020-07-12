set(PROTOBUF_LIBRARY ${CMAKE_SOURCE_DIR}/c-protobuf)

add_library(libvarint
    ${CMAKE_SOURCE_DIR}/c-protobuf/varint.h
    ${CMAKE_SOURCE_DIR}/c-protobuf/varint.c
)
target_compile_options(libvarint PRIVATE ${CMAKE_C_FLAGS})
add_library(libprotobuf
    SHARED
        ${CMAKE_SOURCE_DIR}/c-protobuf/protobuf.h
        ${CMAKE_SOURCE_DIR}/c-protobuf/protobuf.c
)
target_link_libraries(libprotobuf libvarint)
target_compile_options(libprotobuf PRIVATE ${CMAKE_C_FLAGS})

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

set(PROTOBUF_LIBRARY ${CMAKE_SOURCE_DIR}/c-protobuf/libprotobuf.a)
set(PROTOBUF_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/c-protobuf)

