#!/bin/bash

# ---[ Script Setup ]---

set -e

# module load mpich

CUDA_HOME="/opt/nvidia/hpc_sdk/Linux_x86_64/21.9/cuda"
export CUDA_HOME
export PATH="${CUDA_HOME}/include:$PATH"
export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:$LD_LIBRARY_PATH"


export NCCL_HOME=/home/ldai8/NCCL/deps-nccl/nccl/build
# export NCCL_TEST_HOME=/home/ldai8/NCCL/deps-nccl/nccl-tests/build
export PATH="${NCCL_HOME}/include:$PATH"
export LD_LIBRARY_PATH="${NCCL_HOME}/lib:$LD_LIBRARY_PATH"

module load mpich/3.4.2-nvidiahpc-21.9-0
MPI_HOME="/opt/apps/mpi/mpich-3.4.2_nvidiahpc-21.9-0"
export MPI_HOME
export PATH="${MPI_HOME}/include:$PATH"
export LD_LIBRARY_PATH="${MPI_HOME}/lib:$LD_LIBRARY_PATH"

echo MALLOC_CHECK_


# for the shared library generated by myself

export LD_LIBRARY_PATH=/home/ldai8/software/Netgauge/libnccl:$LD_LIBRARY_PATH

ldd /home/ldai8/software/Netgauge/libnccl/libMyNcclCode.so

mpirun -n 2 hostname

export MALLOC_CHECK_=2
echo MALLOC_CHECK_

# mpirun -n 2 /home/ldai8/software/netgauge-2.4.6/netgauge --verbosity 3 -t 30 -s 1048576 -c 20 -g 65535 -x loggp -o

# mpirun -n 2 /home/ldai8/software/Netgauge/netgauge -m mpi -x loggp -o ng_logGP_intranode


mpiexec -n 1 gdb --args /home/ldai8/software/Netgauge/netgauge -m mpi -x loggp -o ng_logGP_intranode : -n 1 \
 /home/ldai8/software/Netgauge/netgauge -m mpi -x loggp -o ng_logGP_intranode


