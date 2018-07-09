# Electron Transfer

The NWChem electron transfer (ET) module calculates the electronic
coupling energy (also called the electron transfer matrix element)
between ET reactant and product states. The electronic coupling
(<img alt="$V_{RP}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/4cb79cac616f73ccf51965af40c2b949.svg?invert_in_darkmode&sanitize=true" align=middle width="29.57889pt" height="22.38192pt"/>), activation energy (<img alt="$\Delta G^{*}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/d4b6f1efc7506d98c4c1182d400b8b19.svg?invert_in_darkmode&sanitize=true" align=middle width="33.23397pt" height="22.59873pt"/>), and nuclear
reorganization energy (λ) are all components of the electron transfer
rate defined by Marcus' theory, which also depends on the temperature
(see Reference 1
below):

<img alt="${k_{ET}}= \frac{2\pi}{\hbar} V_{RP}^{2} \frac{1}{\sqrt{4\pi \lambda k_{B}T}} \exp \left( \frac{- \Delta G^{*}}{k_{B} T} \right)$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/534ce113598ba681e3cbb214b4ef4072.svg?invert_in_darkmode&sanitize=true" align=middle width="255.900645pt" height="37.80348pt"/>

The ET module utilizes the method of *Corresponding Orbital
Transformation* to calculate <img alt="$V_{RP}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/4cb79cac616f73ccf51965af40c2b949.svg?invert_in_darkmode&sanitize=true" align=middle width="29.57889pt" height="22.38192pt"/>. The only input required are the
names of the files containing the open-shell (UHF) MO vectors for the ET
reactant and product states (*R* and *P*).

The basis set used in the calculation of <img alt="$V_{RP}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/4cb79cac616f73ccf51965af40c2b949.svg?invert_in_darkmode&sanitize=true" align=middle width="29.57889pt" height="22.38192pt"/> must be the same as
the basis set used to calculate the MO vectors of *R* and *P*. The
magnitude of <img alt="$V_{RP}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/4cb79cac616f73ccf51965af40c2b949.svg?invert_in_darkmode&sanitize=true" align=middle width="29.57889pt" height="22.38192pt"/> depends on the amount of overlap between *R* and
*P*, which is important to consider when choosing the basis set. Diffuse
functions may be necessary to fill in the overlap, particularly when the
ET distance is long.

The MO's of *R* and *P* must correspond to localized states. for
instance, in the reaction <img alt="$A^{ -} B \rightarrow  A B^{ -}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/15728481d59878d0e5ad1e52c3c03e12.svg?invert_in_darkmode&sanitize=true" align=middle width="97.899945pt" height="26.12412pt"/> the
transferring electron is localized on A in the reactant state and is
localized on B in the product state. To verify the localization of the
electron in the calculation of the vectors, carefully examine the
Mulliken population analysis. In order to determine which orbitals are
involved in the electron transfer, use the print keyword "mulliken ao"
which prints the Mulliken population of each basis function.

An effective core potential (ECP) basis can be used to replace core
electrons. However, there is one caveat: the orbitals involved in
electron transfer must not be replaced with ECP's. Since the ET orbitals
are valence orbitals, this is not usually a problem, but the user should
use ECP's with care.

Suggested references are listed below. The first two references gives a
good description of Marcus' two-state ET model, and the appendix of the
third reference details the method used in the ET module.

1.  R.A. Marcus, N. Sutin, Biochimica Biophysica Acta 35, 437, (1985).
2.  J.R. Bolton, N. Mataga, and G. McLendon in "Electron Transfer in
    Inorganic, Organic and Biological Systems" (American Chemical
    Society, Washington, D.C., 1991)
3.  A. Farazdel, M. Dupuis, E. Clementi, and A. Aviram, J. Am. Chem.
    Soc., 112, 4206 (1990).

## VECTORS -- input of MO vectors for ET reactant and product states

` VECTORS [reactants] `<string reactants_filename>  
` VECTORS [products ] `<string products_filename>

In the VECTORS directive the user specifies the source of the molecular
orbital vectors for the ET reactant and product states. This is required
input, as no default filename will be set by the program. In fact, this
is the only required input in the ET module, although there are other
optional keywords described
below.

## FOCK/NOFOCK -- method for calculating the two-electron contribution to <img alt="$V_{RP}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/4cb79cac616f73ccf51965af40c2b949.svg?invert_in_darkmode&sanitize=true" align=middle width="29.57889pt" height="22.38192pt"/>

`  <string (FOCK||NOFOCK) default FOCK>`

This directive enables/disables the use of the NWChem's Fock matrix
routine in the calculation of the two-electron portion of the ET
Hamiltonian. Since the Fock matrix routine has been optimized for speed,
accuracy and parallel performance, it is the most efficient choice.

Alternatively, the user can calculate the two-electron contribution to
the ET Hamiltonian with another subroutine which may be more accurate
for systems with a small number of basis functions, although it is
slower.

## TOL2E -- integral screening threshold

` TOL2E <real tol2e default max(10e-12,min(10e-7, S(RP)*10e-7 )>`

The variable tol2e is used in determining the integral screening
threshold for the evaluation of the two-electron contribution to the
Hamiltonian between the electron transfer reactant and product states.
As a default, tol2e is set depending on the magnitude of the overlap
between the ET reactant and product states (<img alt="$S_{RP}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/09e2ae89de9087b174958724cbf3e4e9.svg?invert_in_darkmode&sanitize=true" align=middle width="30.06795pt" height="22.38192pt"/>), and is not less
than 1.0d-12 or greater than 1.0d-7.

The input to specify the threshold explicitly within the ET directive
is, for example:
```
 tol2e 1e-9
```
##  FMO -- Fragment Orbital Approach

The keyword <tt>FMO</tt> can be used to compute electronic couplings by means of the fragment orbital approach
(EF Valeev, V Coropceanu, DA da Silva Filho, S Salman, JL Bredas,. J. Am. Chem. Soc., 128, 9882 (2006))

```
fmo
```
An example input file can be found in  the [etrans-fmo QA directory](../tree/master/QA/tests/etrans-fmo)

## Example

The following example is for a simple electron transfer reaction,
<img alt="$He_{} \rightarrow He^{ +}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/071c03bc68d9e9cb99efa0d16a160ace.svg?invert_in_darkmode&sanitize=true" align=middle width="81.53376pt" height="26.12412pt"/>. The ET calculation is easy to execute,
but it is crucial that ET reactant and product wavefunctions reflect
localized states. This can be accomplished using either a [fragment
guess](Hartree-Fock-Theory-for-Molecules#superposition-of-fragment-molecular-orbitals "wikilink"), or
a [charged atomic density
guess](Hartree-Fock-Theory-for-Molecules#atomic-guess-orbitals-with-charged-atoms "wikilink"). For
self-exchange ET reactions such as this one, you can use the
[REORDER](Hartree-Fock-Theory-for-Molecules#vectors----inputoutput-of-mo-vectors "wikilink") keyword
to move the electron from the first helium to the second.

Example input :
```
#ET reactants:  
charge 1  
scf   
  doublet; uhf; vectors input fragment HeP.mo He.mo output HeA.mo  
# HeP.mo are the vectors for He(+),   
# He.mo  are the vectors for neutral He.  
end  
task scf  
  
#ET products: 
charge 1  
scf   
  doublet; uhf; vectors input HeA.mo reorder 2 1 output HeB.mo  
end  
task scf  
  
et  
 vectors reactants HeA.mo   
 vectors products HeB.mo  
end  
task scf et
```
Here is what the output looks like for this example:
```
                          Electron Transfer Calculation  
                          -----------------------------  
  
MO vectors for reactants: HeA.mo  
MO vectors for products : HeB.mo  
  
Electronic energy of reactants     H(RR)      -5.3402392824  
Electronic energy of products      H(PP)      -5.3402392824  
  
Reactants/Products overlap         S(RP)      -0.0006033839  
  
Reactants/Products interaction energy:  
-------------------------------------  
One-electron contribution         H1(RP)       0.0040314092  
  
Beginning calculation of 2e contribution  
Two-electron integral screening (tol2e) : 6.03E-11  
  
Two-electron contribution         H2(RP)      -0.0007837138  
Total interaction energy           H(RP)       0.0032476955  
  
Electron Transfer Coupling Energy |V(RP)|      0.0000254810  
                                                      5.592 cm-1  
                                                   0.000693 eV  
                                                      0.016 kcal/mol
```
The overlap between the ET reactant and product states (<img alt="$S_{RP}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/09e2ae89de9087b174958724cbf3e4e9.svg?invert_in_darkmode&sanitize=true" align=middle width="30.06795pt" height="22.38192pt"/>) is
small, so the magnitude of the coupling between the states is also
small. If the fragment guess or charged atomic density guess were not
used, the Mulliken spin population would be 0.5 on both He atoms, the
overlap between the ET reactant and product states would be 100 % and an
infinite <img alt="$V_{RP}$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/4cb79cac616f73ccf51965af40c2b949.svg?invert_in_darkmode&sanitize=true" align=middle width="29.57889pt" height="22.38192pt"/> would result.
