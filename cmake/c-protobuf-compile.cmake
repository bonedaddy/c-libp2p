macro(define_c_protobuf)
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
endmacro()