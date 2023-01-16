
```
link_ecp <(auto||user)default auto> 
```
This directive specifies ECP basis set on fluoride link atoms. If set to
auto the ECP basis set given by Zhang, Lee, Yang for 6-31G* basis
will be used. Strictly speaking, this implies the use of 6-31G*
spherical basis as the main basis set. If other choices are desired then
keyword user should be used and ECP basis set should be entered
separatelly following the format given in section dealing with [ECPs](ECP.md) .
The name tag for fluoride link atoms is `F_L`.
