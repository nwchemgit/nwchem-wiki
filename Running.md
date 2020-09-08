# Running NWChem

The command required to invoke NWChem is machine dependent, whereas most
of the NWChem input is machine independent.

## Sequential execution

To run NWChem sequentially on nearly all UNIX-based platforms simply use
the command nwchem and provide the name of the input file as an
argument. This does assume that either nwchem is in your path or you
have set an alias of nwchem to point to the appropriate executable.

Output is to standard output, standard error and Fortran unit 6 (usually
the same as standard output). Files are created by default in the
current directory, though this may be [overridden in the
input](Top-level#SCRATCH_DIR_.2F_PERMANENT_DIR).

Generally, one will run a job with the following
command:
```
  nwchem input.nw >& input.out &
```
## Parallel execution on UNIX-based parallel machines including workstation clusters using MPI

To run with MPI, parallel should not be used. The way we usually run
nwchem under MPI are the following

  - using mpirun:  
  ```    
    mpirun -np 8 $NWCHEM_TOP/bin/$NWCHEM_TARGET/nwchem input.nw  
  ```    
  

## Parallel execution on MPPs

All of these machines require use of different commands in order to gain
exclusive access to computational resources.
