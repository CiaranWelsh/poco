if(WIN32)
    # cmake has CMAKE_RC_COMPILER, but no message compiler
    if("${CMAKE_GENERATOR}" MATCHES "Visual Studio")
        # this path is only present for 2008+, but we currently require PATH to
        # be set up anyway
        get_filename_component(sdk_dir "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Microsoft SDKs\\Windows;CurrentInstallFolder]" REALPATH)
        get_filename_component(kit_dir "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows Kits\\Installed Roots;KitsRoot]" REALPATH)
        get_filename_component(kit81_dir "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows Kits\\Installed Roots;KitsRoot81]" REALPATH)
        get_filename_component(kit10_dir "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows Kits\\Installed Roots;KitsRoot10]" REALPATH)
        get_filename_component(kit10wow_dir "[HKEY_LOCAL_MACHINE\\SOFTWARE\\WOW6432Node\\Microsoft\\Windows Kits\\Installed Roots;KitsRoot10]" REALPATH)
        file(GLOB kit10_list ${kit10_dir}/bin/10.* ${kit10wow_dir}/bin/10.*)
        if(X64)
            set(sdk_bindir "${sdk_dir}/bin/x64")
            set(kit_bindir "${kit_dir}/bin/x64")
            set(kit81_bindir "${kit81_dir}/bin/x64")
            foreach(tmp_elem ${kit10_list})
                if(IS_DIRECTORY ${tmp_elem})
                    list(APPEND kit10_bindir "${tmp_elem}/x64")
                endif()
            endforeach()
        else(X64)
            set(sdk_bindir "${sdk_dir}/bin")
            set(kit_bindir "${kit_dir}/bin/x86")
            set(kit81_bindir "${kit81_dir}/bin/x86")
            foreach(tmp_elem ${kit10_list})
                if(IS_DIRECTORY ${tmp_elem})
                    list(APPEND kit10_bindir "${tmp_elem}/x86")
                endif()
            endforeach()
        endif(X64)
    endif()
    find_program(CMAKE_MC_COMPILER mc.exe HINTS "${sdk_bindir}" "${kit_bindir}" "${kit81_bindir}" ${kit10_bindir}
            DOC "path to message compiler")
    if(NOT CMAKE_MC_COMPILER)
        message(FATAL_ERROR "message compiler not found: required to build")
    endif(NOT CMAKE_MC_COMPILER)
    message(STATUS "Found message compiler: ${CMAKE_MC_COMPILER}")
    mark_as_advanced(CMAKE_MC_COMPILER)
endif(WIN32)
