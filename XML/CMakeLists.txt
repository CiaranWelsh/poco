set(LIBNAME "PocoXML")

aux_source_directory(src SRCS)

add_definitions(-D_USRDLL -DXML_NS -DXML_DTD -DHAVE_EXPAT_CONFIG_H -DXML_EXPORTS)

add_library( ${LIBNAME} ${LIB_MODE} ${SRCS} )
set_target_properties( ${LIBNAME} 
	PROPERTIES 
	VERSION ${SHARED_LIBRARY_VERSION} SOVERSION ${SHARED_LIBRARY_VERSION} )
target_link_libraries( ${LIBNAME} PUBLIC PocoFoundation)
if (${LIB_MODE} STREQUAL "STATIC")
    add_compile_definitions(${LIBNAME} PUBLIC XML_STATIC)
endif()
#target_compile_definitions(${LIBNAME} PUBLIC _USRDLL XML_NS XML_DTD HAVE_EXPAT_CONFIG_H XML_EXPORTS)
#target_compile_definitions(${LIBNAME} PUBLIC XML_NS XML_DTD HAVE_EXPAT_CONFIG_H)
#install(
#    DIRECTORY include/Poco
#    DESTINATION include
#    PATTERN ".svn" EXCLUDE
#    )
#
#install(
#    TARGETS ${LIBNAME}
#    LIBRARY DESTINATION lib${LIB_SUFFIX}
#    ARCHIVE DESTINATION lib${LIB_SUFFIX}
#    RUNTIME DESTINATION bin
#    )


install(TARGETS ${LIBNAME}
        EXPORT ${LIBNAME}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${LIBNAME}
        )

# install the export info
install(
        EXPORT ${LIBNAME}
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake
        NAMESPACE ${LIBNAME}::
        FILE ${LIBNAME}Config.cmake
)

#install public headers
install(DIRECTORY include/Poco DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})


if (ENABLE_TESTS)
  add_subdirectory(samples)
  add_subdirectory(testsuite)
endif ()

