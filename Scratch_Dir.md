
## SCRATCH_DIR

This start-up directive allows the user to specify the directory
location of scratch files created by NWChem. NWChem distinguishes
between permanent (or persistent) files and scratch (or temporary)
files, and allows the user the option of putting them in different
locations. In most installations, however, permanent and scratch files
are all written to the current directory by default. What constitutes
"local" disk space may also differ from machine to machine.

The conventions for file storage are at the discretion of the specific
installation, and are quite likely to be different on different
machines. When assigning locations for permanent and scratch files, the
user must be cognizant of the characteristics of the installation on a
particular platform. To consider just a few examples, on clusters,
machine-specific or process-specific names must be supplied for both
local and shared file systems, while on SMPs it is useful to specify
scratch file directories with automated striping across processors with
round-robin allocation. On SMP clusters (a.k.a. constellations), both of
these specifications are required.

The SCRATCH_DIR enables the user to specify a single directory for all
processes or different directories for different processes. The general
form of the directive is as
follows:
```
(SCRATCH_DIR) [(<string host>||<integer process>):]  <string directory>  [...]
```
Directories are extracted from the user input by executing the following
steps, in sequence:

1.  Look for a directory qualified by the process ID number of the
    invoking process. Processes are numbered from zero. Else,
2.  If there is a list of directories qualified by the name of the host
    machineAs returned by util\_hostname() which maps to the output of
    the command hostname on Unix workstations., then use round-robin
    allocation from the list for processes executing on the given host.
    Else,
3.  If there is a list of directories unqualified by any hostname or
    process ID, then use round-robin allocation from this list.

If directory allocation directive(s) are not specified in the input
file, or if no match is found to the directory names specified by input
using these directives, then the steps above are executed using the
installation-specific defaults. If the code cannot find a valid
directory name based on the input specified in either the directive(s)
or the system defaults, files are automatically written to the current
working directory (".").

The following is a list of examples of specific allocations of scratch
directory locations:

  - Put scratch files from all processes in the local scratch directory
    (Warning: the definition of "local scratch directory" may change
    from machine to machine):

`scratch_dir /localscratch`

  - Put scratch files from Process 0 in /piofs/rjh, but put all other
    scratch files in /scratch:

`scratch_dir /scratch 0:/piofs/rjh`

  - Put scratch files from Process 0 in directory scr1, those from
    Process 1 in scr2, and so forth, in a round-robin fashion, using the
    given list of directories:

`scratch_dir /scr1 /scr2 /scr3 /scr4 /scr5`

  - Allocate files in a round-robin fashion from host-specific lists for
    processes distributed across two SGI multi-processor machines (node
    names coho and
bohr):

`scratch_dir coho:/xfs1/rjh coho:/xfs2/rjh coho:/xfs3/rjh  bohr:/disk01/rjh bohr:/disk02/rjh bohr:/disk13/rjh`
