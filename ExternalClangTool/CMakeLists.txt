
project(external-clang-tool-support)

include(SetupClangProject)

add_library(ExternalClangTool SHARED
  ExternalClangTool.cpp
  ${CLANG_TOOL_PROJECT_INCLUDE_DIR}/ExternalClangTool.h)

target_include_directories(ExternalClangTool PUBLIC ${CLANG_TOOL_PROJECT_INCLUDE_DIR})
target_add_clang_dep(ExternalClangTool LIBRARY SET_RPATH clangTooling)


