
include(ExternalProject)

set(llvm_host_system_name
  "Linux")
set(llvm_target_triple
  "x86_64-Linux-linux-gnu")
set(llvm_runtimes_target
  "${llvm_target_triple}")
set(llvm_cmake_args
  "-DLLVM_ENABLE_PROJECTS=all -DBUILD_SHARED_LIBS=ON -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLLVM_ENABLE_RUNTIMES=all -DCMAKE_HOST_SYSTEM_NAME=${llvm_host_system_name} -DLLVM_DEFAULT_TARGET_TRIPLE=${llvm_target_triple} -DLLVM_RUNTIMES_TARGET=${lvm_runtimes_target} -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DLLVM_USE_LINKER=lld -DLLVM_USE_RELATIVE_PATHS_IN_FILES=ON -DLLVM_USE_RELATIVE_PATHS_IN_DEBUG_INFO=ON -DLLVM_USE_SPLIT_DWARF=ON -DLLVM_INSTALL_UTILS=ON -DLLVM_OPTIMIZED_TABLEGEN=ON -DLLVM_ENABLE_FFI=ON -DLLVM_BUILD_DOCS=ON -DLLVM_BUILD_EXAMPLES=ON")
set(llvm_cmake_command
  "cmake -S $(realpath llvm) -B BUILD/RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$(realpath ~/dev) -DLLVM_ENABLE_PROJECTS=all -DBUILD_SHARED_LIBS=ON -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLLVM_ENABLE_RUNTIMES=all -DCMAKE_HOST_SYSTEM_NAME=${llvm_host_system_name} -DLLVM_DEFAULT_TARGET_TRIPLE=${llvm_target_triple} -DLLVM_RUNTIMES_TARGET=${lvm_runtimes_target} -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DLLVM_USE_LINKER=lld -DLLVM_USE_RELATIVE_PATHS_IN_FILES=ON -DLLVM_USE_RELATIVE_PATHS_IN_DEBUG_INFO=ON -DLLVM_USE_SPLIT_DWARF=ON -DLLVM_INSTALL_UTILS=ON -DLLVM_OPTIMIZED_TABLEGEN=ON -DLLVM_ENABLE_FFI=ON -DLLVM_BUILD_DOCS=ON -DLLVM_BUILD_EXAMPLES=ON")
ExternalProject_Add(llvm-project
  PREFIX llvm-project
  GIT_REPOSITORY https://github.com/llvm/llvm-project.git
  GIT_TAG origin/main
  GIT_SHALLOW TRUE
  GIT_PROGRESS TRUE
#  CONFIGURE_COMMAND "${llvm_cmake_command}"
  CMAKE_ARGS "${llvm_cmake_args}"
  CMAKE_GENERATOR "Ninja"
)
