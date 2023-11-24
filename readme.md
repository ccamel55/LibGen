# Lib Gen

This is an example of how you might extract needed includes only from a larger subset of
includes using CMake and your compiler only. This is useful when you want to only ship essential includes with a library or 
want to pass a smaller set of includes to a bind generator. 

Note: This does not remove unused functions and objects from the binary, it only provides
you with a list of includes defined under an umbrella header file. 

## Why?

From looking online, there are no CMake only solutions, tools such as `include-what-you-use`
could be configured to do what this project does and is more elegant, but using it requires you to
install additional dependencies.

## Requirements

- `CMake 3.23` or higher
- Project is built using `Clang` (including windows Clang) or `GCC` 
- include directories are located in the `include` directory

## Usage


## How it works