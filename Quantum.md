# Quantum

The quantum features are routines for printing out one- and
two-electron integrals that can be utilized in quantum algorithms. The
outputs can be interpreted and formatted in
[YAML](https://en.wikipedia.org/wiki/YAML) files that include the
integrals and basic information including initial wavefunction guesses
for quantum algorithms. There are currently two options for integrals:

## Bare Hamiltonian

To print the bare Hamiltonian, you must set up a CCSD calculation with the following parameters:   
* The symmetry must be declared as 'C1'   
* In the TCE block, you must include the following:   
```
        2eorb
        2emet 13
        nroots ### (Optional, but will include leading excitations for excited-state quantum calculations)
```
You must set the printing parameters at the end of the input file:  
```
        set tce:print_integrals T
        set tce:qorb ### (Total number of orbitals you wish to be printed)
        set tce:qela ### (Number of alpha electrons)
        set tce:qelb ### (number of beta electrons)
```
_Notes:_  

* The two-electron integrals are printed out in compact Mulliken
notation (each printed element corresponds to (ij|kl), (ij|lk),
(ji|kl), (ji|lk), (kl|ij), (kl|ji), (lk|ij), and (lk|ji) )  
* The number
of alpha and beta electrons that are set in the printing does not need
to correspond to the total number of alpha and beta electrons. Rather
it is the number of electrons included in the printing, starting from
the HOMO and counting down. This allows you to 'freeze' core
orbitals. However, this is not recommended, because unlike freezing
Fock matrix elements and two-electron integrals in correlated
calculations, this procedure is dropping core orbitals of the standard
one- and two-electron integrals and can lead to an imbalance of the
correlation energy.  
* If the number of electrons and orbitals do not
correspond to the total numbers of electrons and orbitals, then the
calculation will perform a corresponding frozen core/frozen virtual
CC/EOMCC calculation. This is to ensure that leading CC/EOMCC
excitations do not correspond to orbitals outside of the printed
integrals.  

## DUCC Hamiltonian
The double unitary coupled-cluster (DUCC)
Hamiltonian is a way of incorporating correlation effects (mainly
dynamical) into a reduced dimensionality Hamiltonian based on a
defined active space. The procedure currently only reduces the virtual
space and all occupied orbitals are considered active. Only the
ground-state implementation is available in the current [NWChem
release](https://github.com/nwchemgit/nwchem/releases/tag/v7.0.0-release).  

To print the DUCC Hamiltonian, you must set up a CCSD calculation with the following parameters:  

* The symmetry must be declared as 'C1'  
* In the TCE block, you must include the following:  
```
        2eorb
        2emet 13
```
You must set the printing parameters at the end of the input file:  
```
        set tce:qducc T
        set tce:nactv ### (The number of active virtual orbitals. 
                           Remember that all occupied orbitals are active as well)
        set tce:nonhf F/T (If a non-RHF reference is used, set to T. Otherwise, keep as F.)
        set tce:ducc_model ### (Determines how the similarity transformed Hamiltonian is truncated. See note below.)
```
_Notes:_

* Six models for the truncation of the similarity transformed are implemented and numbered 1-6. They correspond to approximations A(2)-A(7), respectively, that are detailed in [arXiv:2110.12077](https://arxiv.org/abs/2110.12077). Model 3 corresponds to the earliest implementation described in [J. Chem. Phys. 151, 014107 (2019)](https://doi.org/10.1063/1.5094643) and [J. Chem. Phys. 151, 234114 (2019)]( https://doi.org/10.1063/1.5128103). In contrast to these early publications, the full form of the two-electron integral is printed. Model 2 is an aggressive truncation and is not recommended for use. 
* The entire two-electron integral is printed out since the DUCC Hamiltonian does not have the same symmetry as the bare Hamiltonian. Instead of the 8-fold symmetry, it has dual 4-fold symmetries    
```
        (IJ|KL) = (JI|LK) = (KL|IJ) = (LK|JI)  
        Separately, (IJ|LK) = (JI|KL) = (KL|JI) = (LK|IJ)  
        But (IJ|KL) /= (IJ|LK)    
```  
*  When utilizing the [YAML interpreter](#yaml-interpreter), the full two-electron integral will be printed in the YAML file, despite it being labeled as 'sparse' in the YAML file.   
* Frozen core calculations should not be performed. There is nothing preventing such calculation from being executed, but the integrals will be incorrect.   
* Since the all-orbital coupled-cluster calculation must be performed, then there is a chance that a leading excitation outside of the active-space will be printed and therefore included in the initial wave function description in the YAML file. The user ought to be aware of this risk and make changes to the YAML file to exclude these excitations, which would include renormalizing the remaining amplitudes of the initial guess.  

## YAML Interpreter
Once the calculation is completed, the integrals and basic information including initial wavefunction guesses for quantum algorithms can be extracted into a YAML file. To generate the YAML file, executed the following command:
```
python $NWCHEM_TOP/contrib/quasar/export_chem_library_yaml.py < {NWChem output file} > {YAML file name}
```
_Note:_
* the 'fci_energy' in the YAML file is taken to be the energy of the correlated method, which, in either case, is the CCSD energy.


## Example input file for Bare Hamiltonian

```
echo

start Lih

geometry units angstroms
symmetry C1
 Li 0 0   0.000
 H  0 0   1.600
end

basis spherical
 * library sto-3g
end

scf
  singlet
  rhf
  thresh 1e-10
end

tce
  2eorb
  2emet 13
  ccsd
  thresh 1.0d-8
  maxiter 150
  nroots 2
end

set tce:print_integrals T
set tce:qorb 6
set tce:qela 2
set tce:qelb 2

task tce energy
```

## Example input file for DUCC
```
echo

start Lih

geometry units angstroms
symmetry C1
 Li 0 0   0.000
 H  0 0   1.600
end

basis spherical
 * library sto-3g
end

scf
  singlet
  rhf
  thresh 1e-10
end

tce
  2eorb
  2emet 13
  ccsd
  thresh 1.0d-8
  maxiter 150
end

set tce:qducc T
set tce:nactv 4
set tce:nonhf F
set tce:ducc_model 3

task tce energy
```
