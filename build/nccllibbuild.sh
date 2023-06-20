#!/bin/bash
#SBATCH -N 1 # request 1 nodes
##SBATCH --nodelist=node01,node02
#SBATCH --output=nccl_lib_build_%j.stdout    # standard output will be redirected to this file, where the % is replaced with the job allocation number.
#SBATCH -J "nccl_lib_build"    # this is your job’s name
#SBATCH --gpus-per-node=1


# ---[ Script Setup ]---

set -e

# ---[ Set Up cuda/nccl/nccl-test/mpi ]---
#CUDA_HOME="/opt/spack/opt/spack/linux-rhel8-icelake/gcc-8.4.1/cuda-11.8.0-fdqi76f2fma5m7wyc2ngmbkspssgwr2c"
# CUDA_HOME="/opt/nvidia/hpc_sdk/Linux_x86_64/21.9/cuda"
# export CUDA_HOME
# export PATH="${CUDA_HOME}/include:$PATH"
# export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:$LD_LIBRARY_PATH"

# source ~/sbatch_sh/.nvccrc

export LD_LIBRARY_PATH=/home/liuyao/software/mpich4_1_1/lib:$LD_LIBRARY_PATH
export PATH=/home/liuyao/software/mpich4_1_1/bin:$PATH
export C_INCLUDE_PATH=/home/liuyao/software/mpich4_1_1/include:$C_INCLUDE_PATH

MPI_HOME="/home/liuyao/software/mpich4_1_1"
export MPI_HOME

source ~/sbatch_sh/.nvccrc

export NCCL_HOME=/home/liuyao/NCCL/deps-nccl/nccl/build
# export NCCL_TEST_HOME=/home/ldai8/NCCL/deps-nccl/nccl-tests/build
# export C_INCLUDE_PATH="${NCCL_HOME}/include":$C_INCLUDE_PATH
# export CXX_INCLUDE_PATH="${NCCL_HOME}/include":$CXX_INCLUDE_PATH

export LD_LIBRARY_PATH="${NCCL_HOME}/lib:$LD_LIBRARY_PATH"


# for the shared library generated by myself

export LD_LIBRARY_PATH="/home/liuyao/software/Netgauge/libnccl:$LD_LIBRARY_PATH"


echo "########## ENVIRONMENT ########"
echo "NCCL_LOCATION=${NCCL_HOME}"
# echo "NCCL_TEST_LOCATION=${NCCL_TEST_HOME}"
# echo " ### nccl based nccl-test ###"
# echo " ### how to check ###"
# ldd /home/ldai8/NCCL/deps-nccl/nccl-tests/build/all_reduce_perf
# echo " ### check end ###"
echo ""

# export NCCL_DEBUG=INFO
# export NCCL_ALGO=Tree
# export NCCL_PROTO=LL128

pushd /home/liuyao/software/Netgauge/libnccl

nvcc -shared -o libMyNcclCode.so MyNcclCode.cu -I/home/liuyao/software/Netgauge/libnccl  -I/${NCCL_HOME}/include -L/home/liuyao/NCCL/deps-nccl/nccl/build/lib -lnccl -L/home/liuyao/software/cuda-11.6/lib64 -lcudart -Xcompiler -fPIC

# nvcc -I/opt/apps/mpi/mpich-3.4.2_nvidiahpc-21.9-0/include -I/home/ldai8/nccl-learning/p2p ncclp2p.cc -o ncclp2p -L/home/ldai8/NCCL/deps-nccl/nccl/build/lib -lnccl -L/opt/apps/mpi/mpich-3.4.2_nvidiahpc-21.9-0/lib -lmpi

# nvcc -I/opt/apps/mpi/mpich-3.4.2_nvidiahpc-21.9-0/include -I/home/ldai8/nccl-learning/p2p ncclp2p_shared.cc -o ncclp2p -L/home/ldai8/NCCL/deps-nccl/nccl/build/lib -lnccl -L/opt/apps/mpi/mpich-3.4.2_nvidiahpc-21.9-0/lib -lmpi -L/home/ldai8/nccl-learning/p2p -lmynccl_code




popd