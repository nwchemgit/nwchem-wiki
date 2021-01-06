# Docker 

Dockerfile recipes are available at the repository [https://github.com/nwchemgit/nwchem-dockerfiles](https://github.com/nwchemgit/nwchem-dockerfiles)

Docker images are available at [https://hub.docker.com/u/nwchemorg](https://hub.docker.com/u/nwchemorg)

The following docker command will pull the NWChem 7.0.0 image and run it in parallel using three processes 
```
docker run  --entrypoint='mpirun' -v  /Users/edo/nwchem/tests:/data -it nwchemorg/nwchem-700.fedora.sockets  -np 3 nwchem  /data/h2o_b2lyp.nw
```
This example uses the input file `h2o_b2lyp.nw` available on the host directory `/Users/edo/nwchem/tests`

The associated Dockerfile is available at  
[https://github.com/nwchemgit/nwchem-dockerfiles/tree/master/nwchem-700.fedora.sockets](https://github.com/nwchemgit/nwchem-dockerfiles/tree/master/nwchem-700.fedora.sockets) 

NWChem documentation available on the NWChem website at   
[https://github.com/nwchemgit/nwchem-dockerfiles/tree/master/nwchem-700.fedora.sockets](https://github.com/nwchemgit/nwchem-dockerfiles/tree/master/nwchem-700.fedora.sockets) 

# Singularity

Singularity recipes for NWChem are available at.  
[https://github.com/edoapra/nwchem-singularity](https://github.com/edoapra/nwchem-singularity)

Singularity images are available at  
[https://cloud.sylabs.io/library/edoapra](https://cloud.sylabs.io/library/edoapra)
