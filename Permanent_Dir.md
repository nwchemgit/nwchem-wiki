
## PERMANENT\_DIR

This start-up directive allows the user to specify the directory
location of permanent files created by NWChem. NWChem distinguishes
between permanent (or persistent) files and scratch (or temporary)
files, and allows the user the option of putting them in different
locations. In most installations, however, permanent and scratch files
are all written to the current directory by default. What constitutes
"local" disk space may also differ from machine to machine.

The PERMANENT\_DIR directives enable the user to specify a single
directory for all processes or different directories for different
processes. The general form of the directive is as
follows:

`(PERMANENT_DIR) [(<string host&>||`<integer process>`):]  `<string directory>`  [...]`
