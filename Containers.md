# Containers

## Docker 

Dockerfile recipes are available at the repository [https://github.com/nwchemgit/nwchem-dockerfiles](https://github.com/nwchemgit/nwchem-dockerfiles)

Docker images of the master branch are hosted at [https://ghcr.io](https://github.com/features/packages) and can be used with the following command  

```
 docker run --shm-size 256m  --rm -v [host_system_dir]:/data ghcr.io/nwchemgit/nwchem-dev/[arch] input.nw
```
where the `[arch]` option can have the values `amd64`, `arm64`, `ppc64le` or `armv7` . For example, the following command can be used on `amd64` (a.k.a. `x86_64`) hardware:
```
 docker run --shm-size 256m  --rm -v /tmp:/data ghcr.io/nwchemgit/nwchem-dev/amd64 input.nw
```
where the input file `input.nw` is located in the `/tmp` directory.


The following docker command will run NWChem in parallel using three processes 
```
docker run --shm-size 256m  --rm  --entrypoint='mpirun' -v /tmp:/data ghcr.io/nwchemgit/nwchem-dev/amd64  -np 2 nwchem /data/xvdw.nw
```
This example uses the input file `xvdw.nw` available on the host directory `/tmp`

The associated Dockerfile is available at  
[https://github.com/nwchemgit/nwchem-dockerfiles/blob/master/nwchem-dev/Dockerfile](https://github.com/nwchemgit/nwchem-dockerfiles/blob/master/nwchem-dev/Dockerfile) 


## Singularity

Singularity recipes for NWChem are available at.  
[https://github.com/edoapra/nwchem-singularity](https://github.com/edoapra/nwchem-singularity)

Singularity images are available at  
[https://cloud.sylabs.io/library/edoapra](https://cloud.sylabs.io/library/edoapra)

## Podman

Docker images could be run using podman commands
```
podman run --rm --shm-size 256m --volume /tmp:/data -i -t ghcr.io/nwchemgit/nwchem-dev/amd64 xvdw.nw
```
