# Correlation consistent Composite Approach (ccCA)

The CCCA module calculates the total energy using the correlation
consistent Composite Approach (ccCA). At present the ccCA module is
designed for the study of main group species
only.

<img alt="$E_{ccCA} = \Delta E_{MP2/CBS} + \Delta E_{CC} + \Delta E_{CV} + \Delta E_{SR} + \Delta E_{ZPE}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/33d001731fec2d367d816d40f9d4d5c1.svg?invert_in_darkmode&sanitize=true" align=middle width="435.461895pt" height="22.38192pt"/>

where EMP2/CBS is the complete basis set extrapolation of MP2 energies
with the aug-cc-pVnZ (n=T,D,Q) series of basis sets, <img alt="$\Delta E_{CC}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/79cb5a98482f91ca45c232baf0f425c2.svg?invert_in_darkmode&sanitize=true" align=middle width="46.132515pt" height="22.38192pt"/>
is the correlation correction,

<img alt="$\Delta E_{CC} = E_{CCSD(T)/cc-pVTZ}  -  E_{MP2/cc-pVTZ}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/7cd8edeec69d3ef393984d8fdcf574d8.svg?invert_in_darkmode&sanitize=true" align=middle width="335.001645pt" height="22.38192pt"/>

<img alt="$\Delta E_{CV}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/0570832b09f85b50763a623dd4e06142.svg?invert_in_darkmode&sanitize=true" align=middle width="46.490235pt" height="22.38192pt"/> is the core-valence correction,

<img alt="$\Delta E_{CV} = E_{MP2(FC1)/aug-cc-pCVTZ}  -  E_{MP2/aug-cc-pVTZ}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/4b107a49e88b226a19ca4d21d252e686.svg?invert_in_darkmode&sanitize=true" align=middle width="417.031395pt" height="22.38192pt"/>

<img alt="$\Delta E_{SR}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/1cd5c52716adb816ebcf09a0e34ed078.svg?invert_in_darkmode&sanitize=true" align=middle width="44.332365pt" height="22.38192pt"/> is the scalar-relativistic correction,

<img alt="$\Delta E_{SR} = E_{MP2/cc-pVTZ-DK} -  E_{MP2/cc-pVTZ}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/59c2e1bfd715f850fe20dd8d285fee91.svg?invert_in_darkmode&sanitize=true" align=middle width="336.805095pt" height="22.38192pt"/>

and <img alt="$\Delta E_{ZPE}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/0072b1808e925a44693aafbef49b4135.svg?invert_in_darkmode&sanitize=true" align=middle width="55.81818pt" height="22.38192pt"/> is the zero-point energy correction or thermal
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

CCCA

`       [(ENERGY||OPTIMIZE)   default ENERGY]`  
`       [(DFT||DIRECT)   default DFT]`  
`       [(MP2||MBPT2)   default MP2]`  
`       [(RHF||ROHF||UHF)   default RHF]`  
`       [(CCSD(T)||TCE)   default CCSD(T)]`  
`       [NOPEN   <integer number of unpaired electrons   default   0 >]`  
`       [(THERM||NOTHERM)   default  THERM]`  
`       [(PRINT||NOPRINT) default NOPRINT]`  
`       [BASIS `<basis name for orbital projection guess>`]`  
`       [MOVEC `<file name for orbital projection guess>`]`  
`END`

One example of input file for single point energy evaluation is given
here:

start h2o\_ccca

title "H2O, ccCA test"

geometry units au

` H       0.0000000000   1.4140780900  -1.1031626600`  
` H       0.0000000000  -1.4140780900  -1.1031626600`  
` O       0.0000000000   0.0000000000  -0.0080100000`

end

task ccca

An input file for the ground state of O2 with geometry optimization is
given below:

start o2\_ccca

title "O2, ccCA test"

geometry units au

` O       0.0000000000   0.0000000000  -2.0000`  
` O       0.0000000000   0.0000000000   0.0000`

end

ccca

` optimize`  
` dft`  
` nopen 2`

end

task ccca
