```
 maxiter  [maxiter1] [maxiter2] [maxiter3]
```
This directive controls maximum number of iterations for the optimizations of regions as defined by by regions directive. User is strongly encouraged to set this directive explicitly as the default value shown below may not be appropriate in all the cases:
```
      if(region.eq."qm") then
        maxiter = 20
      else if (region.eq."qmlink") then
        maxiter = 20
      else if (region.eq."mm") then
        maxiter = 100
      else if (region.eq."solvent") then
        maxiter = 100
      else
        maxiter = 50
      end if
```
