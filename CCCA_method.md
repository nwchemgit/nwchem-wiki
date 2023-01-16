# Correlation consistent Composite Approach (ccCA)

The CCCA module calculates the total energy using the correlation
consistent Composite Approach (ccCA). At present the ccCA module is
designed for the study of main group species
only.

$$E_{ccCA} = \Delta E_{MP2/CBS} \  \   + \Delta E_{CC} + \Delta E_{CV} + \Delta E_{SR} + \Delta E_{ZPE}$$

where EMP2/CBS is the complete basis set extrapolation of MP2 energies
with the aug-cc-pVnZ (n=T,D,Q) series of basis sets, $\Delta E_{CC}$ is the correlation correction,

$$\Delta E_{CC} = E_{CCSD(T)/cc-pVTZ} \  \ \  -  E_{MP2/cc-pVTZ}$$

$\Delta E_{CV}$ is the core-valence correction,

$$\Delta E_{CV} = E_{MP2(FC1)/aug-cc-pCVTZ} \  \  \  \  \   -  E_{MP2/aug-cc-pVTZ}$$

where $FC1$ symbolizes that all electrons of first-row atoms are correlated, all electrons of second-row atoms are correlated except the 1s MOs, and all electrons of atoms K–Kr are correlated except the 1s2s2p MOs.  
$\Delta E_{SR}$ is the scalar-relativistic correction,

$$\Delta E_{SR} = E_{MP2/cc-pVTZ-DK} \  \  \  -  E_{MP2/cc-pVTZ}$$

and $\Delta E_{ZPE}$ is the zero-point energy correction or thermal
correction. Geometry optimization and subsequent frequency analysis are
performed with B3LYP/cc-pVTZ.

Suggested reference: N.J. DeYonker, B. R. Wilson, A.W. Pierpont, T.R.
Cundari, A.K. Wilson, Mol. Phys. 107, 1107 (2009). Earlier variants for
ccCA algorithms can also be found in: N. J. DeYonker, T. R. Cundari, A.
K. Wilson, J. Chem. Phys. 124, 114104 (2006).

The ccCA module can be used to calculate the total single point energy
for a fixed geometry and the zero-point energy correction is not
available in this calculation. Alternatively the geometry optimization
by B3LYP/cc-pVTZ is performed before the single point energy evaluation.
For open shell molecules, the number of unpaired electrons must be given
explicitly.
```
CCCA

       [(ENERGY||OPTIMIZE)   default ENERGY] 
       [(DFT||DIRECT)   default DFT]  
       [(MP2||MBPT2)   default MP2]  
       [(RHF||ROHF||UHF)   default RHF]  
       [(CCSD(T)||TCE)   default CCSD(T)]  
       [NOPEN   <integer number of unpaired electrons   default   0 >]  
       [(THERM||NOTHERM)   default  THERM]  
       [(PRINT||NOPRINT) default NOPRINT]  
       [BASIS <basis name for orbital projection guess>]  
       [MOVEC <file name for orbital projection guess>]  
END
```
One example of input file for single point energy evaluation is given
here:
```
start h2o_ccca

title "H2O, ccCA test"

geometry units au

 H       0.0000000000   1.4140780900  -1.1031626600  
 H       0.0000000000  -1.4140780900  -1.1031626600  
 O       0.0000000000   0.0000000000  -0.0080100000
end

task ccca
```
An input file for the ground state of O2 with geometry optimization is
given below:
```
start o2_ccca

title "O2, ccCA test"

geometry units au

 O       0.0000000000   0.0000000000  -2.0000  
 O       0.0000000000   0.0000000000   0.0000

end

ccca
 optimize
 dft  
 nopen 2
end

task ccca
```
