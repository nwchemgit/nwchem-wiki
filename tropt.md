## TROPT

The TROPT module is one of three drivers (see Section
[Stepper](Geometry-Optimization#geometry-optimization-with-stepper)
for documentation on STEPPER and Section
[Driver module](Geometry-Optimization#geometry-optimization-with-DRIVER)
for documentation on DRIVER) to perform a geometry optimization function
on the molecule defined by input using the `GEOMETRY` directive (see
Section [Geometry](Geometry)).
Geometry optimization is either an energy minimization or a transition
state optimization. The algorithm programmed in TROPT is a trust region
quasi-newton optimization and approximate energy Hessian updates.

TROPT is **not** selected by default out of the two available modules to
perform geometry optimization. In order to force use of TROPT (e.g.,
because a previous optimization used STEPPER or DRIVER) provide a TROPT
input block (below) — even an empty block will force use of TROPT.

Optional input for this module is specified within the compound
directive,
```
      TROPT 
        (LOOSE || DEFAULT || TIGHT)
        GMAX <real value>
        GRMS <real value>
        XMAX <real value>
        XRMS <real value>

        OPTTOL <real opttol default 3e-4>

        EPREC <real eprec default 1e-7>

        TRUST <real trust default 0.3>

        CLEAR
        REDOAUTOZ

        INHESS <integer inhess default 0>

        (MODDIR || VARDIR) <integer dir default 0>
        (FIRSTNEG || NOFIRSTNEG)

        MAXITER <integer maxiter default 20>

        BSCALE <real BSCALE default 1.0>
        ASCALE <real ASCALE default 0.25>
        TSCALE <real TSCALE default 0.1>
        HSCALE <real HSCALE default 1.0>
       
        PRINT ...

        XYZ [<string xyz default $file_prefix$>]
        NOXYZ

      END
```
###Convergence criteria
```
        (LOOSE || DEFAULT || TIGHT)
        GMAX <real value>
        GRMS <real value>
        XMAX <real value>
        XRMS <real value>
        
        OPTTOL  <real value>
```        

The defaults may be used, or the directives `LOOSE`, `DEFAULT`, or
`TIGHT` specified to use standard sets of values, or the individual
criteria adjusted. All criteria are in atomic units. `GMAX` and `GRMS`
control the maximum and root mean square gradient in the coordinates
being used (Z-matrix, redundant internals, or Cartesian). `XMAX` and
`XRMS` control the maximum and root mean square of the Cartesian step.
```
                      LOOSE    DEFAULT    TIGHT
             GMAX   0.0045d0   0.00045   0.000015   
             GRMS   0.0030d0   0.00030   0.00001
             XMAX   0.0054d0   0.00180   0.00006
             XRMS   0.0036d0   0.00120   0.00004
```
Additionally the user may request a specific value for the tolerance
with the keyword `OPTTOL` which will couple all the convergence criteria
in the following way:
```
             GRMS   1.0*OPTTOL
             GMAX   1.5*OPTTOL
             XRMS   4.0*OPTTOL
             XMAX   6.0*OPTTOL
```
Note that GMAX and GRMS used for convergence of geometry may
significantly vary in different coordinate systems such as Z-matrix,
redundant internals, or Cartesian. The coordinate system is defined in
the input file (default is Z-matrix). Therefore the choice of coordinate
system may slightly affect converged energy. Although in most cases XMAX
and XRMS are last to converge which are always done in Cartesian
coordinates, which insures convergence to the same geometry in different
coordinate systems.

The old criterion may be recovered with the input
```
       gmax 0.0008; grms 1; xrms 1; xmax 1
```
###Available precision
```
        EPREC <real eprec default 1e-7>
```
In performing a trust region optimization the precision of the energy is
coupled to the convergence criteria. As mentioned above in most cases
XMAX and XRMS are last to converge, thus, an accelerated converge is
triggered in TROPT when GMAX and GRMS are already converged and the
corresponding energy change with respect to the previous point is below
the EPREC threshold, then, the structure is treated as optimized. This
is used as an accelerated convergence criteria to avoid long tail in the
optimization process. This will increase the speed of an optimization in
most of the cases but it will be somehow cumbersome when dealing with
flat energy surfaces, in this case a more tight EPREC value is
recommended. Note that the default EPREC for DFT calculations is 5e-6
instead of 1e-7.

###Controlling the step length
```
        TRUST <real trust default 0.3>
```
A dynamic trust radius (`trust`) is used to control the step during
optimization processes both minimization and saddle-point searches. It
defaults to 0.3 for minimizations and 0.1 for saddle-point searches.

###Backstepping in TROPT

If a step taken during the optimization is too large or in the wrong
direction (e.g., the step causes the energy to go up for a
minimization), the TROPT optimizer will automatically “backstep” and
reduce the current value of the trust radius in order to avoid a
permanent “backsteping”.

###Maximum number of steps
```
        MAXITER <integer maxiter default 20>
```
By default at most 20 geometry optimization steps will be taken, but
this may be modified with this directive.

###Discard restart information
```
        CLEAR
```
By default TROPT reuses Hessian information from a previous
optimization, and, to facilitate a restart also stores which mode is
being followed for a saddle-point search. This option deletes all
restart data.

###Regenerate internal coordinates
```
        REDOAUTOZ
```
Deletes Hessian data and regenerates internal coordinates at the current
geometry. Useful if there has been a large change in the geometry that
has rendered the current set of coordinates invalid or non-optimal.

###Initial Hessian
```
        INHESS <integer inhess default 0>
```
-   0 = Default ... use restart data if available, otherwise use
    diagonal guess.

-   1 = Use diagonal initial guess.

-   2 = Use restart data if available, otherwise transform Cartesian
    Hessian from previous frequency calculation.

In addition, the diagonal elements of the initial Hessian for internal
coordinates may be scaled using separate factors for bonds, angles and
torsions with the following
```
        BSCALE <real bscale default 1.0>
        ASCALE <real ascale default 0.25>
        TSCALE <real tscale default 0.1>
```
These values typically give a two-fold speedup over unit values, based
on about 100 test cases up to 15 atoms using 3-21g and 6-31g\* SCF.
However, if doing many optimizations on physically similar systems it
may be worth fine tuning these parameters.

Finally, the entire Hessian from any source may be scaled by a factor
using the directive
```
        HSCALE <real hscale default 1.0>
```
It might be of utility, for instance, when computing an initial Hessian
using SCF to start a large MP2 optimization. The SCF vibrational modes
are expected to be stiffer than the MP2, so scaling the initial Hessian
by a number less than one might be beneficial.

###Mode or variable to follow to saddle point
```
        (MODDIR || VARDIR) <integer dir default 0>
        (FIRSTNEG || NOFIRSTNEG)
```
When searching for a transition state the program, by default, will take
an initial step uphill and then do mode following using a fuzzy maximum
overlap (the lowest eigen-mode with an overlap with the previous search
direction of 0.7 times the maximum overlap is selected). Once a negative
eigen-value is found, that mode is followed regardless of overlap.

The initial uphill step is appropriate if the gradient points roughly in
the direction of the saddle point, such as might be the case if a
constrained optimization was performed at the starting geometry.
Alternatively, the initial search direction may be chosen to be along a
specific internal variable (using the directive `VARDIR`) or along a
specific eigen-mode (using `MODDIR`). Following a variable might be
valuable if the initial gradient is either very small or very large.
Note that the eigen-modes in the optimizer have next-to-nothing to do
with the output from a frequency calculation. You can examine the
eigen-modes used by the optimizer with

             tropt; print hvecs; end

The selection of the first negative mode is usually a good choice if the
search is started in the vicinity of the transition state and the
initial search direction is satisfactory. However, sometimes the first
negative mode might not be the one of interest (e.g., transverse to the
reaction direction). If `NOFIRSTNEG` is specified, the code will not
take the first negative direction and will continue doing mode-following
until that mode goes negative.

###Optimization history as XYZ file
```
        XYZ [<string xyz default $fileprefix>]
        NOXYZ
```
The `XYZ` directive causes the geometry at each step to be output into
file in the permanent directory in XYZ format. The optional string will
prefix the filename. The `NOXYZ` directive turns this off.

For example, the input
```
        tropt; xyz ; end
```
will cause a trajectory file filename.xyz to be created in the permanent
directory.

###Print options

The UNIX command `"egrep '^@' < output"` will extract a pretty table
summarizing the optimization.

If you specify the NWChem input
```
          scf; print none; end
          tropt; print low; end
          task scf optimize
```
you’ll obtain a pleasantly terse output.

For more control, these options for the standard print directive are
recognized

-   `debug` - prints a large amount of data. Don’t use in parallel.

-   `high` - print the search direction in internals

-   `default` - prints geometry for each major step (not during the line
    search), gradient in internals (before and after application of
    constraints)

-   `low` - prints convergence and energy information. At convergence
    prints final geometry, change in internals from initial geometry

and these specific print options

-   `finish` (low) - print geometry data at end of calculation

-   `bonds` (default) - print bonds at end of calculation

-   `angles` (default) - print angles at end of calculation

-   `hvecs` (never) - print eigen-values/vectors of the Hessian

-   `searchdir` (high) - print the search direction in internals

-   ‘`internal gradient`’ (default) - print the gradient in internals

-   `sadmode` (default) - print the mode being followed to the saddle
    point
