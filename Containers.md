# Containers

## Docker 

Dockerfile recipes are available at the repository [https://github.com/nwchemgit/nwchem-dockerfiles](https://github.com/nwchemgit/nwchem-dockerfiles)

Docker images of the master branch are hosted at [https://ghcr.io](https://github.com/features/packages) and can be used with the following command  

```
 docker run --shm-size 256m -u `id -u` --rm -v [host_system_dir]:/data ghcr.io/nwchemgit/nwchem-dev input.nw
```
For example, the following command can be used when starting from the `/tmp` directory:
```
 docker run --shm-size 256m -u `id -u` --rm -v /tmp:/data ghcr.io/nwchemgit/nwchem-dev /data/input.nw
```
where the input file `input.nw` is located in the `/tmp` directory.


The following docker command will run NWChem in parallel using three processes 
```
docker run --shm-size 256m  -u `id -u` --rm  --entrypoint='mpirun' -v /tmp:/data ghcr.io/nwchemgit/nwchem-dev  -np 2 nwchem /data/xvdw.nw
```
This example uses the input file `xvdw.nw` available on the host directory `/tmp`

The associated Dockerfile is available at  
[https://github.com/nwchemgit/nwchem-dockerfiles/blob/master/nwchem-dev/Dockerfile](https://github.com/nwchemgit/nwchem-dockerfiles/blob/master/nwchem-dev/Dockerfile) 


## Singularity

Singularity recipes for NWChem are available at.  
[https://github.com/edoapra/nwchem-singularity](https://github.com/edoapra/nwchem-singularity)

Singularity images are available at  
[https://cloud.sylabs.io/library/edoapra](https://cloud.sylabs.io/library/edoapra)
or at
[ghcr.io/edoapra/nwchem-singularity/nwchem-dev.ompi40x](https://ghcr.io/edoapra/nwchem-singularity/nwchem-dev.ompi40)


### Instruction for running on EMSL Tahoma

Instructions for running NWChem Singularity images on [EMSL tahoma](https://www.emsl.pnnl.gov/MSC/UserGuide/tahoma/tahoma_overview.html)

```
#!/bin/bash
#SBATCH -N 2
#SBATCH -t 00:29:00
#SBATCH -A allocation_name
#SBATCH --ntasks-per-node 18
#SBATCH -o singularity_library.output.%j
#SBATCH -e ./singularity_library.err.%j
#SBATCH -J singularity_library
#SBATCH --export ALL
source /etc/profile.d/modules.sh
export https_proxy=http://proxy.emsl.pnl.gov:3128
module purge
module load openmpi
# remove old images
rm -f ./nwchems_`id -u`.img
# pull new image to the current directory
singularity pull --name ./nwchems_`id -u`.img oras://ghcr.io/edoapra/nwchem-singularity/nwchem-dev.ompi40x:latest
# copy image from current directory to local /big_scratch/ on compute nodes
srun -N $SLURM_NNODES -n $SLURM_NNODES cp ./nwchems_`id -u`.img /big_scratch/nwchems.img
# run
srun singularity exec /big_scratch/nwchems.img nwchem  "file name"
```

## Podman

Docker images could be run using podman commands
```
podman run --rm --shm-size 256m --volume /tmp:/data -i -t ghcr.io/nwchemgit/nwchem-dev/amd64 xvdw.nw
```
