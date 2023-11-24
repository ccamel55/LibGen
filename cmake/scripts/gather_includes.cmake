# remove old include files before gathering new ones
if (EXISTS ${lib_gen_output_include_folder})
    file(REMOVE_RECURSE ${lib_gen_output_include_folder})
endif ()

message(STATUS "=======================================================================================================")
message(STATUS "Starting to gather includes, include files read from ${lib_gen_output_file}")

# add each line as its own entry in a list
file(STRINGS ${lib_gen_output_file} lib_gen_used_includes)

# only keep includes that have our project name somewhere in them, discard the rest
list(FILTER lib_gen_used_includes INCLUDE REGEX ".*${lib_gen_project_name}.*.(hpp|h|hh)$")

message(STATUS "Found includes, creating minimal include directory at ${lib_gen_output_include_folder}")

foreach (used_include ${lib_gen_used_includes})

    # remove everything upto the last space character seen
    string(REGEX REPLACE "(.*) " "" used_include "${used_include}")

    # remove everything up to the include folder
    string(REGEX REPLACE "(.*)include" "" used_include_folder_path ${used_include})

    # copy everything into the correct include directory
    configure_file(${used_include} ${lib_gen_output_include_folder}/${used_include_folder_path} COPYONLY)

endforeach ()

message(STATUS "Finished gathering includes")