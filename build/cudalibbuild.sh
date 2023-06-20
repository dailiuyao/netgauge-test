#!/bin/bash
#SBATCH -N 1 # request 1 nodes
##SBATCH --nodelist=node01,node02
#SBATCH --output=nccl_lib_build_%j.stdout    # standard output will be redirected to this file, where the % is replaced with the job allocation number.
#SBATCH -J "nccl_lib_build"    # this is your job’s name
#SBATCH --gpus-per-node=1


# ---[ Script Setup ]---

set -e

source ~/sbatch_sh/.nvccrc

# for the shared library generated by myself

export LD_LIBRARY_PATH="/home/liuyao/software/Netgauge_gdr/libcuda:$LD_LIBRARY_PATH"

pushd /home/liuyao/software/Netgauge_gdr/libcuda

nvcc -shared -o libMyCudaCode.so MyCudaCode.cu -I/home/liuyao/software/Netgauge/libcuda -L/home/liuyao/software/cuda-11.6/lib64 -lcudart -Xcompiler -fPIC

# nvcc -I/opt/apps/mpi/mpich-3.4.2_nvidiahpc-21.9-0/include -I/home/ldai8/nccl-learning/p2p ncclp2p.cc -o ncclp2p -L/home/ldai8/NCCL/deps-nccl/nccl/build/lib -lnccl -L/opt/apps/mpi/mpich-3.4.2_nvidiahpc-21.9-0/lib -lmpi

# nvcc -I/opt/apps/mpi/mpich-3.4.2_nvidiahpc-21.9-0/include -I/home/ldai8/nccl-learning/p2p ncclp2p_shared.cc -o ncclp2p -L/home/ldai8/NCCL/deps-nccl/nccl/build/lib -lnccl -L/opt/apps/mpi/mpich-3.4.2_nvidiahpc-21.9-0/lib -lmpi -L/home/ldai8/nccl-learning/p2p -lmynccl_code




popd