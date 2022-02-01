# Docker 

Dockerfile recipes are available at the repository [https://github.com/nwchemgit/nwchem-dockerfiles](https://github.com/nwchemgit/nwchem-dockerfiles)

Docker images of the master branch are hosted at [https://ghcr.io](https://ghcr.io) and can be used with the following command  

```
 docker run --rm -v [host_system_dir]:/data ghcr.io/nwchemgit/nwchem-dev/[arch] input.nw
```
where the `[arch]` option can have the values `amd64`, `arm64`, `ppc64le` or `armv7` . For example, the following command can be used on `amd64` (a.k.a. `x86_64`) hardware:
```
 docker run --rm -v /tmp:/data ghcr.io/nwchemgit/nwchem-dev/amd64 input.nw
```
where the input file `input.nw` is located in the `/tmp` directory.
  

Older Docker images are available at [https://hub.docker.com/u/nwchemorg](https://hub.docker.com/u/nwchemorg)

The following docker command will pull the NWChem 7.0.0 image and run it in parallel using three processes 
```
docker run  --entrypoint='mpirun' -v  /Users/edo/nwchem/tests:/data -it nwchemorg/nwchem-700.fedora.sockets  -np 3 nwchem  /data/h2o_b2lyp.nw
```
This example uses the input file `h2o_b2lyp.nw` available on the host directory `/Users/edo/nwchem/tests`

The associated Dockerfile is available at  
[https://github.com/nwchemgit/nwchem-dockerfiles/tree/master/nwchem-700.fedora.sockets](https://github.com/nwchemgit/nwchem-dockerfiles/tree/master/nwchem-700.fedora.sockets) 


# Singularity

Singularity recipes for NWChem are available at.  
[https://github.com/edoapra/nwchem-singularity](https://github.com/edoapra/nwchem-singularity)

Singularity images are available at  
[https://cloud.sylabs.io/library/edoapra](https://cloud.sylabs.io/library/edoapra)
