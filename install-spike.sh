#!/bin/bash
set -e
ROOT=${PITON_ROOT}/piton/design/chip/tile/ariane

cd $ROOT/tmp

if [ -z ${NUM_JOBS} ]; then
    NUM_JOBS=1
fi

if [ ! -e "${RISCV}/bin/spike"  ]; then
    echo "Installing Spike"
    git clone https://github.com/riscv/riscv-isa-sim.git 
    cd riscv-isa-sim
    mkdir -p build
    cd build
    ../configure --prefix="$RISCV/"
    make -j${NUM_JOBS}
    make install
else
    echo "Using Spike from cached directory."
fi
