#!/bin/bash
sudo apt -y install mpi-default-bin libgfortran4 libopenblas-base \
libopenmpi2 libscalapack-openmpi2.0 openmpi-bin libquadmath0 \
libfabric1 libhwloc5 libibverbs1 libpsm-infinipath1 \
openmpi-common libhwloc-plugins libnl-route-3-200 \
ocl-icd-libopencl1  librdmacm1
wget https://github.com/nwchemgit/nwchem/releases/download/6.8.1-release/nwchem-data_6.8.1+133+gitge032219-2_all.ubuntu_bionic.deb
wget https://github.com/nwchemgit/nwchem/releases/download/6.8.1-release/nwchem_6.8.1+133+gitge032219-2_amd64.ubuntu_bionic.deb
sudo dpkg -i nwchem_6.8.1+133+gitge032219-2_amd64.ubuntu_bionic.deb nwchem-data_6.8.1+133+gitge032219-2_all.ubuntu_bionic.deb
