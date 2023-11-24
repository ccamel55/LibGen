cmake_minimum_required(VERSION 3.23)

project(LibGen)

set(CMAKE_CXX_STANDARD 20)

# include the main cmake file, this is where most of the magic happens
include(cmake/lib_gen.cmake)

# include the library we want to generate a minimal library for
add_subdirectory(library)

add_library(${PROJECT_NAME} STATIC LibGenProxy.cpp)

target_include_directories(${PROJECT_NAME} PUBLIC
        include
)

target_link_libraries(${PROJECT_NAME} PUBLIC
        custom_lib
)

# route compiler output to a temporary file
lib_gen_configure_output(${PROJECT_NAME})
