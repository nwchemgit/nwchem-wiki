# Format of MD files

## Format of fragment file  


| Card                                                             | Format    | Description                          |
| :--------------------------------------------------------------- | :---------| :----------------------------------- |
| I-1-1                                                            | a1        | $ or \# comments to describe fragment           |
| I-2-1                                                            | i5        | number of atoms in the fragment                 |
| I-2-2                                                            | i5        | number of parameter sets                        |
| I-2-3                                                            | i5        | default parameter set                           |
| I-2-4                                                            | i5        | number of z-matrix definition                   |
| **For each parameter** | ||
| **set one card I-3**| ||
| I-3-1                                                            | a         | residue name for parameter set                  |
| **For each atom one deck II**                                    |
| II-1-1                                                           | i5        | atom sequence number                            |
| II-1-2                                                           | a6        | atom name                                       |
| II-1-3                                                           | a5        | atom type                                       |
| II-1-4                                                           | a1        | dynamics type                                   |
|                                                                  |           | blank : normal                                  |
|                                                                  |           | D : dummy atom                                  |
|                                                                  |           | S: solute interactions only                     |
|                                                                  |           | Q : quantum atom                                |
|                                                                  |           | other : intramolecular solute interactions only |
| II-1-5                                                           | i5        | link number                                     |
|                                                                  |           | 0: no link                                      |
|                                                                  |           | 1: first atom in chain                          |
|                                                                  |           | 2: second atom in chain                         |
|                                                                  |           | 3 and up: other links                           |
| II-1-6                                                           | i5        | environment type                                |
|                                                                  |           | 0: no special identifier                        |
|                                                                  |           | 1: planar, using improper torsion               |
|                                                                  |           | 2: tetrahedral, using improper torsion          |
|                                                                  |           | 3: tetrahedral, using improper torsion          |
|                                                                  |           | 4: atom in aromatic ring                        |
| II-1-7                                                           | i5        |                                                 |
| II-1-8                                                           | i5        | charge group                                    |
| II-1-9                                                           | i5        | polarization group                              |
| II-1-10                                                          | f12.6     | atomic partial charge                           |
| II-1-11                                                          | f12.6     | atomic polarizability                           |
| **For each additional**                   |||
| **parameter set on card II-2**            |||
| II-2-1                                                           | 11x,a6    | atom type                                       |
| II-2-2                                                           | a1        | dynamics type                                   |
|                                                                  |           | blank : normal                                  |
|                                                                  |           | D : dummy atom                                  |
|                                                                  |           | S : solute interactions only                    |
|                                                                  |           | Q : quantum atom                                |
|                                                                  |           | other : intramolecular solute interactions only |
| II-2-7                                                           | 25x,f12.6 | atomic partial charge                           |
| II-2-8                                                           | f12.6     | atomic polarizability                           |
| **Any number of cards in deck III to**  |
| **specify complete connectivity** |
| III-1-1                                                          | 16i5      | connectivity, duplication allowed               |
| **One blank card to signal**     |||
| **the end of the connectivity list**       || |
| **For each z-matrix definition one card IV**                         |
| IV-1-1                                                           | i5        | atom i                                          |
| IV-1-2                                                           | i5        | atom j                                          |
| IV-1-3                                                           | i5        | atom k                                          |
| IV-1-4                                                           | i5        | atom l                                          |
| IV-1-5                                                           | f12.6     | bond length i-j                                 |
| IV-1-6                                                           | f12.6     | angle i-j-k                                     |
| IV-1-7                                                           | f12.6     | torson i-j-k-l                                  |



  
## Format of segment file (1 of 7)  
  

| Card                                | Format | Description                                 |
| :---------------------------------- | :----- | :------------------------------------------ |
| I-0-1                               |        | \# lines at top are comments                |
| I-1-1                               | a1     | $ to identify the start of a segment        |
| I-1-2                               | a10    | name of the segment, the tenth character    |
|                                     |        | N: identifies beginning of a chain          |
|                                     |        | C: identifies end of a chain                |
|                                     |        | blank: identifies chain fragment            |
|                                     |        | M: identifies an integral molecule          |
| I-2-1                               | f12.6  | version number                              |
| I-3-1                               | i5     | number of atoms in the segment              |
| I-3-2                               | i5     | number of bonds in the segment              |
| I-3-3                               | i5     | number of angles in the segment             |
| I-3-4                               | i5     | number of proper dihedrals in the segment   |
| I-3-5                               | i5     | number of improper dihedrals in the segment |
| I-3-6                               | i5     | number of z-matrix definitions              |
| I-3-7                               | i5     | number of parameter sets                    |
| 1-3-8                               | i5     | default parameter set                       |
| For each parameter set one card I-4 |
| I-4-1                               | f12.6  | dipole correction energy                    |




## Format of segment file (2 of 7)  


| Card                                 | Format | Description                                            |
| :----------------------------------- | :----- | :----------------------------------------------------- |
| For each atom one deck II            |
| II-1-1                               | i5     | atom sequence number                                   |
| II-1-2                               | a6     | atom name                                              |
| II-1-3                               | i5     | link number                                            |
| II-1-4                               | i5     | environment type                                       |
|                                      |        | 0: no special identifier                               |
|                                      |        | 1: planar, using improper torsion                      |
|                                      |        | 2: tetrahedral, using improper torsion                 |
|                                      |        | 3: tetrahedral, using improper torsion                 |
|                                      |        | 4: atom in aromatic ring                               |
| II-1-5                               | i5     |                                                        |
| II-1-6                               | i5     | charge group                                           |
| II-1-7                               | i5     | polarization group                                     |
| For each parameter set one card II-2 |
| II-2-1                               | 5x,a5  | atom type                                              |
| II-2-2                               | a1     | dynamics type                                          |
|                                      |        | blank : normal                                         |
|                                      |        | D : dummy atom                                         |
|                                      |        | S : solute interactions only                           |
|                                      |        | Q : quantum atom                                       |
|                                      |        | other : intramolecular solute interactions only        |
| II-2-3                               | f12.6  | atomic partial charge in e                             |
| II-2-4                               | f12.6  | atomic polarizability (4 &pi; &epsilon;<sub>o</sub> in nm<sup>3</sup>) |


  
## Format of segment file (3 of 7)  
  


| Card                                  | Format | Description                                   |
| :------------------------------------ | :----- | :-------------------------------------------- |
| For each bond a deck III              |
| III-1-1                               | i5     | bond sequence number                          |
| III-1-2                               | i5     | bond atom i                                   |
| III-1-3                               | i5     | bond atom j                                   |
| III-1-4                               | i5     | bond type                                     |
|                                       |        | 0: harmonic                                   |
|                                       |        | 1: constrained bond                           |
| III-1-5                               | i5     | bond parameter origin                         |
|                                       |        | 0: from database, next card ignored           |
|                                       |        | 1: from next card                             |
| For each parameter set one card III-2 |
| III-2-1                               | f12.6  | bond length in nm                             |
| III-2-2                               | e12.5  | bond force constant in (kJ nm<sup>2</sup> mol<sup>-1</sup>) |



  
## Format of segment file (4 of 7)  
  

| Card                                 | Format | Description                             |
| :----------------------------------- | :----- | :-------------------------------------- |
| For each angle a deck IV             |
| IV-1-1                               | i5     | angle sequence number                   |
| IV-1-2                               | i5     | angle atom i                            |
| IV-1-3                               | i5     | angle atom j                            |
| IV-1-4                               | i5     | angle atom k                            |
| IV-1-5                               | i5     | angle type                              |
|                                      |        | 0: harmonic                             |
| IV-1-6                               | i5     | angle parameter origin                  |
|                                      |        | 0: from database, next card ignored     |
|                                      |        | 1: from next card                       |
| For each parameter set one card IV-2 |
| IV-2-1                               | f10.6  | angle in radians                        |
| IV-2-2                               | e12.5  | angle force constant in (kJ mol<sup>-1</sup>) |


  
## Format of segment file (5 of 7)  


| Card                                | Format | Description                                       |
| :---------------------------------- | :----- | :------------------------------------------------ |
| For each proper dihedral a deck V   |
| V-1-1                               | i5     | proper dihedral sequence number                   |
| V-1-2                               | i5     | proper dihedral atom i                            |
| V-1-3                               | i5     | proper dihedral atom j                            |
| V-1-4                               | i5     | proper dihedral atom k                            |
| V-1-5                               | i5     | proper dihedral atom l                            |
| V-1-6                               | i5     | proper dihedral type                              |
|                                     |        | 0: (*C*cos(m&phi;-&delta;)                        |
| V-1-7                               | i5     | proper dihedral parameter origin                  |
|                                     |        | 0: from database, next card ignored               |
|                                     |        | 1: from next card                                 |
| For each parameter set one card V-2 |
| V-2-1                               | i3     | multiplicity                                      |
| V-2-2                               | f10.6  | proper dihedral in radians                        |
| V-2-3                               | e12.5  | proper dihedral force constant in (kJ mol<sup>-1</sup>) |




   
## Format of segment file (6 of 7)  
  


| Card                                 | Format   | Description                                         |
| :----------------------------------- | :------- | :-------------------------------------------------- |
| For each improper dihedral a deck VI |
| VI-1-1                               | i5       | improper dihedral sequence number                   |
| VI-1-2                               | i5       | improper dihedral atom i                            |
| VI-1-3                               | i5       | improper dihedral atom j                            |
| VI-1-4                               | i5       | improper dihedral atom k                            |
| VI-1-5                               | i5       | improper dihedral atom l                            |
| VI-1-6                               | i5       | improper dihedral type                              |
|                                      |          | 0: harmonic                                         |
| VI-1-7                               | i5       | improper dihedral parameter origin                  |
|                                      |          | 0: from database, next card ignored                 |
|                                      |          | 1: from next card                                   |
| For each parameter set one card VI-2 |
| VI-2-1                               | 3x,f10.6 | improper dihedral in radians                        |
| VI-2-2                               | e12.5    | improper dihedral force constant in (kJ mol<sup>-1</sup>) |



## Format of segment file (7 of 7)



| Card                                      | Format | Description     |
| :---------------------------------------- | :----- | :-------------- |
| For each z-matrix definition one card VII |
| VII-1-1                                   | i5     | atom i          |
| VII-1-2                                   | i5     | atom j          |
| VII-1-3                                   | i5     | atom k          |
| VII-1-4                                   | i5     | atom l          |
| VII-1-5                                   | f12.6  | bond length i-j |
| VII-1-6                                   | f12.6  | angle i-j-k     |
| VII-1-7                                   | f12.6  | torson i-j-k-l  |



## Format of sequence file



| Card                                                         | Format | Description                            |
| :----------------------------------------------------------- | :----- | :--------------------------------------------------------- |
| I-1-1                                                        | a1     | $ to identify the start of a sequence                      |
| I-1-2                                                        | a10    | name of the sequence                                       |
| Any number of cards 1 and 2 in deck II |
| to specify the system |
| II-1-1                                                       | i5     | segment number                                             |
| II-1-2                                                       | a10    | segment name, last character will be determined from chain |
| II-2-1                                                       | a      | break to identify a break in the molecule chain            |
| II-2-1                                                       | a      | molecule to identify the end of a solute molecule          |
| II-2-1                                                       | a      | fraction to identify the end of a solute fraction          |
| II-2-1                                                       | a5     | link to specify a link                                     |
| II-2-2                                                       | i5     | segment number of first link atom                          |
| II-2-3                                                       | a4     | name of first link atom                                    |
| II-2-4                                                       | i5     | segment number of second link atom                         |
| II-2-5                                                       | a4     | name of second link atom                                   |
| II-2-1                                                       | a      | solvent to identify solvent definition on next card        |
| II-2-1                                                       | a      | stop to identify the end of the sequence                   |
| II-2-1                                                       | a6     | repeat to repeat next ncard cards ncount times             |
| II-2-2                                                       | i5     | number of cards to repeat (ncards)                         |
| II-2-3                                                       | i5     | number of times to repeat cards (ncount)                   |
| Any number of cards in deck II |
| to specify the system         |



## Format of trajectory file



| Card                                                                         | Format    | Description                           |
| :--------------------------------------------------------------------------- | :-------- | :------------------------------------ |
| I-1-1                                                                        | a6        | keyword header                                                |
| I-2-1                                                                        | i10       | number of atoms per solvent molecule                          |
| I-2-2                                                                        | i10       | number of solute atoms                                        |
| I-2-3                                                                        | i10       | number of solute bonds                                        |
| I-2-4                                                                        | i10       | number of solvent bonds                                       |
| I-2-5                                                                        | i10       | number of solvent molecules                                   |
| I-2-6                                                                        | i10       | precision of the coordinates. 0=standard, 1=high              |
| For each atom per solvent molecule one card I-3                              |
| I-3-1                                                                        | a5        | solvent name                                                  |
| I-3-2                                                                        | a5        | atom name                                                     |
| For each solute atom one card I-4                                            |
| I-4-1                                                                        | a5        | segment name                                                  |
| I-4-2                                                                        | a5        | atom name                                                     |
| I-4-3                                                                        | i6        | segment number                                                |
| I-4-4                                                                        | i10       | solute atom counter                                           |
| I-4-5                                                                        | i5        | integer 1                                                     |
| For each solvent bond one card I-5                                           |
| I-5-1                                                                        | i8        | atom index i for bond between i and j                         |
| I-5-2                                                                        | i8        | atom index j for bond between i and j                         |
| For each solute bond one card I-6                                            |
| I-6-1                                                                        | i8        | atom index i for bond between i and j                         |
| I-6-2                                                                        | i8        | atom index j for bond between i and j                         |
| For each frame one deck II                                                   |
| II-1-1                                                                       | a5        | keyword frame                                                 |
| II-2-1                                                                       | f12.6     | time of frame in ps                                           |
| II-2-2                                                                       | 12.6      | temperature of frame in K                                     |
| II-2-3                                                                       | e12.5     | pressure of frame in Pa                                       |
| II-2-4                                                                       | a10       | date                                                          |
| II-2-5                                                                       | a10       | time                                                          |
| II-3-1                                                                       | f12.6     | box dimension x                                               |
| II-3-2                                                                       | 12x,f12.6 | box dimension y                                               |
| II-3-3                                                                       | 24x,f12.6 | box dimension z                                               |
| II-4-1                                                                       | l1        | logical lxw for solvent coordinates                           |
| II-4-2                                                                       | l1        | logical lvw for solvent velocities                            |
| II-4-3                                                                       | l1        | logical lfw for solvent forces                                |
|                                                                              | I-4-4     | l1                                                            |
| II-4-5                                                                       | l1        | logical lxs for solute coordinates                            |
| II-4-6                                                                       | l1        | logical lvs for solute velocities                             |
| II-4-7                                                                       | l1        | logical lfs for solute forces                                 |
| II-4-8                                                                       | l1        | logical lps for solute induced dipoles                        |
| II-4-5                                                                       | i10       | number of solvent molecules                                   |
| II-4-6                                                                       | i10       | number of solvent atoms                                       |
| II-4-7                                                                       | i10       | number of solute atoms                  |
|  | |
| **For each solvent molecule one card II-5** ||
| **for each atom, if standard precision** ||
| II-5-1                                                                       | 3f8.3     | solvent atom coordinates, if lxw or lvw                       |
| II-5-4                                                                       | 3f8.3     | solvent atom velocities, if lvw                               |
| II-5-7                                                                       | 3f8.1     | solvent atom forces, if lfw                                   |
| **For each solute atom one card II-6** ||
| **for each atom, if standard precision**     ||
| II-6-1                                                                       | 3f8.3     | solute atom coordinates, if lxs or lvs                        |
| II-6-4                                                                       | 3f8.3     | solute atom velocities, if lvs                                |
| II-6-7                                                                       | 3f8.1     | solute atom forces, if lfs                                    |
| **For each solvent molecule one card II-5** ||
| **for each atom, if high precision**     ||
| II-5-1                                                                       | 3e12.6    | solvent atom coordinates, if lxw or lvw                       |
| II-5-4                                                                       | 3e12.6    | solvent atom velocities, if lvw                               |
| II-5-7                                                                       | 3e12.6    | solvent atom forces, if lfw (on new card if both lxw and lvw) |
| **For each solute atom one card II-6**  |  |
| **for each atom, if high precision**          |  |
| II-6-1                                                                       | 3e12.6    | solute atom coordinates, if lxs or lvs                        |
| II-6-4                                                                       | 3e12.6    | solute atom velocities, if lvs                                |
| II-6-7                                                                       | 3e12.6    | solute atom forces, if lfs (on new card if both lxs and lvs)  |



## Format of free energy file


| Card                                    | Format  | Description                                                          |
| :-------------------------------------- | :------ | :------------------------------------------------------------------- |
| For each step in &lambda; one deck I |
| I-1-1                                   | i7      | number nderiv of data summed in derivative decomposition array deriv |
| I-1-2                                   | i7      | length ndata of total derivative array drf                           |
| I-1-3                                   | f12.6   | current value of &lambda;                                         |
| I-1-4                                   | f12.6   | step size of &lambda;                                             |
| I-2-1                                   | 4e12.12 | derivative decomposition array deriv(1:24)                           |
| I-3-1                                   | 4e12.12 | total derivative array dfr(1:nda)                                    |
| I-4-1                                   | i10     | size of ensemble at current &lambda;                              |
| I-4-2                                   | e20.12  | average temperature at current &lambda;                           |
| I-4-3                                   | e20.12  | average exponent reverse perturbation energy at current &lambda;  |
| I-4-4                                   | e20.12  | average exponent forward perturbation energy at current &lambda;  |




  
## Format of root mean square deviation file  


| Card                                     | Format | Description                                                      |
| :--------------------------------------- | :----- | :--------------------------------------------------------------- |
| For each analyzed time step one card I-1 |
| I-1-1                                    | f12.6  | time in ps                                                       |
| I-1-2                                    | f12.6  | total rms deviation of the selected atoms before superimposition |
| I-1-3                                    | f12.6  | total rms deviation of the selected atoms after superimposition  |
| II-1-1                                   | a8     | keyword analysis                                                 |
| For each solute atom one card II-2       |
| II-2-1                                   | a5     | segment name                                                     |
| II-2-2                                   | a5     | atom name                                                        |
| II-2-3                                   | i6     | segment number                                                   |
| II-2-4                                   | i10    | atom number                                                      |
| II-2-5                                   | i5     | selected if 1                                                    |
| II-2-6                                   | f12.6  | average atom rms deviation after superimposition                 |
| III-1-1                                  | a8     | keyword analysis                                                 |
| For each solute segment one card III-2   |
| III-2-1                                  | a5     | segment name                                                     |
| III-2-2                                  | i6     | segment number                                                   |
| III-2-3                                  | f12.6  | average segment rms deviation after superimposition              |



## Format of property file



| Card                                          | Format     | Description                         |
| :-------------------------------------------- | :--------- | :---------------------------------- |
| 1                                             | i7         | number nprop of recorded properties |
| I-1-2                                         | 1x,2a10    | date and time                       |
| For each of the nprop properties one card I-2 |            |                                     |
| I-2-1                                         | a50        | description of recorded property    |
| For each recorded step one deck II            |            |                                     |
| II-1-1                                        | 4(1pe12.5) | value of property                   |






