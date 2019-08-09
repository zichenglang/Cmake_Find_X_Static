# - Try to find Glog
#
# The following variables are optionally searched for defaults
#  GLOG_ROOT_DIR:            Base directory where all GLOG components are found
#
# The following are set after configuration is done:
#  GLOG_FOUND
#  GLOG_INCLUDE_DIRS
#  GLOG_LIBRARIES
#  GLOG_LIBRARYRARY_DIRS

include(FindPackageHandleStandardArgs)

set(GLOG_ROOT_DIR "" CACHE PATH "Folder contains Google glog")

# Support preference of static libs by adjusting CMAKE_FIND_LIBRARY_SUFFIXES
if( GLOG_USE_STATIC_LIBS )
  set( _glog_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_FIND_LIBRARY_SUFFIXES})
  if(WIN32)
    set(CMAKE_FIND_LIBRARY_SUFFIXES .lib .a ${CMAKE_FIND_LIBRARY_SUFFIXES})
  else()
    set(CMAKE_FIND_LIBRARY_SUFFIXES .a )
  endif()
endif()


find_path(GLOG_INCLUDE_DIR glog/logging.h
    PATHS ${GLOG_ROOT_DIR})

find_library(GLOG_LIBRARY glog 
    PATHS ${GLOG_ROOT_DIR}
    PATH_SUFFIXES lib lib64)

find_package_handle_standard_args(Glog DEFAULT_MSG GLOG_INCLUDE_DIR GLOG_LIBRARY)

if( GLOG_USE_STATIC_LIBS )
  set(CMAKE_FIND_LIBRARY_SUFFIXES ${_glog_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES})
endif()

if(GLOG_FOUND)
  set(GLOG_INCLUDE_DIRS ${GLOG_INCLUDE_DIR})
  set(GLOG_LIBRARIES ${GLOG_LIBRARY})
  message(STATUS "Found glog    (include: ${GLOG_INCLUDE_DIR}, library: ${GLOG_LIBRARY})")
  mark_as_advanced(GLOG_ROOT_DIR GLOG_LIBRARY_RELEASE GLOG_LIBRARY_DEBUG
                                 GLOG_LIBRARY GLOG_INCLUDE_DIR)
endif()
