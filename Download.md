# Source Download

NWChem source is available for download from
[https://github.com/nwchemgit/nwchem/releases](https://github.com/nwchemgit/nwchem/releases)

Compilation instructions can be found at this [link](Compiling-NWChem)

# NWChem availability in Linux distributions

Debian: [https://packages.debian.org/search?keywords=nwchem](https://packages.debian.org/search?keywords=nwchem)

Ubuntu: [https://launchpad.net/ubuntu/+source/nwchem](https://launchpad.net/ubuntu/+source/nwchem)

Fedora and EPEL: [https://admin.fedoraproject.org/updates/search/nwchem](https://admin.fedoraproject.org/updates/search/nwchem)

Good search engine for NWChem Linux packages: [https://pkgs.org/search/?q=nwchem](https://pkgs.org/search/?q=nwchem)

Example of NWChem RPM installation under RedHat 6 x86_64

```
sudo yum -y install http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo yum update
sudo yum install nwchem-openmpi.x86_64
```

# NWChem availability on macOS

NWChem can be installed from [Homebrew](https://brew.sh/), by executing the following commands  
```
bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install nwchem
```