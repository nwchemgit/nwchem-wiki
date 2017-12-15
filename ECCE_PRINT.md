## ECCE\_PRINT

The ECCE\_PRINT directive allows the user to print out a file, usually
called ecce.out, that will allow the calculation and its results to be
imported into Ecce (see <http://ecce.pnl.gov>).

`ECCE_PRINT `<string name>

The entry for variable <name> is the name of the file that will contain
the Ecce import information and should include the full path to the
directory where you want that file. For example

`ecce_print /home/user/job/ecce.out`

If the full path is not given and only the file name is given, the file
will be located in whatever directory the job is started in. For
example, if the line

`ecce_print ecce.out`

is in the input file, the file could end up in the scratch directory if
the user is using a batch script that copies the input file to a local
scratch directory and then launches NWChem from there. If the system
then automatically removes files in the scratch space at the end of the
job, the ecce.out file will be lost. So, the best practice is to include
the full path name for the file.
