
cmake_policy(PUSH)
cmake_minimum_required(VERSION 3.27)

# For finding self-installed Find*.cmake packages.
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
include(SetupLLVMProject)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${Clang_DIR})
find_package(Clang ${CLANG_VERSION} CONFIG)
include(AddClang)

function(SetupClangLibs)
  foreach(_tgt ${CLANG_EXPORTED_TARGETS})
    get_property(_libs TARGET ${_tgt}
      PROPERTY "IMPORTED_LINK_DEPENDENT_LIBRARIES_${LLVM_BUILD_TYPE}")
    foreach(_lib ${_libs})
      target_link_libraries(${_tgt} INTERFACE ${_lib})
      target_include_directories(${_lib} INTERFACE ${LLVM_INCLUDE_DIRS})
      target_link_directories(${_lib} INTERFACE ${LLVM_LIBRARY_DIR} ${CLANG_INCLUDE_DIRS})
      target_link_options(${_lib} INTERFACE ${LLVM_SHARED_LINKER_FLAGS})
      target_compile_definitions(${_lib} INTERFACE ${LLVM_COMPILE_DEFS})
      target_compile_options(${_lib} INTERFACE ${LLVM_COMPILE_OPTS})
    endforeach()
  endforeach()
endfunction()

SetupClangLibs()

function(target_add_clang_dep tgt)
  cmake_parse_arguments(ARG
    "LIBRARY;EXECUTABLE;SET_RPATH"
    "LANGUAGE"
    ""
    ${ARGN})
  set(llvm_dep_args "")
  if (${ARG_LIBRARY} AND ${ARG_EXECUTABLE})
    message(FATAL_ERROR "Cannot declare target both library and executable")
  endif()
  if(NOT (${ARG_LIBRARY} OR ${ARG_EXECUTABLE}))
    set(ARG_EXECUTABLE TRUE)
  endif()
  if(${ARG_LIBRARY})
    list(APPEND llvm_dep_args LIBRARY)
  else()
    list(APPEND llvm_dep_args EXECUTABLE)
  endif()
  if(NOT ${ARG_LANGUAGE})
    set(ARG_LANGUAGE "CXX")
  endif()

  set(_clang_libs "")
  foreach(_lib ${ARG_UNPARSED_ARGUMENTS})
    list(FIND CLANG_EXPORTED_TARGETS "${_lib}" _lib_found)
    if(${_lib_found})
      list(APPEND _clang_libs "${_lib}")
    else()
      list(APPEND llvm_dep_args "${_lib}")
    endif()
  endforeach()
  target_add_llvm_dep(${tgt} ${llvm_dep_args})
  if(${_clang_libs})
    target_link_libraries(${tgt} PUBLIC ${_clang_libs})
  endif()
endfunction()

cmake_policy(POP)

