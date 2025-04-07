cmake_minimum_required(VERSION 3.4.1)

add_library(
  VisionCameraPosePlugin
  SHARED
  VisionCameraPosePlugin.mm
)

target_include_directories(
  VisionCameraPosePlugin PRIVATE
  ${REACT_NATIVE_INCLUDE_DIRS}
)

target_link_libraries(
  VisionCameraPosePlugin
  ${REACT_NATIVE_LIBRARIES}
)
