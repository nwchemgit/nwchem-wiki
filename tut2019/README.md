**Material for the 2019 EMSL/ARM Aerosol Summer School**  
https://pnnl.cvent.com/events/aerosol-summer-school/agenda-a5619d0658f24e799567a97dbb6ef20d.aspx

*Instruction for installing NWChem on Mac with Homebrew* 
* In Terminl App  
* If Homebrew is not installed yet, type
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
* type
```
brew install nwchem
```

*Instruction for installing NWChem on Ubuntu 18 Bionic*  
* Open terminal and type
```
sudo apt -y install mpi-default-bin libgfortran4 libopenblas-base \
libopenmpi2 libscalapack-openmpi2.0 openmpi-bin libquadmath0 \
libfabric1 libhwloc5 libibverbs1 libpsm-infinipath1 \
openmpi-common libhwloc-plugins libnl-route-3-200 \
ocl-icd-libopencl1  librdmacm1
```
* Download NWChem install file by typing
```
wget https://github.com/nwchemgit/nwchem/releases/download/6.8.1-release/nwchem-data_6.8.1+133+gitge032219-2_all.ubuntu_bionic.deb
wget https://github.com/nwchemgit/nwchem/releases/download/6.8.1-release/nwchem_6.8.1+133+gitge032219-2_amd64.ubuntu_bionic.deb
```
* Install the NWChem packages
```
sudo dpkg -i nwchem_6.8.1+133+gitge032219-2_amd64.ubuntu_bionic.deb \ 
nwchem-data_6.8.1+133+gitge032219-2_all.ubuntu_bionic.deb
```
