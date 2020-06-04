
## START / RESTART

The START or RESTART directive define the start-up mode and are optional
keywords. If one of these two directives is not specified explicitly,
the code will infer one, based upon the name of the input file and the
availability of the database. When allowing NWChem to infer the start-up
directive, the user must be quite certain that the contents of the
database will result in the desired action. It is usually more prudent
to specify the directive explicitly, using the following
format:
```
(RESTART || START) [<string file_prefix default input_file_prefix>] \  
                   [rtdb <string rtdb_file_name default file_prefix.db>]
```
The START directive indicates that the calculation is one in which a new
database is to be created. Any relevant information that already exists
in a previous database of the same name is destroyed. The string
variable <file_prefix> will be used as the prefix to name any files
created in the course of the calculation.

E.g., to start a new calculation on water, one might specify
```
start water
```
which will make all files begin with "water.".

If the user does not specify an entry for <file_prefix> on the START
directive (or omits the START directive altogether), the code uses the
base-name of the input file as the file prefix. That is, the variable
<file_prefix> is assigned the name of the input file (not its full
pathname), but without the last "dot-suffix". For example, the input
file name /home/dave/job.2.nw yields job.2 as the file prefix, if a name
is not assigned explicitly using the START directive.

The user also has the option of specifying a unique name for the
database, using the keyword rtdb. When this keyword is entered, the
string entered for rtdb\_file\_name is used as the database name. If the
keyword rtdb is omitted, the name of the database defaults to
file\_prefix.db in the directory for permanent files.

If a calculation is to start from a previous calculation and go on using
the existing database, the RESTART directive must be used. In such a
case, the previous database must already exist. The name specified for
<file_prefix> usually should not be changed when restarting a
calculation. If it is changed, NWChem will not be able to find needed
files when going on with the calculation.

In the most common situation, the previous calculation was completed
(with or without an error condition), and it is desired to perform a new
task or restart the previous one, perhaps with some input changes. In
these instances, the RESTART directive should be used. This re-uses the
previous database and associated files, and reads the input file for new
input and task information.

The RESTART directive looks immediately for new input and task
information, deleting information about previous incomplete tasks. For
example, when doing a RESTART there is no need to specify geometry or
basis set declaration because the program will detect this information
since it is stored in the run-time database.

If a calculation runs out of time, for example because it is on a
queuing system, this is another instance where doing a RESTART is
advisable. Simply include nothing after the RESTART directive except
those tasks that are unfinished.

To summarize the default options for this start-up directive, if the
input file does not contain a START or a RESTART directive, then

  - the variable <file_prefix> is assigned the name of the input file
    for the job, without the suffix (which is usually .nw)
  - the variable <rtdb_file_name> is assigned the default name,
    file\_prefix.db

If the database with name file\_prefix.db does not already exist, the
calculation is carried out as if a START directive had been encountered.
If the database with name file\_prefix.db does exist, then the
calculation is performed as if a RESTART directive had been encountered.

For example, NWChem can be run using an input file with the name
water.nw by typing the UNIX command line,
```
nwchem water.nw
```
If the NWChem input file water.nw does not contain a START or RESTART
directive, the code sets the variable <file_prefix> to water. Files
created by the job will have this prefix, and the database will be named
water.db. If the database water.db does not exist already, the code
behaves as if the input file contains the directive,
```
start water
```
If the database water.db does exist, the code behaves as if the input
file contained the directive,
```
restart water
```
### Use of permanent_dir
We suggest the user to add the [permanent directory](#Permanent_Dir) line to the input file. This allows to store files in a specific directory for easy re-use between start and restart stages.  
The start file then becomes

```
start water
permanent_dir /home/doe/nwchem_files
```
while the restart file  becomes
```
restart water
permanent_dir /home/doe/nwchem_files
```