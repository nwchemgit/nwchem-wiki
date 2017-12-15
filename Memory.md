\_\_NOTITLE\_\_

## MEMORY

This is a start-up directive that allows the user to specify the amount
of memory PER PROCESSOR CORE that NWChem can use for the job. If this
directive is not specified, memory is allocated according to
installation-dependent defaults. The defaults should generally suffice
for most calculations, since the defaults usually correspond to the
total amount of memory available on the machine.

The general form of the directive is as follows:

`MEMORY [[total] `<integer total_size>`]        \`  
`        [stack `<integer stack_size>`]         \`  
`        [heap `<integer heap_size>`]           \`  
`        [global `<integer global_size>`]       \ `  
`        [units `<string units default real>`]  \ `  
`        [(verify||noverify)]                 \`  
`        [(nohardfail||hardfail)]`

NWChem recognizes the following memory units:

  - real and double (synonyms)
  - integer
  - real and double (synonyms)
  - integer
  - byte
  - kb (kilobytes)
  - mb (megabytes)
  - mw (megawords, 64-bit word)

In most cases, the user need specify only the total memory limit to
adjust the amount of memory used by NWChem. The following specifications
all provide for eight megabytes of total memory (assuming 64-bit
floating point numbers), which will be distributed according to the
default partitioning:

`memory 1048576 `  
`memory 1048576 real `  
`memory 1 mw`  
`memory 8 mb `  
`memory total 8 mb `  
`memory total 1048576`

In NWChem there are three distinct regions of memory: stack, heap, and
global. Stack and heap are node-private, while the union of the global
region on all processors is used to provide globally-shared memory. The
allowed limits on each category are determined from a default
partitioning (currently 25% heap, 25% stack, and 50% global).
Alternatively, the keywords stack, heap, and global can be used to
define specific allocations for each of these categories. If the user
sets only one of the stack, heap, or global limits by input, the limits
for the other two categories are obtained by partitioning the remainder
of the total memory available in proportion to the weight of those two
categories in the default memory partitioning. If two of the category
limits are given, the third is obtained by subtracting the two given
limits from the total limit (which may have been specified or may be a
default value). If all three category limits are specified, they
determine the total memory allocated. However, if the total memory is
also specified, it must be larger than the sum of all three categories.
The code will abort if it detects an inconsistent memory specification.

The following memory directives also allocate 8 megabytes, but specify a
complete partitioning as well:

`memory total 8 stack 2 heap 2 global 4 mb `  
`memory stack 2 heap 2 global 4 mb`

The optional keywords verify and noverify in the directive give the user
the option of enabling or disabling automatic detection of corruption of
allocated memory. The default is verify, which enables the feature. This
incurs some overhead (which can be around 10% increase in walltime on
some platforms), which can be eliminated by specifying noverify.

The keywords hardfail and nohardfail give the user the option of forcing
(or not forcing) the local memory management routines to generate an
internal fatal error if any memory operation fails. The default is
nohardfail, which allows the code to continue past any memory operation
failure, and perhaps generate a more meaningful error message before
terminating the calculation. Forcing a hard-fail can be useful when
poorly coded applications do not check the return status of memory
management routines.

When assigning the specific memory allocations using the keywords stack,
heap, and global in the MEMORY directive, the user should be aware that
some of the distinctions among these categories of memory have been
blurred in their actual implementation in the code. The memory allocator
(MA) allocates both the heap and the stack from a single memory region
of size heap+stack, without enforcing the partition. The heap vs. stack
partition is meaningful only to applications developers, and can be
ignored by most users. Further complicating matters, the global array
(GA) toolkit is allocated from within the MA space on distributed memory
machines, while on shared-memory machines it is separate. This is
because on true shared-memory machines there is no choice but to
allocate GAs from within a shared-memory segment, which is managed
differently by the operating system.

On distributed memory platforms, the MA region is actually the total
size of stack+heap+global. All three types of memory allocation compete
for the same pool of memory, with no limits except on the total
available memory. This relaxation of the memory category definitions
usually benefits the user, since it can allow allocation requests to
succeed where a stricter memory model would cause the directive to fail.
These implementation characteristics must be kept in mind when reading
program output that relates to memory usage.

Standard default for memory is currently 512 MB.
