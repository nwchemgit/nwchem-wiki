

# Getting Started

This section provides an overview of NWChem input and program
architecture, and the syntax used to describe the input. See [Simple
Input File](#simple-input-file----scf-geometry-optimization)
and [Water Molecule Input](#water-molecule-sample-input-file)
for examples of NWChem input files with detailed explanation.

NWChem consists of independent modules that perform the various
functions of the code. Examples of modules include the input parser, SCF
energy, SCF analytic gradient, DFT energy, etc.. Data is passed between
modules and saved for restart using a disk-resident database or dumpfile
(see [NWChem Architecture](Release66:Nwarch "wikilink")).

The input to NWChem is composed of commands, called directives, which
define data (such as basis sets, geometries, and filenames) and the
actions to be performed on that data. Directives are processed in the
order presented in the input file, with the exception of certain
start-up directives (see [Input File
Structure](#input-file-structure "wikilink")) which provide critical job
control information, and are processed before all other input. Most
directives are specific to a particular module and define data that is
used by that module only. A few directives (see [Top-level
Directives](Top-level#top-level-directives "wikilink"))
potentially affect all modules, for instance by specifying the total
electric charge on the system.

There are two types of directives. Simple directives consist of one line
of input, which may contain multiple fields. Compound directives group
together multiple simple directives that are in some way related and are
terminated with an END directive. See the sample inputs ([Simple Input
File](#simple-input-file---_SCF_geometry_optimization "wikilink") and
[Water Molecule Input](#Water_Molecule_Sample_Input_File "wikilink"))
and the input syntax specification ([Input Format and Syntax for
Directives](#Input_Format_and_Syntax_for_Directives "wikilink")).

All input is free format and case is ignored except for actual data
(e.g., names/tags of centers, titles). Directives or blocks of
module-specific directives (i.e., compound directives) can appear in any
order, with the exception of the TASK directive (see [Input File
Structure](#Input_File_Structure "wikilink") and
[Tasks](Release66:Top-level#TASK "wikilink")) which is used to invoke an
NWChem module. All input for a given task must precede the TASK
directive. This input specification rule allows the concatenation of
multiple tasks in a single NWChem input file.

To make the input as short and simple as possible, most options have
default values. The user needs to supply input only for those items that
have no defaults, or for items that must be different from the defaults
for the particular application. In the discussion of each directive, the
defaults are noted, where applicable.

The input file structure is described in the following sections, and
illustrated with two examples. The input format and syntax for
directives is also described in detail.

## .nwchemrc for environment variables and libraries

Each user should have a .nwchemrc file to point to default data files,
such as basis sets, pseudopotentials, and MD potentials.

Contents of the default.nwchemrc file based on the above information
should
be:

` nwchem_basis_library `<location of NWChem installation>`/src/basis/libraries/`  
` nwchem_nwpw_library `<location of NWChem installation>`/src/nwpw/libraryps/`  
` ffield amber`  
` amber_1 `<location of NWChem installation>`/src/data/amber_s/`  
` amber_2 `<location of NWChem installation>`/src/data/amber_q/`  
` amber_3 `<location of NWChem installation>`/src/data/amber_x/`  
` amber_4 `<location of NWChem installation>`/src/data/amber_u/`  
` spce   `<location of NWChem installation>`/src/data/solvents/spce.rst`  
` charmm_s `<location of NWChem installation>`/src/data/charmm_s/`  
` charmm_x `<location of NWChem installation>`/src/data/charmm_x/`

It is can also be useful to use the NWCHEM\_BASIS\_LIBRARY environment
variable when testing a new libraries in your own directory. This will
allow you to overwrite the value of nwchem\_basis\_library in your
.nwchemrc file and point to the new basis library. For example:

`   % setenv NWCHEM_BASIS_LIBRARY "$NWCHEM/data-5.0/libraries/"`

Do not forget the trailing "/".

## Input File Structure

The structure of an input file reflects the internal structure of
NWChem. At the beginning of a calculation, NWChem needs to determine how
much memory to use, the name of the database, whether it is a new or
restarted job, where to put scratch/permanent files, etc.. It is not
necessary to put this information at the top of the input file, however.
NWChem will read through the entire input file looking for the start-up
directives. In this first pass, all other directives are ignored.

The start-up directives are

`START`  
`RESTART`  
`SCRATCH_DIR`  
`PERMANENT_DIR`  
`MEMORY`  
`ECHO`

After the input file has been scanned for the start-up directives, it is
rewound and read sequentially. Input is processed either by the
top-level parser (for the directives listed in [Top-level
Directives](Release66:Top-level "wikilink"), such as TITLE, SET, ...) or
by the parsers for specific computational modules (e.g., SCF, DFT, ...).
Any directives that have already been processed (e.g., MEMORY) are
ignored. Input is read until a TASK directive (see
[Tasks](Release66:Top-level#TASK "wikilink")) is encountered. A TASK
directive requests that a calculation be performed and specifies the
level of theory and the operation to be performed. Input processing then
stops and the specified task is executed. The position of the TASK
directive in effect marks the end of the input for that task. Processing
of the input resumes upon the successful completion of the task, and the
results of that task are available to subsequent tasks in the same input
file.

The name of the input file is usually provided as an argument to the
execute command for NWChem. That is, the execute command looks something
like the following

` nwchem input_file`

The default name for the input file is nwchem.nw. If an input file name
input\_file is specified without an extension, the code assumes .nw as a
default extension, and the input filename becomes input\_file.nw. If the
code cannot locate a file named either input\_file or input\_file.nw (or
nwchem.nw if no file name is provided), an error is reported and
execution terminates. The following section presents two input files to
illustrate the directive syntax and input file format for NWChem
applications.

## Simple Input File -- SCF geometry optimization

A simple example of an NWChem input file is an SCF geometry optimization
of the nitrogen molecule, using a Dunning cc-pvdz basis set. This input
file contains the bare minimum of information the user must specify to
run this type of problem -- fewer than ten lines of input, as follows:

` title "Nitrogen cc-pvdz SCF geometry optimization"`  
` geometry  `  
`   n 0 0 0`  
`   n 0 0 1.08`  
` end`  
` basis`  
`   n library cc-pvdz`  
` end`  
` task scf optimize`

Examining the input line by line, it can be seen that it contains only
four directives; TITLE, GEOMETRY, BASIS, and TASK. The TITLE directive
is optional, and is provided as a means for the user to more easily
identify outputs from different jobs. An initial geometry is specified
in Cartesian coordinates and Angstrøms by means of the GEOMETRY
directive. The Dunning cc-pvdz basis is obtained from the NWChem basis
library, as specified by the BASIS directive input. The TASK directive
requests an SCF geometry optimization.

The [GEOMETRY directive](Release66:Geometry "wikilink") defaults to
Cartesian coordinates and Angstrøms (options include atomic units and
Z-matrix format). The input blocks for the BASIS and GEOMETRY directives
are structured in similar fashion, i.e., name, keyword, ..., end (In
this simple example, there are no keywords). The BASIS input block must
contain basis set information for every atom type in the geometry with
which it will be used. Refer to Sections 7 and 8, and Appendix A for a
description of available basis sets and a discussion of how to define
new ones.

The last line of this sample input file (task scf optimize) tells the
program to optimize the molecular geometry by minimizing the SCF energy.
(For a description of possible tasks and the format of the TASK
directive, refer to [Tasks](Release66:Top-level#TASK "wikilink"))

If the input is stored in the file n2.nw, the command to run this job on
a typical UNIX workstation is as follows:

` nwchem n2`

NWChem output is to UNIX standard output, and error messages are sent to
both standard output and standard error.

## Water Molecule Sample Input File

A more complex sample problem is the optimization of a positively
charged water molecule using second-order Møller-Plesset perturbation
theory (MP2), followed by a computation of frequencies at the optimized
geometry. A preliminary SCF geometry optimization is performed using a
computationally inexpensive basis set (STO-3G). This yields a good
starting guess for the optimal geometry, and any Hessian information
generated will be used in the next optimization step. Then the
optimization is finished using MP2 and a basis set with polarization
functions. The final task is to calculate the MP2 vibrational
frequencies. The input file to accomplish these three tasks is as
follows:

`start h2o_freq`  
`charge 1`  
`geometry units angstroms`  
` O       0.0  0.0  0.0`  
` H       0.0  0.0  1.0`  
` H       0.0  1.0  0.0`  
`end`  
`basis`  
` H library sto-3g`  
` O library sto-3g`  
`end`  
`scf`  
` uhf; doublet`  
` print low`  
`end`  
`title "H2O+ : STO-3G UHF geometry optimization"`  
`task scf optimize`  
`basis`  
` H library 6-31g**`  
` O library 6-31g**`  
`end`  
`title "H2O+ : 6-31g** UMP2 geometry optimization"`  
`task mp2 optimize`  
`mp2; print none; end`  
`scf; print none; end`  
`title "H2O+ : 6-31g** UMP2 frequencies"`  
`task mp2 freq`

The START directive
([START/RESTART](Release66:Top-level#START_/_RESTART "wikilink") tells
NWChem that this run is to be started from the beginning. This directive
need not be at the beginning of the input file, but it is commonly
placed there. Existing database or vector files are to be ignored or
overwritten. The entry h2o\_freq on the START line is the prefix to be
used for all files created by the calculation. This convention allows
different jobs to run in the same directory or to share the same scratch
directory
[SCRATCH\_DIR/PERMANENT\_DIR](Release66:Top-level#SCRATCH_DIR_/_PERMANENT_DIR "wikilink"),
as long as they use different prefix names in this field.

As in the first sample problem, the geometry is given in Cartesian
coordinates. In this case, the units are specified as Angstrøms. (Since
this is the default, explicit specification of the units is not actually
necessary, however.) The CHARGE directive defines the total charge of
the system. This calculation is to be done on an ion with charge +1.

A small basis set (STO-3G) is specified for the intial geometry
optimization. Next, the multiple lines of the first SCF directive in the
scf ...end block specify details about the SCF calculation to be
performed. Unrestricted Hartree-Fock is chosen here (by specifying the
keyword uhf), rather than the default, restricted open-shell high-spin
Hartree-Fock (ROHF). This is necessary for the subsequent MP2
calculation, because only UMP2 is currently available for open-shell
systems (see Section 4). For open-shell systems, the spin multiplicity
has to be specified (using doublet in this case), or it defaults to
singlet. The print level is set to low to avoid verbose output for the
starting basis calculations.

All input up to this point affects only the settings in the runtime
database. The program takes its information from this database, so the
sequence of directives up to the first TASK directive is irrelevant. An
exchange of order of the different blocks or directives would not affect
the result. The TASK directive, however, must be specified after all
relevant input for a given problem. The TASK directive causes the code
to perform the specified calculation using the parameters set in the
preceding directives. In this case, the first task is an SCF calculation
with geometry optimization, specified with the input scf and optimize.
(See [Tasks](Release66:Top-level#TASK "wikilink") for a list of
available tasks and operations.)

After the completion of any task, settings in the database are used in
subsequent tasks without change, unless they are overridden by new input
directives. In this example, before the second task (task mp2 optimize),
a better basis set (6-31G\*\*) is defined and the title is changed. The
second TASK directive invokes an MP2 geometry optimization.

Once the MP2 optimization is completed, the geometry obtained in the
calculation is used to perform a frequency calculation. This task is
invoked by the keyword freq in the final TASK directive, task mp2 freq.
The second derivatives of the energy are calculated as numerical
derivatives of analytical gradients. The intermediate energies and
gradients are not of interest in this case, so output from the SCF and
MP2 modules is disabled with the PRINT directives.

## Input Format and Syntax for Directives

This section describes the input format and the syntax used in the rest
of this documentation to describe the format of directives. The input
format for the directives used in NWChem is similar to that of UNIX
shells, which is also used in other chemistry packages, most notably
GAMESS-UK. An input line is parsed into whitespace (blanks or tabs)
separating tokens or fields. Any token that contains whitespace must be
enclosed in double quotes in order to be processed correctly. For
example, the basis set with the descriptive name modified Dunning DZ
must appear in a directive as "modified Dunning DZ", since the name
consists of three separate words.

### Input Format

A (physical) line in the input file is terminated with a newline
character (also known as a \`return' or \`enter' character). A semicolon
(;) can be also used to indicate the end of an input line, allowing a
single physical line of input to contain multiple logical lines of
input. For example, five lines of input for the GEOMETRY directive can
be entered as follows;

` geometry`  
`  O 0  0     0`  
`  H 0  1.430 1.107`  
`  H 0 -1.430 1.107`  
` end`

These same five lines could be entered on a single line, as

` geometry; O 0 0 0; H 0 1.430 1.107; H 0 -1.430 1.107; end`

This one physical input line comprises five logical input lines. Each
logical or physical input line must be no longer than 1023 characters.

In the input file:

  - a string, token, or field is a sequence of ASCII characters (NOTE:
    if the string includes blanks or tabs (i.e., white space), the
    entire string must be enclosed in double quotes).
  - \\ (backslash) at the end of a line concatenates it with the next
    line. Note that a space character is automatically inserted at this
    point so that it is not possible to split tokens across lines. A
    backslash is also used to quote special characters such as
    whitespace, semi-colons, and hash symbols so as to avoid their
    special meaning (NOTE: these special symbols must be quoted with the
    backslash even when enclosed within double quotes).
  - ; (semicolon) is used to mark the end of a logical input line within
    a physical line of input.
  - \# (the hash or pound symbol) is the comment character. All
    characters following \# (up to the end of the physical line) are
    ignored.
  - If any input line (excluding Python programs, Section 38) begins
    with the string INCLUDE (ignoring case) and is followed by a valid
    file name, then the data in that file are read as if they were
    included into the current input file at the current line. Up to
    three levels of nested include files are supported. The user should
    note that inputting a basis set from the standard basis library
    ([Basis Sets](Basis_Sets "wikilink")) uses one level of include.
  - Data is read from the input file until an end-of-file is detected,
    or until the string EOF (ignoring case) is encountered at the
    beginning of an input line.

### Format and syntax of directives

Directives consist of a directive name, keywords, and optional input,
and may contain one line or many. Simple directives consist of a single
line of input with one or more fields. Compound directives can have
multiple input lines, and can also include other optional simple and
compound directives. A compound directive is terminated with an END
directive. The directives START (see
[START/RESTART](Release66:Top-level#START_/_RESTART "wikilink")) and
ECHO (see [ECHO](Release66:Top-level#ECHO "wikilink")) are examples of
simple directives. The directive GEOMETRY (see
[Release66:Geometry](Release66:Geometry "wikilink")) is an example of a
compound directive.

Some limited checking of the input for self-consistency is performed by
the input module, but most defaults are imposed by the application
modules at runtime. It is therefore usually impossible to determine
beforehand whether or not all selected options are consistent with each
other.

In the rest of this document, the following notation and syntax
conventions are used in the generic descriptions of the NWChem input.

  - a directive name always appears in all-capitals, and in computer
    typeface (e.g., GEOMETRY, BASIS, SCF). Note that the case of
    directives and keywords is ignored in the actual input.
  - a keyword always appears in lower case, in computer typeface (e.g.,
    swap, print, units, bqbq).
  - variable names always appear in lower case, in computer typeface,
    and enclosed in angle brackets to distinguish them from keywords
    (e.g., <input_filename>, <basisname>, <tag>).
  - $variable$ is used to indicate the substitution of the value of a
    variable.
  - () is used to group items (the parentheses and other special symbols
    should not appear in the input).
  - || separate exclusive options, parameters, or formats.
  - \[ \] enclose optional entries that have a default value.
  - \< \> enclose a type, a name of a value to be specified, or a
    default value, if any.
  - \\ is used to concatenate lines in a description.
  - ... is used to indicate indefinite continuation of a list.

An input parameter is identified in the description of the directive by
prefacing the name of the item with the type of data expected, i.e.,

  - string - an ASCII character string
  - integer - integer value(s) for a variable or an array
  - logical - true/false logical variable
  - real - real floating point value(s) for a variable or an array
  - double - synonymous with real

If an input item is not prefaced by one of these type names, it is
assumed to be of type \`\`string''.

In addition, integer lists may be specified using Fortran triplet
notation, which interprets lo:hi:inc as lo, lo+inc, lo+2\*inc, ..., hi.
For example, where a list of integers is expected in the input, the
following two lines are equivalent

`  7 10 21:27:2 1:3 99`  
`  7 10 21 23 25 27 1 2 3 99`

(In Fortran triplet notation, the increment, if unstated, is 1; e.g.,
1:3 = 1:3:1.)

The directive VECTORS (Section 10.5) is presented here as an example of
an NWChem input directive. The general form of the directive is as
follows:

` VECTORS [input (`<string input_movecs default atomic>`) || \`  
`                  (project `<string basisname>` `<string filename>`)] \`  
`         [swap [(alpha||beta)] `<integer vec1 vec2>` ...] \`  
`         [output <string output_movecs default $file_prefix$.movecs>]`

This directive contains three optional keywords, as indicated by the
three main sets of square brackets enclosing the keywords input, swap,
and output. The keyword input allows the user to specify the source of
the molecular orbital vectors. There are two mutually exclusive options
for specifying the vectors, as indicated by the || symbol separating the
option descriptions;

` (`<string input_movecs default atomic>`) || \`  
`                 (project `<string basisname>` `<string filename>`) \`

The first option, (<string input_movecs default atomic>), allows the
user to specify an ASCII character string for the parameter
input\_movecs. If no entry is specified, the code uses the default
atomic (i.e., atomic guess). The second option, (project
<string basisname> <string filename>), contains the keyword project,
which takes two string arguments. When this keyword is used, the vectors
in file <filename> will be projected from the (smaller) basis
<basisname> into the current atomic orbital (AO) basis.

The second keyword, swap, allows the user to re-order the starting
vectors, specifying the pairs of vectors to be swapped. As many pairs as
the user wishes to have swapped can be listed for \<integer vec1 vec2
... \>. The optional keywords alpha and beta allow the user to swap the
alpha or beta spin orbitals.

The third keyword, output, allows the user to tell the code where to
store the vectors, by specifying an ASCII string for the parameter
output\_movecs. If no entry is specified for this parameter, the default
is to write the vectors back into either the user- specified MO vectors
input file or, if this is not available, the file $file\_prefix$.movecs.

A particular example of the VECTORS directive is shown below. It
specifies both the input and output keywords, but does not use the swap
option.

` vectors input project "small basis" small_basis.movecs \`  
`         output large_basis.movecs`

This directive tells the code to generate input vectors by projecting
from vectors in a smaller basis named "small basis", which is stored in
the file small\_basis.movecs. The output vectors will be stored in the
file large\_basis.movecs.

The order of keyed optional entries within a directive should not
matter, unless noted otherwise in the specific instructions for a
particular directive.