```
region  < [region1]  [region2]  [region3] >
```
This directive specifies active region(s) for optimization, dynamics,
frequency, and free energy calculations. Up to three regions can be
specified, those are limited to

  - "qm" - all quantum atoms <span id="qm">some text</span>
  - "qmlink" - quantum and link atoms <span id="qmlink"></span>
  - "mm\_solute" - all classical solute atoms excluding link atoms
  - "solute" - all solute atoms including quantum
  - "solvent" all solvent atoms
  - "mm" all classical solute and solvent atoms, excluding link atoms
  - "all" all atoms

Only the first region will be used in dynamics, frequency, and free
energy calculations. In the geometry optimizations, all three regions
will be optimized using the following optimization methods
```
    if (region.eq."qm") then  
       method = "bfgs"  
     else if (region.eq."qmlink") then  
       method = "bfgs"  
     else if (region.eq."mm_solute") then  
       method = "lbfgs"  
     else if (region.eq."mm") then  
       method = "sd"  
     else if (region.eq."solute") then  
       method = "sd"  
     else if (region.eq."solvent") then  
       method = "sd"  
     else if (region.eq."all") then  
       method = "sd"  
     end if
```
where "bfgs" stands for Broyden–Fletcher–Goldfarb–Shanno (BFGS)
optimization method, "lbfgs" limited memory version of quasi-newton, and
"sd" simple steepest descent algorithm. These assignments can be
potentially altered using [method](qmmm_method) directive.
