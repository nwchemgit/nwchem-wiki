# Example of QM/MM solvation free energy calculation input file

A total of two sampling cycles will be performed with 1000 samples per each cycle  

```
 memory total 2000 Mb
 
  start  clfoh
 
  permanent_dir  ./perm
  scratch_dir   /scratch
 
 
  md
  #this will require topology ([[media:clfoh.top|clfoh.top]]) and restart ([[media:clfoh_neb.rst|clfoh_neb.rst]]) files 
   system clfoh_neb
   cutoff 1.5 qmmm 1.5
   noshake solute
   isotherm
  end
 
  qmmm
  print low
  nsamples 1000
  ncycles 2
  end
 
  set qmmm:fep_geom [[media:clfoh_neb-s.xyzi|clfoh_neb-s.xyzi]] [[media:clfoh_neb-e.xyzi|clfoh_neb-e.xyzi]]
  set qmmm:fep_esp  [[media:clfoh_neb-s.esp|clfoh_neb-s.esp]] [[media:clfoh_neb-e.esp|clfoh_neb-e.esp]]
  set qmmm:fep_lambda 0.0 0.1
  set qmmm:fep_deriv .true.
 
  task qmmm fep
```