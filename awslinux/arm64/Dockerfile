FROM amazonlinux:2023

# Install build dependencies
RUN yum update -y && \
    yum install -y \
        cmake \
        ninja-build \
        git \
        clang \
        libunwind-devel \
        make \
        gcc-c++ && \
    yum clean all

# Clone LLVM source
RUN git clone --depth=1 --branch llvmorg-15.0.7 https://github.com/llvm/llvm-project.git

# Configure and build LLVM
RUN mkdir llvm-project/build && \
    cd llvm-project/build && \
    cmake -G Ninja \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_C_COMPILER=clang \
        -DCMAKE_CXX_COMPILER=clang++ \
        -DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" \
        -DLLVM_TARGETS_TO_BUILD="" \
        -DLIBCXX_ENABLE_SHARED=OFF \
        -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=ON \
        -DLIBCXXABI_ENABLE_SHARED=OFF \
        -DLLVM_ENABLE_PEDANTIC=OFF \
        -DLLVM_ENABLE_WERROR=OFF \
        -DLIBCXX_ENABLE_CXX23_REMOVED_FEATURES=ON \
        -DCMAKE_VERBOSE_MAKEFILE=ON \
        ../llvm && \
    ninja cxx && \
    ninja cxxabi && \
    ninja unwind

RUN cd llvm-project/build && \
    ls -l lib && \
    ninja install-cxx install-cxxabi install-unwind && \
    ls -l /usr/local/lib
