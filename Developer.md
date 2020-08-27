# NWChem Development

NWChem is being developed by a consortium of scientists and maintained
at the EMSL at PNNL. A [current list of developers can be found
here](Developer_Team). This page provides important
information for current and new developers.

## Downloading from and Committing to the NWChem source tree

The NWChem source is maintained with [git](https://git-scm.com/), an
open-source version control system. To download NWChem you must have
[git](https://git-scm.com/) installed on your development platform. For
an extensive description of the GIT functionality and commands, please
check the git documentation.

The NWChem GIT repository is hosted on Github at
https://github.com/nwchemgit/nwchem/

  - **Downloading**

The development version (git master branch) of NWChem can be downloaded using the command
```
    % git clone https://github.com/nwchemgit/nwchem
```
A branch version cane be downloaded by using the -b option of git clone. For example,
the hotfix/release-6-8 branch can be downloaded with the command

```
git clone -b hotfix/release-6-8  \
https://github.com/nwchemgit/nwchem nwchem-6.8.1
```


  - **Committing changes adding new files**

Committing changes to existing source files can be done using the
command

TBD ....

TBD Instructions on Fork & Pull

1.  Before committing any changes or additions, make sure the NWChem
    tree compiles properly
2.  Run QA tests (if not the full suite, please try the one relevant for the NWChem module you have just modified).
2.  When adding new files, make sure to properly update the GNUMakefile
    in the directory you are working in, so that the new file gets
    compiled
3.  Do document your changes and additions using the "-m" option of git
    commit

## Obtaining Read/Write access to NWChem source tree

Developer access to the NWChem source tree branches in svn is password
restricted. New potential developers should contact members of the
NWChem Core Developer
Team.

Before contributions from this new developer can be incorporated into
NWChem, this person will have to provide written feedback that the
contributions can be released within NWChem under a
[ECL 2.0 open-source license](http://www.opensource.org/licenses/ecl2.php).

A (Trusted) Developer will receive the appropriate access to the
nwchemgit github repository. If a Developer consistently incorporates
code changes that negatively affect the development tree, access to the
nwchemgit github repository can be revoked.

To Be Revised: %% The type of developer and their level of access are:

1.  NWChem Core Developer: Developer has full git access to release and
    development branches of the NWChem source tree. Owns and is
    responsible for one or more modules.
2.  Trusted Developer: Developer may be internal or external to PNNL but
    has full svn access to release and development branches of the
    NWChem source tree. May own or be responsible for one or more
    modules.
3.  Developer: Developer may be internal or external to PNNL and has
    selected svn access to the development branch of the NWChem source
    tree. Each Developer closely coordinates code contributions with the
    assigned Point of Contact (POC) from the NWChem Core Developer Team,
    primarily the Core Developer owning the module in which the
    contributions will reside. If the development leads to a new module,
    the NWChem Core Developer Team will assign a POC with responsibility
    for the new module.
4.  Contributor: Contributor may be internal or external to PNNL and has
    no access to the development branch of the NWChem source tree.
    Contributor’s code will be incorporated by the Point of Contact from
    the NWChem Core Developer Team. This is the main mechanism for
    external users to contribute developments or enhancements to NWChem.

## Compiling NWChem from source

A detailed step-by-step description of the build process and necessary
and optional environment variables is outlined on the [Compiling
NWChem](Compiling-NWChem) page.

## Development Contribution Requirements

All new functionality or capability contributions require:

1.  Proper documentation in the user manual
2.  QA Test Cases that adequately test the added functionality

Proposed new modules and tasks, and their impact on existing modules and
functionality need to be documented for review. New modules or tasks
will require agreement from the full team before they can be added.

## Programming Model and Languages

The programming model in is based on independent "task" modules that
perform various functions in the code and are build on modular APIs.
Modules and APIs can share data, or share access to files containing
data, only through a (most of the time) [disk-resident run time
database](NWChem-Architecture), which is similar to the
GAMESS-UK dumpfile or the Gaussian checkpoint file. The run time
database contains all the information necessary to
[restart](Top-level#START_.2F_RESTART) a task.

The [structure and flow of the program and input](Top-level)
are such that it allows for performing multiple tasks within one job.
Input is read and stored into the run time database until a [TASK
directive](TASK) is encountered. When a [TASK
directive](TASK) is found in the input, the appropriate
module will extract relevant data from the database and any associated
files and perform the requested calculation. Upon completion of the
task, the module will store significant results in the database, and may
also modify other database entries in order to affect the behavior of
subsequent computations.

  - Programming rules:

<!-- end list -->

1.  All routines should start with "implicit none" and all variables
    used in the routine should be specified explicitly.
2.  Minimize or avoid sharing of data through common blocks. Instead use
    the run time database.
3.  Memory Allocation will be done through the MA and GA memory
    infrastructure.
4.  Global Arrays Toolkit and MPI for parallel programming.

<!-- end list -->

  - NWChem consists of the programming languages:

<!-- end list -->

1.  FORTRAN77 and FORTRAN90. For FORTRAN90, avoid -- when possible -- using allocates and
    deallocates. Dynamic memory access should be performed using the
    memory access (MA) layer.
2.  C and C++. Only simple constructs should be used in C++.
3.  OpenMP directives and CUDA/OpenCL.
4.  Python scripts can be uploaded into the contrib directory. Bindings
    to additional functionality require QA and documentation.

## Testing of Master version

1.  Any check-in into the Github repository is tested using Travis-CI
    <https://travis-ci.org/>.
2.  Code will be tested nightly against QA suite.
3.  Exhaustive coverage analysis of the QA suite will be performed twice
    a year.

## NWChem Mailing List Archive

The archive of the NWChem Mailing list can be found
[here](https://nwchemgit.github.io/Archived-Forum.html).

## NWChem Wiki Page Guidelines

Follow the link to the [NWChem Wiki Page
Guidelines](Guidelines-for-Authors).

## NWChem Doxygen documentation

The source code in NWChem is documented using Doxygen in a number of
places. In order to enable documentation for a given directory only a
script has been created in

` nwchem/contrib/doxygen/run_doxygen`

This script can be run in any subdirectory of the NWChem source tree. It
will automatically adapt the Doxygen configuration file for the
directory it is run in and generate documentation for that directory and
all its children. The documentation is generated in a subdirectory
```
 doxydocs
```
and can be viewed, for example, by running
```
 % firefox doxydocs/html/index.html
```
Doxygen has many capabilities and a number of them can be driven through
the run\_doxygen script. Run
```
  % run_doxygen -h
```
for more details.

## Module specific details

### The NWXC module: higher order derivatives of density functionals

The NWXC module was primarily developed to provide higher order
derivatives of density functionals. In addition it provides
infrastructure needed to manage all aspects of a DFT energy expression
in one place, including the range separation of the exchange integrals
and dispersion corrections.

The derivatives of the density functionals can be optained in two
different ways:

  - by automatic differentiation
  - by symbolic algebra

#### The directory structure of the NWXC module

  - nwxc
      - nwad
          - maxima
          - unit\_tests
      - maxima
          - bin
          - max
          - f77

<b>nwxc</b> is the top-level directory. It also contains the code for
the module API as well as the automatically differentiated code of the
density functionals.

<b>nwad</b> contains the automatic differentiation module.

<b>nwad/maxima</b> contains a script to help create the automatic
differentiation unit tests.

<b>nwad/unit\_tests</b> contains the unit tests.

<b>maxima</b> contains the symbolic algebra tools as well as the code
they generate

<b>maxima/bin</b> contains the scripts that driver the Maxima symbolic
algebra engine as well as utility scripts that process the Maxima
generated Fortran.

<b>maxima/max</b> contains the Maxima specifications of the functionals.

<b>maxima/f77</b> contains the Maxima generated Fortran code.

#### API functions

API routines of the NWXC module are

  - <b>nwxc\_input \[nwxc\_nwchem.F\]</b> parse the functional input
    line
  - <b>nwxc\_print \[nwxc\_nwchem.F\]</b> print the current functional
    definition
  - <b>nwxc\_print\_nwpw \[nwxc\_nwchem.F\]</b> print the current
    functional formatted for the NWPW module
  - <b>nwxc\_rtdb\_store \[nwxc\_nwchem.F\]</b> store the current
    functional definition
  - <b>nwxc\_rtdb\_load \[nwxc\_nwchem.F\]</b> load the currentl
    functional definition
  - <b>nwxc\_is\_on \[nwxc\_query.F\]</b> is NWXC activated?
  - <b>nwxc\_has\_hfx \[nwxc\_query.F\]</b> does the functional have
    Hartree-Fock exchange?
  - <b>nwxc\_has\_mp2 \[nwxc\_query.F\]</b> does the functional have a
    fraction of MP2 correlation?
  - <b>nwxc\_has\_cam \[nwxc\_query.F\]</b> does the functional use
    Coulomb operator attenuation?
  - <b>nwxc\_has\_disp \[nwxc\_query.F\]</b> does the functional have
    dispersion correction terms?
  - <b>nwxc\_get\_cam \[nwxc\_query.F\]</b> get the Coulomb attenuation
    parameters
  - <b>nwxc\_get\_disp \[nwxc\_query.F\]</b> get the dispersion
    correction parameters
  - <b>nwxc\_wght\_hfx \[nwxc\_query.F\]</b> get the Hartree-Fock
    exchange fraction
  - <b>nwxc\_wght\_mp2 \[nwxc\_query.F\]</b> get the MP2 correlation
    fraction
  - <b>nwxc\_is\_lda \[nwxc\_query.F\]</b> is the functional an LDA
    functional?
  - <b>nwxc\_is\_gga \[nwxc\_query.F\]</b> is the functional a GGA
    functional?
  - <b>nwxc\_is\_mgga \[nwxc\_query.F\]</b> is the functional a meta-GGA
    functional?
  - <b>nwxc\_eval\_df \[nwxc\_eval.F\]</b> evaluate the functional and
    its first order partial derivatives
  - <b>nwxc\_eval\_df2 \[nwxc\_eval.F\]</b> evaluate the functional and
    its first and second order partial derivatives
  - <b>nwxc\_eval\_df3 \[nwxc\_eval.F\]</b> evaluate the functional and
    its first, second, and third order partial derivatives

#### Adding new functionals

Within the NWXC module specific terms of the density fucntionals are
identified by an integer constant. These constants are listed in
<b>nwxcP.fh</b>, Currently the order of the constants is: exchange
functionals first, correlation functionals second, and finally combined
exchange-correlation functionals. Within each class the constants are
sorted alphabetically. To add a new functional a new constant needs to
be inserted into nwxcP.fh first.

Internally a functional is stored as two lists of terms. One list
contains the specification as entered by the user. This specification is
used to print the functional in the output, and to store the functional
on the runtime data base. The other list contains the specification of
the functional as it is used to evaluate the expression. These lists as
well as the Coulomb attenuation and dispersion correction parameters are
controlled from <b>nwxc\_add\_df \[nwxc\_add.F\]</b>. The translation of
an input string to the appropriate functional needs to be added here.

In order to print the functional the code uses the name and reference
for the functional (or functional terms). The function
<b>nwxc\_get\_info \[nwxc\_query.F\]</b> returns the corresponding
character string given the integer identifier of a functional. For a new
functional this reference needs to be added.

As the NWXC module currently supports both automatic differentiation as
well as symbolic algebra generated implementations of the functionals
there are two parallel sets of routines that invoke the actual
functional evaluation. The routines <b>nwxc\_eval\_df\_doit</b>,
<b>nwxc\_eval\_df2\_doit</b>, and <b>nwxc\_eval\_df3\_doit</b>
<b>\[nwxc\_eval.F\]</b> invoke the automatic differentiation
implementations. The routines <b>nwxcm\_eval\_df</b>,
<b>nwxcm\_eval\_df2</b>, and <b>nwxcm\_eval\_df3</b>
<b>\[nwxcm\_eval.F\]</b> invoke the Maxima generated implementations.
The appropriate subroutine calls need to be added in these places.

Comments:

  - Note that there is no need to specify the type of the functional
    (LDA, GGA, meta-GGA) as the NWXC module auto-detects this.
  - Note that to achieve reasonable performance for the automatic
    differentiation code the source code of a subroutine needs to be
    included in the file <b>nwxc.F</b>. The reason is that because every
    operator and every intrinsic function is overloaded the performance
    of the automatic differentiation code is extremely sensitive to the
    level of code inlining that the compiler can perform. Unfortunately
    most compilers cannot inline across files or different compiler
    invocations hence all automatic differentiation code must be
    compiled at once.
  - Note that the Maxima generated code always expects a list of
    parameters (even when they are not used). This is a consequence of
    the fact that automatic code generation works best with a strictly
    regimented framework. In the automatic differentiation approach
    there is more flexibility as the energy expression is hand written
    code.
  - Note that the automatic differentiation library generates a number
    of modules each one provides the same data type but the
    implementation of that data type changes:
      - <b>nwad0</b> calculates up to zeroth order derivatives (i.e. it
        just evaluates the basic expression)
      - <b>nwad1</b> calculates up to first order derivatives
      - <b>nwad2</b> calculates up to second order derivatives
      - <b>nwad3</b> calculates up to third order derivatives
      - <b>nwadp1</b> prints the expression being evaluated and
        calculates derivatives up to first order

#### Generating code for a functional

One way to generate the code for a new functional to add is shown in
workflow schematic
[NWXC code generation workflow](Code_generation_workflow.jpg)

The step involved can be summarized as:

  - Create an automatic differentiation implementation
      - Take a Fortran implementation of a functional and strip the code
        for all the derivatives out, leaving just the energy expression
        itself.
      - Change the data type of the input arrays (rho, rgamma, and tau)
        as well as of the output array (func or fnc).
      - Include "nwad.fh" before the "implicit" statement.
      - Change the data type of the appropriate intermediate variables
        (compiler errors result where assignments of derived data type
        variables to double precision variables remain)
  - Generate the Maxima expression
      - Add the functional printing version of the automatically
        differentiated code to <b>nwxc\_eval\_df\_doit\_print
        \[nwxc\_eval\_print.F\]</b>.
      - Recompile <b>nwxc\_fnc\_print</b> (run "make nwxc\_fnc\_print"
        in the nwxc directory).
      - Add an input file to <b>maxima/input</b> to print the
        expression.
      - In the "maxima" directory run "make max/\<functional\>.max" to
        generate the Maxima expression.
  - Generate the symbolic algebra implementation
      - In the "maxima" directory edit the GNUmakefile uncommenting the
        AUTOXC and AUTOXC\_DS variables.
      - Add the appropriate Fortran file to the OBJ variable.
      - Run "make f77/\<functional\>.F" to generate the Fortran source
        code (this may take a while).
