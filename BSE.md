# BSE

## Overview

Bethe–Salpeter equation

*BSE* input is provided using the compound directive

```
BSE
  ...
END
```

The actual *BSE* calculation will be performed when the 
input module encounters the [TASK](TASK.md) directive.

```
TASK DFT BSE
```

Note that `DFT` must be specified as the underlying *QM* theory before 
`BSE`. The [charge](Charge.md), [geometry](Geometry.md), and 
[DFT](Density-Functional-Theory-for-Molecules.md) options are all specified as
normal. 

A BSE calculation requires not only a DFT ground state calculation, but a [GW](GW.md) task to be executed, too.

## BSE Input directives

There are sub-directives which allow for customized *BSE* calculations.
The most general *BSE* input block directive will look like:

```
BSE
  NROOTS [<integer nroots default 10>]
  METHOD [ (davidson || analytic || lanczos) default analytic ]
  (SINGLET || TRIPLET) default SINGLET 
  TDA
  NCAP
  NCAPR
  OUTWIN
  MAXROOTS [<integer maxroots default 200>]
  SKIPGW
  MAXITER [<integer maxiter default 100>]
  NSTART
END
```

The following sections describe these keywords.

### NROOT

The keyword `NROOT` 


## Sample Input File


```

geometry
H 0.000000 0.923274 1.238289
H 0.000000 -0.923274 1.238289
H 0.000000 0.923274 -1.238289
H 0.000000 -0.923274 -1.238289
C 0.000000 0.000000 0.668188
C 0.000000 0.000000 -0.668188
end

basis "ao basis" spherical bse
 * library aug-cc-pvdz
end

basis "ri basis" spherical bse
 * library aug-cc-pvdz-rifit
end

dft
  direct
  xc pbe0
  tolerances acccoul 10
  convergence energy 1d-8
  grid fine
end

gw
  evgw 5
  method analytic
  states alpha occ -1 vir -1
end

task gw

bse
 nroots 12
 method davidson
end

task bse
```

## References
///Footnotes Go Here///
