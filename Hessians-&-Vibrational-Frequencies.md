# Hessians

This section relates to the computation of analytic hessians which are
available for open and closed shell SCF, except ROHF and for closed
shell and unrestricted open shell DFT \[1\]. Analytic hessians are not
currently available for SCF or DFT calculations relativistic
all-electron methodologies or for charge fitting with DFT. The current
algorithm is fully in-core and does not use symmetry.

There is no required input for the Hessian module. This module only
impacts the hessian calculation. For options for calculating the
frequencies, please see the [Vibrational](Vibration "wikilink") module.

## Hessian Module Input

All input for the Hessian Module is optional since the default
definitions are usually correct for most purposes. The generic module
input begins with hessian and has the form:

` hessian`  
`   thresh <real tol default 1d-6>`  
`   print ...`  
`   profile`  
` end`

### Defining the wavefunction threshold

You may modify the default threshold for the wavefunction. This keyword
is identical to
[THRESH](Release66:Hartree-Fock_Theory_for_Molecules#THRESH_--_convergence_threshold "wikilink")
in the SCF, and the
[CONVERGENCE](Density_Functional_Theory_for_Molecules#CONVERGENCE_--_SCF_Convergence_Control "wikilink")
gradient in the DFT. The usual defaults for the convergence of the
wavefunction for single point and gradient calculations is generally not
tight enough for analytic hessians. Therefore, the hessian, by default,
tightens these up to 1d-6 and runs an additional energy point if needed.
If, during an analytic hessian calculation, you encounter an error:

` cphf_solve:the available MOs do not satisfy the SCF equations`

the convergence criteria of the wavefunction generally needs to be
tightened.

### Profile

The PROFILE keyword provides additional information concerning the
computation times of different sections of the hessian code. Summary
information is given about the maximum, minimum and average times that a
particular section of the code took to complete. This is normally only
useful for developers.

### Print Control

Known controllable print options are shown in the table
below:

<center>

|                |                 |                                                 |
| -------------- | --------------- | ----------------------------------------------- |
| **Name**       | **Print Level** | **Description**                                 |
| "hess\_follow" | high            | more information about where the calculation is |
| "cphf\_cont"   | debug           | detailed CPHF information                       |
| "nucdd\_cont"  | debug           | detailed nuclear contribution information       |
| "onedd\_cont"  | debug           | detailed one electron contribution information  |
| "twodd\_cont"  | debug           | detailed two electron contribution information  |
| "fock\_xc"     | debug           | detailed XC information during the fock builds  |

Hessian Print Control Specifications

</center>

# Vibrational frequencies

The nuclear hessian which is used to compute the vibrational frequencies
can be computed by finite difference for any ab initio wave-function
that has analytic gradients or by analytic methods for SCF and DFT (see
[Hessians](#Hessians "wikilink") for details). The appropriate nuclear
hessian generation algorithm is chosen based on the user input when TASK
<theory> frequencies is the task directive.

The vibrational package was integrated from the Utah Messkit and can use
any nuclear hessian generated from the driver routines, finite
difference routines or any analytic hessian modules. There is no
required input for the "VIB" package. VIB computes the Infra Red
frequencies and intensities for the computed nuclear hessian and the
"projected" nuclear hessian. The VIB module projects out the
translations and rotations of the nuclear hessian using the standard
Eckart projection algorithm. It also computes the zero point energy for
the molecular system based on the frequencies obtained from the
projected hessian.

The default mass of each atom is used unless an alternative mass is
provided via the [geometry](Release66:Geometry "wikilink") input or
redefined using the vibrational module input. The default mass is the
mass of the most abundant isotope of each element. If the abundance was
roughly equal, the mass of the isotope with the longest half life was
used.

In addition, the vibrational analysis is given at the default standard
temperature of 298.15 degrees.

## Vibrational Module Input

All input for the Vibrational Module is optional since the default
definitions will compute the frequencies and IR intensities. The generic
module input can begin with vib, freq, frequency and has the form:

` {freq || vib || frequency}`  
`   [reuse [`<string hessian_filename>`]]`  
`   [mass `<integer lexical_index>` `<real new_mass>`]`  
`   [mass `<string tag_identifier>` `<real new_mass>`]`  
`   [{temp || temperature} `<integer number_of_temperatures>` \`  
`         <real temperature1 temperature2 ...>]`  
`   [animate [`<real step_size_for_animation>`]]`  
`   [fd_delta [`<real step_size_for_fd_hessian>`]]`  
`   [filename `<string file_set_name>` [overwrite]]`  
` end`

### Hessian File Reuse

By default the task <theory> frequencies directive will recompute the
hessian. To reuse the previously computed hessian you need only specify
reuse in the module input block. If you have stored the hessian in an
alternate place you may redirect the reuse directive to that file by
specifying the path to that file.

` reuse /path_to_hessian_file`

This will reuse your saved Hessian data but one caveat is that the
geometry specification at the point where the hessian is computed must
be the default "geometry" on the current run-time-data-base for the
projection to work properly.

### Redefining Masses of Elements

You may also modify the mass of a specific center or a group of centers
via the input.

To modify the mass of a specific center you can simply use:

` mass 3 4.00260324`

which will set the mass of center 3 to 4.00260324 AMUs. The lexical
index of centers is determined by the geometry object.

To modify all Hydrogen atoms in a molecule you may use the tag based
mechanism:

` mass hydrogen 2.014101779`

The mass redefinitions always start with the default masses and change
the masses in the order given in the input. Care must be taken to change
the masses properly. For example, if you want all hydrogens to have the
mass of Deuterium and the third hydrogen (which is the 6th atomic
center) to have the mass of Tritium you must set the Deuterium masses
first with the tag based mechanism and then set the 6th center's mass to
that of Tritium using the lexical center index mechanism.

The mass redefinitions are not fully persistent on the
run-time-data-base. Each input block that redefines masses will
invalidate the mass definitions of the previous input block. For
example,

`freq`  
`  reuse`  
`  mass hydrogen 2.014101779`  
`end`  
`task scf frequencies`  
`freq`  
`  reuse`  
`  mass oxygen 17.9991603`  
`end`  
`task scf frequencies`

will use the new mass for all hydrogens in the first frequency analysis.
The mass of the oxygen atoms will be redefined in the second frequency
analysis but the hydrogen atoms will use the default mass. To get a
modified oxygen and hydrogen analysis you would have to use:

`freq`  
`  reuse`  
`  mass hydrogen 2.014101779`  
`end`  
`task scf frequencies`  
`freq`  
`  reuse`  
`  mass hydrogen 2.014101779`  
`  mass oxygen 17.9991603`  
`end`  
`task scf frequencies`

### Temp or Temperature

The "VIB" module can generate the vibrational analysis at various
temperatures other than at standard room temperature. Either temp or
temperature can be used to initiate this command.

To modify the temperature of the computation you can simply use:

` temp 4 298.15 300.0 350.0 400.0`

At this point, the temperatures are persistant and so the user must
"reset" the temperature if the standard behavior is required after
setting the temperatures in a previous "VIB" command, i.e.

` temp 1 298.15`

### Animation

The "VIB" module also can generate mode animation input files in the
standard xyz file format for graphics packages like RasMol or XMol There
are scripts to automate this for RasMol in
$NWCHEM_TOP/contrib/rasmolmovie. Each mode will have 20 xyz files
generated that cycle from the equilibrium geometry to 5 steps in the
positive direction of the mode vector, back to 5 steps in the negative
direction of the mode vector, and finally back to the equilibrium
geometry. By default these files are not generated. To activate this
mechanism simply use the following input directive

` animate`

anywhere in the frequency/vib input block.

Given an ordered list of files containing molecular coordinates in XYZ
format, the rasmolmovie shell script generates an animated gif for each
of the six possible views down a Cartesian axis.

It uses the free utilities

` - rasmol `  
`   (http://www.umass.edu/microbio/rasmol) `  
`   to manipulate the molecule and generate the individual frames`  
` - convert from ImageMagick `  
`   (http://www.imagemagick.org/)`  
`   to combine the frames into an animated gif`

It should be easy to modify the script to other file formats or
animation tools.

#### Controlling the Step Size Along the Mode Vector

By default, the step size used is 0.15 a.u. which will give reliable
animations for most systems. This can be changed via the animate input
directive, e.g.

`vib`  
`   animate 0.20`  
`end`

where <step_size> is the real number that is the magnitude of each step
along the eigenvector of each nuclear hessian mode in atomic units.

### Specifying filenames for animated normal modes

By default, normal modes will be stored in files that start with
"freq.m-<mode number>". This is inconvenient if more than vibrational
analysis is run in a single input file. To specify different filename
for a particular vibrational analysis use the directive

`filename `<file_set_name>` [overwrite]`

where <file_set_name> is the name that will be prepended to the usual
filenames. In addition the code by default requires all files to be new
files. When the option "overwrite" is provided any pre-existing files
will simply be overwritten.

### Controlling the Step Size of the Finite difference Hessian

By default, the step size used for calculating the finite difference
Hessian is 0.010 a.u. for DFT and NWPW modules, and 0.001 a.u. otherwise
This can be changed via the fd\_delta input directive, e.g.

`vib`  
`   fd_delta 0.005`  
`end`

where <fd_hessian_step_size> is the real number that is the magnitude of
each displacement in atomic units for the calculation of the finite
difference Hessian. For older versions of NWChem without the fd\_delta
option just set the "stpr\_gen:delta" value on the runtime database,
e.g.

`set stpr_gen:delta 0.005`

### An Example Input Deck

This example input deck will optimize the geometry for the given basis
set, compute the frequencies for <img alt="$H_{2}O$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/d7fc8f229a929f93c03b951b7fe40bf0.svg?invert_in_darkmode&sanitize=true" align=middle width="33.934725pt" height="22.38192pt"/>, <img alt="$H_{2}O$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/d7fc8f229a929f93c03b951b7fe40bf0.svg?invert_in_darkmode&sanitize=true" align=middle width="33.934725pt" height="22.38192pt"/> at different
temperatures, <img alt="$D_{2}O$" src="https://raw.githubusercontent.com/wiki/nwchemgit/nwchem/svgs/ce64a0239658825eb59f2dbb21363632.svg?invert_in_darkmode&sanitize=true" align=middle width="33.88011pt" height="22.38192pt"/>, HDO, and TDO.

`start  h2o`  
`title Water `  
`geometry units au autosym`  
`  O      0.00000000    0.00000000    0.00000000`  
`  H      0.00000000    1.93042809   -1.10715266`  
`  H      0.00000000   -1.93042809   -1.10715266`  
`end`  
`basis noprint`  
`  H library sto-3g `  
`  O library sto-3g`  
`end`  
`scf; thresh 1e-6; end`  
`driver; tight; end`  
`task scf optimize`  
  
`scf; thresh 1e-8; print none; end`  
`task scf freq `  
  
`freq`  
` reuse; temp 4 298.15 300.0 350.0 400.0`  
`end`  
`task scf freq`  
  
`freq `  
` reuse; mass H 2.014101779`  
` temp 1 298.15`  
`end`  
`task scf freq`  
  
`freq`  
` reuse; mass 2 2.014101779`  
`end`  
`task scf freq`  
  
`freq`  
` reuse; mass 2 2.014101779 ; mass 3 3.01604927`  
`end`  
`task scf freq`

## References

<references/>

1.  Johnson, B.G. and Frisch, M.J. (1994) "An implementation of analytic
    second derivatives of the gradient-corrected density functional
    energy", *Journal of Chemical Physics* **100** 7429-7442,
    [doi:\[http://dx.doi.org/10.1063/1.466887](doi:%5Bhttp://dx.doi.org/10.1063/1.466887)
    10.1063/1.466887\]
