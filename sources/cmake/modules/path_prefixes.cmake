# Declare variables for path prefixes for different types of files.
#
# Declare path prefixes for install variant, and for tests.
# Variables for install prefixes are named KEDR_INSTALL_PREFIX_...,
# variables for test prefixes are named KEDR_TEST_PREFIX.

set(KEDR_ALL_PATH_SUFFIXES EXEC READONLY GLOBAL_CONF LIB INCLUDE TEMP_SESSION TEMP STATE CACHE VAR DOC KMODULE KSYMVERS KINCLUDE EXAMPLES)

# See conventions about paths of installed files
# Determine type of installation
string(REGEX MATCH "(^/opt|^/usr|^/$)" IS_GLOBAL_INSTALL ${CMAKE_INSTALL_PREFIX})
if(IS_GLOBAL_INSTALL)
	set(KEDR_INSTALL_TYPE "global")
    set(KEDR_INSTALL_PREFIX_VAR "/var/opt/kedr")
	if(CMAKE_MATCH_1 STREQUAL "/opt")
		message("Global installation into /opt")
		set(KEDR_INSTALL_GLOBAL_IS_OPT "opt")
	else(CMAKE_MATCH_1 STREQUAL "/opt")
	    message("Global installation")
	endif(CMAKE_MATCH_1 STREQUAL "/opt")
else(IS_GLOBAL_INSTALL)
    message("Local installation")
	set(KEDR_INSTALL_TYPE "local")
    set(KEDR_INSTALL_PREFIX_VAR "${CMAKE_INSTALL_PREFIX}/var")
endif(IS_GLOBAL_INSTALL)

# Set prefixes
# 1
set(KEDR_INSTALL_PREFIX_EXEC
		"${CMAKE_INSTALL_PREFIX}/bin")
set(KEDR_INSTALL_PREFIX_EXEC_AUX
		"${CMAKE_INSTALL_PREFIX}/lib/${KEDR_PACKAGE_NAME}")
# 2
set(KEDR_INSTALL_PREFIX_READONLY
		"${CMAKE_INSTALL_PREFIX}/share/${KEDR_PACKAGE_NAME}")
set(KEDR_INSTALL_PREFIX_MANPAGE
		"${CMAKE_INSTALL_PREFIX}/share/man")
# 3
if(KEDR_INSTALL_TYPE STREQUAL "global")
	set(KEDR_INSTALL_PREFIX_GLOBAL_CONF
			"/etc/${KEDR_PACKAGE_NAME}")
else(KEDR_INSTALL_TYPE STREQUAL "global")
	set(KEDR_INSTALL_PREFIX_GLOBAL_CONF
			"${CMAKE_INSTALL_PREFIX}/etc/${KEDR_PACKAGE_NAME}")
endif(KEDR_INSTALL_TYPE STREQUAL "global")
# 4
set(KEDR_INSTALL_PREFIX_LIB
		"${CMAKE_INSTALL_PREFIX}/lib")
set(KEDR_INSTALL_PREFIX_LIB_AUX
		"${CMAKE_INSTALL_PREFIX}/lib/${KEDR_PACKAGE_NAME}")
# 5
set(KEDR_INSTALL_PREFIX_INCLUDE
		"${CMAKE_INSTALL_PREFIX}/include/${KEDR_PACKAGE_NAME}")
# 6
set(KEDR_INSTALL_PREFIX_TEMP_SESSION
			"/tmp/${KEDR_PACKAGE_NAME}")
# 7
if(KEDR_INSTALL_TYPE STREQUAL "global")
	set(KEDR_INSTALL_PREFIX_TEMP
				"/var/tmp/${KEDR_PACKAGE_NAME}")
else(KEDR_INSTALL_TYPE STREQUAL "global")
	set(KEDR_INSTALL_PREFIX_TEMP
				"${CMAKE_INSTALL_PREFIX}/var/tmp/${KEDR_PACKAGE_NAME}")
endif(KEDR_INSTALL_TYPE STREQUAL "global")
# 8
if(KEDR_INSTALL_TYPE STREQUAL "global")
	if(KEDR_INSTALL_GLOBAL_IS_OPT)
		set(KEDR_INSTALL_PREFIX_STATE
			"/var/opt/${KEDR_PACKAGE_NAME}/lib/${KEDR_PACKAGE_NAME}")
	else(KEDR_INSTALL_GLOBAL_IS_OPT)
		set(KEDR_INSTALL_PREFIX_STATE
			"/var/lib/${KEDR_PACKAGE_NAME}")
	endif(KEDR_INSTALL_GLOBAL_IS_OPT)
else(KEDR_INSTALL_TYPE STREQUAL "global")
	set(KEDR_INSTALL_PREFIX_STATE
		"${CMAKE_INSTALL_PREFIX}/var/lib/${KEDR_PACKAGE_NAME}")
endif(KEDR_INSTALL_TYPE STREQUAL "global")
# 9
if(KEDR_INSTALL_TYPE STREQUAL "global")
	if(KEDR_INSTALL_GLOBAL_IS_OPT)
		set(KEDR_INSTALL_PREFIX_CACHE
			"/var/opt/${KEDR_PACKAGE_NAME}/cache/${KEDR_PACKAGE_NAME}")
	else(KEDR_INSTALL_GLOBAL_IS_OPT)
		set(KEDR_INSTALL_PREFIX_CACHE
			"/var/cache/${KEDR_PACKAGE_NAME}")
	endif(KEDR_INSTALL_GLOBAL_IS_OPT)
else(KEDR_INSTALL_TYPE STREQUAL "global")
	set(KEDR_INSTALL_PREFIX_CACHE
		"${CMAKE_INSTALL_PREFIX}/var/cache/${KEDR_PACKAGE_NAME}")
endif(KEDR_INSTALL_TYPE STREQUAL "global")
# 10
if(KEDR_INSTALL_TYPE STREQUAL "global")
	if(KEDR_INSTALL_GLOBAL_IS_OPT)
		set(KEDR_INSTALL_PREFIX_VAR
			"/var/opt/${KEDR_PACKAGE_NAME}")
	else(KEDR_INSTALL_GLOBAL_IS_OPT)
		set(KEDR_INSTALL_PREFIX_VAR
			"/var/opt/${KEDR_PACKAGE_NAME}")
# Another variant
#		set(KEDR_INSTALL_PREFIX_VAR
#			"/var/${KEDR_PACKAGE_NAME}")
	endif(KEDR_INSTALL_GLOBAL_IS_OPT)
else(KEDR_INSTALL_TYPE STREQUAL "global")
	set(KEDR_INSTALL_PREFIX_VAR
		"${CMAKE_INSTALL_PREFIX}/var/${KEDR_PACKAGE_NAME}")
endif(KEDR_INSTALL_TYPE STREQUAL "global")
# 11
set(KEDR_INSTALL_PREFIX_DOC
	"${CMAKE_INSTALL_PREFIX}/share/doc/${KEDR_PACKAGE_NAME}")

# Set derivative prefixes

# additional, 1
set(KEDR_INSTALL_PREFIX_KMODULE "${KEDR_INSTALL_PREFIX_LIB}/modules/${KBUILD_VERSION_STRING}/misc")
# Another variant
#"${KEDR_INSTALL_PREFIX_LIB}/modules/${KBUILD_VERSION_STRING}/extra")
# additional, 2
set(KEDR_INSTALL_PREFIX_KSYMVERS "${CMAKE_INSTALL_PREFIX}/lib/modules/${KBUILD_VERSION_STRING}/symvers")
# additional, 3
set(KEDR_INSTALL_PREFIX_KINCLUDE
		"${KEDR_INSTALL_PREFIX_INCLUDE}")
# additional, 4
set(KEDR_INSTALL_PREFIX_EXAMPLES
		"${KEDR_INSTALL_PREFIX_READONLY}/examples")

############################################################################################################
# Path prefixes for tests

set(KEDR_TEST_COMMON_PREFIX "/var/tmp/kedr/test")

foreach(var_suffix ${KEDR_ALL_PATH_SUFFIXES})
    set(KEDR_TEST_PREFIX_${var_suffix} "${KEDR_TEST_COMMON_PREFIX}${KEDR_INSTALL_PREFIX_${var_suffix}}")
endforeach(var_suffix ${KEDR_ALL_PATH_SUFFIXES})

#kedr_load_install_prefixes()
#Set common prefixes variables equal to ones in install mode(should be called before configure files, which use prefixes)
macro(kedr_load_install_prefixes)
    foreach(var_suffix ${KEDR_ALL_PATH_SUFFIXES})
        set(KEDR_PREFIX_${var_suffix} ${KEDR_INSTALL_PREFIX_${var_suffix}})
    endforeach(var_suffix ${KEDR_ALL_PATH_SUFFIXES})
endmacro(kedr_load_install_prefixes)

#kedr_load_test_prefixes()
#Set common prefixes variables equal to ones in test mode(should be called before configure files, which use prefixes)
macro(kedr_load_test_prefixes)
    foreach(var_suffix ${KEDR_ALL_PATH_SUFFIXES})
        set(KEDR_PREFIX_${var_suffix} ${KEDR_TEST_PREFIX_${var_suffix}})
    endforeach(var_suffix ${KEDR_ALL_PATH_SUFFIXES})
endmacro(kedr_load_test_prefixes)