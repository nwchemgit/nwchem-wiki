The QM/MM interface
parameters define the interaction between classical and quantum
regions.
```
 qmmm  
 [ [eref](qmmm_eref) <double precision default 0.0d0>]  
 [ [bqzone](qmmm_bq_zone) <double precision default 9.0d0>]  
 [ [mm_charges](qmmm_mm_charges) [exclude <(none||all||linkbond||linkbond_H) default none>]  
          [ expand  <none||all||solute||solvent> default none]  
          [ update  <integer default 0>]   
 [ [link_atoms](qmmm_link_atoms) <(hydrogen||halogen) default hydrogen>]  
 [ [link_ecp](qmmm_link_ecp)  <(auto||user) default auto>]  
 [ [region](Qmmm_region)   < [region1]  [region2]  [region3] > ]  
 [ [method](qmmm_method)   [method1]  [method2]  [method3]  ]  
 [ [maxiter](Qmmm_maxiter)  [maxiter1] [maxiter2] [maxiter3] ]  
 [ [ncycles](Qmmm_ncycles)  < [number] default 1 > ]  
 [ [density](Qmmm_density)  [espfit] [static] [dynamical] ]  
 [ [xyz](Qmmm_xyz)  ]  
 [ [convergence](Qmmm_convergence) <double precision default 1.0d-4>] ]  
 [ [rename](Qmmm_rename) ] <filename>  
 [ [nsamples](Qmmm_nsamples) ]  
 end
```

Detailed explanation of the subdirectives in the QM/MM input block is
given below:

[qmmm_eref](qmmm_eref)

[qmmm_bq_zone](qmmm_bq_zone)

[qmmm_mm_charges](qmmm_mm_charges)

[qmmm_link_atoms](qmmm_link_atoms)

[qmmm_link_ecp](qmmm_link_ecp)

[Qmmm_region](Qmmm_region)

[qmmm_method](qmmm_method)

[Qmmm_maxiter](Qmmm_maxiter)

[Qmmm_ncycles](Qmmm_ncycles)

[Qmmm_density](Qmmm_density)

[Qmmm_rename](Qmmm_rename)

[Qmmm_convergence](Qmmm_convergence)

[Qmmm_nsamples](Qmmm_nsamples)
