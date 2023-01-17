# QM/MM parameters

The QM/MM interface parameters define the interaction between classical
and quantum regions. 
```
 qmmm  
 [ [eref] <double precision default 0.0d0>]  
 [ [bqzone] <double precision default 9.0d0>]  
 [ [mm_charges] [exclude <(none||all||linkbond||linkbond_H) default none>]  
          [ expand  <none||all||solute||solvent> default none]  
          [ update  <integer default 0>]   
 [ [link_atoms] <(hydrogen||halogen) default hydrogen>]  
 [ [link_ecp]  <(auto||user) default auto>]  
 [ [region]   < [region1]  [region2]  [region3] > ]  
 [ [method]   [method1]  [method2]  [method3]  ]  
 [ [maxiter]  [maxiter1] [maxiter2] [maxiter3] ]  
 [ [ncycles]  < [number] default 1 > ]  
 [ [density]  [espfit] [static] [dynamical] ]  
 [ [xyz]  ]  
 [ [convergence] <double precision default 1.0d-4>] ]  
 [ [load] ]  
 [ [nsamples] ]  
 end
```

Detailed explanation of the subdirectives in the QM/MM input block is given below:  

### QM/MM eref
```
eref <double precision default 0.0d0>
```
This directive sets the relative zero of energy for the QM component of
the system. The need for this directive arises from different
definitions of zero energy for QM and MM methods. In QM methods the zero
of energy for the system is typically vacuum. The zero of energy for the
MM system is by definition of most parameterized force fields the
separated atom energy. Therefore in many cases the energetics of the QM
system will likely overshadow the MM component of the system. This
imbalance can be corrected by suitably chosen value of `eref`. In most
cases *IT IS OK* to leave `eref` at its default value of zero.

### QM/MM bqzone

```
bqzone <double precision default 9.0d0>
```
This directive defines the radius of the zone (in angstroms) around the
quantum region where classical residues/segments will be allowed to
interact with quantum region both electrostatically and through Van der
Waals interactions. It should be noted that classical atoms interacting
with quantum region via bonded interactions are always included (this is
true even if bqzone is set to 0). In addition, even if one atom of a
given charged group is in the bqzone (residues are typically treated as
one charged group) then the whole group will be included.

### QM/MM mm_charges

```
mm_charges [exclude <(none||all||linkbond||linkbond_H) default none>]
           [expand  <none||all||solute||solvent> default none]
           [update  <integer default 0>]
```
This directive controls treatment of classical point (MM) charges that
are interacting with QM region. For most QM/MM applications the use of
directive will be not be necessary. Its absence would be simply mean
that all MM charges within the cuttof distance ( as specified by cutoff
) as well those belonging to the charges groups directly bonded to QM
region will be allowed to interact with QM region.

Keyword `exclude` specifies the subset MM charges that will be
specifically excluded from interacting with QM region.

  - `none` default value reverts to the original set of MM charges as
    described above.
  - `all` excludes all MM charges from interacting with QM region ("gas
    phase" calculation).
  - `linkbond` excludes MM charges that are connected to a quantum region
    by at most two bonds,
  - `linkbond_H` similar to `linkbond` but excludes only hydrogen atoms.

Keyword `expand` expands the set MM charges interacting with QM region
beyond the limits imposed by cutoff value.

  - `none` default value reverts to the original set of MM charges
  - `solute` expands electrostatic interaction to all solute MM charges
  - `solvent` expands electrostatic interaction to all solvent MM charges
  - `all` expands electrostatic interaction to all MM charges

Keyword `update` specifies how often list of MM charges will be updated in
the course of the calculation. Default behavior is not to update.

### QM/MM link_atoms

```
link_atoms <(hydrogen||halogen) default halogen>
```
This directive controls the treatment of bonds crossing the boundary
between quantum and classical regions. The use of hydrogen keyword will
trigger truncation of such bonds with hydrogen link atoms. The position
of the hydrogen atom will be calculated from the coordinates of the
quantum and classical atom of the truncated bond using the following
expression

$$\mathbf{R}_{hlink} = (1-g)\mathbf{R}_{quant} + g*\mathbf{R}_{class}$$

where *g* is the scale factor set at 0.709

Setting `link_atoms` to `halogen` will result in the modification of the
quantum atom of the truncated bond to the fluoride atom. This
fluoride atom will typically carry an effective core potential (ECP)
basis set as specified in [`link_ecp`](#qmmm-link_ecp) directive.

### QM/MM link_ecp

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

### QM/MM region

```
region  < [region1]  [region2]  [region3] >
```
This directive specifies active region(s) for optimization, dynamics,
frequency, and free energy calculations. Up to three regions can be
specified, those are limited to

  - `qm` - all quantum atoms 
  - `qmlink` - quantum and link atoms <span id="qmlink"></span>
  - `mm_solute` - all classical solute atoms excluding link atoms
  - `solute` - all solute atoms including quantum
  - `solvent` all solvent atoms
  - `mm` all classical solute and solvent atoms, excluding link atoms
  - `all` all atoms

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

### QM/MM method

```
  method   [method1]  [method2]  [method3]
```

This directive controls which optimization algorithm will be used for the regions as defined by [[qmmm_region|Qmmm_region]] directive.
The allowed values are `bfgs` aka [DRIVER](Geometry-Optimization#geometry-optimization-with-driver),
`lbfgs` limited memory version of quasi-newton,
and `sd` simple steepest descent algorithm.
The use of this directive is not recommended in all but special cases. In particular, 
`bfgs` should be used for QM region if there are any constraints,
`sd` method should always be used for classical solute and solvent atoms with shake constraints.


### QM/MM maxiter

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


### QM/MM ncycles

```
 ncycles  < [number] default 1 >
```
This directive controls the number of optimization cycles where the defined regions will be optimized in succession, or number of sampling cycles in free energy calculations.


### QM/MM density

```
density  [espfit] [static] [dynamical] default dynamical
```
This directive controls the electrostatic representation of *fixed* QM
region during optimization/dynamics of classical regions. It has no
effect when position of QM atoms are changing.

  - **dynamical** is an option where QM region is treated the standard
    way, through the recalculation of the wavefunction calculated and
    the resulting electron density is used to compute electrostatic
    interactions with classical atoms. This option is the most expensive
    one and becomes impractical for large scale optimizations.


  - **static** option will not recalculate QM wavefunction but will
    still use full electron density in the computations of electrostatic
    interactions.


  - **espfit** option will not recalculate QM wavefunction nor it will
    use full electron density. Instead, a set of ESP charges for QM
    region will be calculated and used to compute electrostatic
    interactions with the MM regions. This option is the most efficient
    and is strongly recommended for large systems.

Note that both "static" and "espfit" options do require the presence of
the movecs file. It is typically available as part as part of
calculation process. Otherwise it can be generated by running qmmm
energy calculation.

In most calculations default value for **density** would **dynamical**,
with the exception of free energy calculations where default setting
**espfit** will be used.

### QM/MM load

```
load < esp > [<filename>]
```
This directive instructs to load external file (located in permanent
directory) containing esp charges for QM region. If filename is not
provided it will be constructed from the name of the restart file by
replacing ".rst" suffix with ".esp". Note that file containing esp
charges is always generated whenever esp charge calculation is performed

### QM/MM convergence

```
convergence  < double precision etol default 1.0d-4>
```
This directive controls convergence of geometry optimization. The
optimization is deemed converged if absolute difference in total
energies between consecutive optimization cycles becomes less than
*etol*.

### QM/MM nsamples

```
nsamples
```
This directive is required for [free energy
calculations](QMMM_Free_Energy#nsamples) and defines number
of samples for averaging during single cycle.

