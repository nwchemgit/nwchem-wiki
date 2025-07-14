# Containers

## Docker 

Instruction for using the NWChem Docker container with the [docker compose](https://docs.docker.com/compose) command

1. Install docker  as described in [https://docs.docker.com/engine/install](https://docs.docker.com/engine/install)

2. Download the [compose.yaml](https://raw.githubusercontent.com/nwchemgit/nwchem-dockerfiles/refs/heads/master/nwchem-dev.mpipr/compose.yaml) file
 
```
 wget https://raw.githubusercontent.com/nwchemgit/nwchem-dockerfiles/refs/heads/master/nwchem-dev.mpipr/compose.yaml
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
 docker compose run nwchem h2o.nw
```
In some installation, `docker compose` is available as the command `docker-compose`, therefore in those cases, this command becomes
``` 
 docker-compose run nwchem h2o.nw
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
module swap libfabric libfabric/1.15.2.0
module  load cray-mpich-abi
export APPTAINERENV_LD_LIBRARY_PATH="$CRAY_MPICH_DIR/lib-abi-mpich:$CRAY_MPICH_ROOTDIR/gtl/lib:/opt/rocm/lib:/opt/rocm/lib64:$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH:/opt/cray/pe/lib64:$HIP_LIB_PATH:/opt/cray/pe/gcc/11.2.0/snos/lib64:/opt/cray/xpmem/default/lib64"
export APPTAINER_CONTAINLIBS="/usr/lib64/libcxi.so.1,/usr/lib64/libjson-c.so.3,/lib64/libtinfo.so.6,/usr/lib64/libnl-3.so.200,/usr/lib64/libgfortran.so.5,/usr/lib64/libjansson.so.4"
MYFS=$(findmnt -r -T . | tail -1 |cut -d ' ' -f 1)
export http_proxy=http://proxy.ccs.ornl.gov:3128/
export https_proxy=http://proxy.ccs.ornl.gov:3128/
export no_proxy='localhost,127.0.0.0/8,*.ccs.ornl.gov'
export PERMANENT_DIR=$MEMBERWORK/$SLURM_JOB_ACCOUNT
export BINDS=/usr/share/libdrm,/var/spool/slurmd,/opt/cray,${MYFS},${PERMANENT_DIR}
export FI_CXI_RX_MATCH_MODE=hybrid
export COMEX_EAGER_THRESHOLD=32768
export MPICH_SMP_SINGLE_COPY_MODE=NONE
export OMP_NUM_THREADS=1
MYIMG=oras://ghcr.io/edoapra/nwchem-singularity/nwchem-dev.mpich3.4.2:
export APPTAINER_CACHEDIR=$MEMBERWORK/$SLURM_JOB_ACCOUNT/cache
mkdir -p $APPTAINER_CACHEDIR
srun  -N $SLURM_NNODES  -l  apptainer exec --bind $BINDS --workdir `pwd` $MYIMG   nwchem siosi6.nw >& siosi6.out.$SLURM_JOBID
```

## Shifter 

Instructions for running the NWChem [Shifter images](https://docs.nersc.gov/applications/nwchem/) are available at [https://docs.nersc.gov/applications/nwchem](https://docs.nersc.gov/applications/nwchem)  

## Podman

Docker images could be run using podman commands
```
podman run --rm --shm-size 256m --volume /tmp:/data -i -t ghcr.io/nwchemgit/nwchem-dev/amd64 xvdw.nw
```
