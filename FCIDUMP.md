# FCIDUMP

## Overview

The FCIDUMP module writes the 1-electron and 2-electron integrals to disk folllowing the format
specified in the paper  [@knowles1898]

The  module is used when following NWChem task directive is specified
```
task dft fcidump
```
The input for the module is taken from the FCIDUMP input block
```
FCIDUMP
  ... 
END
```

The resulting file will be named `file_prefix.fcidump`

## ORBITALS - Orbitals specifications
```
ORBITALS [(molecular || atomic) default molecular]
```

The `ORBITALS` keyword can have the value `molecular`  (default) or `atomic`.
When the default keyword `molecular` is used, the integrals are transformed using the
molecular orbitals.
When the  keyword `atomic` is specified, the integrals are evaluated using the atomic orbitals
(*option not implemented yet*)


## FREEZE - Freezing orbitals

When using molecular orbitals, orbitals can be frozen as described in the
[MP2](MP2##freeze----freezing-orbitals) section

## Examples

```
...
dft
 xc hfexch
end

task dft

fcidump
 orbitals molecular
 freeze atomic
end

task dft fcidump
```
## References
///Footnotes Go Here///
