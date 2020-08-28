# Known Bugs

### How to report bugs

Use our [Github issue tracker](https://github.com/nwchemgit/nwchem/issues) to report new bugs. 

Also check there for other issues that may not have made it into these lists. 

See the [FAQ page](FAQ) for solutions to common issues.

### Bugs present in NWChem binary packages

* The packages shipped with Ubuntu Bionic 18.04 are buggy. Calculations  stop with the error
```
spcart_bra2etran: nbf_xj.ne.nbf_sj  (xj-sj) =                   5
```
[https://nwchemgit.github.io/Special_AWCforum/st/id3386/Ubuntu_18.html](https://nwchemgit.github.io/Special_AWCforum/st/id3386/Ubuntu_18.html)
[https://bugs.launchpad.net/ubuntu/+source/nwchem/+bug/1675817](https://bugs.launchpad.net/ubuntu/+source/nwchem/+bug/1675817)

Please use commands to install an updated version (as described
at the [NWChem 7.0.0 release page](https://github.com/nwchemgit/nwchem/releases/tag/v7.0.0-release))
```
sudo apt -y install curl  python3-dev gfortran  mpi-default-bin mpi-default-dev libopenblas-dev ssh

curl -LJO https://github.com/nwchemgit/nwchem/releases/download/v7.0.0-release/nwchem-data_7.0.0-3_all.ubuntu_bionic.deb
curl -LJO https://github.com/nwchemgit/nwchem/releases/download/v7.0.0-release/nwchem_7.0.0-3_amd64.ubuntu_bionic.deb

sudo dpkg -i nwchem_7.0.0-3*_bionic.deb
```

###  Known bugs for NWChem 6.8

* _AR comppilation failure on Mac OSX_   
[https://github.com/nwchemgit/nwchem/issues/5](https://github.com/nwchemgit/nwchem/issues/5)
Temporary fix: set the env. variable USE_ARUR=n, e.g.
```
make USE_ARUR=n
```
  Fix   available in  the branches master and hotfix/release-6-8

* _Moldenfile property bug when symmetry and linear dependencies are present_   
[https://github.com/nwchemgit/nwchem/issues/7](https://github.com/nwchemgit/nwchem/issues/7)
Workaround described in the issue entry