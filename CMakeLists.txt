cmake_minimum_required(VERSION 3.27)
project(clang-tool-project)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
set(CLANG_TOOL_PROJECT_ROOT ${CMAKE_CURRENT_SOURCE_DIR})
set(CLANG_TOOL_PROJECT_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)
if(${BUILD_LLVM})
  add_subdirectory(external EXCLUDE_FROM_ALL)
endif()
add_subdirectory(cmake)
add_subdirectory(ExternalClangTool)

