Experimental implementation of Nudged Elastic Band (NEB) method is
available for reaction pathway calculations with QM/MM. The actual
pathway/beads construction involves (by default) only the region
containing QM and link atoms (referred to as qmlink). The rest of the
system plays a passive role and is quenched/optimized each time a
gradient on a bead is calculated.

The initial guess for NEB pathway can be generated using geometries of
the starting and ending point provided by the .rst files. These are set
in the input using the following directive
```
set qmmm:neb_path_limits xxx_start.rst xxx_end.rst
```
where xxx_start.rst xxx_end.rst refers to starting and ending point of
the NEB pathway. Both rst files have to be present at the **top level**
directory. It should be noted that only coordinates of qmlink region
will be used from these two files. The initial coordinates for the rest
of the system come from reference rst file provided in the MD block
```
md
  system xxx_ref
  ...
end
```
Typically this reference restart file ( xxx_ref.rst ) would be a copy
of a restart file for starting or ending point.

The number of beads in the NEB pathway, initial optimization step size,
and number of optimization steps are set using the following directives
```
set neb:nbeads 10
set neb:stepsize 10
set neb:steps 20
```
The calculation starts by constructing initial guess for the pathway
(consisting of a sequence of numbered rst files) by combining linearly
interpolated coordinates of the qmlink regions from starting and ending
rst files and classical coordinates from the reference file. Next phase
involves calculation of the gradients on qmlink region atoms for each of
the beads. This involves two steps. First classical region around the
qmlink region is relaxed following standard QM/MM optimization protocol.
Aside the fact that optimization region cannot be qmlink, all other
optimization directives apply and should be set in the QM/MM block
following standard convention, e.g.
```
qmmm
 region  solvent
 maxiter 1000
 ncycles 1
 density espfit
end
```
or
```
qmmm
 region  mm_solute solvent
 maxiter 300          1000
 ncycles 3
 density espfit
end
```
In both examples presented above we utilized espfit option for density
to speed up calculations. **Note that optimization region cannot be
qmlink\!**

After the optimization has been performed the gradient on qmlink region
is calculated. The procedure is repeated for all the beads. After that
the bead coordinates will be advanced following NEB protocol and the
entire cycle will be repeated again.

In addition to interpolated initial guess, one can also specify custom
initial path represented by numbered sequence of restart files stored in
the **perm** directory. This behavior will be triggered automatically in
the absence of *qmmm:neb_path_limits* directive. The default naming of
the custom initial path is of the form <system>XXX.rst, where <system>
is the prefix of reference restart file as defined in MD block and XXX
is the 3-digit integer counter with zero blanks (001,002, ..., 010, 011,
..). If needed the prefix for the custom initial path can be adjusted
using

`set qmmm:neb_path `<string prefix>

The progress of NEB calculation can be monitored by
```
grep gnorm <output file>
```
Experience shows that the value of gnorm less or around O(10^-2)
indicates converged pathway. The current pathway in the XYZ format can
be found in the output file (look for XYZ FILE string) and viewed as
animation in some of the molecular viewers (e.g.
[JMOL](https://jmol.sourceforge.net/))

The entire example directory including the output file can be downloaded from [here](QMMM_NEB_example1.tar.gz). 
