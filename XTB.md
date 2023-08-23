# XTB

## Overview

XTB method [@bannwarth2020]. Full documentation available at the [XTB website](https://xtb-docs.readthedocs.io).  
The NWChem implementation makes use of the [TBlite library](https://xtb-docs.readthedocs.io).  

```
 XTB
   [ACC <real acc default 1.0>] 
   [UHF <integer uhf default 0>]
   [METHOD gfn1 || gfn2 default gfn2]
   [GUESS]
   [VERBOSITY]
   [PRINT]  
   [NOPRINT]
   [NSPIN <integer nspin default 1>]
   [BROYDEN <real broyden default 0.4>]
 END
```

## ACC: Accuracy

For example, if the user wants to increase the accuracy:
```
 acc 1d-4
```

## UHF: number of unpaired electrons

```
 uhf 3
```

## NSPIN:

A value of `nspin` equal to two triggers an open-shell calculation (while the default value of 1 triggers a closed-shell calculation).

```
 nspin 2
```


## References
///Footnotes Go Here///

