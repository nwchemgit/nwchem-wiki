# How to download and install NWChem

## Source Download

The NWChem source is available for download from
[https://github.com/nwchemgit/nwchem/releases](https://github.com/nwchemgit/nwchem/releases)

Compilation instructions can be found at this [link](Compiling-NWChem)

## NWChem availability in Linux distributions

Debian: [https://packages.debian.org/search?keywords=nwchem](https://packages.debian.org/search?keywords=nwchem)

Ubuntu: [https://launchpad.net/ubuntu/+source/nwchem](https://launchpad.net/ubuntu/+source/nwchem)

Fedora and EPEL: [https://admin.fedoraproject.org/updates/search/nwchem](https://admin.fedoraproject.org/updates/search/nwchem)

Good search engine for NWChem Linux packages: [https://pkgs.org/search/?q=nwchem](https://pkgs.org/search/?q=nwchem)

### Example of NWChem installation on Debian/Ubuntu

```
sudo apt-get  install nwchem
```

### Example of NWChem RPM installation under RedHat 6 x86_64

```
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
sudo yum update
sudo yum install nwchem nwchem-openmpi environment-modules
```
In order to run NWChem, you must type
```
module load openmpi-x86_64
```
The name of the NWChem executable is
```
nwchem_openmpi
```

### Example of NWChem RPM installation under Centos 7 x86_64

```
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum update
sudo yum install nwchem nwchem-openmpi Lmod
```
In order to run NWChem, you must type
```
module load mpi/openmpi-x86_64
```
The name of the NWChem executable is
```
nwchem_openmpi
```
Serial runs, using a single process, (on a input file named `n2.nw` in the following example) can be performed with the command
```
nwchem_openmpi n2.nw
```
Parallel runs (using more than one process) can be performed with the command
```
mpirun -np 2 nwchem_openmpi n2.nw
```

## NWChem availability on macOS

NWChem can be installed from [Homebrew](https://brew.sh/), by executing the following commands  
```
bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install nwchem
```

## NWChem installation on Conda

NWChem can be installed  on Linux or MacOS from the [conda-forge](https://conda-forge.org/) channel of [Conda](https://docs.conda.io) with the command
```
conda install -c conda-forge nwchem
```
More details at [https://github.com/conda-forge/nwchem-feedstock](https://github.com/conda-forge/nwchem-feedstock)

