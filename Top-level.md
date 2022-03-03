# Top-level Directives

Top-level directives are directives that can affect all modules in the code. Some specify molecular properties or other data that should apply to all subsequent calculations with the current database. However, most top-level directives provide the user with the means to manage the resources for a calculation and to start computations. As the first step in the execution of a job, NWChem scans the entire input file looking for start-up directives, which NWChem must process before all other input. The input file is then rewound and processed sequentially, and each directive is processed in the order in which it is encountered. In this second pass, start-up directives are ignored.

The following sections describe each of the top-level directives in detail, noting all keywords, options, required input, and defaults.

* [START/RESTART](Start_Restart.md)

* [PERMANENT_DIR](Permanent_Dir.md)

* [SCRATCH_DIR](Scratch_Dir.md)

* [MEMORY](Memory.md)

* [ECHO](ECHO.md)

* [TITLE](TITLE.md)

* [PRINT / NOPRINT](Print_Noprint.md)

* [SET](SET.md)

* [UNSET](UNSET.md)

* [STOP](STOP.md)

* [TASK](TASK.md)

* [ECCE_PRINT](ECCE_PRINT.md)