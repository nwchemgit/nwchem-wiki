# Geometry Optimization

## Geometry Optimization with DRIVER

The DRIVER module is one of two drivers (also see documentation on
[STEPPER](#geometry-optimization-with-stepper))
to perform a geometry optimization function on the molecule defined by
input using the [GEOMETRY](Geometry.md) directive.
Geometry optimization is either an energy minimization or a transition
state optimization. The algorithm programmed in DRIVER is a quasi-newton
optimization with line searches and approximate energy Hessian updates.

DRIVER is selected by default out of the two available modules to
perform geometry optimization. In order to force use of DRIVER (e.g.,
because a previous optimization used STEPPER) provide a DRIVER input
block (below) -- even an empty block will force use of DRIVER.

Optional input for this module is specified within the compound
directive,
```
 DRIVER   
   (LOOSE || DEFAULT || TIGHT)  
   GMAX <real value>  
   GRMS <real value>  
   XMAX <real value>  
   XRMS <real value>  
   EPREC <real eprec default 1e-7>  
   TRUST <real trust default 0.3>  
   SADSTP <real sadstp default 0.1>  
   CLEAR  
   REDOAUTOZ  
   INHESS <integer inhess default 0>  
   (MODDIR || VARDIR) <integer dir default 0> 
   (FIRSTNEG || NOFIRSTNEG)  
   MAXITER <integer maxiter default 20>  
   BSCALE <real BSCALE default 1.0>` 
   ASCALE <real ASCALE default 0.25>  
   TSCALE <real TSCALE default 0.1> 
   HSCALE <real HSCALE default 1.0> 
      PRINT ... 
   XYZ <string xyz default *file_prefix*>]  
   NOXYZ  
   SOCKET (UNIX || IPI_CLIENT) <string socketname default (see input description)>  
 END
```
On each optimization step a line search is performed. To speed up
calculations (up to two times), it may be beneficial to turn off the
line search using following directive:
```
 set driver:linopt 0
```
### Convergence criteria
```
   (LOOSE || DEFAULT || TIGHT)  
   GMAX <real value>  
   GRMS <real value>  
   XMAX <real value>  
   XRMS <real value>
```
The defaults may be used, or the directives LOOSE, DEFAULT, or TIGHT
specified to use standard sets of values, or the individual criteria
adjusted. All criteria are in atomic units. GMAX and GRMS control the
maximum and root mean square gradient in the coordinates being used
(Z-matrix, redundant internals, or Cartesian). XMAX and XRMS control the
maximum and root mean square of the Cartesian step.

|      | LOOSE   | DEFAULT | TIGHT    |
|------|---------|---------|----------|
| GMAX | 0.00450 | 0.00045 | 0.000015 |
| GRMS | 0.00300 | 0.00030 | 0.00001  |
| XMAX | 0.01800 | 0.00180 | 0.00006  |
| XRMS | 0.01200 | 0.00120 | 0.00004  |

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
### Available precision
```
   EPREC <real eprec default 1e-7>
```
In performing a line search the optimizer must know the precision of the
energy (this has nothing to do with convergence criteria). The default
value of 1e-7 should be adjusted if less, or more, precision is
available. Note that the default EPREC for DFT calculations is 5e-6
instead of 1e-7.

### Controlling the step length

```
   TRUST <real trust default 0.3>
   SADSTP <real sadstp default 0.1>
```

A fixed trust radius (trust) is used to control the step during
minimizations, and is also used for modes being minimized during
saddle-point searches. It defaults to 0.3 for minimizations and 0.1 for
saddle-point searches. The parameter sadstp is the trust radius used for
the mode being maximized during a saddle-point search and defaults to
0.1.

### Maximum number of steps
```
   MAXITER <integer maxiter default 20>
```
By default at most 20 geometry optimization steps will be taken, but
this may be modified with this directive.

### Discard restart information

```
   CLEAR
```

By default Driver reuses Hessian information from a previous
optimization, and, to facilitate a restart also stores which mode is
being followed for a saddle-point search. This option deletes all
restart data.

### Regenerate internal coordinates

```
   REDOAUTOZ
```

Deletes Hessian data and regenerates internal coordinates at the current
geometry. Useful if there has been a large change in the geometry that
has rendered the current set of coordinates invalid or non-optimal.

### Initial Hessian

```
   INHESS <integer inhess default 0>
```

  - 0 = Default ... use restart data if available, otherwise use
    diagonal guess.
  - 1 = Use diagonal initial guess.
  - 2 = Use restart data if available, otherwise transform Cartesian
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

### Mode or variable to follow to saddle point
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
specific internal variable (using the directive VARDIR) or along a
specific eigen-mode (using MODDIR). Following a variable might be
valuable if the initial gradient is either very small or very large.
Note that the eigen-modes in the optimizer have next-to-nothing to do
with the output from a frequency calculation. You can examine the
eigen-modes used by the optimizer with

```
  driver; print hvecs; end
```

The selection of the first negative mode is usually a good choice if the
search is started in the vicinity of the transition state and the
initial search direction is satisfactory. However, sometimes the first
negative mode might not be the one of interest (e.g., transverse to the
reaction direction). If NOFIRSTNEG is specified, the code will not take
the first negative direction and will continue doing mode-following
until that mode goes negative.

### Optimization history as XYZ files
```
   XYZ [<string xyz default $fileprefix>] 
   NOXYZ
```
The XYZ directive causes the geometry at each step (but not intermediate
points of a line search) to be output into separate files in the
permanent directory in XYZ format. The optional string will prefix the
filename. The NOXYZ directive turns this off.

For example, the input
```
   driver; xyz test; end
```
will cause files test-000.xyz, test-001.xyz, ... to be created in the
permanent directory.

The script rasmolmovie in the NWChem contrib directory can be used to
turn these into an animated GIF movie.


### i-PI Socket communication
```
   SOCKET (UNIX || IPI_CLIENT) <string socketname default (see input description)>  
```
The SOCKET directive enables NWChem to communicate with other software
packages -- such as [i-PI](http://ipi-code.org/) or
[ASE](https://wiki.fysik.dtu.dk/ase/ase/calculators/socketio/socketio.html) -- via the i-PI socket protocol.

Communication is done either over Unix sockets (`SOCKET UNIX`) or IP
sockets (`SOCKET IPI_CLIENT`):

  - Unix sockets - NWChem will create and bind to a UNIX socket
    file located at `/tmp/ipi_<socketname>`. If not specified,
    `<socketname>` will default to `nwchem`.
  - IP sockets - NWChem will bind to the IP address and port
    specified by `<socketname>`. If not specified, `<socketname>`
    will default to `127.0.0.1:31415`.

The `SOCKET` directive is only useful when used in conjunction with other
software packages that support communication via the i-PI socket
protocol. For more information, see the
[i-PI documentation](https://ipi-code.org/i-pi/user-guide.html#communication-protocol).

### Print options

The UNIX command "egrep '^@' \< output" will extract a pretty table
summarizing the optimization.

If you specify the NWChem input
```
     scf; print none; end  
     driver; print low; end  
     task scf optimize
```
you'll obtain a pleasantly terse output.

For more control, these options for the standard print directive are
recognized

  - debug - prints a large amount of data. Don't use in parallel.
  - high - print the search direction in internals
  - default - prints geometry for each major step (not during the line
    search), gradient in internals (before and after application of
    constraints)
  - low - prints convergence and energy information. At convergence
    prints final geometry, change in internals from initial geometry

and these specific print options

  - finish (low) - print geometry data at end of calculation
  - bonds (default) - print bonds at end of calculation
  - angles (default) - print angles at end of calculation
  - hvecs (never) - print eigen-values/vectors of the Hessian
  - searchdir (high) - print the search direction in internals
  - "internal gradient" (default) - print the gradient in internals
  - sadmode (default) - print the mode being followed to the saddle
    point

## Geometry Optimization with STEPPER

The STEPPER module performs a search for critical points on the
potential energy surface of the molecule defined by input using the
[GEOMETRY](Geometry.md) directive. Since STEPPER is
not the primary geometry optimization module in NWChem the compound
directive is required; the
[DRIVER](#geometry-optimization-with-driver) module is the
default. Input for this module is specified within the compound
directive,
```
 STEPPER  
   ...  
 END
```
The presence of the STEPPER compound directive automatically turns off
the default geometry optimization tool DRIVER. Input specified for the
STEPPER module must appear in the input file after the GEOMETRY
directive, since it must know the number of atoms that are to be used in
the geometry optimization. In the current version of NWChem, STEPPER can
be used only with geometries that are defined in Cartesian coordinates.
STEPPER removes translational and rotational components before
determining the step direction (5 components for linear systems and 6
for others) using a standard Eckart algorithm. The default initial guess
nuclear Hessian is the identity matrix.

The default in STEPPER is to minimize the energy as a function of the
geometry with a maximum of 20 geometry optimization iterations. When
this is the desired calculation, no input is required other than the
STEPPER compound directive. However, the user also has the option of
defining different tasks for the STEPPER module, and can vary the number
of iterations and the convergence criteria from the default values. The
input for these options is described in the following sections.

### MIN and TS: Minimum or transition state search

The default is for STEPPER to minimize the energy with respect to the
geometry of the system. This default behavior may be forced with the
directive
```
 MIN
```
STEPPER can also be used to find the transition state by following the
lowest eigenvector of the nuclear Hessian. This is usually invoked by
using the saddle keyword on the [TASK
directive](Top-level#TASK), but it may also be
selected by specifying the directive
```
 TS
```
in the STEPPER input.

### TRACK: Mode selection

STEPPER has the ability to \`\`track'' a specific mode during an
optimization for a transition state search, the user can also have the
module track the eigenvector corresponding to a specific mode. This is
done by specifying the directive
```
 TRACK [nmode <integer nmode default 1>]
```
The keyword TRACK tells STEPPER to track the eigenvector corresponding
to the integer value of <nmode> during a transition state walk. (Note:
this input is invalid for a minimization walk since following a specific
eigenvector will not necessarily give the desired local minimum.) The
step is constructed to go up in energy along the nmode eigenvector and
down in all other degrees of freedom.

### MAXITER: Maximum number of steps

In most applications, 20 stepper iterations will be sufficient to obtain
the energy minimization. However, the user has the option of specifying
the maximum number of iterations allowed, using the input line,
```
 MAXITER <integer maxiter default 20>
```
The value specified for the integer <maxiter> defines the maximum number
of geometry optimization steps. The geometry optimization will restart
automatically.

### TRUST: Trust radius

The size of steps that can be taken in STEPPER is controlled by the
trust radius which has a default value of 0.1. Steps are constrained to
be no larger than the trust radius. The user has the option of
overriding this default using the keyword TRUST, with the following
input line,
```
 TRUST <real radius default 0.1>
```
The larger the value specified for the variable radius, the larger the
steps that can be taken by STEPPER. Experience has shown that for larger
systems (i.e., those with 20 or more atoms), a value of 0.5, or greater,
usually should be entered for <radius>.

### CONVGGM, CONVGG and CONVGE: Convergence criteria

Three convergence criteria can be specified explicitly for the STEPPER
calculations. The keyword CONVGGM allows the user to specify the
convergence tolerance for the largest component of the gradient. This is
the primary convergence criterion, as per the default settings, although
all three criteria are in effect. this default setting is consistent
with the other optimizer module DRIVER. The input line for CONVGGM has
the following form,
```
  CONVGGM <real convggm default 8.0d-04>
```
The keyword CONVGG allows the user to specify the convergence tolerance
for the gradient norm for all degrees of freedom. The input line is of
the following form,
```
  CONVGG <real convgg default 1.0d-02>
```
The entry for the real variable <convgg> should be approximately equal
to the square root of the energy convergence tolerance.

The energy convergence tolerance is the convergence criterion for the
energy difference in the geometry optimization in STEPPER. It can be
specified by input using a line of the following form,
```
  CONVGE <real convge default 1.0d-04>
```
### Backstepping in STEPPER

If a step taken during the optimization is too large (e.g., the step
causes the energy to go up for a minimization or down for a transition
state search), the STEPPER optimizer will automatically "backstep"
and correct the step based on information prior to the faulty step. If
you have an optimization that "backsteps" frequently then the initial
trust radius should most likely be decreased.

### Initial Nuclear Hessian Options

Stepper uses a modified Fletcher-Powell algorithm to find the transition
state or energy minimum on the potential energy hypersurface.  
There are
two files left in the user's permanent directory that are used to
provide an initial hessian to the critical point search algorithm. If
these files do not exist then the default is to use a unit matrix as the
initial hessian.  
Once Stepper executes it generates a binary dump file
by the name of `name.stpr41` which will be used on all subsequent stepper
runs and modified with the current updated hessian. The default file
prefix is the "name" that is used (see
[START](Start_Restart.md)).
It also stores the information for the last valid step in case the
algorithm must take a ["backstep"](#backstepping-in-stepper).
This file is the working data store for all stepper-based optimizations.
This file is never deleted by default and is the first source of an
initial hessian.  
The second source of an initial hessian is an ASCII file
that contains the lower triangular values of the initial hessian. This
is stored in file `name.hess`, where "name" is again the default file
prefix. This is the second source of an initial hessian and is the
method used to incorporate an initial hessian from any other source
(e.g., another ab initio code, a molecular mechanics code, etc.,). To
get a decent starting hessian at a given point you can use the task
specification task scf hessian, with a smaller basis set, which will by
default generate the `name.hess` file. Then you may define your basis set
of choice and proceed with the optimization you desire.
