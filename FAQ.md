
# General information about NWChem

## Where is the User's Manual?

The NWChem User's Manual is now at [https://github.com/nwchemgit/nwchem/wiki](https://github.com/nwchemgit/nwchem/wiki) 

## Where do I go for help with a Global Arrays problem?

If you have problems with compiling the tools directory, please visit
the Global Arrays Google group at
<http://groups.google.com/group/hpctools> or visit the Global Arrays
website at <http://hpc.pnl.gov/globalarrays/>

## Where do I go for help with NWChem problems?

Please post your NWChem issue to the NWChem forum hosted on Google Groups at
<https://groups.google.com/forum/#!forum/nwchem-forum>

## Where do I find the instructions for installing NWChem?

For updated instructions for compiling NWChem please visit the following
URL <https://github.com/nwchemgit/nwchem/wiki/Compiling-NWChem>

# Installation Problems

## How to fix `configure: error: could not compile simple C MPI program`

When compiling the tools directory, you might see the compilation
stopping with the message `configure: error: could not compile simple C
MPI program` This is most likely due to incorrect settings for the
`MPI_LIB`, `MPI_INCLUDE` and `LIBMPI` environment variables. The
suggested course of action is a) to use NWChem 6.6, b) unset all of the
three variables above and c) point your `PATH` env. variable to the
location of mpif90. If bash is your shell choice, this can be
accomplished by typing

`unset MPI_LIB`  
`unset MPI_INCLUDE `  
`unset LIBMPI`  
`export PATH="directory where mpif90 is located":$PATH`

## What's this business with ARMCI and ARMCI\_NETWORK?

ARMCI is a library used by Global Arrays (both ARMCI and GA source code
is located in NWChem's tools directory). More information can be found
at the following URL <http://hpc.pnl.gov/armci> If your installation
uses a fast network and you are aiming to get optimal communication
performance, you might want to assign a non-default value to
`ARMCI_NETWORK`. The following links contained useful information about
`ARMCI_NETWORK`: [ Choosing the ARMCI
library](Release66:ARMCI "wikilink") and [ Setting up the proper
environment\_variables when compiling
NWChem](Compiling_NWChem#Setting_up_the_proper_environment_variables "wikilink")

# Input Problems

## I get the message: `! warning: processed input with no task`. What is wrong?

Have you used emacs to create your input file? Emacs usually does not
put and an end-of-line as a last character of the file, therefore the
NWChem input parser ignores the last line of your input (the one
containing the task directive). To fix the problem, add one more blank
line after the task line and your task directive will be executed.

## AUTOZ fails to generate valid internal coordinates. Now what?

If AUTOZ fails, NWChem will default to using Cartesian coordinates (and
ignore any zcoord data) so you don't have to do anything unless you
really need to use internal coordinates. An exception are certain cases
where we have a molecule that contains a linear chain of 4 or more
atoms, in which case the code will fail (see item 2. for work arounds).
For small systems you can easily construct a Z-matrix, but for larger
systems this can be quite hard.

First check your input. Are you using the correct units? The default is
Angstroms. If you input atomic units but did not tell NWChem, then it's
no wonder things are breaking. Also, is the geometry physically
sensible? If atoms are too close to each other you'll get many
unphysical bonds, whereas if they are too far apart AUTOZ will not be
able to figure out how to connect things.

Once the obvious has been checked, there are several possible modes of
failure, some of which may be worked around in the input.

1\. Strictly linear molecules with 3 or more atoms. AUTOZ does not
generate linear bend coordinates, but, just as in a real Z-matrix, you
can specify a dummy center that is not co-linear. There are two relevant
tips: i) constrain the dummy center to be not co-linear otherwise the
center could become co-linear. Also, the inevitable small forces on the
dummy center can confuse the optimizer. ii) put the dummy center far
enough away so that only one connection is generated.

E.g., this input for acetylene will not use internals

``` 
           geometry
             h  0  0  0
             c  0  0  1
             c  0  0  2.2
             h  0  0  3.2
           end

           but this one will

           geometry
             zcoord
               bond    2 3  3.0  cx constant
               angle 1 2 3 90.0 hcx constant
             end
             h  0  0  0
             c  0  0  1
             x  3  0  1
             c  0  0  2.2
             h  0  0  3.2
           end
```

2\. Larger molecules that contain a strictly linear chain of four or
more atoms (that ends in a free atom). For these molecules the autoz
will fail and the code can currently not recover by using cartesians.
One has to explicitly define noautoz in the geometry input to make it
work. If internal coordinates are required one can fix it in the same
manner as described above. However, you can also force a connection to a
real nearby atom.

3\. Very highly connected systems generate too many internal coordinates
which can make optimization in redundant internals less efficient than
in Cartesians. For systems such as clusters of atoms or small molecules,
try using a smaller value of the scaling factor for covalent radii

`zcoord; cvr_scaling 0.9; end`

In addition to this you can also try specifying a minimal set of bonds
to connect the fragments.

If these together don't work, then you're out of luck. Use Cartesians or
construct a Z-matrix.

## How do I restart a geometry optimization?

If you have saved the restart information that is kept in the permanent
directory, then you can restart a calculation, as long as it did not
crash while writing to the data base.

Following are two input files. The first starts a geometry optimization
for ammonia. If this stops for nearly any reason such as it was
interrupted, ran out of time or disk space, or exceeded the maximum
number of iterations, then it may be restarted with the second job.

The key points are

  - The first job contains a START directive with a name for the
    calculation.
  - All subsequent jobs should contain a RESTART directive with the same
    name for the calculation.
  - All jobs must specify the same permanent directory. The default
    permanent directory is the current directory.
  - If you want to change anything in the restart job, just put the data
    before the task directive. Otherwise, all options will be the same
    as in the original job.

Job 1.

``` 
         start ammonia
         permanent_dir /u/myfiles

         geometry
           zmatrix
             n
             h 1 nh
             h 1 nh 2 hnh
             h 1 nh 2 hnh 3 hnh -1
           variables
             nh 1.
             hnh 115.
           end
         end

         basis
           n library 3-21g; h library 3-21g
         end

         task scf optimize
```

Job 2.

``` 
         restart ammonia
         permanent_dir /u/myfiles

         task scf optimize
```

# Execution Problems

## How do I set the correct value for `ARMCI_DEFAULT_SHMMAX`?

Some ARMCI\_NETWORK values (e.g. OPENIB) depend on the
`ARMCI_DEFAULT_SHMMAX` value for large allocations of Global memory. We
recommend a value of -- at least -- 2048, e.g. in bash shell parlance

`export ARMCI_DEFAULT_SHMMAX=2048`

A value of 2048 for ARMCI\_DEFAULT\_SHMMAX corresponds to 2048 GBytes,
equal to 2048\*1024\*1024=2147483648 bytes. For
ARMCI\_DEFAULT\_SHMMAX=2048 to work, it is necessary that kernel
parameter `kernel.shmmax` to be greater than 2147483648. You can check
the current value of `kernel.shmmax` on your system by typing

`sysctl kernel.shmmax`

More detail about kernel.shmmax can be found at the webpage
<https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/5/html/Tuning_and_Optimizing_Red_Hat_Enterprise_Linux_for_Oracle_9i_and_10g_Databases/sect-Oracle_9i_and_10g_Tuning_Guide-Setting_Shared_Memory-Setting_SHMALL_Parameter.html>
