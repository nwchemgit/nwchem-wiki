# Dynamical Nucleation Theory Monte Carlo

1.  Schenter, G. K.; Kathmann, S. M.; Garrett, B. C. J. Chem. Phys.
    (1999), 110, 7951.
2. Crosby, L. D.; Kathmann, S. M.; Windus, T. L.
    J. Comput. Chem. ( 2008), submitted.

The Dynamical Nucleation Theory Monte Carlo (DNTMC) module utilizes
Dynamical Nucleation Theory (DNT) to compute monomer evaporation rate
constants at a given temperature. The reactant is a molecular cluster of
*i* rigid monomers while the product is a molecular cluster with *i-1*
monomers plus a free monomer. A Metropolis Monte Carlo (MC) methodology
is utilized to sample the configurational space of these *i* rigid
monomers. Both homogenous and heterogenous clusters are supported.

## SubGroups

The DNTMC module supports the use of subgroups in the MC simulations.
The number of subgroups is defined in the input through a set directive:
```
    set subgroup_number <integer number>
```
where the number of subgroups requested is the argument. The number of
processors that each subgroup has access to is determined by
Total/subgroup_number. A separate MC simulation is performed within
each subgroup. To use this functionality, NWChem must be compiled with
the USE_SUBGROUPS environmental variable set.

Each MC simulation starts at a different starting configuration, which
is equally spaced along the reaction coordinate. The statistical
distributions which these MC simulations produce are averaged to form
the final statistical distribution. Output from these subgroups consists
of various files whose names are of the form (`*.#num`). These files
include restart files and other data files. The NWChem runtime database
(RTDB) is used as input for these subgroups and must be globally
accessible (set through the Permanent_Dir directive) to all processes.

## Input Syntax

The input block has the following form:
```
 DNTMC  
    [nspecies <integer number>]  
    [species  <list of strings name[nspecies]]  
    [nmol     <list of integers number[nspecies]>]  
      
    [temp     <real temperature>]  
    [rmin     <real rmin>]  
    [rmax     <real rmax>]  
    [nob      <integer nob>]  
    [mcsteps  <integer number>]  
    [tdisp    <real disp>]  
    [rdisp    <real rot>]  
    [rsim || rconfig]  
    [mprnt    <integer number>]  
    [convergence <real limit>]  
    [norestart]  
    [dntmc_dir <string directory>]  
      
    [print &&|| noprint]  
      
    [procrestart <integer number>]  
 END
```
## Definition of Monomers

Geometry information is required for each unique monomer (species). See
the geometry input section 6 for more information. A unique label must
be given for each monomer geometry. Additionally, the noautosym and
nocenter options are suggested for use with the DNTMC module to prevent
NWChem from changing the input geometries. Symmetry should also not be
used since cluster configurations will seldom exhibit any symmetry;
although monomers themselves may exhibit symmetry.
```
 GEOMETRY [<string name species_1>] noautosym nocenter ...  
     ...  
 symmetry c1  
 END  
   
 GEOMETRY [<string name species_2>] noautosym nocenter ...  
     ...  
 symmetry c1  
 END  
   
 ...
```
The molecular cluster is defined by the number of unique monomers
(nspecies). The geometry labels for each unique monomer is given in a
space delimited list (species). Also required are the number of each
unique monomer in the molecular cluster given as a space delimited list
(nmol). These keywords are required and thus have no default values.
```
    [nspecies <integer number>]  
    [species  <list of strings name[nspecies]]  
    [nmol     <list of integers number[nspecies]>]
```
An [example](#example) is shown for a 10 monomer cluster
consisting of a 50/50 mixture of water and ammonia.

## DNTMC runtime options

Several options control the behavior of the DNTMC module. Some required
options such as simulation temperature (temp), cluster radius (rmin and
rmax), and maximum number of MC steps (mcsteps) are used to control the
MC simulation.
```
    [temp     <real temperature>]
```
This required option gives the simulation temperature in which the MC
simulation is run. Temperature is given in kelvin.
```
    [rmin     <real rmin>]  
    [rmax     <real rmax>]  
    [nob    <integer nob>]
```
These required options define the minimum and maximum extent of the
projected reaction coordinate (The radius of a sphere centered at the
center of mass). Rmin should be large enough to contain the entire
molecular cluster of monomers and Rmax should be large enough to include
any relevant configurational space (such as the position of the reaction
bottleneck). These values are given in Angstroms.

The probability distributions obtain along this projected reaction
coordinate has a minimum value of Rmin and a maximum value of Rmax. The
distributions are created by chopping this range into a number of
smaller sized bins. The number of bins (nob) is controlled by the option
of the same name.
```
    [mcsteps  <integer number>]  
    [tdisp    <real disp default 0.04>]  
    [rdisp    <real rot default 0.06>]  
    [convergence <real limit default 0.00>]
```
These options define some characteristics of the MC simulations. The
maximum number of MC steps (mcsteps) to take in the course of the
calculation run is a required option. Once the MC simulation has
performed this number of steps the calculation will end. This is a per
Markov chain quantity. The maximum translational step size (tdisp) and
rotational step size (rdisp) are optional inputs with defaults set at
0.04 Angstroms and 0.06 radians, respectively. The convergence keyword
allows the convergence threshold to be set. The default is 0.00 which
effectively turns off this checking. Once the measure of convergence
goes below this threshold the calculation will end.

`    [rsim || rconfig]`

These optional keywords allow the selection of two different MC sampling
methods. rsim selects a Metropolis MC methodology which samples
configurations according to a Canonical ensemble. The rconfig keyword
selects a MC methodology which samples configurations according to a
derivative of the Canonical ensemble with respect to the projected
reaction coordinate. These keywords are optional with the default method
being rconfig.
```
    [mprnt    <integer number default 10>]  
    [dntmc_dir <string directory default ./>]  
    [norestart]
```
These three options define some of the output and data analysis
behavior. mprnt is an option which controls how often data analysis
occurs during the simulation. Currently, every `mprnt*nob` MC steps data
analysis is performed and results are output to files and/or to the log
file. Restart files are also written every mprnt number of MC steps
during the simulation. The default value is 10. The keyword dntmc_dir
allows the definition of an alternate directory to place DNTMC specific
ouputfiles. These files can be very large so be sure enough space is
available. This directory should be accessible by every process
(although not necessarily globally accessible). The default is to place
these files in the directory which NWChem is run (./). The keyword
norestart turns off the production of restart files. By default restart
files are produced every mprnt number of MC steps.

## Print Control

The DNTMC module supports the use of PRINT and NOPRINT Keywords. The
specific labels which DNTMC recognizes are included
below.

<center>

|               |                 |                                                                                                                                                                                                                          |
| ------------- | --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Name**      | **Print Level** | **Description**                                                                                                                                                                                                          |
| "debug"       | debug           | Some debug information written in Output file.                                                                                                                                                                           |
| "information" | none            | Some information such as energies and geometries.                                                                                                                                                                        |
| "mcdata"      | low             | Production of a set of files (`Prefix.MCdata.#num`). These files are a concatenated list of structures, Energies, and Dipole Moments for each accepted configuration sampled in the MC run.                             |
| "alldata"     | low             | Production of a set of files (`Prefix.Alldata.#num`). These files include the same information as MCdata files. However, they include ALL configurations (accepted or rejected).                                          |
| "mcout"       | debug - low     | Production of a set of files (`Prefix.MCout.#num`). These files contain a set of informative and debug information. Also included is the set of information which mirrors the Alldata files.                              |
| "fdist"       | low             | Production of a file (`Prefix.fdist`) which contains a concatenated list of distributions every `mprnt*100` MC steps.                                                                                                       |
| "timers"      | debug           | Enables some timers in the code. These timers return performance statistics in the output file every time data analysis is performed. Two timers are used. One for the mcloop itself and one for the communication step. |

</center>

## Selected File Formats

Several output files are available in the DNTMC module. This section
defines the format for some of these files.

1.  `*.fdist`  
      
    This file is a concatenated list of radial distribution functions
    printed out every mprnt MC steps. Each distribution is normalized
    (sum equal to one) with respect to the entire (all species)
    distribution. The error is the RMS deviation of the average at each
    point. Each entry is as follows:
    
```    
    [1] # Total Configurations 
    [2] Species number # 
    [3](R coordinate in Angstroms) (Probability) (Error) 
    [Repeats nob times] 
    [2 and 3 Repeats for each species]
    [4] *** separator.  
```

2.  `*.MCdata.#`  
      
    This file is a concatenated list of accepted configurations. Each
    file corresponds to a single Markov chain. The dipole is set to zero
    for methods which do not produce a dipole moment with energy
    calculations. Rsim is either the radial extent of the cluster
    (r-config) or the simulation radius (r-simulation). Each entry is as
    follows:  

```    
    [1] (Atomic label) (X Coord.) (Y Coord.) (Z Coord.) 
    [1 Repeats for each atom in the cluster configuration, units are in
    angstroms] 
    [2] Ucalc = # hartree 
    [3] Dipole = (X) (Y) (Z) au
    [4] Rsim = # Angstrom 
    [1 through 4 repeats for each accepted configuration]  
```

3.  `*.MCout.#`  
      
    This file has the same format and information content as the MCdata
    file except that additional output is included. This additional
    output includes summary statistics such as acceptance ratios,
    average potential energy, and average radius. The information
    included for accepted configurations does not include dipole moment
    or radius.  
      
4.  `*.MCall.#`  
      
    This file has the same format as the MCdata file expect that it
    includes information for all configurations for which an energy is
    determined. All accepted and rejected configurations are included in
    this file.  
      
5.  `*.restart.#`  
      
    This file contains the restart information for each subgroup. Its
    format is not very human readable but the basic fields are described
    in short here.

```
    Random number seed Potential energy in hartrees
    Sum of potential energy
    Average potential energy
    Sum of the squared potential energy
    Squared potential energy Dipole moment in au (x) (Y) (Z)
    Rmin and Rmax Rsim (Radius corresponds to r-config or r-sim methods)
    Array of nspecies length, value indicates the number of  each type of monomer which lies at radius Rsim from the center of mass [r-simulation sets these to zero]
    Sum of Rsim Average of Rsim
    Number of accepted translantional moves
    Number of accepted rotational moves Number of accepted volume moves
    Number of attempted moves (volume) (translational) (rotational)
    Number of accepted moves (Zero)
    Number of accepted moves (Zero)
    Number of MC steps completed
    [1] (Atom label) (X Coord.) (Y Coord.) (Z Coord.)
    [1 repeats for each atom in cluster configurations, units are in angstroms]
    [2] Array of nspecies length, number of configurations in bin
    [3] Array of nspecies length, normalized number of configurations in each bin
    [4] (Value of bin in Angstroms) (Array of nspecies length, normalized probability of bin)
    [2 through 4 repeats nob  times]
```

## DNTMC Restart
```
[procrestart <integer number>]
```
Flag to indicate restart postprocessing. It is suggested that this
postprocessing run is done utilizing only one processor.

In order to restart a DNTMC run, postprocessing is required to put
required information into the runtime database (RTDB). During a run
restart information is written to files (`Prefix.restart.#num`) every
mprnt MC steps. This information must be read and deposited into the
RTDB before a restart run can be done. The number taken as an argument
is the number of files to read and must also equal the number of
subgroups the calculation utilizes. The start directive must also be set
to restart for this to work properly. All input is read as usual.
However, values from the restart files take precedence over input
values. Some keywords such as mcsteps are not defined in the restart
files. Task directives are ignored. You must have a RTDB present in your
permanent directory.

Once postprocessing is done a standard restart can be done from the RTDB
by removing the procrestart keyword and including the restart directive.

## Task Directives

The DNTMC module can be used with any level of theory which can produce
energies. Gradients and Hessians are not required within this
methodology. If dipole moments are available, they are also utilized.
The task directive for the DNTMC module is shown below:  

```
   task <string theory> dntmc
```
## Example

This example is for a molecular cluster of 10 monomers. A 50/50 mixture
of water and ammonia. The energies are done at the SCF/6-31++G** level
of theory.

```
   start  
   # start or restart directive if a restart run  
   MEMORY 1000 mb  
     
   PERMANENT_DIR /home/bill  
   # Globally accessible directory which the  
   # rtdb (*.db) file will/does reside.  
     
   basis "ao basis" spherical noprint  
       * library 6-31++G**  
   end  
   # basis set directive for scf energies  
     
   scf  
       singlet  
       rhf  
       tol2e 1.0e-12  
       vectors input atomic  
       thresh 1.0e-06  
       maxiter 200  
       print none  
   end  
   # scf directive for scf energies  
     
   geometry geom1 units angstroms noautosym nocenter noprint  
   O  0.393676503613369      -1.743794626956820      -0.762291912129271  
   H -0.427227157125777      -1.279138812526320      -0.924898279781319  
   H  1.075463952717060      -1.095883929075060      -0.940073459864222  
   symmetry c1  
   end  
   # geometry of a monomer with title "geom1"  
     
   geometry geom2 units angstroms noautosym nocenter noprint  
   N     6.36299e-08     0.00000     -0.670378  
   H     0.916275     0.00000     -0.159874  
   H     -0.458137     0.793517     -0.159874  
   H     -0.458137     -0.793517     -0.159874  
   symmetry c1  
   end  
   # geometry of another monomer with title "geom2"  
   # other monomers may be included with different titles  
     
   set subgroups_number 8  
   # set directive which gives the number of subgroups  
   # each group runs a separate MC simulation  
     
   dntmc  
   # DNTMC input block  
       nspecies 2  
       # The number of unique species (number of titled geometries  
       # above)  
       species geom1 geom2  
       # An array of geometry titles (one for each  
       # nspecies/geometry)  
       nmol    5  5  
       # An array stating the number of each  
       # monomer/nspecies/geometry in simulation.  
       temp  243.0  
       mcsteps 1000000  
       rmin 3.25  
       rmax 12.25  
       mprnt 10  
       tdisp 0.04  
       rdisp 0.06  
       print none fdist mcdata  
       # this print line first sets the print-level to none  
       # then it states that the *.fdist and *.mcdata.(#num)  
       # files are to be written  
       rconfig  
       dntmc_dir /home/bill/largefile  
       # An accessible directory which to place the *.fdist,  
       # *.mcdata.(#num), and *.restart.(#num) files.  
       convergence 1.0D+00  
   end  
     
   task scf dntmc  
   # task directive stating that energies are to be done at the scf  
   #level of theory.
```   
