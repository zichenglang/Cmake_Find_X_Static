cmake_minimum_required (VERSION 2.6)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/Modules/")

# 1. Set Static Switch ON ------------------------------
# Use protobuf static libs ON/OFF
SET(Protobuf_USE_STATIC_LIBS ON)

# Use GRPC static libs ON/OFF
SET(GRPC_USE_STATIC_LIBS ON)

# Use GLOG static libs ON/OFF
# Attention !! If you are using static glog libs, you MUST use gfags static libs.
SET(GLOG_USE_STATIC_LIBS ON)

# Use GFLAGS static libs ON/OFF
# Needs by Glog static libs.
SET(GFLAGS_USE_STATIC_LIBS ON)

# Use Libevent static libs ON/OFF
SET(LIBEVENT_USE_STATIC_LIBS ON)

# 2. Find Libraries. -----------------------------------
find_package(Glog)

find_package(LibEvent)

find_package(Protobuf REQUIRED)

find_package(GRPC)

# 3. Set Include Dir And 3rd party libraries. ----------

include_directories(src ${GFLAGS_INCLUDE_DIRS} ${GLOG_INCLUDE_DIRS} ${LIBEVENT_INCLUDE_DIR} ${Protobuf_INCLUDE_DIRS} ${GRPC_INCLUDE_DIRS})

# libz.a is used by grpc static libraries.
set(LIB_3RD libz.a ${GFLAGS_LIBRARIES} ${GLOG_LIBRARIES} ${LIBEVENT_LIB} ${PROTOBUF_LIBRARIES} ${GRPC_LIBRARIES})


# 4. Link libraries to you binary file. ----------------
target_link_libraries(execfile  ${LIB_3RD})

