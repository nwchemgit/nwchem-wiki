```
  method   [method1]  [method2]  [method3]
```

This directive controls which optimization algorithm will be used for the regions as defined by [[qmmm_region|Qmmm_region]] directive. The allowed values are "bfgs" aka [[DRIVER|driver]], "lbfgs" limited memory version of quasi-newton, and "sd" simple steepest descent algorithm. The use of this directive is not recommended in all but special cases. In particular, 
"bfgs" should be used for QM region if there are any constraints, "sd" method should always be used for classical solute and solvent atoms with shake constraints.
