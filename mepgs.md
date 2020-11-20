## MEPGS


The MEPGS module performs a search for the two critical points on the
potential energy surface connected to a saddle point of the molecule
defined by input using the `GEOMETRY` directive (see Section
[geometry](Geometry) ).
The algorithm programmed in MEPGS is a **constrained** trust region
quasi-newton optimization and approximate energy Hessian updates.

Optional input for this module is specified within the compound
directive,
```
      MEPGS 
        OPTTOL <real opttol default 3e-4>
        EPREC <real eprec default 1e-7>
        STRIDE <real stride default 0.1>
        EVIB <real evib default 1e-4>
        MAXMEP <integer maxiter default 250>
        MAXITER <integer maxiter default 20>
        INHESS <integer inhess default 2>
        (BACKWARD || FORWARD) <string default both>
        (MSWG || NOMSWG) <string default NOMSWG>
        (XYZ || NOXYZ) 
      END
```
### Convergence criteria

The user may request a specific value for the tolerance with the keyword
`OPTTOL` which will couple all the convergence criteria in the following
way:
```
             GRMS   1.0*OPTTOL
             GMAX   1.5*OPTTOL
             XRMS   4.0*OPTTOL
             XMAX   6.0*OPTTOL
```
### Available precision

        EPREC <real eprec default 1e-7>

In performing a constrained trust region optimization the precision of
the energy is coupled to the convergence criteria (see Section
[TROPT](tropt) ).
Note that the default EPREC for DFT calculations is 5e-6 instead of 1e-7.

### Controlling the step length
```
        STRIDE <real stride default 0.1>
```
A dynamic stride (`stride`) is used to control the step length during
the minimum energy path walking when taking the Euler step as starting
point.

### Moving away from the saddle point
```
        EVIB <real evib default 1e-4>
```
The expected decrease in energy (`evib`) assuming a quadratic
approximation around the saddle structure to be obtained.

### Maximum number of MEPGS steps
```
        MAXMEP <integer maxmep default 250>
```
By default at most 250 minimum energy path steps will be taken, but this
may be modified with this directive.

###Maximum number of steps
```
        MAXITER <integer maxiter default 20>
```
By default at most 20 **constrained** geometry optimization steps will
be taken, but this may be modified with this directive.

###Initial Hessian
```
        INHESS <integer inhess default 2>
```
With this option the MEPGS module will be able to transform Cartesian
Hessian from previous frequency calculation.

### Selecting the side to traverse
```
        (BACKWARD || FORWARD) <string default both>
```
With this option the MEPGS module will select which side of the minimum
energy path to explore. By default both sides are explored for a MEPGS run.

### Using mass
```
        (MSWG || NOMSWG) <string default NOMSWG>
```
With this option the MEPGS will trigger the use of mass when following
the minimum energy path. Mass is not used as default, if mass is used
then this formally becomes an intrinsic reaction coordinate.

### Minimum energy path saved XYZ file
```
        XYZ [<string xyz default $fileprefix>]
        NOXYZ
```
The `XYZ` directive causes the geometry at each calculated structure on
the minimum energy path to be output into file in the permanent
directory in XYZ format. The optional string will prefix the filename.
The `NOXYZ` directive turns this off.

For example, the input
```
        mepgs; xyz ; end
```
will cause a trajectory file filename.xyz to be created in the permanent
directory.

###MEPGS usage
```
        start somename
        geometry; <saddle point body > ; end   
        task theory freq
        freq; reuse somename.hess ; end
        mepgs; <mepgs options> ; end
        task theory mepgs
```
In the above example, after performing a frequency analysis for the
saddle point, the information of the force constant matrix is reused
(freq directive) in order to be able to follow the transition state
mode.

Example input and output files can be find at
[https://github.com/nwchemgit/nwchem/blob/master/QA/tests/mep-test/mep-test.nw](https://github.com/nwchemgit/nwchem/blob/master/QA/tests/mep-test/mep-test.nw)
[https://github.com/nwchemgit/nwchem/blob/master/QA/tests/mep-test/mep-test.out](https://github.com/nwchemgit/nwchem/blob/master/QA/tests/mep-test/mep-test.out)
