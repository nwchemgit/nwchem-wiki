# QM/MM parameters

The QM/MM interface parameters define the interaction between classical
and quantum regions. 
```
 qmmm  
 [ [eref](qmmm_eref "wikilink") <double precision default 0.0d0>]  
 [ [bqzone](qmmm_bq_zone "wikilink") <double precision default 9.0d0>]  
 [ [mm_charges](qmmm_mm_charges "wikilink") [exclude <(none||all||linkbond||linkbond_H) default none>]  
          [ expand  <none||all||solute||solvent> default none]  
          [ update  <integer default 0>]   
 [ [link_atoms](qmmm_link_atoms "wikilink") <(hydrogen||halogen) default hydrogen>]  
 [ [link_ecp](qmmm_link_ecp "wikilink")  <(auto||user) default auto>]  
 [ [region](qmmm_region "wikilink")   < [region1]  [region2]  [region3] > ]  
 [ [method](qmmm_method "wikilink")   [method1]  [method2]  [method3]  ]  
 [ [maxiter](qmmm_maxiter "wikilink")  [maxiter1] [maxiter2] [maxiter3] ]  
 [ [ncycles](qmmm_ncycles "wikilink")  < [number] default 1 > ]  
 [ [density](qmmm_density "wikilink")  [espfit] [static] [dynamical] ]  
 [ [xyz](qmmm_xyz "wikilink")  ]  
 [ [convergence](qmmm_convergence "wikilink") <double precision default 1.0d-4>] ]  
 [ [load](qmmm_load "wikilink") ]  
 [ [nsamples](qmmm_nsamples "wikilink") ]  
 end
```
 Detailed explanation of the subdirectives in the QM/MM
input block is given below:

Detailed explanation of the subdirectives in the QM/MM input block is given below:

[qmmm_eref](qmmm_eref)

[qmmm_bq_zone](qmmm_bq_zone)

[qmmm_mm_charges](qmmm_mm_charges)

[qmmm_link_atoms](qmmm_link_atoms)

[qmmm_link_ecp](qmmm_link_ecp)

[qmmm_region](qmmm_region)

[qmmm_method](qmmm_method)

[qmmm_maxiter](qmmm_maxiter)

[qmmm_ncycles](qmmm_ncycles)

[qmmm_density](qmmm_density)

[qmmm_load](qmmm_load)

[qmmm_convergence](qmmm_convergence)

[qmmm_nsamples](qmmm_nsamples)
