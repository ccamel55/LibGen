# setup launcher to output std::err logs to a specific file for a defined target
macro(lib_gen_configure_output target)

    set(lib_gen_output_file "${lib_gen_output_dir}/compiler-output-${lib_gen_project_name}.txt")
    set(lib_gen_output_include_folder "${lib_gen_output_dir}/minimal_include-${lib_gen_project_name}")

    # make sure that the output file exits
    file(WRITE ${lib_gen_output_file} "")

    message(STATUS "=======================================================================================================")

    # the -H flag will cause the compiler to output used header files
    target_compile_options(${target} PRIVATE -H)

    if (WIN32)

        # on windows, we need to invoke the compiler from command prompt in order to use the redirect symbol
        # at the start of a command, powershell requires the redirect symbol to be at the end which is not as
        # easy to append. We also keep stdout rather than stderr
        set_property(TARGET ${target} PROPERTY CXX_COMPILER_LAUNCHER cmd.exe /c 1> ${lib_gen_output_file})
        message(STATUS "Host device: ${CMAKE_HOST_SYSTEM}, using cmd.exe to run compiler.")

    else ()

        # on nix based OS, we can use redirect at start of command in bash, used headers are also outputted to stderr
        set_property(TARGET ${target} PROPERTY CXX_COMPILER_LAUNCHER 2> ${lib_gen_output_file})
        message(STATUS "Host device: ${CMAKE_HOST_SYSTEM}, using bash to run compiler.")

    endif ()

    message(STATUS "Redirected output to: ${lib_gen_output_file}.")

    # setup a custom target to run the gather_includes.cmake script on a successful build
    add_custom_command(TARGET ${target}
            POST_BUILD
            COMMAND ${CMAKE_COMMAND}

            # explicitly pass environment variables into the script file as the script isn't executed
            # in the same environment as the cmake project
            -Dlib_gen_output_file=${lib_gen_output_file}
            -Dlib_gen_project_path=${lib_gen_project_path}
            -Dlib_gen_project_name=${lib_gen_project_name}
            -Dlib_gen_output_include_folder=${lib_gen_output_include_folder}

            # define script file to call
            -P ${lib_gen_module_path}/scripts/gather_includes.cmake
            -P ${lib_gen_module_path}/scripts/gather_libraries.cmake
    )

endmacro()