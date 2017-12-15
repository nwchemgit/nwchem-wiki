
## ECHO

This start-up directive is provided as a convenient way to include a
listing of the input file in the output of a calculation. It causes the
entire input file to be printed to Fortran unit six (standard output).
It has no keywords, arguments, or options, and consists of the single
line:

`ECHO`

The ECHO directive is processed only once, by Process 0 when the input
file is read.
