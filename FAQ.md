
# General information about NWChem

## Where is the User's Manual?

The NWChem User's Manual is now at
[https://nwchemgit.github.io/Home.html](https://nwchemgit.github.io/Home.html)

## Where do I go for help with a Global Arrays problem?

If you have problems with compiling the tools directory, please visit
the Global Arrays Google group at
<http://groups.google.com/g/hpctools/> or visit the Global Arrays
website at <http://hpc.pnl.gov/globalarrays/>

## Where do I go for help with NWChem problems?

Please post your NWChem issue to the NWChem forum hosted on Google Groups at
[https://groups.google.com/g/nwchem-forum](https://groups.google.com/g/nwchem-forum)

## Where do I find the installation instructions?

For updated instructions for compiling NWChem please visit the following
URL [https://nwchemgit.github.io/Compiling-NWChem.html](https://nwchemgit.github.io/Compiling-NWChem.html)

## Installation Problem for the tools directory

When compiling the tools directory, you might see the compilation
stopping with the message

```
configure: error: could not compile simple C MPI program
```

This is most likely due to incorrect settings for the
`MPI_LIB`, `MPI_INCLUDE` and `LIBMPI` environment variables. The
suggested course of action is to unset all of the
three variables above and point your `PATH` env. variable to the
location of `mpif90`. If bash is your shell choice, this can be
accomplished by typing

```
unset MPI_LIB
unset MPI_INCLUDE
unset LIBMPI
export PATH="directory where mpif90 is located":$PATH
```

## What are ARMCI and ARMCI_NETWORK?

ARMCI is a library used by Global Arrays (both ARMCI and GA source code
is located in NWChem's tools directory). More information can be found
at the following URL <http://hpc.pnl.gov/armci>  
If your installation
uses a fast network and you are aiming to get optimal communication
performance, you might want to assign a non-default value to
`ARMCI_NETWORK`.  
The following links contained useful information about
`ARMCI_NETWORK`:  

- [Choosing the ARMCI library](ARMCI)
- [Choosing the proper environment variables when compiling NWChem](Compiling-NWChem.md#setting-up-the-proper-environment-variables)  

## Input Problem: no output

You might encounter the following error message:

```
! warning: processed input with no task
```

Have you used emacs to create your input file? Emacs usually does not
put and an end-of-line as a last character of the file, therefore the
NWChem input parser ignores the last line of your input (the one
containing the task directive). To fix the problem, add one more blank
line after the task line and your task directive will be executed.

## Input problem: AUTOZ fails to generate valid internal coordinates

If [AUTOZ](Keywords-for-the-GEOMETRY-directive.md#autoznoautoz) fails, NWChem will default to using Cartesian coordinates (and
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

1. Strictly linear molecules with 3 or more atoms. AUTOZ does not
generate linear bend coordinates, but, just as in a real Z-matrix, you
can specify a dummy center that is not co-linear. There are two relevant
tips:

- constrain the dummy center to be not co-linear otherwise the
center could become co-linear. Also, the inevitable small forces on the
dummy center can confuse the optimizer.
- put the dummy center far
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

2. Larger molecules that contain a strictly linear chain of four or
more atoms (that ends in a free atom). For these molecules the autoz
will fail and the code can currently not recover by using cartesians.
One has to explicitly define noautoz in the geometry input to make it
work. If internal coordinates are required one can fix it in the same
manner as described above. However, you can also force a connection to a
real nearby atom.

3. Very highly connected systems generate too many internal coordinates
which can make optimization in redundant internals less efficient than
in Cartesians. For systems such as clusters of atoms or small molecules,
try using a smaller value of the scaling factor for covalent radii

```
zcoord; cvr_scaling 0.9; end
```

In addition to this you can also try specifying a minimal set of bonds
to connect the fragments.

If these together don't work, then you're out of luck. Use either 
Cartesians coordinates (by using the geometry [NOAUTOZ](Keywords-for-the-GEOMETRY-directive.md#autoznoautoz) keyword) or
supply your own Z-matrix (using the [ZMATRIX](ZMATRIX.md) input option).

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

## Execution Problem: How do I set the value of ARMCI_DEFAULT_SHMMAX?

Some ARMCI_NETWORK values (e.g. OPENIB) depend on the
`ARMCI_DEFAULT_SHMMAX` value for large allocations of Global memory. We
recommend a value of -- at least -- 2048, e.g. in bash shell parlance

```
export ARMCI_DEFAULT_SHMMAX=2048
```

A value of 2048 for ARMCI_DEFAULT_SHMMAX corresponds to 2048 GBytes,
equal to 2048*1024*1024=2147483648 bytes. For
ARMCI_DEFAULT_SHMMAX=2048 to work, it is necessary that kernel
parameter `kernel.shmmax` to be greater than 2147483648. You can check
the current value of `kernel.shmmax` on your system by typing

```
sysctl kernel.shmmax
```

More detail about kernel.shmmax can be found at this [link](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/5/html/tuning_and_optimizing_red_hat_enterprise_linux_for_oracle_9i_and_10g_databases/sect-oracle_9i_and_10g_tuning_guide-setting_shared_memory-setting_shmall_parameter)

## WSL execution problems

NWChem runs on Windows Subsystem for Linux (WSL) can crash with the error message

```
--------------------------------------------------------------------------
WARNING: Linux kernel CMA support was requested via the
btl_vader_single_copy_mechanism MCA variable, but CMA support is
not available due to restrictive ptrace settings.

The vader shared memory BTL will fall back on another single-copy
mechanism if one is available. This may result in lower performance.

  Local host: hostabc
--------------------------------------------------------------------------
[hostabc:16805] 1 more process has sent help message help-btl-vader.txt / cma-permission-denied
[hostabc:16805] Set MCA parameter "orte_base_help_aggregate" to 0 to see all help / error messages
```

The error can be fixed with the following command

```
echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
```

More details at

- [https://github.com/Microsoft/WSL/issues/3397#issuecomment-417876710](https://github.com/Microsoft/WSL/issues/3397#issuecomment-417876710)  
- [https://nwchemgit.github.io/Special_AWCforum/st/id2939/mpirun_nwchem_on_Windows_Subsyst....html](https://nwchemgit.github.io/Special_AWCforum/st/id2939/mpirun_nwchem_on_Windows_Subsyst....html)  

## How do I increase the number of digits of the S matrix printout

The only way to increase the number of digits of the AO overlap matrix printout is by modify the source code of
the `ga_print()` function.

For example, in the cagse NWChem 7.0.2, you can do this by editing the C source code in
$NWCHEM_TOP/src/tools/ga-5.7.2/global/src/global.util.c by increaseing the number of digits from 5 to 7

```
--- global.util.c.org 1969-07-20 15:50:45.000000000 -0700
+++ global.util.c 1969-07-20 15:51:19.000000000 -0700
@@ -122,22 +122,22 @@
             case C_DBL:
               pnga_get(g_a, lo, hi, dbuf, &ld);
               for(jj=0; jj<(jmax-j+1); jj++)
-                fprintf(file," %11.5f",dbuf[jj]);
+                fprintf(file," %11.7f",dbuf[jj]);
               break;
             case C_DCPL:
               pnga_get(g_a, lo, hi, dbuf, &ld);
               for(jj=0; jj<(jmax-j+1); jj+=2)
-                fprintf(file," %11.5f,%11.5f",dbuf[jj], dbuf[jj+1]);
+                fprintf(file," %11.7f,%11.7f",dbuf[jj], dbuf[jj+1]);
               break;
             case C_SCPL:
               pnga_get(g_a, lo, hi, dbuf, &ld);
               for(jj=0; jj<(jmax-j+1); jj+=2)
-                fprintf(file," %11.5f,%11.5f",dbuf[jj], dbuf[jj+1]);
+                fprintf(file," %11.7f,%11.7f",dbuf[jj], dbuf[jj+1]);
               break;
             case C_FLOAT:
               pnga_get(g_a, lo, hi, fbuf, &ld);
               for(jj=0; jj<(jmax-j+1); jj++)
-                fprintf(file," %11.5f",fbuf[jj]);
+                fprintf(file," %11.7f",fbuf[jj]);
               break;       
             case C_LONG:
               pnga_get(g_a, lo, hi, lbuf, &ld);
@@ -229,22 +229,22 @@
             case C_DBL:
               pnga_get(g_a, lo, hi, dbuf, &ld);
               for(jj=0; jj<(jmax-j+1); jj++)
-                fprintf(file," %11.5f",dbuf[jj]);
+                fprintf(file," %11.7f",dbuf[jj]);
               break;
             case C_FLOAT:
               pnga_get(g_a, lo, hi, dbuf, &ld);
               for(jj=0; jj<(jmax-j+1); jj++)
-                fprintf(file," %11.5f",fbuf[jj]);
+                fprintf(file," %11.7f",fbuf[jj]);
               break;     
             case C_DCPL:
               pnga_get(g_a, lo, hi, dbuf, &ld);
               for(jj=0; jj<(jmax-j+1); jj+=2)
-                fprintf(file," %11.5f,%11.5f",dbuf[jj], dbuf[jj+1]);
+                fprintf(file," %11.7f,%11.7f",dbuf[jj], dbuf[jj+1]);
               break;
             case C_SCPL:
               pnga_get(g_a, lo, hi, dbuf, &ld);
               for(jj=0; jj<(jmax-j+1); jj+=2)
-                fprintf(file," %11.5f,%11.5f",dbuf[jj], dbuf[jj+1]);
+                fprintf(file," %11.7f,%11.7f",dbuf[jj], dbuf[jj+1]);
               break;
             default: pnga_error("ga_print: wrong type",0);
           }
@@ -761,28 +761,28 @@
                             if(ndim > 1)
                                 for(j=0; j<(hip[1]-lop[1]+1); j++)
                                     if((double)dbuf_2d[j*bufsize+i]<100000.0)
-                                        fprintf(file," %11.5f",
+                                        fprintf(file," %11.7f",
                                                 dbuf_2d[j*bufsize+i]);
                                     else
                                         fprintf(file," %.5e",
                                                 dbuf_2d[j*bufsize+i]);
                             else
                                 if((double)dbuf_2d[i]<100000.0)
-                                    fprintf(file," %11.5f",dbuf_2d[i]);
+                                    fprintf(file," %11.7f",dbuf_2d[i]);
                                 else
                                     fprintf(file," %.5e",dbuf_2d[i]);
                             break;
                         case C_FLOAT:
                             if(ndim > 1)
                                 for(j=0; j<(hip[1]-lop[1]+1); j++)
-                                    fprintf(file," %11.5f", fbuf_2d[j*bufsize+i]);
-                            else fprintf(file," %11.5f", fbuf_2d[i]);
+                                    fprintf(file," %11.7f", fbuf_2d[j*bufsize+i]);
+                            else fprintf(file," %11.7f", fbuf_2d[i]);
                             break;           
                         case C_DCPL:
                             if(ndim > 1)
                                 for(j=0; j<(hip[1]-lop[1]+1); j++)
                                     if(((double)dcbuf_2d[(j*bufsize+i)*2]<100000.0)&&((double)dcbuf_2d[(j*bufsize+i)*2+1]<100000.0))
-                                        fprintf(file," %11.5f,%11.5f",
+                                        fprintf(file," %11.7f,%11.7f",
                                                 dcbuf_2d[(j*bufsize+i)*2],
                                                 dcbuf_2d[(j*bufsize+i)*2+1]);
                                     else
@@ -792,7 +792,7 @@
                             else
                                 if(((double)dcbuf_2d[i*2]<100000.0) &&
                                    ((double)dcbuf_2d[i*2+1]<100000.0))
-                                    fprintf(file," %11.5f,%11.5f",
+                                    fprintf(file," %11.7f,%11.7f",
                                             dcbuf_2d[i*2], dcbuf_2d[i*2+1]);
                                 else
                                     fprintf(file," %.5e,%.5e",
@@ -802,7 +802,7 @@
                             if(ndim > 1)
                                 for(j=0; j<(hip[1]-lop[1]+1); j++)
                                     if(((float)fcbuf_2d[(j*bufsize+i)*2]<100000.0)&&((float)fcbuf_2d[(j*bufsize+i)*2+1]<100000.0))
-                                        fprintf(file," %11.5f,%11.5f",
+                                        fprintf(file," %11.7f,%11.7f",
                                                 fcbuf_2d[(j*bufsize+i)*2],
                                                 fcbuf_2d[(j*bufsize+i)*2+1]);
                                     else
@@ -812,7 +812,7 @@
                             else
                                 if(((float)fcbuf_2d[i*2]<100000.0) &&
                                    ((float)fcbuf_2d[i*2+1]<100000.0))
-                                    fprintf(file," %11.5f,%11.5f",
+                                    fprintf(file," %11.7f,%11.7f",
                                             fcbuf_2d[i*2], fcbuf_2d[i*2+1]);
                                 else
                                     fprintf(file," %.5e,%.5e",
```

[https://nwchemgit.github.io/Special_AWCforum/sp/id3358.html](https://nwchemgit.github.io/Special_AWCforum/sp/id3358.html)

## Linear Dependencies

Two or more basis functions can be consider linearly dependent when they span the same region of space. This can result in SCF converge problems. Analysis of the eigenvectors of the S<sup>-1/2</sup> matrix (where S is the overlap matrix) is used to detect linear dependencies: if there are eigenvalues  close to zero, the basis set goes through the process of canonical orthogonalization (as described in Section 3.4.5 of [Szabo & Ostlund "Modern Quantum Chemistry" book](https://store.doverpublications.com/0486691861.html)). This has net effect of a reduction of number of basis function used, compared to the original number set by input.
By setting

```
set lindep:n_dep 0
```

this orthogonalization process is skipped.

## Discrepancy on the number of basis functions: spherical vs cartesian functions

If you are comparing NWChem results with the ones obtained from  other codes and you believe  there is a
discrepancy in the number of basis functions, keep in mind that NWChem uses cartesian functions by default, while other codes could be using spherical functions, instead.  
If you need to use spherical functions, the beginning of the basis input field needs to be

```
basis spherical
```

More details in the documentation at the link [https://nwchemgit.github.io/Basis.html#spherical-or-cartesian](https://nwchemgit.github.io/Basis.html#spherical-or-cartesian).

See also the following [forum entries](https://groups.google.com/g/nwchem-forum/search?q=default%20cartesian).

## Starting NWChem with `mpirun -np 1` crashes

This is most likely due to the fact that NWChem was compiled with the setting `ARMCI_NETWORK=MPI-PR`.  
This is the expected behavior, since `ARMCI_NETWORK=MPI-PR` requires asking for  for n+1 processes. In other words, a serial run (with a single computing process) is triggered by executing `mpirun -np 2`.  
If you would prefer  `mpirun -np 1` to work, other choice of `ARMCI_NETWORK` are possible as described in the [ARMCI documentation](ARMCI.md).

## nb_wait_for_handle Error

If you get the following error 
```
{1} nb_wait_for_handle Error: all user-level nonblocking handles have been exhausted
application called MPI_Abort(comm=0x84000002, -1)
```
you can fix it by executing the following command
```
export COMEX_MAX_NB_OUTSTANDING=16
```

## Memory errors

If you get the following error
```
[0] Received an Error in Communication: (-1) 0: ptsalloc: increase memory in input line:
```

you can fix it by either    
* increasing the memory line in the input file using the syntax described in the [Memory section](Memory.md) (e.g. `memory total 1000 mb`), or by  
* recompiling the NWChem binary with the `getmem.nwchem` script as described in the section avaible at this 
[link](Compiling-NWChem.md#setting-the-default-memory-values)  


