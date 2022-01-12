# SMD (Solvation Model Based on Density) Model

SMD denotes “solvation model based on density” and it is described in
detail in the 2009 paper by Marenich, Cramer and Truhlar[^1].  

The SMD model is a universal continuum solvation model where “universal”
denotes its applicability to any charged or uncharged solute in any
solvent or liquid medium for which a few key descriptors are known. The
word “continuum” denotes that the solvent is not represented explicitly
as a collection of discrete solvent molecules but rather as a dielectric
medium with surface tensions at the solute-solvent interface.

SMD directly calculates the free energy of solvation of an ideal
solvation process that occurs at fixed concentration (for example, from
an ideal gas at a concentration of 1 mol/L to an ideal solution at a
liquid-phase concentration of 1 mol/L) at 298 K, but this may converted
by standard thermodynamic formulas to a standard-state free energy of
solvation, which is defined as the transfer of molecules from an ideal
gas at 1 bar to an ideal 1 molar solution.

The SMD model separates the fixed-concentration free energy of solvation
into two components. The first component is the bulk-electrostatic
contribution arising from a self-consistent reaction field (SCRF)
treatment. The SCRF treatment involves an integration of the
nonhomogeneous-dielectric Poisson equation for bulk electrostatics in
terms of the [COSMO model](COSMO-Solvation-Model#cosmo-solvation-model)
of Klamt and Schürmann with the modified [COSMO scaling factor](COSMO-Solvation-Model#cosmo-input-parameters) 
suggested by Stefanovich and Truong and by using the SMD
intrinsic atomic Coulomb radii. These radii have been optimized for H,
C, N, O, F, Si, P, S, Cl, and Br. For any other atom the current
implementation of the SMD model uses scaled values of the van der Waals
radii of Mantina et al.

Mantina, M.; Valero, R.; Cramer, C. J.; Truhlar, D. G. “Atomic Radii of
the Elements.” In CRC Handbook of Chemistry and Physics, 91st Edition,
2010-2011; Haynes, W. M., Ed.; CRC Press: Boca Raton, FL, 2010; pp 9-49.

The scaling factor equals 1.52 for group 17 elements heavier than Br
(i.e., for I and At) and 1.18 for all other elements for which there are
no optimized SMD radii.

The second contribution to the fixed-concentration free energy of
solvation is the contribution arising from short-range interactions
between the solute and solvent molecules in the first solvation shell.
This contribution is called the cavity–dispersion–solvent-structure
(CDS) term, and it is a sum of terms that are proportional (with
geometry-dependent proportionality constants called atomic surface
tensions) to the solvent-accessible surface areas (SASAs) of the
individual atoms of the solute.

At the moment the SMD model is available in NWChem only with the DFT
block

The SMD input options are as follows:

```
do_cosmo_smd <logical do_cosmo_smd default .true.>
```
The `do_cosmo_smd` keyword instructs NWChem to perform a ground-state SMD calculation


```
solvent (keyword)
```
 a `solvent` keyword from a list of available SMD solvent names below:


| Keyword     | Name                            |
| ----------- | ------------------------------- |
| h2o         | water (default)                 |
| water       | water (default)                 |
| acetacid    | acetic acid                     |
| acetone     | acetone                         |
| acetntrl    | acetonitrile                    |
| acetphen    | acetophenone                    |
| aniline     | aniline                         |
| anisole     | anisole                         |
| benzaldh    | benzaldehyde                    |
| benzene     | benzene                         |
| benzntrl    | benzonitrile                    |
| benzylcl    | benzyl chloride                 |
| brisobut    | 1-bromo-2-methylpropane         |
| brbenzen    | bromobenzene                    |
| brethane    | bromoethane                     |
| bromform    | bromoform                       |
| broctane    | 1-bromooctane                   |
| brpentan    | 1-bromopentane                  |
| brpropa2    | 2-bromopropane                  |
| brpropan    | 1-bromopropane                  |
| butanal     | butanal                         |
| butacid     | butanoic acid                   |
| butanol     | 1-butanol                       |
| butanol2    | 2-butanol                       |
| butanone    | butanone                        |
| butantrl    | butanonitrile                   |
| butile      | butyl acetate                   |
| nba         | butylamine                      |
| nbutbenz    | n-butylbenzene                  |
| sbutbenz    | sec-butylbenzene                |
| tbutbenz    | tert-butylbenzene               |
| cs2         | carbon disulfide                |
| carbntet    | carbon tetrachloride            |
| clbenzen    | chlorobenzene                   |
| secbutcl    | sec-butyl chloride              |
| chcl3       | chloroform                      |
| clhexane    | 1-chlorohexane                  |
| clpentan    | 1-chloropentane                 |
| clpropan    | 1-chloropropane                 |
| ocltolue    | o-chlorotoluene                 |
| m-cresol    | m-cresol                        |
| o-cresol    | o-cresol                        |
| cychexan    | cyclohexane                     |
| cychexon    | cyclohexanone                   |
| cycpentn    | cyclopentane                    |
| cycpntol    | cyclopentanol                   |
| cycpnton    | cyclopentanone                  |
| declncis    | cis-decalin                     |
| declntra    | trans-decalin                   |
| declnmix    | decalin (cis/trans mixture)     |
| decane      | n-decane                        |
| decanol     | 1-decanol                       |
| edb12       | 1,2-dibromoethane               |
| dibrmetn    | dibromomethane                  |
| butyleth    | dibutyl ether                   |
| odiclbnz    | o-dichlorobenzene               |
| edc12       | 1,2-dichloroethane              |
| c12dce      | cis-dichloroethylene            |
| t12dce      | trans-dichloroethylene          |
| dcm         | dichloromethane                 |
| ether       | diethyl ether                   |
| et2s        | diethyl sulfide                 |
| dietamin    | diethylamine                    |
| mi          | diiodomethane                   |
| dipe        | diisopropyl ether               |
| dmds        | dimethyl disulfide              |
| dmso        | dimethyl sulfoxide              |
| dma         | N,N-dimethylacetamide           |
| cisdmchx    | cis-1,2-dimethylcyclohexane     |
| dmf         | N,N-dimethylformamide           |
| dmepen24    | 2,4-dimethylpentane             |
| dmepyr24    | 2,4-dimethylpyridine            |
| dmepyr26    | 2,6-dimethylpyridine            |
| dioxane     | 1,4-dioxane                     |
| phoph       | diphenyl ether                  |
| dproamin    | dipropylamine                   |
| dodecan     | n-dodecane                      |
| meg         | 1,2-ethanediol                  |
| etsh        | ethanethiol                     |
| ethanol     | ethanol                         |
| etoac       | ethyl acetate                   |
| etome       | ethyl formate                   |
| eb          | ethylbenzene                    |
| phenetol    | ethyl phenyl ether              |
| c6h5f       | fluorobenzene                   |
| foctane     | 1-fluorooctane                  |
| formamid    | formamide                       |
| formacid    | formic acid                     |
| heptane     | n-heptane                       |
| heptanol    | 1-heptanol                      |
| heptnon2    | 2-heptanone                     |
| heptnon4    | 4-heptanone                     |
| hexadecn    | n-hexadecane                    |
| hexane      | n-hexane                        |
| hexnacid    | hexanoic acid                   |
| hexanol     | 1-hexanol                       |
| hexanon2    | 2-hexanone                      |
| hexene      | 1-hexene                        |
| hexyne      | 1-hexyne                        |
| c6h5i       | iodobenzene                     |
| iobutane    | 1-iodobutane                    |
| c2h5i       | iodoethane                      |
| iohexdec    | 1-iodohexadecane                |
| ch3i        | iodomethane                     |
| iopentan    | 1-iodopentane                   |
| iopropan    | 1-iodopropane                   |
| cumene      | isopropylbenzene                |
| p-cymene    | p-isopropyltoluene              |
| mesityln    | mesitylene                      |
| methanol    | methanol                        |
| egme        | 2-methoxyethanol                |
| meacetat    | methyl acetate                  |
| mebnzate    | methyl benzoate                 |
| mebutate    | methyl butanoate                |
| meformat    | methyl formate                  |
| mibk        | 4-methyl-2-pentanone            |
| mepropyl    | methyl propanoate               |
| isobutol    | 2-methyl-1-propanol             |
| terbutol    | 2-methyl-2-propanol             |
| nmeaniln    | N-methylaniline                 |
| mecychex    | methylcyclohexane               |
| nmfmixtr    | N-methylformamide (E/Z mixture) |
| isohexan    | 2-methylpentane                 |
| mepyrid2    | 2-methylpyridine                |
| mepyrid3    | 3-methylpyridine                |
| mepyrid4    | 4-methylpyridine                |
| c6h5no2     | nitrobenzene                    |
| c2h5no2     | nitroethane                     |
| ch3no2      | nitromethane                    |
| ntrprop1    | 1-nitropropane                  |
| ntrprop2    | 2-nitropropane                  |
| ontrtolu    | o-nitrotoluene                  |
| nonane      | n-nonane                        |
| nonanol     | 1-nonanol                       |
| nonanone    | 5-nonanone                      |
| octane      | n-octane                        |
| octanol     | 1-octanol                       |
| octanon2    | 2-octanone                      |
| pentdecn    | n-pentadecane                   |
| pentanal    | pentanal                        |
| npentane    | n-pentane                       |
| pentacid    | pentanoic acid                  |
| pentanol    | 1-pentanol                      |
| pentnon2    | 2-pentanone                     |
| pentnon3    | 3-pentanone                     |
| pentene     | 1-pentene                       |
| e2penten    | E-2-pentene                     |
| pentacet    | pentyl acetate                  |
| pentamin    | pentylamine                     |
| pfb         | perfluorobenzene                |
| benzalcl    | phenylmethanol                  |
| propanal    | propanal                        |
| propacid    | propanoic acid                  |
| propanol    | 1-propanol                      |
| propnol2    | 2-propanol                      |
| propntrl    | propanonitrile                  |
| propenol    | 2-propen-1-ol                   |
| propacet    | propyl acetate                  |
| propamin    | propylamine                     |
| pyridine    | pyridine                        |
| c2cl4       | tetrachloroethene               |
| thf         | tetrahydrofuran                 |
| sulfolan    | tetrahydrothiophene-S,S-dioxide |
| tetralin    | tetralin                        |
| thiophen    | thiophene                       |
| phsh        | thiophenol                      |
| toluene     | toluene                         |
| tbp         | tributyl phosphate              |
| tca111      | 1,1,1-trichloroethane           |
| tca112      | 1,1,2-trichloroethane           |
| tce         | trichloroethene                 |
| et3n        | triethylamine                   |
| tfe222      | 2,2,2-trifluoroethanol          |
| tmben124    | 1,2,4-trimethylbenzene          |
| isoctane    | 2,2,4-trimethylpentane          |
| undecane    | n-undecane                      |
| m-xylene    | m-xylene                        |
| o-xylene    | o-xylene                        |
| p-xylene    | p-xylene                        |
| xylenemx    | xylene (mixture)                |
  
<br/><br/> 

When a solvent is specified by name, the descriptors for the solvent are
based on the Minnesota Solvent Descriptor Database[^2].  

The user can specify a solvent that is not on the list by omitting the
solvent keyword and instead introducing user-provided values for the
following solvent
descriptors:

```
dielec (real input)
```
dielectric constant at 298 K  

```
sola (real input) 
```
Abraham’s hydrogen bond acidity   

```
solb (real input) 
```
Abraham’s hydrogen bond basicity  

```
solc (real input)
```
aromaticity as a fraction of non-hydrogenic solvent atoms that are aromatic carbon atoms  

```
solg (real input)
```
macroscopic surface tension of the solvent at an air/solvent interface at 298 K in units of
cal mol<sup>–1</sup> Å<sup>–2</sup>  
(note that 1 dyne/cm = 1.43932 cal mol<sup>–1</sup> Å<sup>–2</sup>)  

```
solh (real input)
```
electronegative halogenicity as the fraction of non-hydrogenic solvent atoms that are F, Cl, or Br  

```
soln (real input)
```
index of refraction at optical frequencies at 293 K  

An example of an SMD input file is as
follows:

```
echo 
title 'SMD/M06-2X/6-31G(d) solvation free energy for CF3COO- in water'
start
charge -1
geometry nocenter
C    0.512211   0.000000  -0.012117
C   -1.061796   0.000000  -0.036672
O   -1.547400   1.150225  -0.006609
O   -1.547182  -1.150320  -0.006608
F    1.061911   1.087605  -0.610341
F    1.061963  -1.086426  -0.612313
F    0.993255  -0.001122   1.266928
symmetry c1
end
basis
* library 6-31G*
end
dft
 XC m06-2x
end
cosmo
 do_cosmo_smd true
 solvent water
end
task dft energy
```

## References
///Footnotes Go Here///

[^1]: Marenich, A. V.; Cramer, C. J.; Truhlar, D. G. "Universal solvation model based on solute electron density and on a continuum model of the solvent defined by the bulk dielectric constant and atomic surface tensions". J. Phys. Chem. B 2009, 113, 6378-6396. [DOI:10.1021/jp810292n](http://dx.doi.org/10.1021/jp810292n).  
[^2:] Winget, P.; Dolney, D. M.; Giesen, D. J.; Cramer, C. J.; Truhlar, D. G. "Minnesota Solvent Descriptor Database". University of Minnesota: Minneapolis, MN, 2010. [http://comp.chem.umn.edu/solvation/mnsddb.pdf](http://comp.chem.umn.edu/solvation/mnsddb.pdf)

