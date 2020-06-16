While we have done our best to compile an exhaustive list of software
using NWChem, we might have missed packages and/or incorrectly described
some software features. Please use the [Github Issue feature](https://github.com/nwchemgit/nwchem/issues) to provide
feedback on this page content.

## User interface software

  - **ECCE** Extensible Computational Chemistry Environment
    <http://ecce.emsl.pnl.gov/> \[1\]
  - **EMSL Arrows** Evolution of Chemical and Materials Computation
    <http://www.nwchem-sw.org/index.php/EMSL_Arrows>
  - **Avogadro** reads cube files, generates NWChem input files,
    analyzes output files (including frequencies) <http://avogadro.cc>
  - **WebMO** World Wide Web-based interface to computational chemistry
    packages <https://www.webmo.net/> \[2\]
  - **Jmol** analyzes output and cube files
    <http://wiki.jmol.org/index.php/NWChem>
  - **Scienomics MAPS** platform has a NWChem Plugin that will allow
    users to easily create NWChem input files. Since MAPS platform also
    has complex builders available, users can create complex models and
    then submit NWChem simulations to HPCs. MAPS also allows easy
    analysis of NWChem output files
    <http://www.scienomics.com/software/>
  - **CULGI** computational platform
    <https://www.culgi.com/software/features-quantum-chemistry/>
  - **KiSThelP** predicts thermodynamic properties and rate constants
    from NWChem results <http://kisthelp.univ-reims.fr/>
  - **Chemcraft** <http://www.chemcraftprog.com>
  - **ASE** Atomic Simulation Environment <http://wiki.fysik.dtu.dk/ase>
  - **Ascalaph**
    <http://www.biomolecular-modeling.com/Ascalaph/index.html>
  - **Molecular Design Toolkit**
    <http://bionano.autodesk.com/MolecularDesignToolkit/>
  - **MoCalc2012** <http://mocalc2012.sourceforge.net/>
  - **Chemissian** <http://www.chemissian.com/>
  - **Gausssum** a GUI application that can analyze the output since
    version 3.0 using the [cclib](http://cclib.github.io/) library
    <http://gausssum.sf.net>
  - **OpenDFT** is a free and open source software that brings cutting edge solid state research to the people https://github.com/JannickWeisshaupt/OpenDFT

<references/>

## Codes using NWChem wavefunctions and/or post-processing NWChem output files

  - **Fiesta** is a Gaussian-basis GW and Bethe-Salpeter code
    <http://perso.neel.cnrs.fr/xavier.blase/fiesta/>
  - **JANPA** performs Natural Population Analysis <http://janpa.sf.net>
  - **CamCASP** Cambridge package for Calculation of Anisotropic Site
    Properties <http://www-stone.ch.cam.ac.uk/documentation/camcasp/users_guide.pdf>
  - **ChemShell** is a computational chemistry environment for standard
    quantum chemical or force field calculations
    <http://community.hartree.stfc.ac.uk/wiki/site/admin/chemshell.html>
  - **PUPIL** allows developers to perform multi-scale simulations
    <http://pupil.sf.net>
  - **LICHEM** interfaces between QM and MM software
    <http://github.com/kratman/LICHEM_QMMM>
  - **VENUS** interfaces NWChem with chemical dynamics
    <http://hase-group.ttu.edu/venus.html>
    <https://www.sciencedirect.com/science/article/pii/S0010465513004049>
  - **VOTCA-XTP** is a GW-BSE code to calculate excited state properties
    <http://www.votca.org> <http://doc.votca.org/xtp-manual.pdf>
  - **PyDP4** is Python workflow for DP4 analysis of organic molecules
    <https://github.com/KristapsE/PyDP4>
  - **Fafoom** Flexible algorithm for optimization of molecules
    <https://github.com/adrianasupady/fafoom>
  - **Pymatgen** Python Materials Genomics open-source Python library for materials analysis
    <http://pymatgen.org>
  - **PVSCF** A parallel vibrational self-consistent field program <http://pvscf.org>
  - **ResLibCal** A tool to compute triple-axis neutron spectrometer resolution <http://ifit.mccode.org/Applications/ResLibCal/doc/ResLibCal.html>
  - **SMFA**  General program package for performing quantum chemistry calculations on large molecules using an energy-based fragmentation approach <https://github.com/mickcollins/SMFAPAC>
  - **OCLIMAX** Free program for simulation of inelastic neutron scattering <https://sites.google.com/site/ornliceman/download>
  -  **Artaios** A code for calculating spin-dependent electron transport properties for molecular junctions in the coherent tunneling regime<https://www.chemie.uni-hamburg.de/institute/ac/arbeitsgruppen/herrmann/software/artaios.html>
  -  **Cuby**  A computational chemistry framework that provides  access to various computational methods available in different software package <http://cuby.molecular.cz/?page=Interfaces>
  - **autoDIAS** A python tool for an automated Distortion/Interaction Activation Strain Analysis <https://github.com/dsvatunek/autoDIAS>
  - **PolyParGen** provides OPLS-AA and Amber force field parameters for polymers or large molecules <http://polypargen.com>
  - **BiKi Life Sciences** is a suite for Molecular Dynamics and related methods in Drug Discovery <http://www.bikitech.com/products/>
  - **Shermo** is a general code for calculating molecular thermodynamic properties 
<http://sobereva.com/soft/shermo/>


## Programs that can display or manipulate cube and/or Molden files

The following programs can display cube files from [ charge density
](DPLOT#GAUSSIAN_--_Gaussian_Cube_format) and [
ESP](Properties#Gaussian_Cube_Files) and/or use
[Molden](Properties#Moldenfile) files

  - **gOpenMol** <http://www.csc.fi/~laaksone/gopenmol/gopenmol.html>
  - **Molden** <http://www.cmbi.ru.nl/molden/howtoget.html>
  - **Molekel** <http://ugovaretto.github.io/molekel/>
  - **GaussView** <http://www.gaussian.com/g_prod/gv5.htm>
  - **VMD** <http://www.ks.uiuc.edu/Research/vmd>
  - **VESTA** <http://jp-minerals.org/vesta/en/>
  - **Jamberoo**
    <http://sf.anu.edu.au/~vvv900/cct/appl/jmoleditor/index.html>
  - **Molden2AIM** is a utility program which can be used to create AIM-WFN, AIM-WFX, and NBO-47 files from a Molden file
     <https://github.com/zorkzou/Molden2AIM>

## Programs post-processing AIM files

NWChem can generate [AIM](Properties#Aimfile) wavefunction
files (.wfn/.wfx) can be post-processed with a variety of codes, e.g.

  - **XAIM** <http://www.quimica.urv.es/XAIM>
  - **NCIPLOT** <https://github.com/aoterodelaroza/nciplot>
  - **Multiwfn** <http://sobereva.com/multiwfn/>
  - **Postg** <https://github.com/aoterodelaroza/postg>
  - **GPUAM** <http://www.fqt.izt.uam.mx/html/Profes/JGO/GPUAM/GPUAM.html>
  - ** CHARGEMOL ** <https://sourceforge.net/projects/ddec/>
<!-- end list -->

1.  No longer been actively developed at PNNL. New development effort at
    <https://github.com/FriendsofECCE/ECCE/releases>
2.  The WebMo interface might not be compatible with NWChem 6.0 and
    later versions
