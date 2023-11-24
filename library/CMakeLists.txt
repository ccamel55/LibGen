# include custom_lib as an example
# we need to specify some options before we can build the library

set(LIB_BACKEND_INPUT none)
set(LIB_BACKEND_RENDER gl3)
set(LIB_BACKEND_WINDOW_CREATION glfw)
set(LIB_COMMON_LOGGER 4)
set(LIB_COMMON_THREADING true)

add_subdirectory(custom_lib)