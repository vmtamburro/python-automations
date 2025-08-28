#!/bin/bash

source ~/.bash_profile
conda init

mamba create -n $1 python=3.9

conda activate $1

# https://github.com/scikit-learn/sklearn-pypi-package
conda env config vars set SKLEARN_ALLOW_DEPRECATED_SKLEARN_PACKAGE_INSTALL=True

# Try installing pyfarmhash first, if it fails, use LLVM fix
echo "Attempting to install pyfarmhash..."
if ! pip install pyfarmhash==0.3.2; then
    echo "pyfarmhash installation failed. Installing LLVM and retrying..."
    
    # Install LLVM for pyfarmhash compilation (macOS fix)
    brew install llvm
    
    # Install pyfarmhash with custom compiler flags to fix C++ header issues
    echo "Installing pyfarmhash with LLVM toolchain..."
    CPPFLAGS="-I$(brew --prefix llvm)/include/c++/v1" \
    CXXFLAGS="-I$(brew --prefix llvm)/include/c++/v1" \
    LDFLAGS="-L$(brew --prefix llvm)/lib" \
    CC=$(brew --prefix llvm)/bin/clang \
    CXX=$(brew --prefix llvm)/bin/clang++ \
    pip install pyfarmhash==0.3.2
fi

# Install remaining requirements
pip install -r requirements/dev.txt
