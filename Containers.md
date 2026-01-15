# Containers

## Docker 

Instruction for using the NWChem Docker container with the [docker compose](https://docs.docker.com/compose) command

1. Install docker  as described in [https://docs.docker.com/engine/install](https://docs.docker.com/engine/install)

2. Download the [compose.yaml](https://github.com/nwchemgit/nwchem-dockerfiles/raw/refs/heads/master/nwchem-cross/compose.yaml) file
 
```
 wget https://github.com/nwchemgit/nwchem-dockerfiles/raw/refs/heads/master/nwchem-cross/compose.yaml
```

3. Create the nwchem service
``` 
docker compose up -d
```
In some installation, `docker compose` is available as the command `docker-compose`, therefore in those cases, this command becomes
``` 
docker-compose up -d
```

4. Run NWChem
 
``` 
 docker compose run --rm nwchem h2o.nw
```
In some installation, `docker compose` is available as the command `docker-compose`, therefore in those cases, this command becomes
``` 
 docker-compose run --rm nwchem h2o.nw
```


In the example above the input file name is `h2o.nw`.   
The default setting will run NWChem using 2 processes.
If you would like to use more processes,
then you would have to set the environment variable `MYNPROC` to the number of processes plus one.
For example, if you wish to use 4 processes, then you will execute the following (bash syntax)
```
export MYNPROC=5
```


## Singularity/Apptainer

Singularity/Apptainer recipes for NWChem are available at.  
[https://github.com/edoapra/nwchem-singularity](https://github.com/edoapra/nwchem-singularity)

Singularity images are available at 
[ghcr.io/edoapra/nwchem-singularity/nwchem-dev.ompi41x](https://ghcr.io/edoapra/nwchem-singularity/nwchem-dev.ompi41x)  
and 
[ghcr.io/edoapra/nwchem-singularity/nwchem-dev.mpich3.4.2](https://ghcr.io/edoapra/nwchem-singularity/nwchem-dev.mpich3.4.2)


### Instruction for running on EMSL Tahoma

Slurm script for running NWChem Singularity/Apptainer images on [EMSL tahoma](https://www.emsl.pnnl.gov/MSC/UserGuide/tahoma/tahoma_overview.html)

```
#!/bin/bash
#SBATCH -N 2
#SBATCH -t 00:29:00
#SBATCH -A allocation_name
#SBATCH --ntasks-per-node 36
#SBATCH -o singularity_library.output.%j
#SBATCH -e ./singularity_library.err.%j
#SBATCH -J singularity_library
#SBATCH --export ALL
source /etc/profile.d/modules.sh
export https_proxy=http://proxy.emsl.pnl.gov:3128
module purge
module load gcc/9.3.0
module load openmpi/4.1.4
SCRATCH=/big_scratch
# pull new image to the current directory
singularity pull -F --name ./nwchems_`id -u`.img oras://ghcr.io/edoapra/nwchem-singularity/nwchem-dev.ompi41x:latest
# copy image from current directory to local /big_scratch/ on compute nodes
srun -N $SLURM_NNODES -n $SLURM_NNODES cp ./nwchems_`id -u`.img $SCRATCH/nwchems.img
# basis library files
export SINGULARITYENV_NWCHEM_BASIS_LIBRARY=/cluster/apps/nwchem/nwchem/src/basis/libraries/
# use /big_scratch as scratch_dir
export SINGULARITYENV_SCRATCH_DIR=$SCRATCH
# bind local file system
MYFS=$(findmnt -r -T . | tail -1 |cut -d ' ' -f 1)
# run
srun --mpi=pmi2 -N $SLURM_NNODES -n $SLURM_NPROCS singularity exec --bind $SCRATCH,$MYFS $SCRATCH/nwchems.img nwchem  "file name"
```

### Instruction for running on OLCF Frontier

Slurm script for running NWChem Singularity/Apptainer images on [OLCF Frontier](https://docs.olcf.ornl.gov/systems/frontier_user_guide.html)

```
#!/bin/bash
#SBATCH -t 00:29:00
#SBATCH -A ABCXYZ123
#SBATCH -N 4
#SBATCH  --tasks-per-node 56
#SBATCH  --cpus-per-task 1
#SBATCH -J siosi6
#SBATCH -o siosi6.err.%j
module  load cray-mpich-abi
export APPTAINERENV_LD_LIBRARY_PATH="$CRAY_MPICH_DIR/lib-abi-mpich:$CRAY_MPICH_ROOTDIR/gtl/lib:$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH:/opt/cray/pe/lib64:$HIP_LIB_PATH:/opt/cray/pe/gcc/current/snos/lib64"
export APPTAINER_CONTAINLIBS="/usr/lib64/libcxi.so.1,/usr/lib64/libjson-c.so.3,/lib64/libtinfo.so.6,/usr/lib64/libnl-3.so.200,/usr/lib64/libgfortran.so.5,/usr/lib64/libjansson.so.4"
MYFS=$(findmnt -r -T . | tail -1 |cut -d ' ' -f 1)
export https_proxy=http://proxy.ccs.ornl.gov:3128/
export BINDS=/usr/share/libdrm,/var/spool/slurmd,/opt/cray,${MYFS}
export FI_CXI_RX_MATCH_MODE=hybrid
export COMEX_EAGER_THRESHOLD=32768
export MPICH_SMP_SINGLE_COPY_MODE=NONE
export OMP_NUM_THREADS=1
export APPTAINERENV_OMP_NUM_THREADS=1
MYIMG=oras://ghcr.io/edoapra/nwchem-singularity/nwchem-dev.mpich3.4.2:
srun apptainer exec --bind $BINDS --workdir `pwd` $MYIMG nwchem siosi6.nw >& siosi6.out.$SLURM_JOBID
```

### Instruction for running on NERSC Perlmutter CPU partition

Slurm script for running NWChem Singularity/Apptainer images on the CPU partition of [NERSC Perlmutter](https://docs.nersc.gov/systems/perlmutter/architecture/)

```
#SBATCH -C cpu
#SBATCH -N 8
#SBATCH -A ABC123
#SBATCH --ntasks-per-node=64
#SBATCH --cpus-per-task=2
module load PrgEnv-gnu
module load cray-pmi
module load  cray-mpich-abi
module list
export APPTAINERENV_LD_LIBRARY_PATH="$CRAY_MPICH_DIR/lib-abi-mpich:$CRAY_MPICH_ROOTDIR/gtl/lib:$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH:/opt/cray/pe/lib64:/opt/cray/pe/gcc/default/snos/lib64"
export APPTAINER_CONTAINLIBS="/usr/lib64/libcxi.so.1,/usr/lib64/libjson-c.so.3,/lib64/libtinfo.so.6,/usr/lib64/libnl-3.so.200,/usr/lib64/libgfortran.so.5,/usr/lib64/libjansson.so.4"
export OMP_NUM_THREADS=1
export OMP_PROC_BIND=true
export COMEX_MAX_NB_OUTSTANDING=6
export COMEX_EAGER_THRESHOLD=65536
export SCRATCH_DIR=/tmp
export APPTAINER_CONFIGDIR=${SCRATCH}/apptainer
export APPTAINER_CACHEDIR=${SCRATCH}/apptainer/cache
export APP_VER=current
export PATH=/cvmfs/oasis.opensciencegrid.org/mis/apptainer/$APP_VER/x86_64/bin:$PATH
export PATH=/cvmfs/oasis.opensciencegrid.org/mis/apptainer/$APP_VER/x86_64/utils/bin/:$PATH
export LD_LIBRARY_PATH=/cvmfs/oasis.opensciencegrid.org/mis/apptainer/current/x86_64/utils/lib:$LD_LIBRARY_PATH
MYFS=$(findmnt -r -T . | tail -1 |cut -d ' ' -f 1)
export BINDS=/usr/share/libdrm,/var/spool/slurmd,/opt/cray,${MYFS}
export MPICH_GPU_SUPPORT_ENABLED=0
export MPICH_SMP_SINGLE_COPY_MODE=NONE
export FI_CXI_RX_MATCH_MODE=software
export FI_MR_CACHE_MONITOR=disabled
export FI_CXI_RDZV_THRESHOLD=16384
MYIMG=oras://ghcr.io/edoapra/nwchem-singularity/nwchem-dev.mpich3.4.2.libfabric1.21.1:
apptainer pull  /tmp/nwchem.sif $MYIMG
srun  -v  -N  $SLURM_NNODES  -n $SLURM_NPROCS   apptainer exec --bind $BINDS --workdir `pwd`  $MYIMG nwchem siosi6.nw >& siosi6.out.$SLURM_JOBID
```
## Shifter 

Instructions for running the NWChem [Shifter images](https://docs.nersc.gov/applications/nwchem/) are available at [https://docs.nersc.gov/applications/nwchem](https://docs.nersc.gov/applications/nwchem)  

## Podman

Docker images could be run using podman commands
```
podman run --rm --shm-size 256m --volume /tmp:/data -i -t ghcr.io/nwchemgit/nwchem-dev/amd64 xvdw.nw
```
