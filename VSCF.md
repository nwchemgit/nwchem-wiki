# Vibrational SCF (VSCF)

The VSCF module[@chaban1999] can be used to calculate the anharmonic contributions to
the vibrational modes of the molecule of interest. Energies are
calculated on a one-dimensional grid along each normal mode, on a
two-dimensional grid along each pair of normal modes, and optionally on
a three-dimensional grid along each triplet of normal modes. These
energies are then used to calculate the vibrational nuclear wavefunction
at an SCF- (VSCF) and MP2-like (cc-VSCF) level of theory.

VSCF can be used at all levels of theory, SCF and correlated methods,
and DFT. For correlated methods, only the SCF level dipole is evaluated
and used to calculate the IR intensity values.

The VSCF module is started when the task directive `TASK <theory> vscf` is
defined in the user input file. The input format has the form:
```
 VSCF
   [coupling <string couplelevel default "pair">]  
   [ngrid    <integer default 16 >]  
   [iexcite  <integer default 1  >]  
   [vcfct    <real    default 1.0>]  
 END
```
The order of coupling of the harmonic normal modes included in the
calculation is controlled by the specifying:
```
   coupling <string couplelevel default "pair">
```
For `coupling=diagonal` a one-dimensional grid along each normal mode is
computed.   
For `coupling=pair` a two-dimensional grid along each pair of normal modes is computed.   
For `coupling=triplet` a three-dimensional grid along each triplet of normal modes is computed. 

The number of grid points along each normal mode, or pair of modes can
be defined by specifying:
```
   ngrid <integer default 16>
```
This VSCF module by default calculates the ground state (&nu;=0), but can
also calculate excited states (such as &nu;=1). The number of excited
states calculated is defined by specifying:
```
   iexcite <integer default 1>
``` 
With `iexcite=1` the fundamental frequencies are calculated.  
With `iexcite=2` the first overtones are calculated.  
With `iexcite=3` the second overtones are calculated.

In certain cases the pair coupling potentials can become larger than
those for a single normal mode. In this case the pair potentials need to
be scaled down. The scaling factor used can be defined by specifying:
```
   vcfct <real default 1.0>
```

**References**

1. G. M. Chaban, J. O. Jung, and R. B. Gerber, The Journal of Chemical Physics 111, 1823-1829 (1999)