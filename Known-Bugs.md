Use our "issue tracker":http://github.com/nwchemgit/nwchem to report new bugs. 

Also check there for other issues that may not have made it into these lists. 

See [[FAQ]] for solutions to common issues.

##  Known bugs for NWChem 6.8

* _AR failure on Mac OSX_   
https://github.com/nwchemgit/nwchem/issues/5  
Temporary fix: set the env. variable USE_ARUR=n, e.g.
```
make USE_ARUR=n
```
  Fix   available in  the branches master and hotfix/release-6-8

* _Moldenfile property bug when symmetry and linear dependencies are present_   
https://github.com/nwchemgit/nwchem/issues/7  
Workaround described in the issue entry